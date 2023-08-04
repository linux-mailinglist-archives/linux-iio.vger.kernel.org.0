Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC176FDFF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHDKBL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHDKBJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 06:01:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4146B1;
        Fri,  4 Aug 2023 03:01:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso3237563e87.1;
        Fri, 04 Aug 2023 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691143266; x=1691748066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSPZltSRUQIUHufTq3pkT56bksgDNIXjXhEtAeHqofM=;
        b=KAvHG75c00dAlD5NF61Ddw2oQRbNEgITCv7gV7B0qZZSzJe00NiLG4648JFnKvru8C
         qGyCybBCY5+NccUCp4HZZaiuENspsr/zPCtYJSIvG9x1BTX7hmK3NiJpnu+26xjY+l5y
         RsWsplYikSH7OJBzmL3QILsNk/OHtx3zV5kTD1O3rfdWM/gewYyrPuJjBYboN2X9FtBD
         lsOduls1E/4YySez4FF6JnNE2b6Zm1Nk9ojHBtgB6VeLrXM3WByL5kQa93gb28X7l2+C
         ZgTrOujmmnKDNynWJtWOA+1ht88iNkxg5TKVqDjtQD2XmUZzScnnsB2anOwrnQfX8aCj
         uaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143266; x=1691748066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSPZltSRUQIUHufTq3pkT56bksgDNIXjXhEtAeHqofM=;
        b=PJwo2HTpi2315FvryQ8X93bd/Il8p2lBs+9Tj3IWzHNoQqseqG1FoQLdHnVVJmCC2n
         2Nhe8gq7hjC4oHTohUMRz4OKHQw/OULuF90zoS9l/7mAx1gMN2LV1SualYFg3yMwNVcn
         aeKT6Le56hK0SjyPVM7F4kA6VNO0yTltIhGsMDb7Yrh9aay6XTnDS6/isv9kMXI7ecgm
         QSIF2Qu7i1tZNKCX1k4jq6vUbguvP7TbHaO534RmZZJzNIddMt2sqWqhwez78OMzU9ZX
         /T3BLo2DeQNlrTpfzsHEMtuW7RKYZARQG8IINg94pGQkiQvHLO7DEGxXY57kp2/yyUXl
         MalA==
X-Gm-Message-State: AOJu0Yy/LTvO22NaFh1KctH9f2reg94or8GBCCTJCSW3Jlq6e/qlbZbj
        ju/OEc1IMmjuefAJNlgULNU=
X-Google-Smtp-Source: AGHT+IHQGNObYw4Cwb4U5IuF9/OdNlz5RzvHRAUP8jgwwQjntNWkaXxKjvTM7J0YW4i10ASxyAIqdg==
X-Received: by 2002:a05:6512:20c1:b0:4f8:58af:ebd7 with SMTP id u1-20020a05651220c100b004f858afebd7mr790625lfr.39.1691143266188;
        Fri, 04 Aug 2023 03:01:06 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id o10-20020ac2494a000000b004f87893ce21sm311859lfi.3.2023.08.04.03.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:01:03 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Fri,  4 Aug 2023 12:02:47 +0200
Message-Id: <20230804100248.3773861-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Microchip does have many similar chips, add those to the compatible
string as the driver support is extended.

The new supported chips are:
  - microchip,mcp3910
  - microchip,mcp3912
  - microchip,mcp3913
  - microchip,mcp3914
  - microchip,mcp3918
  - microchip,mcp3919

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    v2:
        - No changes

 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index f7b3fde4115a..06951ec5f5da 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -18,7 +18,13 @@ description: |
 properties:
   compatible:
     enum:
+      - microchip,mcp3910
       - microchip,mcp3911
+      - microchip,mcp3912
+      - microchip,mcp3913
+      - microchip,mcp3914
+      - microchip,mcp3918
+      - microchip,mcp3919
 
   reg:
     maxItems: 1
-- 
2.40.1

