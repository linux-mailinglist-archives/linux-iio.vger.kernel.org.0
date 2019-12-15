Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F111F5FD
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLOFRg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLOFRe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so1731245pgk.2;
        Sat, 14 Dec 2019 21:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7AK/TlaexQptYohFbIUq4KsseUGVisXwtLl1qNBNNIk=;
        b=D81//jzpc2vjR9Hw1Wax/s98TMZnO0WTjxCpQd4gOBTR5Wohhaz2TIwEwns2odGc1G
         6dtjro67Y37h7nFo/p5998Vs4glqeZyplsBRJR6kVRmHcKXz2pcQVbk/10HqsrEtO8Ch
         YpQXvVbntOfa2ngfgW6aFR8RII72nUFGrRkn6B1Ga0U8YjP+H1FLpqRnwg4fZFOUKu+C
         EpcSKFf6f9m5QDojhaPHSVtYNU1etCLSQzRFvUu+WKqoU1rbDZNvVn7NH1FH8Iwk2ng2
         1xDjkvz1fR8SktIraMOjjS7dsAmbGjJKeMX5iLHXjnn5TCnP4UweLtrK9284v7foqOZs
         nnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7AK/TlaexQptYohFbIUq4KsseUGVisXwtLl1qNBNNIk=;
        b=XRNp1LQAlhzAWRKGjHSx+VhteNOFxqeAiCRMoFU4tBla9hPqUH1aZvDPPJvqETaQKB
         8aZNp6gQ+1di/8Yn3gKRizXF482evIYJJOdnB8RBOQ/ZJMjbQEVqROZr9w0as1Ldfy89
         9IGg03qdQ9I4SafyAYQp9xwCasz2JStUgRVdRmcRPjGFOwQGikJP7gfe3gEf8yDinbIq
         Ls3kkWBtd/W7YaZfFVAZk/PH+tCrHZIHtnKy4JXpb1HLRUGbPzR+4bE7rbLhYAxxinW1
         Z9bDkId85YHT/0hLfLcm9n4hNA4hoh9wxkoVnWzokcA8alWGs6jLKJGXtrh8dudi3EKL
         7HgA==
X-Gm-Message-State: APjAAAVIoz1clIOSdKV5Ee1XOS+0ibt+IkYrQzDZHqdgI/sBbgO2ciIH
        oK0wglDzIirjpBnpr9y1B3wuimqhz9c=
X-Google-Smtp-Source: APXvYqxBRv2wn/eiGSZO0EPNa37cbHfApIbzp5cD39XlP29sX6Ug2mD7Qmiq5o6dpS3hCLz8ic6akg==
X-Received: by 2002:a62:e215:: with SMTP id a21mr9141541pfi.208.1576387054256;
        Sat, 14 Dec 2019 21:17:34 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:33 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH v4 09/12] iwlegacy: use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:12 +0900
Message-Id: <1576386975-7941-10-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the iwlegacy driver to use celsius_to_kelvin() and
kelvin_to_celsius() in <linux/units.h>.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by and Acked-by tags
- remove "wireless: " in the title

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

