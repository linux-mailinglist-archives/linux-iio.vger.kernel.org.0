Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7D833826
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFCSeY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfFCSeV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so881992pff.9
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lykn9s6TtPMAOpfxJzZK4DKwASEPMO5bfMfE4ug8wts=;
        b=doDoE6Ajg8pMDUBLhqP9lz/5JGJA61M1SVYTu3TY6l0e8ng5ymDx8dIw9EgAbp70fq
         dGHTz//UTevJ/wt6+rm6LDHTGkh0cGHereeyHUa3mjezyO1FoZgAmfyKDZuU14ZP+Cpm
         bngSkL62uK6fUb3UGuwod8ooH25e4WnuvVQKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lykn9s6TtPMAOpfxJzZK4DKwASEPMO5bfMfE4ug8wts=;
        b=XY+z0S00tXDqoQz4ngbK8l72UDM8Hmcoa3A6TNWxgHxsSz/fcLC20+9XFL6eiC6HtF
         WKLaZpWikYx5rqLOhl1ui4Mjytkhfx9e94KO5wx8O2uTMqgjHTcynyPm9ZUgJ1n/yPiM
         RFAF5w1xF/kVN80FjCFKF2iKRR2FO4brptpg/6pEYSVPLowDov1DXBNpjTwU2nTg1/2C
         PR9/EXew+pdaH2TXNF7YxJn8tJxS9CeWOsqQJKinJniVZeAcnb3dEyK0oXSF+siCb4yg
         4Js5GcX1SA03F07VH2Uqf7sooES6aHHWuF6sEgP2708BqZ74NgWtXt8vrQtSLNMsrmay
         tb0A==
X-Gm-Message-State: APjAAAVaZGzkV1ODXaCjyDfsL99wyPuC2xdTXIGywgzH/ypAQYpyA2Mq
        aOMEpW3y38E+JDv5WEQoaSQPlQ==
X-Google-Smtp-Source: APXvYqzxJo5BsFObFfqc2WCxB/CbSpDkohhz8GD7DUj6e3JbDngjr0t4wNqc5w6hXnh40c9ixuCyVQ==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr30759181pjo.127.1559586860482;
        Mon, 03 Jun 2019 11:34:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 140sm19299543pfw.123.2019.06.03.11.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 09/30] mfd: cros_ec: Remove zero-size structs
Date:   Mon,  3 Jun 2019 11:33:40 -0700
Message-Id: <20190603183401.151408-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Empty structure size is different between C and C++.
To prevent clang warning when compiling this include file in C++
programs, remove empty structures.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 33 +++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d8bde2b5e9ce..fabf341af97f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1540,10 +1540,14 @@ struct lightbar_program {
 struct ec_params_lightbar {
 	uint8_t cmd;		      /* Command (see enum lightbar_command) */
 	union {
-		struct {
-			/* no args */
-		} dump, off, on, init, get_seq, get_params_v0, get_params_v1,
-			version, get_brightness, get_demo, suspend, resume;
+		/*
+		 * The following commands have no args:
+		 *
+		 * dump, off, on, init, get_seq, get_params_v0, get_params_v1,
+		 * version, get_brightness, get_demo, suspend, resume
+		 *
+		 * Don't use an empty struct, because C++ hates that.
+		 */
 
 		struct __ec_todo_unpacked {
 			uint8_t num;
@@ -1597,11 +1601,13 @@ struct ec_response_lightbar {
 			uint8_t red, green, blue;
 		} get_rgb;
 
-		struct {
-			/* no return params */
-		} off, on, init, set_brightness, seq, reg, set_rgb,
-			demo, set_params_v0, set_params_v1,
-			set_program, manual_suspend_ctrl, suspend, resume;
+		/*
+		 * The following commands have no response:
+		 *
+		 * off, on, init, set_brightness, seq, reg, set_rgb,
+		 * set_params_v0, set_params_v1, set_program,
+		 * manual_suspend_ctrl, suspend, resume
+		 */
 	};
 } __ec_todo_packed;
 
@@ -3021,9 +3027,7 @@ enum charge_state_params {
 struct ec_params_charge_state {
 	uint8_t cmd;				/* enum charge_state_command */
 	union {
-		struct {
-			/* no args */
-		} get_state;
+		/* get_state has no args */
 
 		struct __ec_todo_unpacked {
 			uint32_t param;		/* enum charge_state_param */
@@ -3049,9 +3053,8 @@ struct ec_response_charge_state {
 		struct __ec_align4 {
 			uint32_t value;
 		} get_param;
-		struct {
-			/* no return values */
-		} set_param;
+
+		/* set_param returns no args */
 	};
 } __ec_align4;
 
-- 
2.21.0.1020.gf2820cf01a-goog

