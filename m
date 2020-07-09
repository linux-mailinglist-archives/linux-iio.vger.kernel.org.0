Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB821A385
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGIPWz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 11:22:55 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36951 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgGIPWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 11:22:54 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 433CAC000B;
        Thu,  9 Jul 2020 15:22:50 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v8 5/6] dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
Date:   Thu,  9 Jul 2020 17:21:59 +0200
Message-Id: <20200709152200.10039-6-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709152200.10039-1-contact@artur-rojek.eu>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support for touchscreen channels found in JZ47xx SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

 Changes:

 v2-v7: no change

 v8: add XN/YN and XD/YD channels

 include/dt-bindings/iio/adc/ingenic,adc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 42f871ab3272..4627a00e369e 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -7,5 +7,11 @@
 #define INGENIC_ADC_AUX		0
 #define INGENIC_ADC_BATTERY	1
 #define INGENIC_ADC_AUX2	2
+#define INGENIC_ADC_TOUCH_XP	3
+#define INGENIC_ADC_TOUCH_YP	4
+#define INGENIC_ADC_TOUCH_XN	5
+#define INGENIC_ADC_TOUCH_YN	6
+#define INGENIC_ADC_TOUCH_XD	7
+#define INGENIC_ADC_TOUCH_YD	8
 
 #endif
-- 
2.27.0

