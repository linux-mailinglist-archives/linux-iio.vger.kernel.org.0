Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF347D2C20
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjJWIDC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Oct 2023 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjJWIDC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 04:03:02 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED0D6E
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 01:02:59 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 006d021491bc7-5845213c583so713550eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698048179; x=1698652979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WJLRl7gW5F2R9FLKTDY4Su7u0rxcic9SiQezCgXXFA=;
        b=dh/ed7X0OwFSvn2iT0oMJ24Ka6kasjYMC0NYy4gEKK2KkTXAiTmW4cuBo3dCYT1EjL
         grE/wdyu9mvY1v57AYiJFXcBbcgJstRIQNyxXwNaQj21oVqelVKq5D7BKmTCkKbM8a5E
         ZrmKvurAhNhTbAH6qifvf3FA7ree1Jc8LsbhgS+7lTsj0EHNwcZjp6H3emcwJk/Jj4sX
         mmc64t9UhghsdCzyLho/u4lIum4sHWKYUbwdC+qzr52Y5j4YI22NKA0rj5nT17Q21D1K
         ur6iZS3REbxvibNL6U3lKKJz+3opz7LtGETrxtdadAZT/ulObQLBVlyCa1yEHu3/Qxav
         fhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048179; x=1698652979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WJLRl7gW5F2R9FLKTDY4Su7u0rxcic9SiQezCgXXFA=;
        b=HT0Kufiut13/SwgaO6cKF81heH+aSvizCIxlcQd9vMW92BxMKnByADOe34BP4kpByu
         8WOTJAHdulx0+KcGqsofKF8GRB8+1udGVObb2V/7omhH1GEmSEGeHuXzgAnHvMVcHTDw
         yRpnr/yKhCqyB6NCNrX3wQQWWmGPZ7B/9J8Jz+NvUKJvt72d9c0Lct3b8TCyTi0Od7EI
         DBMNrZpJANnBDTjlZ0tNvkWBpZWx46ZHLx6Izyfox4g39YtnHDfWmw1/5pwzyKBX35f5
         CLvBlG6PTL/nYV/vxwcQQwHFlA4lxtWx/OQ07XTgmoA+KXa5N08wGP9JB5ojmapC252E
         zulw==
X-Gm-Message-State: AOJu0YzUdgHAQih3I/+9HcVKRaZxJlKjKinM7n9ZH4oCtQh5tiK82d7T
        9XzTbv45oYQxaN5c/hhKeqQ=
X-Google-Smtp-Source: AGHT+IEWk7WstzpsJr+XrA7+1VpCfC6kuC2utCOurxpAMCtTR1wvVJmWh6XazeOPE6domYM1eYEX0w==
X-Received: by 2002:a05:6358:c602:b0:168:cfc5:82c with SMTP id fd2-20020a056358c60200b00168cfc5082cmr4446670rwb.13.1698048178564;
        Mon, 23 Oct 2023 01:02:58 -0700 (PDT)
Received: from dawn-Aspire-A715-74G.. ([183.198.59.255])
        by smtp.gmail.com with ESMTPSA id z8-20020a6553c8000000b00584aff3060dsm4539002pgr.59.2023.10.23.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:02:58 -0700 (PDT)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Li peiyu <579lpy@gmail.com>
Subject: [PATCH] dt-bindings: iio: pressure: bmp085: Update links about sensor specifications
Date:   Mon, 23 Oct 2023 16:02:37 +0800
Message-Id: <20231023080237.218179-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The link to the device specifications in bmp085.yaml is no longer valid

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 .../devicetree/bindings/iio/pressure/bmp085.yaml       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..5c77769c8200 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -13,11 +13,11 @@ description: |
   Pressure, temperature and humidity iio sensors with i2c and spi interfaces
 
   Specifications about the sensor can be found at:
-    https://www.bosch-sensortec.com/bst/products/all_products/bmp180
-    https://www.bosch-sensortec.com/bst/products/all_products/bmp280
-    https://www.bosch-sensortec.com/bst/products/all_products/bme280
-    https://www.bosch-sensortec.com/bst/products/all_products/bmp380
-    https://www.bosch-sensortec.com/bst/products/all_products/bmp580
+    https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
+    https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp280/
+    https://www.bosch-sensortec.com/products/environmental-sensors/humidity-sensors-bme280/
+    https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp380/
+    https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp580/
 
 properties:
   compatible:
-- 
2.34.1

