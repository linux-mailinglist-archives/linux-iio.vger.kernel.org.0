Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B65F4276
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 13:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJDL44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJDL4v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 07:56:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABB23BFD
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 04:56:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k19so1480986lji.12
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CkVLRt6oEZ54xF22urRfcES2f955CNvMgQuZB8MJX3M=;
        b=V+255m3zUgj9duoQq2iOXmX8d2fQw1ChL2ZkjolZ8LH3y5rX+qWCadCkwZ4hnu8fjG
         AqjF9WEMbWB3JWhnON4XbCkoazXaarunre1JRGUyG+uEAp1ogfHJnxy/IZjXDxeBANce
         pj7GTUmBlXSrV8WOCmBBCBLvDZrbIdwZ1Crgk0p7qduNecgHwCoTtxw7HJeuXVanbq6m
         IeeKJUx7JuxgF8CwMh8uU2Wy5XiyOTy0P+Yrma1az3Dirz/qGT4lMMMpS7KAkqm3XJXv
         Q1dLS6VNiF/yxLwP4MmjUi4IwwFm+LixjXHA7W9ZFgJpdcfnuZcVHnW1cQ/RltiUFNtv
         nFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CkVLRt6oEZ54xF22urRfcES2f955CNvMgQuZB8MJX3M=;
        b=RO9TshAqUx/nwHw/LCle6MB/0mZM7Dx9Od6h05zxp/TiWNtXTSrKsDeHtN2FIFttj5
         TIQO4w0aXF3c4ufq1F7Mz7WT7E5qdkryTAaKI+iydV4ZCj77ysQnwOJDYZ+wDVQ06oMF
         4HiJS9iKNGxWDVA13C1LPBquwu32PNHWSJn1TLd+Y/hADwxrAbn76rzKLD7C1yjG7p/Z
         Nl+pFI+B4vMia1jdLyuze/5EgBxv0KqdBgtjL9iaNS/NP887l/EMLl8AY6hswDlWsZY4
         EzvZSrqatMswsb+FjTB8sefWnP2J2PQbrzqalCyH7lIecj2Trpb5I0jfCJ2YFY7xD7vv
         C6Dw==
X-Gm-Message-State: ACrzQf3XVRjmjC53X2TBXzCT3dJFBu29pXlKb/H9DeDtoG9vciE/7+PP
        3fTzjJIVLwfkGCWqRuZesNflOA==
X-Google-Smtp-Source: AMsMyM52Uz3CLl59/iIWiiBHl8yzdccky+00QtKyUWTIWybkGAQ+P+yYRGj65BG22CuT2293jgfy4Q==
X-Received: by 2002:a05:651c:b13:b0:26c:679f:ea66 with SMTP id b19-20020a05651c0b1300b0026c679fea66mr8610289ljr.516.1664884607920;
        Tue, 04 Oct 2022 04:56:47 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/8] dt-bindings: iio: frequency: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:37 +0200
Message-Id: <20221004115642.63749-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For devices connectable by SPI bus (e.g. already using
"spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
schema to allow using all SPI device properties, even these which device
bindings author did not tried yet.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/frequency/adi,adf4350.yaml     | 7 +++++--
 .../devicetree/bindings/iio/frequency/adi,admv1013.yaml    | 5 ++++-
 .../devicetree/bindings/iio/frequency/adi,admv1014.yaml    | 5 ++++-
 .../devicetree/bindings/iio/frequency/adi,admv4420.yaml    | 6 +++++-
 .../devicetree/bindings/iio/frequency/adi,adrf6780.yaml    | 5 ++++-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
index d7f20b8518e0..43cbf27114c7 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
@@ -160,13 +160,16 @@ properties:
       2: +2dBm
       3: +5dBm
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
   - clocks
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
index 23f1f3b55abb..fc813bcb6532 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
@@ -70,7 +70,10 @@ required:
   - clock-names
   - vcm-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
index 2716c1e8fe31..ab86daa2c56e 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
@@ -104,7 +104,10 @@ required:
   - clock-names
   - vcm-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
index da7fe85ec92e..d4b92481af81 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
@@ -37,7 +37,11 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
index 3a8ea93f4e0c..f11391ab4b62 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -113,7 +113,10 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

