Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779BC60AEF3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiJXPW4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJXPWj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 11:22:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620F18F923;
        Mon, 24 Oct 2022 07:06:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so11373255edc.9;
        Mon, 24 Oct 2022 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UBEsDOtGvuqocb1tQphZqfQPO49fazm6XTep7E5qLU=;
        b=nDAwkhGpUseVldEa+nd6n9zF/tkqyQhZlEI9B4uy5NneWVkbJl1WuxqnMr3UT7mk82
         BspUUfEUTcKa8mBe65Q3kL7B/2T8UENqq5LM0iTq/HEtj7cWLPts9qPIj+FAMeWjI8VA
         oUTSPRXOVimyRDgRTbQ8Kgsopaqrd6/Ma280044VHyYnJbY4hnpecHJdDrWNM1tAgu0y
         KsJxs9vq+5A3Euo3RHHUaTFQvh6vVYFP2cIUYEtAD0y0fB/drr3NUS44qgNJSqWWcrUl
         kYyVfkqEjeMRF01E0N8dfPwquasC/ka9GoShuPZ7XevSvAWv7TaEAISDlTFsLf2unKgO
         9axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UBEsDOtGvuqocb1tQphZqfQPO49fazm6XTep7E5qLU=;
        b=KZY8hcA1qYxCRdyVLxi+ShPL3NUVwNBUyBLRggVNB5KeWv3wHMCcybeKXR/skt97we
         UWNS/hw63Ri2CYokkPA9bkTl2D6WD2ayn9z2yPx5oGa4e63ObbyOFtixYyMR/IJgs38q
         i7bseoEQ03BlbQPet9PJ2Pw8stp9Ddm2ELzbfVidyBkAO9evRnkGTJs93Zo3MbdgxLoh
         +qiaIi+J7nUNXSXLOKm1tn6ChvDE4Og/F1/oVVAZ5Jd4HewpqrsJ+jMf5e4X6KhLPHRa
         P2LYnpVepNbWlmhIgxqLu8beWQWUQM0ygPRVk8DLBxr3K5fAtOOBLC0mQaElazM3uefS
         JRhA==
X-Gm-Message-State: ACrzQf3qtKnzJz+DP6c4dzx/aFC4Zw0aDonWhSp1gFBlvBTSNhPvcVpj
        UfhBd88KA4I+QT99m4H9uTV9Or5NMpM=
X-Google-Smtp-Source: AMsMyM741Q0+KuGzBJqCT6ePEjtdpRdPVylZpUQ2x6R6r5bekAgiB5+Ns9qejo/ngiDM7t/TJvK10Q==
X-Received: by 2002:a05:6402:3705:b0:454:e006:82 with SMTP id ek5-20020a056402370500b00454e0060082mr30580615edb.360.1666618086450;
        Mon, 24 Oct 2022 06:28:06 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:06 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 5/8] power: supply: mp2629: Add USB fast charge settings
Date:   Mon, 24 Oct 2022 15:27:54 +0200
Message-Id: <20221024132757.3345400-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
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
---
 .../ABI/testing/sysfs-class-power-mp2629         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
index 914d67caac0d..b386d02cb010 100644
--- a/Documentation/ABI/testing/sysfs-class-power-mp2629
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -1,3 +1,19 @@
+What:		/sys/class/power_supply/mp2629_battery/usb_fast_charge
+Date:		June 2022
+KernelVersion:	5.20
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
2.32.0

