Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71AF4C988D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 23:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiCAW4g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiCAW4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 17:56:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF863BE3;
        Tue,  1 Mar 2022 14:55:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so158511wmp.5;
        Tue, 01 Mar 2022 14:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNzPi6lzSrMkhOu1rYI3ULtZdVbsMI/D7W0iS0nwK7I=;
        b=NYe99Fdv9qsx8DcTwWi3jT40gLeUuxSdfRVMXv/0Cbdc2FcRPOhYWVXiDLetBUfu6u
         79eg0LcXfk86tefC38uAjHG3ryr6kkvIdK/XdY23iRMfJYdBDd2A4Fh8n5DqEddmOIWK
         RS7x4A8WcJ3SKhMUk67uvRkA+VlbPX+mDhXvuhDfj8uV/j7Kcah0YC3IT3lNE4A7W+Rf
         xv2tbP7dhTE3guKJJUyuhUEHA/xOXNmHNwOXeZIitgYKHs89r/2G+PpF8L6XSpM7Kclz
         ujq830pScvgXZKTkpQ7TPvJ0Q5+78S0YFayVwzpQ1xUmHKMBZCGCtPJ/YVsdl+PkebHD
         FUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNzPi6lzSrMkhOu1rYI3ULtZdVbsMI/D7W0iS0nwK7I=;
        b=ViBDsvRxOYLiPTZ6VIqXOU8Na821BTSTBKgFNlGycnYd7hLdxoLsGPJY+6xLXPkBoS
         fm3QeSx4Bm3MLFxfMFeBYM1cxo55TUYduQxJk225BwoiGeSEEKIgd+QTKxJ9ZC5tdle9
         mwHPNpThSed/ejw7VLqX1kp9mts+jAeI4eOzwkiGP/zXDXAHp2h2pxl1XLWeU9dajOmH
         Tmvyu3vCanfjSRo86O5oTnLrVslenofgld2vGl4V+Wg40ft46ClF3XFK2gMQBBVaWHhX
         xap+byi0fhUqQvcdi7BvG+kB5sCzdCvkPzEZFaXDnq2jo+6NNgK6Isp07RYpPPOWLZ+k
         LmiQ==
X-Gm-Message-State: AOAM53340HpOfSzX+jj8RVgts4PWhWSHutoi0o048DNg3N5OT/3+WcLE
        GSswj8Klw5+QG3+or6qCHWA=
X-Google-Smtp-Source: ABdhPJyZP20LQkQj+YixbYNY6tJ/bEpDvaEjnSUtfgHWcNnibZskJe0KHIsoTS+hv2ByyiJ6nxZF2A==
X-Received: by 2002:a05:600c:4f8e:b0:381:6de4:fccc with SMTP id n14-20020a05600c4f8e00b003816de4fcccmr8093260wmq.82.1646175351789;
        Tue, 01 Mar 2022 14:55:51 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm5314832wms.7.2022.03.01.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:55:51 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v2 2/3] iio: accel: Remove unused enum in st_accel
Date:   Wed,  2 Mar 2022 00:54:31 +0200
Message-Id: <20220301225432.60844-3-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301225432.60844-1-absicsz@gmail.com>
References: <20220301225432.60844-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The st_accel_type enum is not used anywhere else in the code, and can be
removed

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/iio/accel/st_accel.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 8750dea56fcb..969cc7faca07 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -14,31 +14,6 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
-enum st_accel_type {
-	LSM303DLH,
-	LSM303DLHC,
-	LIS3DH,
-	LSM330D,
-	LSM330DL,
-	LSM330DLC,
-	LIS331DLH,
-	LSM303DL,
-	LSM303DLM,
-	LSM330,
-	LSM303AGR,
-	LIS2DH12,
-	LIS3L02DQ,
-	LNG2DM,
-	H3LIS331DL,
-	LIS331DL,
-	LIS3LV02DL,
-	LIS2DW12,
-	LIS3DHH,
-	LIS2DE12,
-	LIS2HH12,
-	ST_ACCEL_MAX,
-};
-
 #define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
 #define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
 #define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
-- 
2.35.1

