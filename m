Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52411351D
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfECWDC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46476 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfECWDC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so3515681pff.13
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yl9LIaaw5zAtBfEcA+TBAKczFNYIZa1zYtQlrYAdLxY=;
        b=TarcXvnKwae48olHX/4jlj+Ay6ojofQt2b8GTMshyqsqe62/8fSEP6HG+X2mAblTx7
         P1Ads56S7dF2EL6OWLjXvhAVZNpMS0X4SyQIUVGA9hyd2N8DhExkOCDoQ1gOnyZA+dXD
         CHulYOGk8lhFWjgPXUiD3Bmx8QXxUS64QFo04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yl9LIaaw5zAtBfEcA+TBAKczFNYIZa1zYtQlrYAdLxY=;
        b=Wg5JXdsW+3wfOzboPALnjid/0ztaKn0474ypB4twQKVfAP29btUt7ceeiKR1syUcCE
         ZyPlTjiDDfkRBxhGg+uB7D9+YsC1i2zawEsjDsVIEw0y/P1K6x5oAKOq3shKQ172tL3t
         WXNH9du9QmbSF6Iy6juyc3EVSwuFDSQ4aP1UQR7O4QrYjn3HuM7oJFDp03J2/5lUqHgA
         0ohlCcg45m7JS3u9Uo2fTfkTA1gJJxGt02yxNakp1D+4siPKpz2VBG1Tjh4j3Tquu0AJ
         2gqQgACtd0B2LNG23hBizVGtKrsId5ljoJH/2gQo7AM36SBMMCEz+nfBAwlhgfqac38Z
         +hSg==
X-Gm-Message-State: APjAAAXaSVOYxnykWrRPHDFsirhzEg6H/I2VKEZsd8hHrv8Of4uLuuMu
        FsiWtD7U1rlFvsaStyBLtR7Xzg==
X-Google-Smtp-Source: APXvYqyNpyWPQJ9mM+GWxXQytWrgsHiA9LYsw79pt4iZnkwhf1QDmNVIfMK+779lK5G6iNvO6rxN3w==
X-Received: by 2002:a65:4185:: with SMTP id a5mr13670008pgq.82.1556920981573;
        Fri, 03 May 2019 15:03:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id x66sm4241659pfb.78.2019.05.03.15.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 11/30] mfd: cros_ec: Add PWM_SET_DUTY API
Date:   Fri,  3 May 2019 15:02:14 -0700
Message-Id: <20190503220233.64546-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API for fan control.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 393c5abab7a0..5747bbcfa45f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1491,11 +1491,19 @@ struct ec_response_pwm_get_fan_rpm {
 /* Set target fan RPM */
 #define EC_CMD_PWM_SET_FAN_TARGET_RPM 0x0021
 
-struct ec_params_pwm_set_fan_target_rpm {
+/* Version 0 of input params */
+struct ec_params_pwm_set_fan_target_rpm_v0 {
 	uint32_t rpm;
+} __ec_align4;
+
+/* Version 1 of input params */
+struct ec_params_pwm_set_fan_target_rpm_v1 {
+	uint32_t rpm;
+	uint8_t fan_idx;
 } __ec_align_size1;
 
 /* Get keyboard backlight */
+/* OBSOLETE - Use EC_CMD_PWM_SET_DUTY */
 #define EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT 0x0022
 
 struct ec_response_pwm_get_keyboard_backlight {
@@ -1504,6 +1512,7 @@ struct ec_response_pwm_get_keyboard_backlight {
 } __ec_align1;
 
 /* Set keyboard backlight */
+/* OBSOLETE - Use EC_CMD_PWM_SET_DUTY */
 #define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x0023
 
 struct ec_params_pwm_set_keyboard_backlight {
@@ -1513,10 +1522,17 @@ struct ec_params_pwm_set_keyboard_backlight {
 /* Set target fan PWM duty cycle */
 #define EC_CMD_PWM_SET_FAN_DUTY 0x0024
 
-struct ec_params_pwm_set_fan_duty {
+/* Version 0 of input params */
+struct ec_params_pwm_set_fan_duty_v0 {
 	uint32_t percent;
 } __ec_align4;
 
+/* Version 1 of input params */
+struct ec_params_pwm_set_fan_duty_v1 {
+	uint32_t percent;
+	uint8_t fan_idx;
+} __ec_align_size1;
+
 #define EC_CMD_PWM_SET_DUTY 0x0025
 /* 16 bit duty cycle, 0xffff = 100% */
 #define EC_PWM_MAX_DUTY 0xffff
-- 
2.21.0.1020.gf2820cf01a-goog

