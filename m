Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72BA54CBD6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiFOOyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbiFOOyK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:54:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEDA2A713;
        Wed, 15 Jun 2022 07:54:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z7so16509457edm.13;
        Wed, 15 Jun 2022 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Clv+JrvN5xAcPquJt0P4YgFaBe3M0B8HPlEXIs7o5U=;
        b=HrtHARPp1Xww8CBJG9O4NBrrfnhmef+9FXRkvUyzllK9op+K9cZGY1fehxk9grKgHY
         GXG8hbFJmnK1xu6+2TrgrSAG+cB24FJfiAfYcRiwqWkj93oaOlOQqXuMVjpVunw42Eh9
         Ic01ViH0sn0OgIrXBmb8MLUd+fSF/U+W/2yweKyF/YHyYD4tqXI5TqM2RNiaSZ7HyAGE
         LhvJfMTrdPlcViZc1fR8Vog7zFnv1USEDDM/EHuikEP0KxjT28VAOXnok/WMudsIIFPe
         okjTVnGvKusxFqBBd8C8vPywNotJLvPbxzNfUfkack9T4AHjFsmz+LTgoOBacXGwC5dc
         QzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Clv+JrvN5xAcPquJt0P4YgFaBe3M0B8HPlEXIs7o5U=;
        b=rESDyNqitKt9DVc3tJQHg08ZM2pQCR13Znn4XzQSAUXoy3Zv3ZWl78v25nVzvLaj/W
         JqI+Tvy8SY0AcYcewMN1eDnxu8UpuD5ARZuONwe5R8sCwbEHfiSg7jklqYTrHoMgIW+M
         V2EBW7NY67MUtqHPY1Ay/KvTHrTfQX5y/NyrSRXC++dsOepgPozrvPKgF1HZUZy38ilb
         jKztQAbv8k/JmUXYhMcJ1tI4cAgifFJt/dDD9gGpx+7oVOhV32xk2/NuWFJ1rWjVC4al
         X69apCMDuNt1JDoi+ydKn2JtHnp70LBQgoKRV3+O1lo8inBKeQEjU4ZQQlfWH1l8pz0U
         BGIw==
X-Gm-Message-State: AJIora+SoCENK6tjuysj1qCh2ASUih1+7zCp9TGoq98d7SKNdQKXxP7C
        p5x60LuWc6eYjymcP484TwI=
X-Google-Smtp-Source: AGRyM1ujs1HeXOasq6DHF83w4PPcRH7kW5sgTud79flC34uP4Hx/vJhKCSdoYRUWd1SFHAiZyCK7Fw==
X-Received: by 2002:a05:6402:51d4:b0:42f:b38d:dbb9 with SMTP id r20-20020a05640251d400b0042fb38ddbb9mr100501edd.255.1655304848997;
        Wed, 15 Jun 2022 07:54:08 -0700 (PDT)
Received: from localhost.localdomain (p5dcfe5fe.dip0.t-ipconnect.de. [93.207.229.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063a8200b00706287ba061sm6341665ejd.180.2022.06.15.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:08 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 6/6] power: supply: mp2629: Add USB fast charge settings
Date:   Wed, 15 Jun 2022 16:53:57 +0200
Message-Id: <20220615145357.2370044-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615145357.2370044-1-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
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
2.25.1

