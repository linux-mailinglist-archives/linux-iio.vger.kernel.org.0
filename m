Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686986AC9FA
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCFRZB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCFRYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:24:45 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B65E64AB4;
        Mon,  6 Mar 2023 09:24:16 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEFrX-1phB3609X3-00AHTH; Mon, 06 Mar 2023 18:23:13 +0100
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
Subject: [PATCH 1/8] dt-bindings: vendor-prefixes: add chargebyte
Date:   Mon,  6 Mar 2023 18:22:42 +0100
Message-Id: <20230306172249.74003-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GmRbHadQVwqC+mg7raRvcxSwI16pBkcDjYkmfckT06Qp86+EKtq
 U79lbWonJTVU4EBP9bZ0OZllQyqlCpueGZSzYg8XHWk0L8t6PVjXH25qBdM/eirWQS0Sq2/
 fQj9WVUUU1Nta5jp/TgFGzbBO2+qa5k+tnGZaz6A+2/YGGvggne7OudC6az/Up96ACb0tgd
 hBJSfLO6USTz00bj/gieg==
UI-OutboundReport: notjunk:1;M01:P0:FFLhCtfCQ+g=;2BI/JPFHJO1I4fmNlDsInaPHhmq
 a+Xv4yedotMvzF3pR0q/2bA6asJbb/9jUF/PE/f1iHG1aAyAoJaWxOPtBL8o5clyR5YdZeyF+
 GEhWx5/faMTsTv0kYD9GSZLlxSIbDiLn1ZkF294sLNZLkk2EgwbnjgdOWaieoOVINrLhHHkiR
 NLvwwty2D78ryaFqcuRIYaKBjufJP5NMp4att9dAwnbRIwnIEGism507B3XURxu5Rs5zpQ0Eu
 azvWuTi6EjSjqYDqfFHFJW/L8Ys24qrRyn0DpivwyIYYP1FbDSLxYFFCHDQUdbBrCSdbFUBMJ
 MrWwbqQppUvVUutYGiumpeXq5AWNnVfnNy6bTnZMEFe5zZNn/8RHrR9CfEoED9E1L80ETCI6R
 shMXD4UIba0GZLhQSGkFWdroNxyTcDi7+f1+LiaOFcbgrdbSXX8p4u/1SUqTxi9UAz9HsYoV6
 W+nvuVuQYTiegt6UMJkYii4tdYsZ0lZg/3IOEI0WT09jncael5E9hNtLPuHT9B1kmL4S/CYl9
 G/TXORFleI25isdfLc32mgasV+SGwqv625xH7KC9vRGKgANI43QUEHnDVt3mBM0WuL27BJcJw
 NXDgq5PztfYGzHasNF6Q3w9EBbIUxmQcNSI4QPNAanP4hL9Jen3ZXjSDguM83SzEU+wUNfFLQ
 Hkh4Ruwln/zNBwWBFWoudEAKF6kee9TUSS83mRtB1Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

chargebyte supplies hardware and software products for all
aspects of charging communication.
https://chargebyte.com/

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..b8d8fa1d1fd6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -240,6 +240,8 @@ patternProperties:
     description: CellWise Microelectronics Co., Ltd
   "^ceva,.*":
     description: Ceva, Inc.
+  "^chargebyte,.*":
+    description: chargebyte GmbH
   "^checkpoint,.*":
     description: Check Point Software Technologies Ltd.
   "^chefree,.*":
-- 
2.34.1

