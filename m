Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D50654BACD
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbiFNTml (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344422AbiFNTmk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 15:42:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D25205F1;
        Tue, 14 Jun 2022 12:42:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id me5so19204827ejb.2;
        Tue, 14 Jun 2022 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+z2+RuzeYw1a0nCJ6ZCCmp0DVelodSSgQsNMZ7jN89U=;
        b=cJ7kX6JQZRzP8EB/VLzZ/rsoluvg54LWlfIOnE6HF4ij2gnlskznyS4QUGMtgGXr2u
         7CtN7qgsyjet5Azz53Yv+Yds9SEGess/Xr0xf0/EcaxfEE8q0xh2vREuD6eVMn3bHMbH
         qw585uOE3P0nhauW1STCiWoNTw6LycRESp0yYBCp0rtyEMxWGSaGTudKSf3BO+PcR+04
         5NdMeMGW1oJTCeOWeGfiDEWCVDcYcCSdgLFYp5G0GfzTc//NHhdEary5SchmPIYxtv9q
         p3COrGJeiXHCHHnNmGnyReGVTl9eYdoBjH4NTECAI7HO8wnjeJuk1BCJQW1WoaJ/2MiU
         bADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+z2+RuzeYw1a0nCJ6ZCCmp0DVelodSSgQsNMZ7jN89U=;
        b=A3XJQDnvqxRmqiaWUyuGrYOy+cVWe+nxQ79dM1Zvymvhs6d3WE9SemgEpC53K9ezlo
         IrvmkvkCAJaTyQ4b/sUYm/gucyqsBySMy9OJ95ae3IDGfNe1KZDii4W5pR0b0l+9/SiN
         w2jyPwccawlhc1UVCgrbuxkwh864y+zEpmKs4WR+7lXY7+V685VDhjDr7jL6a+hgkmMU
         fEVrkPyf7deWXIugnF1Mz1yCZ9BdzT1SY9mdgG9xp94PUuf0c8lc0YAHuxjAvAwQj3SY
         /rW9SNFdJnmVqSuET9YXafRcU1gaCEVApZOoVhq7szkZcaXGg39Iw6V+ho0UAWTeKdr+
         jPqg==
X-Gm-Message-State: AOAM533sJw/2Tgw/uzKV4t7BYTtukejtWAm8RLQWyKBcle1RhJhF348/
        QmriwA8GRgMxk2kNkDBdE6A=
X-Google-Smtp-Source: ABdhPJx2p8pxoJOxCffu8kDS/0ExN/Cx+SMmSX/pDxRibwiNirhzMWLOhgbfP6jvibvPNJXd5dF20A==
X-Received: by 2002:a17:907:da2:b0:711:f408:f098 with SMTP id go34-20020a1709070da200b00711f408f098mr5704530ejc.208.1655235757695;
        Tue, 14 Jun 2022 12:42:37 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907058500b00712057b037fsm5306699ejb.167.2022.06.14.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:37 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 6/6] power: supply: mp2629: Add usb fast charge settings
Date:   Tue, 14 Jun 2022 21:42:25 +0200
Message-Id: <20220614194225.2226447-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614194225.2226447-1-sravanhome@gmail.com>
References: <20220614194225.2226447-1-sravanhome@gmail.com>
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
value resets USB existing connection.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../ABI/testing/sysfs-class-power-mp2629         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
index 914d67caac0d..6f1832761fba 100644
--- a/Documentation/ABI/testing/sysfs-class-power-mp2629
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -1,3 +1,19 @@
+What:		/sys/class/power_supply/mp2629_battery/usb_fast_charge
+Date:		June 2022
+KernelVersion:	5.20
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

