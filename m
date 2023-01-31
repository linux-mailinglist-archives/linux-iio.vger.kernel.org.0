Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264F8682A10
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 11:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAaKNf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 05:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAaKNf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 05:13:35 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E249973;
        Tue, 31 Jan 2023 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675160010; x=1706696010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BLfbb6NEKYdixzxNTlcXCZh7D0DeRCzh+i1m4DSVTHE=;
  b=ETIOItMumTwPC0gz/hoe83YrVY19feJQMYgzsPCH5w2R3t6kwBnWI7wZ
   QdXnNvsVDggQzZMGXdb6M6Qg/vu3xzTwI+8joSA8rzL8YjVTo6Azo06pW
   BP4DDG5POCdbt1ga9K6h7in1mAm/yvOr7aMcjMylZeJ7qjxA+1LeQAvOA
   6uGU59eCWGMBtlBBIaKiWQZ9vm9UIcodM43bwJTMrUCMMem6iK/nZsZ8w
   eCfs0arCFfgGFcOD4g3gPriFfbxVL0+aqY9xcam3EjQDTU4t5fbnGLXVY
   YDJG0sw3NDer6ZyStz5oKoK+K/vj4c8jlyTfymAJDrynH914qfd4+6HLf
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28766403"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 11:13:28 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 11:13:28 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 11:13:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675160008; x=1706696008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BLfbb6NEKYdixzxNTlcXCZh7D0DeRCzh+i1m4DSVTHE=;
  b=XsaWx+s9ssnD+/NMSGf8viPpUW8NdIihwUBCWJBiMZi37dGB1xi28RHI
   z0RTFcWuCjoNQYavSpvbbYQbzXm67GU/ifrX+PIfEjqFKjSonPnGO5E3x
   5m0loycsEV/IEomQF/1y2DtyFD9Jc+kiRsxrpM48qPG42Bsh2txfrQ4O1
   Soxm/VKwpP0Lj8N7AQ/kh+/I45XfM8gI47rvQpDx4Bk7xcs9jqgzU+1bk
   4TGsr9KWoFXn2GIrHPNoufg4cLeoDjbyOf1XtRQUmbgjhG4NJIe697Q7u
   1iq70E0kCQnAQkyR5DbFVQwJnEv1KzLLZhlXs1//72H/oIOIyjWqFgepT
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28766402"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 11:13:27 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B8075280056;
        Tue, 31 Jan 2023 11:13:27 +0100 (CET)
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
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] dt-bindings: iio: adc: add missing vref-supply
Date:   Tue, 31 Jan 2023 11:13:23 +0100
Message-Id: <20230131101323.606931-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
index 63369ba388e4..879768af0303 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
@@ -39,6 +39,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  vref-supply:
+    description: External ADC reference voltage supply on VREFH pad.
+
   "#io-channel-cells":
     const: 1
 
@@ -72,6 +75,7 @@ examples:
             assigned-clocks = <&clk IMX_SC_R_ADC_0>;
             assigned-clock-rates = <24000000>;
             power-domains = <&pd IMX_SC_R_ADC_0>;
+            vref-supply = <&reg_1v8>;
             #io-channel-cells = <1>;
         };
     };
-- 
2.34.1

