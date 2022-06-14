Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81D54B45E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356556AbiFNPRs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 11:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbiFNPRq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 11:17:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2B614B;
        Tue, 14 Jun 2022 08:17:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v1so17769568ejg.13;
        Tue, 14 Jun 2022 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2W1wCeUkrJFdZgVUbL1ARvVnvMUdCeqcmW2xMidDUMw=;
        b=ksfRLZiEEqqqPT9ugF93LrfXd+48fpeQ+2CqwR2liioi5OvFf8ogwo9yxuJwJ1s31C
         bkM+H/vysA3efjajHEUfhkkZcUKgZsd9/8hxpJMgozvzrikGlPCAFI19cXNYoXRDAQ+o
         uDYh15tWIRnKMkZUqz3mM565GR4gpaPTKKjLvrLhpx4iPoAkJwhewM4QG6XPUyK6k9/S
         7A6fH/T/6b/cw7HXrJDu8qum6mvCU/xWEdl/i+5Y9MUK/yIIVv9NKStLgckgEs5uelLF
         gzIMryAUDK0L2swAggGi7XFzqVTq5Hmw2Wcv9tEfmkcKFhl+D8CVaJQe6Q4YhLMLMznS
         Sasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2W1wCeUkrJFdZgVUbL1ARvVnvMUdCeqcmW2xMidDUMw=;
        b=7Jaa27jXQjFg5M0lNb7kAdTsqMjSo/ffUi9iyMI+uBAMS+pChPsaIgnt7K6wrbpXna
         G+ocxBgHOBRuYkulI8vHF4ruUaaa98zPUx6XMeu+JSE2agAjh4AuzMlOV/bTY9BwojWW
         sSeNpWnKgEQC3KFfMBVecq8qwyIFbwnoHq1CKnBR4bOCi2ub9z/rYgVDUrrjcDaWJKNb
         pcSSPaG1mmNU8eKV2JOB5QeMDSYXEWJ5m+jOo6jJQsXXzxx7XnKL8TZP7eUs9KqmVR+t
         DuOflFMzELfSmx1nRRAiOoU6cX53CqjvAk2YHenfWzkSBsn2sB3L4mC1cIqYnUtjW7Ro
         MdCA==
X-Gm-Message-State: AJIora9Tqa8U/7o73ooRE6UI/UZZDd06i9WbeDYOzNvfQMO+uTvjSE/P
        CHOmdzZgjJJ6Uc+r4BEeRLA=
X-Google-Smtp-Source: ABdhPJy1mWhyep+XKrfVSwjeDQnhUleoXiuLknBv9l0tW/sYCIz0d5YBMgJ96+24pyLgKyUNmsKEcA==
X-Received: by 2002:a17:906:1c9:b0:712:1115:42a5 with SMTP id 9-20020a17090601c900b00712111542a5mr4654969ejj.662.1655219863821;
        Tue, 14 Jun 2022 08:17:43 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id f1-20020a50d541000000b0042dd7e13391sm7198180edj.45.2022.06.14.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:17:42 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 6/6] power: supply: mp2629: Add usb fast charge settings
Date:   Tue, 14 Jun 2022 17:17:22 +0200
Message-Id: <20220614151722.2194936-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614151722.2194936-1-sravanhome@gmail.com>
References: <20220614151722.2194936-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allows the user to change the usb device fast charge setting to advertise
host on enumeration helps to accelerate the charging cycle. Altering this
value resets usb existing connection.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../ABI/testing/sysfs-class-power-mp2629         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
index 914d67caac0d..42f37675aa0e 100644
--- a/Documentation/ABI/testing/sysfs-class-power-mp2629
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -1,3 +1,19 @@
+What:		/sys/class/power_supply/mp2629_battery/usb_fast_charge
+Date:		April 2020
+KernelVersion:	5.19
+Description:
+		Represents a usb device fast charge settings.Altering this
+		value resets usb existing connection
+		USB DP:DM[0:0] 0.6V : Hi-Z
+		USB DP:DM[0:1] 3.3V : 0.6V
+		USB DP:DM[1:0] 0.6V : 0.6V
+		USB DP:DM[1:1] 0.6V : 3.3V
+
+                Access: Read, Write
+
+                Valid values: Represented in bit DP & DM setting. Valid
+			      range is [0, 3].
+
 What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
 Date:		April 2020
 KernelVersion:	5.7
-- 
2.25.1

