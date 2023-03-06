Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9696ACCD4
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCFSm1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 13:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCFSm1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 13:42:27 -0500
X-Greylist: delayed 70956 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 10:42:25 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C4419F10;
        Mon,  6 Mar 2023 10:42:25 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwQOx-1qPPlc3CFB-00sJUB; Mon, 06 Mar 2023 18:23:13 +0100
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
        Stefan Wahren <stefan.wahren@i2se.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 2/8] dt-bindings: Add DS2482/DS2484 as trivial device
Date:   Mon,  6 Mar 2023 18:22:43 +0100
Message-Id: <20230306172249.74003-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v9b3X29P5y5UzsVy968V/rYnVligG5hrFWkTJJqhBc6P5bT3Hja
 OuJPC/hzzWeTbBSD6bVfxc2xfZNPCsPVvB3GUm6EzyQKFycjQ6ahADYR8CgKuITfSNegaSc
 bfHwfIDqWwyRjrzR5noOlUhehCWJT1xr76Y3fEHvVU5sWM5CTva0mjGpAr+IjcRURV5W07b
 h0FNhZltncbKSnCIt8lvg==
UI-OutboundReport: notjunk:1;M01:P0:VPi6kVUezQ4=;gd1VCBrFoI/zU+yY2h3th6frxa6
 6sheqrKOU9blES4E7NFYv4dNd+4XKHbebl8CShiUHnDefHXzxexJhEQAhj2YX40nOdIojKZBf
 c2M5UJLcFECm1LozP54NYa/7fW3lOqdGRp2HgxZTMhgcHSjtqJcm7jipz3qaZoeBrogRO2aZF
 vlmU79g7dDbCdvUHoXxb3o/6DethJACFAyANs8hNAw4enfQO47xqWB6K0m6gdnMzeJUWIVwWc
 DeN5ML6NobLd7FOcph6JJX9xEZYUQ2sv0n2z2ZhAXqJuScnrhDvOWIsZF2eAId4VvvVinHCbW
 8SAnDQ3sWX1xcTkFblyNpZSa0X/dCWPNQqV1T8k/vIVclEgImCJdB+vE+ZS3BQjE1zb5m7Vz3
 Rw4naWEwwmCQTbb/09KYBg6T+qbJlmY9j4c6f4l6r5nQfRBtwfLPfX2pMRTFd9U/w+2JacHKy
 gkcoykaUBHrdjEcdzqTztk4EHHodIEAG3M0U1r9deaCG4adYLGRIXiFmmWNPuPA/Ra8WwJyKo
 EwWxFGFqBgC31cydV5epc5A35P5BkhEowABZD8LkKVJRx38ioAD/OMRkfnHlT0BHEkqFqJ0C6
 TK+OpvvV6OIIVxptRmI5rFsexuEeoEWYxqxqlClvN4dziwwHAPptDejYUYI8C1w3uywm03cdg
 RogqUFCYAwGS923+QNAoxht+6IdxQ+0tZEbTFR0p2A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

Both chips are I2C to 1-wire bridges.

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..9b7b24989359 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -183,6 +183,10 @@ properties:
           - maxim,ds1803-050
             # 100 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-100
+            # I2C to 1-wire bridge
+          - maxim,ds2482
+            # I2C to 1-wire bridge
+          - maxim,ds2484
             # 10 kOhm digital potentiometer with I2C interface
           - maxim,ds3502
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-- 
2.34.1

