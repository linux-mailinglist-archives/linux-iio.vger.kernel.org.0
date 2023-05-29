Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207B7150B9
	for <lists+linux-iio@lfdr.de>; Mon, 29 May 2023 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjE2Ut4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 May 2023 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE2Utz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2023 16:49:55 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93DD9
        for <linux-iio@vger.kernel.org>; Mon, 29 May 2023 13:49:54 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id ADD441005E9;
        Mon, 29 May 2023 20:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685393012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UhVQK7t+HosSVy3q0W/MQmzaLul2qg9td8dQYWmD0k=;
        b=BR1ELm0lTE3YGEG0DQRxvZAaxdI24SK7OtZgNG9O471K5TJQF/KKId68A3wUnZyBpe6Ai6
        klpuc/f5L6nRPJFTk0M9mViM8330O3X2Wog18JST5c5Ud4OCILQcOiHOf9s/2BqymHOcj0
        trrK64xgMn/d4X9+VRSEkQVOJNdrBw0=
Received: from frank-G5.. (fttx-pool-217.61.156.2.bambit.de [217.61.156.2])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B9450100AD7;
        Mon, 29 May 2023 20:43:31 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: nvmem: mediatek: efuse: add support for mt7986
Date:   Mon, 29 May 2023 22:42:55 +0200
Message-Id: <20230529204258.65238-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529204258.65238-1-linux@fw-web.de>
References: <20230529204258.65238-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 43c692b0-9847-4de0-bc01-d0ed8cf8e474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7986 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index d16d42fb98b6..7ec2988b597e 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - mediatek,mt7622-efuse
               - mediatek,mt7623-efuse
+              - mediatek,mt7986-efuse
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
               - mediatek,mt8186-efuse
-- 
2.34.1

