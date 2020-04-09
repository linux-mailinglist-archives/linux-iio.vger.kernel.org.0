Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49EA1A3591
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgDIOOI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 10:14:08 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:56889 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDIOOI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 10:14:08 -0400
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D617D200004;
        Thu,  9 Apr 2020 14:14:04 +0000 (UTC)
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
Subject: [PATCH v2 1/3] ARM: at91: add atmel tcb capabilities
Date:   Thu,  9 Apr 2020 16:13:59 +0200
Message-Id: <20200409141401.321222-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
References: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
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
Changes from v2:
 - Fixed first patch not applying on mainline

 include/soc/at91/atmel_tcb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200ce151..7e47ace9255c 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -39,6 +39,8 @@ struct clk;
  */
 struct atmel_tcb_config {
 	size_t	counter_width;
+	bool    has_gclk;
+	bool    has_qdec;
 };

 /**
--
2.25.0

