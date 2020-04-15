Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465AA1AA32F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 15:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505916AbgDONFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 09:05:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33033 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505892AbgDONFL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 09:05:11 -0400
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6D846240006;
        Wed, 15 Apr 2020 13:05:00 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v3 1/3] ARM: at91: add atmel tcb capabilities
Date:   Wed, 15 Apr 2020 15:04:53 +0200
Message-Id: <20200415130455.2222019-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some atmel socs have extra tcb capabilities that allow using a generic
clock source or enabling a quadrature decoder.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
Changes from v3:
 - Added missing kernel doc for new elements introduced in structure
   atmel_tcb_config.

Changes from v2:
 - Fixed first patch not applying on mainline

 include/soc/at91/atmel_tcb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200ce151..1d7071dc0bca 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -36,9 +36,14 @@ struct clk;
 /**
  * struct atmel_tcb_config - SoC data for a Timer/Counter Block
  * @counter_width: size in bits of a timer counter register
+ * @has_gclk: boolean indicating if a timer counter has a generic clock
+ * @has_qdec: boolean indicating if a timer counter has a quadrature
+ * decoder.
  */
 struct atmel_tcb_config {
 	size_t	counter_width;
+	bool    has_gclk;
+	bool    has_qdec;
 };
 
 /**
-- 
2.25.0

