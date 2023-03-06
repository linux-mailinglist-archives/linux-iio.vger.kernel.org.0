Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219966ACA02
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCFRZ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCFRZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:25:26 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5D449E;
        Mon,  6 Mar 2023 09:24:48 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M1Hi8-1patW21u94-002pUa; Mon, 06 Mar 2023 18:23:16 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 6/8] dt-bindings: ARM: fsl: Add chargebyte Tarragon
Date:   Mon,  6 Mar 2023 18:22:47 +0100
Message-Id: <20230306172249.74003-7-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FS/4/qcr5NmZKckgW7zlmnMsGwEvDOoLosNndOZo3iPI/pUGk5L
 QRBdr6KZmgoIW21oww7AAIE2OvP4G2ExcMY9W4491dIo1EMS3benQ7yyBgj1Suva+NhZ1d0
 v8299dgBPrWoYSRACET5FUw8SY70yRyxEJIOKsly4Y4EdQukfhOa7pKC0466BuQjNHVo/rx
 /AU7xZrNXSCgM56GxotpA==
UI-OutboundReport: notjunk:1;M01:P0:Bc659OuMOwQ=;Llz3lIdtaaCgD/S7kK8AmYMlU9g
 k+bQtZ5WRG7M3lgoC3gXA7wzm1awcgSDE0DPP1Gw4vSdpD/Io6FVIEJ1y9l2Bu9m1w17RQte+
 /DtiBfLumTSPt0dMWFK4m77MS/w+l12BrQffsMwmXojC8hl8Pi98ApQuj+SvtBzKx4mQ1JHw9
 IGdP0YllM3pZUpxb3YjQ5As2cx3K3p6mOPSW+pKq9/IiNNWn4vSRdi1JIxo87gc/68G2vb4T3
 wxmf0KbaXG2tzQKSjltamqFBDDK8JR8j6f+dauJYSHP8CaGFZiPj42hCVgvj/PkmXScR5BeBK
 sFRz2J3yUO4lxtT3CRCP9b4YU1T+/ms1HkZeKr43K8TZanS/rf63BQ92n0Q0U47MCQjIIbfhM
 ISawMOuJS5ZfjDEQyZ3O3gn0QqXnGtdMCWRtPKSstX9BHgfIjaDby6QP6VWvewhOKc+vACrkS
 biTNQ0gjIvfkgCS2JzzhKf8WfwWeE6BqZfEZc0OghPDstiSxaLr1XmwWIscFLotTmoumzGD9F
 3eUTmH3Y0Tb9QDnFhg02r5+qWSMlc63Zyi5UiMHjil1N5OsRHcYYGyHZVLL4NFiBHDHXsGCfr
 B1UdPljx85r8JMWDQYDMJ2nOJyd3QgKAPq6+SdSmMG0LZ6FgqvH6tYm0bqQ64vQuKQVbZTjDm
 lNFdQYvyGGxCBzALV3CR6I15F1XzpNVECVNhqvo4Tw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

This adds the compatibles for the chargebyte Tarragon boards.

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index dece3e9ba7fd..2b430e20a7a6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -781,6 +781,15 @@ properties:
           - const: tq,imx6ull-tqma6ull2l      # MCIMX6Y2, LGA SoM variant
           - const: fsl,imx6ull
 
+      - description: chargebyte Tarragon Boards
+        items:
+          - enum:
+              - chargebyte,imx6ull-tarragon-master
+              - chargebyte,imx6ull-tarragon-micro
+              - chargebyte,imx6ull-tarragon-slave
+              - chargebyte,imx6ull-tarragon-slavext
+          - const: fsl,imx6ull
+
       - description: i.MX6ULZ based Boards
         items:
           - enum:
-- 
2.34.1

