Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3819468
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEIVQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:16:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44623 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfEIVOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so1823839pgv.11
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4A6ApDzHg0Vagve51lA1yKCs7saRi6gPeDJI9wPwJM=;
        b=iQwAmx3DF99ZighBM5u3JpSwG2F5puJlQg04gWc4p7y+CccRae+tsSz1De01VgrOey
         aw6KXJf2+XggzD1YgjNbx9Jtnq4AI0fUw8opWB+Fjj9V/zeSqHgjjib8Xnl3ajvNeNnh
         eqv0TELKfxtidTfYAwnMaxUxfvNlB8RyfeExY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4A6ApDzHg0Vagve51lA1yKCs7saRi6gPeDJI9wPwJM=;
        b=Xl95c4j3e8evztc6gbm3DP9NjDlxJTXqGTS/yUBqwzE8Grj57XthcKKuCc888PPZTz
         BDjSGT3zn0Z0/4NXST9EKjs4zdf86xbM1T6lHsLL78uKDp7y7vZma5xFuWDzsa5btCgs
         Y5fM0yFv8LSpl4Jw3bhQIvJqsU8orl5pyOG0wmNhYsXSBLu54PKmrMQ6Zz7avmPzyxcT
         zk/VeXD0MPpGrVBWGydLpmhQC9FNJ0BYia+103smyKXyIiF7VW0zj+wihkbgezBSGX5M
         ywTC0r0nnigIEAMSxfjpE1CrYNcTdjRBIEmtuYIOZUYeaXopx3rkvJyl0X3wm7PBWp3i
         ozfw==
X-Gm-Message-State: APjAAAVxMc1kccKcY+2bhVewY6LdaN4/QZnEieSpNQJLwjeYWr9wY+M1
        h61B5kZV+XmZIj8aXMap1o536g==
X-Google-Smtp-Source: APXvYqw3sRuUZF8CLJhv0NVP/D6q0xavfDBIfprlgR/LAKLe0nRNF0H46eszm2hvnZGWagdecZTS4w==
X-Received: by 2002:a65:64ca:: with SMTP id t10mr8581826pgv.177.1557436459846;
        Thu, 09 May 2019 14:14:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n13sm3874857pgh.6.2019.05.09.14.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 11/30] mfd: cros_ec: Add PWM_SET_DUTY API
Date:   Thu,  9 May 2019 14:13:34 -0700
Message-Id: <20190509211353.213194-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API for fan control.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 3d1d26f62bd3..2b3a94a4f0f4 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1521,11 +1521,19 @@ struct ec_response_pwm_get_fan_rpm {
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
@@ -1534,6 +1542,7 @@ struct ec_response_pwm_get_keyboard_backlight {
 } __ec_align1;
 
 /* Set keyboard backlight */
+/* OBSOLETE - Use EC_CMD_PWM_SET_DUTY */
 #define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x0023
 
 struct ec_params_pwm_set_keyboard_backlight {
@@ -1543,10 +1552,17 @@ struct ec_params_pwm_set_keyboard_backlight {
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

