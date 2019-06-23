Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAB4FDAD
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2019 20:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfFWSpX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jun 2019 14:45:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52005 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfFWSpX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jun 2019 14:45:23 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 00772FF804;
        Sun, 23 Jun 2019 18:45:17 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/4] dt-bindings: iio/adc: Add AUX2 channel idx for JZ4770 SoC ADC
Date:   Sun, 23 Jun 2019 20:47:30 +0200
Message-Id: <20190623184732.5492-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623184732.5492-1-contact@artur-rojek.eu>
References: <20190623184732.5492-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support for AUX2 channel found in ADC hardware present on
Ingenic JZ4770 SoC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 82706b2706ac..42f871ab3272 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -6,5 +6,6 @@
 /* ADC channel idx. */
 #define INGENIC_ADC_AUX		0
 #define INGENIC_ADC_BATTERY	1
+#define INGENIC_ADC_AUX2	2
 
 #endif
-- 
2.22.0

