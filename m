Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0ADB149BC8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jan 2020 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAZQF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jan 2020 11:05:26 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46277 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZQFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jan 2020 11:05:25 -0500
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D6A9E1BF20A;
        Sun, 26 Jan 2020 16:05:21 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
Date:   Sun, 26 Jan 2020 17:12:33 +0100
Message-Id: <20200126161236.63631-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200126161236.63631-1-contact@artur-rojek.eu>
References: <20200126161236.63631-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support for touchscreen channels found in JZ47xx SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
---

 Changes:

 v2: no change

 include/dt-bindings/iio/adc/ingenic,adc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 42f871ab3272..95e20a8d6dc8 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -7,5 +7,7 @@
 #define INGENIC_ADC_AUX		0
 #define INGENIC_ADC_BATTERY	1
 #define INGENIC_ADC_AUX2	2
+#define INGENIC_ADC_TOUCH_XP	3
+#define INGENIC_ADC_TOUCH_YP	4
 
 #endif
-- 
2.25.0

