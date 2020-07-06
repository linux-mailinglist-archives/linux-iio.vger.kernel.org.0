Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C37215694
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 13:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgGFLoF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 07:44:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36879 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGFLoF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2020 07:44:05 -0400
Received: from localhost (lfbn-lyo-1-23-225.w86-202.abo.wanadoo.fr [86.202.118.225])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9F0AD240014;
        Mon,  6 Jul 2020 11:44:01 +0000 (UTC)
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
Subject: [PATCH v6 1/5] ARM: at91: add atmel tcb capabilities
Date:   Mon,  6 Jul 2020 13:43:43 +0200
Message-Id: <20200706114347.174452-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
References: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some atmel socs have extra tcb capabilities that allow using a generic
clock source or enabling a quadrature decoder.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
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
2.26.2

