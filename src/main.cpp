#include "Compatibility.h"
#include "Hooks.h"
#include "ImGui/Renderer.h"
#include "Manager.h"
#include "Papyrus.h"

void OnInit(SKSE::MessagingInterface::Message* a_msg)
{
	switch (a_msg->type) {
	case SKSE::MessagingInterface::kPostLoad:
		{
			logger::info("{:*^30}", "POST LOAD");
			ModAPIHandler::GetSingleton()->LoadModSettings();
			Hooks::Install();
		}
		break;
	case SKSE::MessagingInterface::kPostPostLoad:
		{
			logger::info("{:*^30}", "POST POST LOAD");
			ModAPIHandler::GetSingleton()->LoadAPIs();
		}
		break;
	case SKSE::MessagingInterface::kDataLoaded:
		{
			logger::info("{:*^30}", "DATA LOADED");
			Manager::GetSingleton()->OnDataLoaded();
		}
		break;
	default:
		break;
	}
}

SKSEPluginLoad(const SKSE::LoadInterface* a_skse)
{
	logger::info("Game version : {}", a_skse->RuntimeVersion().string());

	SKSE::Init(a_skse, false);

	SKSE::AllocTrampoline(1 << 7);

	ImGui::Renderer::Install();

	const auto messaging = SKSE::GetMessagingInterface();
	messaging->RegisterListener("SKSE", OnInit);

	SKSE::GetPapyrusInterface()->Register(Papyrus::Register);

	return true;
}