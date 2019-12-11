Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991BA11ADEE
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfLKOjp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46248 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbfLKOjn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so1484478pll.13;
        Wed, 11 Dec 2019 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcdhyyyraLVUQAQ3HHOSQ6YNvDlkdwwrUN22Ki1UdWw=;
        b=RyG5UBz1cZHPGUqtMFB5YXFkkEdKKMiMwMxa8vnkNtXJSn70Zzja6yk3iTI/el/Ji7
         7mdXDBMNf7s4VWETE4BQOzat3pRp4cFbQRhjZmJDg1kzg1dpKHj7axOgJOv1it0xkTtv
         64qDc3ri9DQ3B9rGjNLH/xQ8bXwKOeK2yQtzcOL6fP1uiZBFCyaE/HbYfL64wN2sj/FP
         PXfUm8e3jVXPvOw7YquFCs42UtzcocoIDPdohQ/cW8UE9pEGu+OHFwa8hg2C+DL9l5p0
         qGq7WkaPaYNYdqhKGd+Ea8oh+Bst+ULZgi+wmIadHtyeeZnEDTEaNlXWHo4VcdmjIp+3
         ZtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcdhyyyraLVUQAQ3HHOSQ6YNvDlkdwwrUN22Ki1UdWw=;
        b=nDKmJyxZYaJzue73y3YCBpUlVNZuvu4fIcWFJ7zdnnC0OeudT9EolMxUA65VfwDzPn
         DvVlxeSAT9xX13e52zPgoxFF8R+zrGhVf1gX3VawSSXUz9faIw5wEP223tqburaiMf8x
         F8NHB4893NU0jB05XQh9VbnGvGyxKw2G3aL1Dzcd6NSRyubzceSciKcltlcuPlCv1oiR
         wejQh+lAzjj91oTdL/E7mDwHEdJPUu+YQu1lLyaYOON5Ye9rN4TFEv7Xfbp2dFkuDqd8
         XRuLFSJozh0m9t5zI2UBpNptQPqitZMjwZaaF7B3TqdLL9LSJzBvBncCA9IN69OniEaM
         U6HA==
X-Gm-Message-State: APjAAAX9dRVCfOltzL7NZLksvf+63UgPgLkk56gJw0ilVthCQPF/3vCA
        jd3MQDSl2AG+PHBL4n+dQnU=
X-Google-Smtp-Source: APXvYqxp6M46sXtPZT2HvGlWuv1Os2BTC76wIST3HLZF+6k8rsAvHXrRSJFlwIPCfdqDACr2l48xrw==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr3347664plp.120.1576075182587;
        Wed, 11 Dec 2019 06:39:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:41 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH v3 10/12] wireless: iwlwifi: use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:17 +0900
Message-Id: <1576075099-3441-11-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the iwlwifi driver to use celsius_to_kelvin() and
kelvin_to_celsius() in <linux/units.h>.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

 drivers/net/wireless/intel/iwlwifi/dvm/dev.h     | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c | 6 ++++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index be5ef4c..8d83800 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -237,11 +237,6 @@ struct iwl_sensitivity_ranges {
 	u16 nrg_th_cca;
 };
 
-
-#define KELVIN_TO_CELSIUS(x) ((x)-273)
-#define CELSIUS_TO_KELVIN(x) ((x)+273)
-
-
 /******************************************************************************
  *
  * Functions implemented in core module which are forward declared here
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index dc3f197..d42bc46 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -10,6 +10,8 @@
  *
  *****************************************************************************/
 
+#include <linux/units.h>
+
 /*
  * DVM device-specific data & functions
  */
@@ -345,7 +347,7 @@ static s32 iwl_temp_calib_to_offset(struct iwl_priv *priv)
 static void iwl5150_set_ct_threshold(struct iwl_priv *priv)
 {
 	const s32 volt2temp_coef = IWL_5150_VOLTAGE_TO_TEMPERATURE_COEFF;
-	s32 threshold = (s32)CELSIUS_TO_KELVIN(CT_KILL_THRESHOLD_LEGACY) -
+	s32 threshold = (s32)celsius_to_kelvin(CT_KILL_THRESHOLD_LEGACY) -
 			iwl_temp_calib_to_offset(priv);
 
 	priv->hw_params.ct_kill_threshold = threshold * volt2temp_coef;
@@ -381,7 +383,7 @@ static void iwl5150_temperature(struct iwl_priv *priv)
 	vt = le32_to_cpu(priv->statistics.common.temperature);
 	vt = vt / IWL_5150_VOLTAGE_TO_TEMPERATURE_COEFF + offset;
 	/* now vt hold the temperature in Kelvin */
-	priv->temperature = KELVIN_TO_CELSIUS(vt);
+	priv->temperature = kelvin_to_celsius(vt);
 	iwl_tt_handler(priv);
 }
 
-- 
2.7.4

