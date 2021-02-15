Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9D31C235
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 20:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBOTJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 14:09:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhBOTJA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 14:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613416053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HMuLU2e2F9gweGSdzUTIkLLtvZHyRJe4AWF0OUHTtnk=;
        b=K854uxv5IINHifLv+Y1eD36KWtDy+xjsuTWUKaZN70FMG4ZkXBopU6pFCyZR8oVzQBycnM
        0IRLxi20w7jtzKMr9IktX00vPrmzRBOpizPDuLPkNaO2jpnmga67po6xO87xmKRCPY2yRW
        gxp2MAc8RUKsR+FCk/f3h3k2jodiyP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-j2Qg9JbON2qgyr49oa_uZw-1; Mon, 15 Feb 2021 14:07:30 -0500
X-MC-Unique: j2Qg9JbON2qgyr49oa_uZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E153814258;
        Mon, 15 Feb 2021 19:07:28 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-74.ams2.redhat.com [10.36.115.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 502D45D9C0;
        Mon, 15 Feb 2021 19:07:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Dmitry Mastykin <mastichi@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ALSA: hda: intel-dsp-config: Add SND_INTEL_BYT_PREFER_SOF Kconfig option
Date:   Mon, 15 Feb 2021 20:07:23 +0100
Message-Id: <20210215190725.698525-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The kernel has 2 drivers for the Low Power Engine audio-block on
Bay- and Cherry-Trail SoCs. The old SST driver and the new SOF
driver. If both drivers are enabled then the kernel will default
to using the old SST driver, unless told otherwise through the
snd_intel_dspcfg.dsp_driver module-parameter.

Add a boolean SND_INTEL_BYT_PREFER_SOF Kconfig option, which when set to Y
will make the kernel default to the new SOF driver instead.
The option defaults to n, preserving the current behavior.

Making this configurable will help distributions such as Fedora:
https://fedoraproject.org/w/index.php?title=Changes/SofDefaultForIntelLpe
to test using SOF on BYT/CHT during the transition phase where we
have both drivers (eventually the old driver and this option will
be removed).

Note that this drops the acpi_config_table[] containing 2 entries per ACPI
hardware-id if both drivers are enabled. snd_intel_acpi_dsp_find_config()
will always return the first hit, so we only need a single entry with the
flags value set depending on the Kconfig settings.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rework following Takashi's suggestions
---
 sound/hda/Kconfig            | 14 ++++++++++++++
 sound/hda/intel-dsp-config.c | 29 ++++++++++++-----------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index 3bc9224d5e4f..9ed5cfa3c18c 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -46,3 +46,17 @@ config SND_INTEL_DSP_CONFIG
 	select SND_INTEL_NHLT if ACPI
 	# this config should be selected only for Intel DSP platforms.
 	# A fallback is provided so that the code compiles in all cases.
+
+config SND_INTEL_BYT_PREFER_SOF
+	bool "Prefer SOF driver over SST on BY/CHT platforms"
+	depends on SND_SST_ATOM_HIFI2_PLATFORM_ACPI && SND_SOC_SOF_BAYTRAIL
+	default n
+	help
+	  The kernel has 2 drivers for the Low Power Engine audio-block on
+	  Bay- and Cherry-Trail SoCs. The old SST driver and the new SOF
+	  driver. If both drivers are enabled then the kernel will default
+	  to using the old SST driver, unless told otherwise through the
+	  snd_intel_dspcfg.dsp_driver module-parameter.
+
+	  Set this option to Y to make the kernel default to the new SOF
+	  driver instead.
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index c45686172517..68bb977c6a37 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -452,35 +452,30 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 }
 EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);
 
+/* Should we default to SOF or SST for BYT/CHT ? */
+#if IS_ENABLED(CONFIG_SND_INTEL_BYT_PREFER_SOF) || \
+    !IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
+#define FLAG_SST_OR_SOF_BYT	FLAG_SOF
+#else
+#define FLAG_SST_OR_SOF_BYT	FLAG_SST
+#endif
+
 /*
  * configuration table
  * - the order of similar ACPI ID entries is important!
  * - the first successful match will win
  */
 static const struct config_entry acpi_config_table[] = {
+#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI) || \
+    IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 /* BayTrail */
-#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
-	{
-		.flags = FLAG_SST,
-		.acpi_hid = "80860F28",
-	},
-#endif
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 	{
-		.flags = FLAG_SOF,
+		.flags = FLAG_SST_OR_SOF_BYT,
 		.acpi_hid = "80860F28",
 	},
-#endif
 /* CherryTrail */
-#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
-	{
-		.flags = FLAG_SST,
-		.acpi_hid = "808622A8",
-	},
-#endif
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 	{
-		.flags = FLAG_SOF,
+		.flags = FLAG_SST_OR_SOF_BYT,
 		.acpi_hid = "808622A8",
 	},
 #endif
-- 
2.30.0

