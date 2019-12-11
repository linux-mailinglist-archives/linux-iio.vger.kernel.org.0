Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5023E11ADDC
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfLKOjk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:40 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34941 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbfLKOjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:39 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so9029136pjd.2;
        Wed, 11 Dec 2019 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K3UxPRzFZME10fkLXtCYqjJd0IRSW438IJ8inomPhFc=;
        b=TtEhDw9mXoygh60t0P8tM7vAJ0ws8yOzln/xfqEuvUZQ+gxs9TGtjoWk4ijx+7Lhgj
         m/RjMwumNojsGy04ahZTfQNCqOSGq61vGvkvIu6125xhrZqtF4UylwsJXCgFrAe2H8df
         FxtqiaZyqXH6Pfs4MpJadnetPyQHFsOXN2WR9XEJnxurlElV4LEZ/QiIMDuEjbKxq8bG
         Flftq8QdH5Afm2rmNfaA0N9ZNxJCmfCMXEmJ0kzufwBpTx8PtSQrTRzrVLUIqZszZh5e
         fuhvH5Y8abqa1VpwIVVuvvijRYmXugdPHrEsG6aKfZ8rC5OWbcD4s8FVIZ3GyErGjt9B
         a7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K3UxPRzFZME10fkLXtCYqjJd0IRSW438IJ8inomPhFc=;
        b=G5YuALKAJX76zaXrHJgeJl1gALMOneNl+zZNroWTbSsXFwG79FU1qd1hhuzHsKRBsb
         uqKIycQd27tln3kuoMnxuMlmqilkDhF0Mb/7gqtSzfGHwT3ZDlhyO1kvo7csZZTVLXK0
         ZRncOpA3YKrnXfUhj1xAbR+e7BFKx0C+I+wXzAq3QSiSG8gEbhe/yKoYVwDJ878ezLj6
         VfK/VisPxVn7spCp0qS6FHgdzfQu2wriMqMrvxOH+pt9p4b8H/XwmJxYSKZGdoSUou/V
         n2icsD2iv86npnFHKguyBzTaganNzWeWfgkOumx9iFBbSFotc7F8lu0vQLk+mjRGITXw
         vkHw==
X-Gm-Message-State: APjAAAV/D2I8LzTxHzw7GHIpTsMArz87zDn5dGC9L/YMvyx8/ZPWYsaY
        MT+RKjO2827fZfKIZyoqz7E=
X-Google-Smtp-Source: APXvYqwzmKMUAxLD4W5Ax2MVMn7w223/0E+Cw8F33tmd3OWRq8B/HavfEb1OCpln/HaQH8iOvd8Onw==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr3878015pju.66.1576075178437;
        Wed, 11 Dec 2019 06:39:38 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:37 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH v3 09/12] wireless: iwlegacy: use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:16 +0900
Message-Id: <1576075099-3441-10-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the iwlegacy driver to use celsius_to_kelvin() and
kelvin_to_celsius() in <linux/units.h>.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

 drivers/net/wireless/intel/iwlegacy/4965-mac.c |  3 ++-
 drivers/net/wireless/intel/iwlegacy/4965.c     | 11 ++++++-----
 drivers/net/wireless/intel/iwlegacy/common.h   |  3 ---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 3664f56..d6766eb 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -27,6 +27,7 @@
 #include <linux/firmware.h>
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
+#include <linux/units.h>
 
 #include <net/mac80211.h>
 
@@ -6467,7 +6468,7 @@ il4965_set_hw_params(struct il_priv *il)
 	il->hw_params.valid_rx_ant = il->cfg->valid_rx_ant;
 
 	il->hw_params.ct_kill_threshold =
-	   CELSIUS_TO_KELVIN(CT_KILL_THRESHOLD_LEGACY);
+	   celsius_to_kelvin(CT_KILL_THRESHOLD_LEGACY);
 
 	il->hw_params.sens = &il4965_sensitivity;
 	il->hw_params.beacon_time_tsf_bits = IL4965_EXT_BEACON_TIME_POS;
diff --git a/drivers/net/wireless/intel/iwlegacy/4965.c b/drivers/net/wireless/intel/iwlegacy/4965.c
index 32699b6..31b346c 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/units.h>
 #include <net/mac80211.h>
 #include <linux/etherdevice.h>
 #include <asm/unaligned.h>
@@ -1104,7 +1105,7 @@ il4965_fill_txpower_tbl(struct il_priv *il, u8 band, u16 channel, u8 is_ht40,
 	/* get current temperature (Celsius) */
 	current_temp = max(il->temperature, IL_TX_POWER_TEMPERATURE_MIN);
 	current_temp = min(il->temperature, IL_TX_POWER_TEMPERATURE_MAX);
-	current_temp = KELVIN_TO_CELSIUS(current_temp);
+	current_temp = kelvin_to_celsius(current_temp);
 
 	/* select thermal txpower adjustment params, based on channel group
 	 *   (same frequency group used for mimo txatten adjustment) */
@@ -1611,7 +1612,7 @@ il4965_hw_get_temperature(struct il_priv *il)
 	    (temperature * 97) / 100 + TEMPERATURE_CALIB_KELVIN_OFFSET;
 
 	D_TEMP("Calibrated temperature: %dK, %dC\n", temperature,
-	       KELVIN_TO_CELSIUS(temperature));
+	       kelvin_to_celsius(temperature));
 
 	return temperature;
 }
@@ -1671,11 +1672,11 @@ il4965_temperature_calib(struct il_priv *il)
 	if (il->temperature != temp) {
 		if (il->temperature)
 			D_TEMP("Temperature changed " "from %dC to %dC\n",
-			       KELVIN_TO_CELSIUS(il->temperature),
-			       KELVIN_TO_CELSIUS(temp));
+			       kelvin_to_celsius(il->temperature),
+			       kelvin_to_celsius(temp));
 		else
 			D_TEMP("Temperature " "initialized to %dC\n",
-			       KELVIN_TO_CELSIUS(temp));
+			       kelvin_to_celsius(temp));
 	}
 
 	il->temperature = temp;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index e7fb8e6..bc9cd7e 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -779,9 +779,6 @@ struct il_sensitivity_ranges {
 	u16 nrg_th_cca;
 };
 
-#define KELVIN_TO_CELSIUS(x) ((x)-273)
-#define CELSIUS_TO_KELVIN(x) ((x)+273)
-
 /**
  * struct il_hw_params
  * @bcast_id: f/w broadcast station ID
-- 
2.7.4

