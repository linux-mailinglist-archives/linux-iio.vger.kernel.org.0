Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB34CFFF5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Mar 2022 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiCGN1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Mar 2022 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiCGN1T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2022 08:27:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7984B8A6DD;
        Mon,  7 Mar 2022 05:26:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so9286481wmp.5;
        Mon, 07 Mar 2022 05:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNzPi6lzSrMkhOu1rYI3ULtZdVbsMI/D7W0iS0nwK7I=;
        b=j6zD/GI5UVCYlLn2RlFnlS8jKOjD4q23OdU4xdhWgtJKl51wL2hng+R8OIL0XKCORT
         SWKa4U/Q46Gp5zX5TQDt8TyUhLf0TRSCeytYUzAkWRh79W+JgnrJjMkX/lHul2lTsc4o
         sXIY+XQgqKXeEQw5gSLqPMelBy0QS3imdg6P7R32BFJhiOkZPAubzWGiMGQUmxKphrA6
         xzHjT4HD5XZ2BUk9FlW6SnLZMamfDfNmhKLQSFr722zwPcgYi6fV9iSf8X2zEpxrtDNB
         ksaVxHbASeJskkVpHF5qlXvk41MwLyxzd0A2H8TOEZGkhnFKwrfsiDln8X8ymSQbu9LV
         5ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNzPi6lzSrMkhOu1rYI3ULtZdVbsMI/D7W0iS0nwK7I=;
        b=X++uj5MCywMCOeTLzm3/XMa0TE/ulZnijqV6HyzY/1fiozo4XsCblLChpw1aJvfymf
         uio3i8yJMosC6ZQAo9cXMY1UGq3nchJ59PdYOAt/NJJr/lQQOkGo29hyh759mp40+sqZ
         GGWTiUU+PD3g8k2Z6ReiGmZZ078dPloaJHoQYzEpf2XHyV3oQmwimdL5BguiIdX8osRH
         X87C9oYAsPPnB4l7zLPlv1723gIW6BWvaj4qPcFhGNbD0y2kEomvipw+Ki1FQ29rCNwc
         wwWbxwCSQoFkf8ERj6aNz9Q2NPCADQ6eBlMWYXtcW+/1ghU5Kco59cjE0efsyBrDCest
         0gMQ==
X-Gm-Message-State: AOAM530rFevYxozwP7zQuAar1FGBMgPN8wBOOqnVzhqVKA1wdi+x3U+x
        sUVhvCvLp75fhuAjYaS5D7s=
X-Google-Smtp-Source: ABdhPJzBi2Gx0TRle166BfImeAEW1UaeXhRjiA2VHhvoO/mPqFyM5RsMZAr1e12ln/skTAr6lj8K7w==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr9186439wml.160.1646659584094;
        Mon, 07 Mar 2022 05:26:24 -0800 (PST)
Received: from tpt440p.steeds.sam ([41.84.249.145])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm11524965wrw.74.2022.03.07.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:26:23 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        maemo-leste@lists.dyne.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 2/3] iio: accel: Remove unused enum in st_accel
Date:   Mon,  7 Mar 2022 15:25:01 +0200
Message-Id: <20220307132502.73854-3-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307132502.73854-1-absicsz@gmail.com>
References: <20220307132502.73854-1-absicsz@gmail.com>
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

