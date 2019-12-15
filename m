Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6583711F601
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLOFRj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32815 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLOFRj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so3773767pfb.0;
        Sat, 14 Dec 2019 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o0nAQcnsb+T5h9bhgeYIzbak+OeGPv1PHTKsTeCIoXY=;
        b=erojmZQu2yIt3sG10pk8q7D162SAcRjxoBKbUaHuIhQ9qCS8Ovsrir9CSC6ymhCozZ
         FqJbFyL+b7YifQFa/0j7JxpknZq8Q2X9TeL1mjAJCnQEZo0ZaUgUDC3SmpcLnC97qrcz
         6+zdTV3ejXQXKXZW4bWUv3pwgL4xdnBcdl4GiSkW2HOo6e+sUTG07tQiiOZOVyEKlvGZ
         8LWNoxfJfejbBmxVEhjyX3vtC9aLJQopm1lxsyysNlSrJnFGkIcEn/CigYEybtUr7B++
         WTxENH/IzJk+aDB4t8OozPOkKfLmn3HRsMt9cVmg1exjUHP4KQqCK1sXC5J6ExTdjFWA
         aPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o0nAQcnsb+T5h9bhgeYIzbak+OeGPv1PHTKsTeCIoXY=;
        b=gJxgYzzKjQdG5b50t6ibHdYqQda8tbwwL++OY8pSECbwjdAqIlYPfoOi+p/0jarzqx
         8IMb1iEGqaL0R9EkiQ0fSRC3NHMbGAT8dtGi1tTf/oYFCowqAw9zKa9YyzFw9ibDFxE1
         y+mhQF4wDaqQ/AR5Sj0LuDSNSt3VFQli7j19q3Xc0qEJWhQtbyvWDMIONneccr1B+xcS
         igU7Qdx4SOF+R6L4lo/9QWmbtrp3JP6mK0VtMuJxXFE4b1riW0KugrcEf3mQTmkhFT9S
         Osw2KXOkaZq4mdIZ3VYjVkus62Bj0/K+MfgYHh2rj6rHFgdVNwcB+RFgs328zGhNWLRT
         L/gw==
X-Gm-Message-State: APjAAAUNl9+bPoQ2q71wXpXOtLkmPARHsfw57GzaDctc0NBRFEBuWGh0
        4j96MUvnWsbbOnq7ynCbU2Q=
X-Google-Smtp-Source: APXvYqxoUa7OEVWIs7gSylEoHGyOHkaN4si8hTmYB1eDQDWpbT6CBXJiWnAxrimODPovU2iUuCMwpg==
X-Received: by 2002:a63:7705:: with SMTP id s5mr9996843pgc.379.1576387058498;
        Sat, 14 Dec 2019 21:17:38 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:37 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH v4 10/12] iwlwifi: use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:13 +0900
Message-Id: <1576386975-7941-11-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by and Acked-by tags
- remove "wireless: " in the title

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

