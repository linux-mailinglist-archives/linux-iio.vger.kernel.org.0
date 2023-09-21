Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975D7A9E0F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjIUTyi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjIUTyW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:54:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA3D6E45
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:27:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-773aeb22094so128937385a.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320862; x=1695925662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCRMmvveaVcVSR15oJLrWC1xgCD5rCKuEjC1MAuPd54=;
        b=xUV3L/cBqUbplZvJ9Q8K/h6fKfYnPwvRKfxEuIOQoJGm7nXjDl/JTqIfTbAjTkAbeV
         AaDfzKwWsUsyi8h3N4V0fLruES5aXVRFYKK2Da6vqBH918Uh9Pi/DWKMeTbyVDPGpEaP
         zuSoY/UF9aLRKboeKDJLGjG0YFfaIxyeDCiowGaEpC6yd+5ieYHtl1b3ikdynZEeNigE
         9CYtDzsgHgGu7Nsm2LeH7UwyhrPeTyhCxIM6tv9HpdhH/nyS59Bqa+tVquUKD4jdj120
         TNwRQnINTMo4xujy53/15LHd3Il+MrasXefD0T157unikfLjTf+OwFvMZp+VAYo33892
         sVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320862; x=1695925662;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCRMmvveaVcVSR15oJLrWC1xgCD5rCKuEjC1MAuPd54=;
        b=j19+wbxN7Nj2Hw9TNRCsSRQOgly/UCcxEFqo9tnly1coT7+bJvMZr0r5MWlT/JyXfO
         8JO5pCIa9soxU35mKe4iqyLalrr5O88mHzLRv3Q9mO9kg+4BXFMFrU0Lzjnn9TS4d8cT
         RzLsXbpi0fTiNXP5oZB5WO76PMdAK28b7BDWg1Sv895zogdA3ImYi6Ef7ApQbtQ1jPat
         NwZjKdoYxsWjsrF+3kf7PvbqKI/W1ghVc+cKvDdUgeyxFxGsN+MGpciIRtZuhBifib/O
         EOjLhE1wFqXAUr1EnW7z3wGKYgnuAbVGuFIJfJ6QLfHzV3HO23TSPlPXaf5B4ZzjHU9E
         /7Fg==
X-Gm-Message-State: AOJu0YzQIcmn4JU8m9Q4fbIu0SOzwK/btVbsokTderM9rYxTyoCltX1o
        yFnVPa213OLEdrjESRuU4hIpSqN9LXbIN7ildw==
X-Google-Smtp-Source: AGHT+IHDyKp3cW0YeVyd0vhCpme6YAoecIObStizWMW7RFLYKWXmo/R2pTAhUCAwSHys9UXUTSOhS+KIcqAGjnZGfw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ce49:0:b0:d80:ff9:d19e with SMTP
 id x70-20020a25ce49000000b00d800ff9d19emr63960ybe.9.1695279663292; Thu, 21
 Sep 2023 00:01:03 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:01:01 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC3qC2UC/x3NwQqDMAyA4VeRnBeojei6Vxk7jJptOawtiUhFf
 HeLx+/y/zsYq7DBo9tBeRWTnBr6Wwfx905fRpmbwTtPLvgebdEUy4azyspqKJKxaK7yl2VDq4H 8gBHvkQaaxml0FKDFivJH6jV6vo7jBIHQTo14AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695279662; l=2848;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9jDyBMkgavsnNjxewPyVtkova19FE84VVZK9Pvb/rDk=; b=e5TEjYsjowMhf9fPiePv9hrz9ZlUb1GRwFyDE70vdQLcICQkLpAoogAgOXukubFmfNkqyHkBm
 i+6F0QbTVSPBtqz25d/Mw5nxuJ1Y4S/g8IQULtXS2wdUiW7lNb3r3H6
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com>
Subject: [PATCH] iio: sx9324: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

`prop` is defined as this string literal with size 30 (including null):
|       #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
|      	char prop[] = SX9324_PROXRAW_DEF;

Each of the strncpy->strscpy replacements involve string literals with a
size less than 30 which means there are no current problems with how
strncpy is used. However, let's move away from using strncpy entirely.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Moreover, let's opt for the more conventional `sizeof()` as opposed to
`ARRAY_SIZE` for these simple strings.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
FWIW: It seems fragile to base future `prop` stores on the
size of it's default string.

Note: build-tested
---
 drivers/iio/proximity/sx9324.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 438f9c9aba6e..25ac2733bcef 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -937,11 +937,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-			strncpy(prop, "semtech,ph01-resolution",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph01-resolution", sizeof(prop));
 		else
-			strncpy(prop, "semtech,ph23-resolution",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph23-resolution", sizeof(prop));
 
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
@@ -1012,11 +1010,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_PROX_CTRL0:
 	case SX9324_REG_PROX_CTRL1:
 		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
-			strncpy(prop, "semtech,ph01-proxraw-strength",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph01-proxraw-strength", sizeof(prop));
 		else
-			strncpy(prop, "semtech,ph23-proxraw-strength",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph23-proxraw-strength", sizeof(prop));
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
 			break;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039

Best regards,
--
Justin Stitt <justinstitt@google.com>

