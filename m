Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BEE1351B
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfECWC7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:02:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44807 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfECWC6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:02:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so3527074pfm.11
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhMP+EYsF7thTSOZC6IuVUmea4P1pderJRDss92eoz8=;
        b=EdoNQ8RoL8xGsXIXKZyJ40YLQ9yRJ/6/wKnmdK/XhooMvd2G1H9O55nKpVfAyTuWyV
         XMbp4/FDFDh8FnO3eJ/kVj1HGXrEXoqBlIy08ifyKw+9ZcsSCX1XeUgJGvAvUKzk3q/M
         Fy6OkH/k6yE2p8tb+W/B/NCTfkSwV6Yo7WzTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhMP+EYsF7thTSOZC6IuVUmea4P1pderJRDss92eoz8=;
        b=WNttDhF/wkao0irVi93bFEZVBxc/r7Rr9kf3gL0TtbZ/SJsQrN52McPpD0dvwargPL
         iIPtJehGnrZBfMF7hxxuif8vad06ZLJwBC6qLNdmD7CdlMaA7Oeux6SEkwOdFlY6vXbV
         dcm0XZAuJibu//RodgbJMvzmsW+qbpJokLBLcw13ZpHlZ4GhccM3BaQjrEmG6Ce8WxnO
         UHBXDiEtsF702S+tO3h5Bj5XGA9GX9H4KWiOBItxndNKjcwLwx15xXHEpZCgsPyD4/Oo
         ZK9qptLUJipq/lARQL/GWCNYB+urBJYlFNM5tIERW6e1hkqfFB9OakLagubKea6Q54B1
         Uaxg==
X-Gm-Message-State: APjAAAV8986UiY7F8UBrMuPSzAAYrGGpP9WTwESpAWqmu6PuickxSP/b
        mFd8vBfWUxCIw/z1f4Ursu6Gvg==
X-Google-Smtp-Source: APXvYqzlWcuXSUxEH7AfZ9a3T24GZ2bbv83kotRdaDRJLfwrjQctGDViZ4aZbXisd6XHnFLT7UDXSg==
X-Received: by 2002:a63:330e:: with SMTP id z14mr13613746pgz.4.1556920978074;
        Fri, 03 May 2019 15:02:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p7sm3772420pgn.64.2019.05.03.15.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:02:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 09/30] mfd: cros_ec: Remove zero-size structs
Date:   Fri,  3 May 2019 15:02:12 -0700
Message-Id: <20190503220233.64546-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
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
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 33 +++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 67e15c29e083..2e5c93d858d8 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1510,10 +1510,14 @@ struct lightbar_program {
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
@@ -1567,11 +1571,13 @@ struct ec_response_lightbar {
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
 
@@ -2991,9 +2997,7 @@ enum charge_state_params {
 struct ec_params_charge_state {
 	uint8_t cmd;				/* enum charge_state_command */
 	union {
-		struct {
-			/* no args */
-		} get_state;
+		/* get_state has no args */
 
 		struct __ec_todo_unpacked {
 			uint32_t param;		/* enum charge_state_param */
@@ -3019,9 +3023,8 @@ struct ec_response_charge_state {
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

