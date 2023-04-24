Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3896EC8B1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Apr 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjDXJXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDXJXW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 05:23:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5A1B9;
        Mon, 24 Apr 2023 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682328201; x=1713864201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+MzlbYDAy9LH69SHQ+jHTKd7Y60sbpiM9FfO099q13Q=;
  b=nmzYP84KUS2KiQbm3RnciQTu/vVjWKP8Kk8XQ63Hdt1HTqkLkwSUhItd
   1DubdsK29+FYw4upJFBs63ew/zTvUaBNmhMQIzCI9JpWnaD6vh6ck1Ml8
   TbYSnXso+v5yP4BlEXqOgmbeYxC/1pP6WFYVIBbZcsvU48wLzb7IYvXCV
   ZN4HinovIEYpQ9PtiooJyRs1EVJOz87dxUhKjpP8PEGhpym5UzeBVnHO1
   3qmIeHRAtaAfthojMF28LzJKllWx4NsObgabnUJ5n2wzCmEjj+UQPxkFp
   f/zSBHnHEYBPrTA9MCL3WHNJ3AgyTorV5LTUOCbGttdtfRgcB03ZRPHSu
   w==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677538800"; 
   d="scan'208";a="30510899"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Apr 2023 11:23:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 24 Apr 2023 11:23:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 24 Apr 2023 11:23:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682328199; x=1713864199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+MzlbYDAy9LH69SHQ+jHTKd7Y60sbpiM9FfO099q13Q=;
  b=ooysYHSOYNJrwhaMF8yGQlBELVG1bbw/3b3Sf6edEoz1E8L2C6oRybG4
   FaCPMxQaE0ZOKF28lb01CjsQncOAg0xEM9JM4BGuf48WYngfNPS9/03Po
   kM3jBDZE6rIOmR0YU22QsZDuCdOBMYw/dDfkGifV/glArMmsw3LZuPn7V
   VuDtwROtrHYi0ru9iZAJH1PsImkKrSt7Pdz6DWePUKdB2bF/oxN5Mdp1j
   hB3Pl5X6Rve8fWub1kULR7PmojBY6+ROHkT1WuSdKMvHo4htlwJZSyMxA
   zjKmJUW3XjAatV5qknmcymk3FN5e/LicnhK7v2Q0KavHyYJwb01k2289U
   w==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677538800"; 
   d="scan'208";a="30510898"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Apr 2023 11:23:18 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A9ED8280056;
        Mon, 24 Apr 2023 11:23:18 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 1/1] dt-bindings: iio: imx8qxp-adc: add missing vref-supply
Date:   Mon, 24 Apr 2023 11:23:12 +0200
Message-Id: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Although this property is used right now for IIO_CHAN_INFO_SCALE,
this ADC has two internal reference voltages, which the driver currently
doesn't make use of.

Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Thanks for your inputs. This improved descritpion should make it clear
that this property is only about the external reference voltage, not
about the optional, internal voltages.

Changes in v2:
* Improved commit message subject as suggested
* Add hint about feature flag regarding multiple, internal, reference
  voltages

 .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
index 63369ba388e4..878e67054d7c 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
@@ -39,6 +39,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  vref-supply:
+    description: |
+      External ADC reference voltage supply on VREFH pad. If VERID[MVI] is
+      set, there are additional, internal reference voltages selectable.
+      VREFH1 is always from VREFH pad.
+
   "#io-channel-cells":
     const: 1
 
@@ -72,6 +78,7 @@ examples:
             assigned-clocks = <&clk IMX_SC_R_ADC_0>;
             assigned-clock-rates = <24000000>;
             power-domains = <&pd IMX_SC_R_ADC_0>;
+            vref-supply = <&reg_1v8>;
             #io-channel-cells = <1>;
         };
     };
-- 
2.34.1

