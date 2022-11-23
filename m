Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06B76367C9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiKWRzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiKWRzO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:55:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767DC6548;
        Wed, 23 Nov 2022 09:55:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w79so228175pfc.2;
        Wed, 23 Nov 2022 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+M3x55LJlAjHZJKxmYKxIY2+MF/c7xVWLTdidtcZn4=;
        b=b3UVpwmGo3F4HCcrN0/3YXUiCz7Qzq3EIzUyux4zu/Usmg51yIMJPmFtWtDggK5S8f
         lI7LCMtHp6E4jtx8gmyI6gf+W+JkDqmnj1lzEpw6aljSLBTxQSWf4bwohTD8XuCTc72+
         ZMI+8nXMEQWnigyxM8sbRT5SDl9drWpXk+7WnD1g+PWIQ+j0AAq5yAnn1nAcTTq2aD0y
         J4beUJeALB/LOaDYXzGQkwBVW5nx1PNGE8xi39oyvqEdVzhNUn7VXdklTspp9F/j+LEZ
         Lw75eYUc6vhLzC1COtFM8sWQamshZHMbMq2wm+/vn7wOPmPuEL0Bc1HrpNiFNWN9C7gR
         DDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+M3x55LJlAjHZJKxmYKxIY2+MF/c7xVWLTdidtcZn4=;
        b=4El3w7xoCSZM53StdczRDO8fF0OT6zzIXqaUXuHXG3sbbswjKlauejM+rbKHZATqhF
         TDyEm+qXHqe9DTozOfNY98Vk4CvRGVQ9HlW2ECYqAcmBWJJPodWbRdbVKzWCDvcgiQo1
         q0is8f5LeF3u6UIiVsPYwjzPQQnxNSXSpF3CkTQqWX/PovMSfAtj3600WSzBlxVHC9p2
         UX+Bn2UwxOYGylFF8dQZNNyIyOdxiN0tPvsi8pgPZRsYXLPTQupe7FW5ooiCHNGuwhB6
         ZXjfKxOu+6MODYAQvGwF8w8khYsEzr2sGcNNfvlNscgePKgSYu58A7NYsBa76hx4Wwgu
         31CQ==
X-Gm-Message-State: ANoB5pnGXIeFxnKFcA6AbIt7KhPCpnm9EcUX2Ix8La9fg078L935EC3J
        ZGGoBBP1ssp5MYABY3/iPao=
X-Google-Smtp-Source: AA0mqf58zOVYwaWP7qDZBa6fJLF9D8FVab+2rjJ66s8oQ+tlRPc9N//pjAKRFg6ppcYOMchpCNVlIQ==
X-Received: by 2002:a62:2544:0:b0:565:b27d:1f61 with SMTP id l65-20020a622544000000b00565b27d1f61mr19760787pfl.85.1669226112706;
        Wed, 23 Nov 2022 09:55:12 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:55:12 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 7/7] power: supply: mp2629: Add USB fast charge settings
Date:   Wed, 23 Nov 2022 18:54:25 +0100
Message-Id: <20221123175425.564042-8-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allows the user to change the USB device fast charge setting to advertise
host on enumeration helps to accelerate the charging cycle. Altering this
value resets USB existing connection.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../ABI/testing/sysfs-class-power-mp2629         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
index 914d67caac0d..40abb9a11d97 100644
--- a/Documentation/ABI/testing/sysfs-class-power-mp2629
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -1,3 +1,19 @@
+What:		/sys/class/power_supply/mp2629_battery/usb_fast_charge
+Date:		November 2022
+KernelVersion:	6.1
+Description:
+		Represents a USB device fast charge settings.Altering this
+		value resets USB existing connection
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
2.34.1

