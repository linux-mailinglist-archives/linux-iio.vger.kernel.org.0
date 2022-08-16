Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51415962FA
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiHPTTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiHPTTE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 15:19:04 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45F543FE;
        Tue, 16 Aug 2022 12:18:59 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 10F055FD0B;
        Tue, 16 Aug 2022 22:18:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660677537;
        bh=bT3dFp5MzD46j/1XA/ZxsG4fdU9e/Xi1qpgLMC8LesI=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=rCgFGnGpn47MrYPInR6PMyIuQJyVEL5vRejv7AEL3QLDuIWlfK0V74wIJwv0BBdP4
         bgQiHny17sgalsiCabPLwN/Xv0Oplf7unpsgA7Qn3V4SphahxrN2QYNCh7M/G3HdCL
         UoneOV7V/jyTMtgDlnY5rrK3Tyo9ciOYRz6XmL88S34e5APriaf/d4R3LdshJKXOKq
         aZwQMjKGvvZBiajvgNlctfIjoXV6OXVcauyz5yyEzfYYr+YrGTQEoiv6vHyLstKHlC
         LtQQSGHpMCZJ2nsHEk0Rfioip8mM14sZFHFNo7SDSZiorWXdQAqYcAIDQTPhFnN9xJ
         NQ02eNvLuqU6Q==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 16 Aug 2022 22:18:56 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/4] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Topic: [PATCH v6 2/4] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Index: AQHYsaUAFlRjmYWmxEiY9D/1NefkuA==
Date:   Tue, 16 Aug 2022 19:18:44 +0000
Message-ID: <20220816191842.14020-3-ddrokosov@sberdevices.ru>
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/16 16:01:00 #20126973
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
electromechanical system technology company which produces micro
electromechanical system microphones and sensors.
MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
in consumer electronics, industrial control, medical electronics
and automotive, and other fields.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 0496773a3c4d..404b40eac011 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -761,6 +761,8 @@ patternProperties:
     description: MELFAS Inc.
   "^mellanox,.*":
     description: Mellanox Technologies
+  "^memsensing,.*":
+    description: MEMSensing Microsystems Co., Ltd.
   "^memsic,.*":
     description: MEMSIC Inc.
   "^menlo,.*":
--=20
2.36.0
