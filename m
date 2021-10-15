Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE642EBB4
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhJOITL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:19:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37027 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbhJOIRt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:49 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0C35A20002;
        Fri, 15 Oct 2021 08:15:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 25/48] mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ macro
Date:   Fri, 15 Oct 2021 10:14:43 +0200
Message-Id: <20211015081506.933180-26-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before adding another frequency with even more zeroes, use the
HZ_PER_MHZ macro to clarify the number.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/mfd/ti_am335x_tscadc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 893c474c1f8c..a85643677bef 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -9,6 +9,7 @@
 #define __LINUX_TI_AM335X_TSCADC_MFD_H
 
 #include <linux/mfd/core.h>
+#include <linux/units.h>
 
 #define REG_RAWIRQSTATUS	0x024
 #define REG_IRQSTATUS		0x028
@@ -133,7 +134,7 @@
 #define SEQ_STATUS		BIT(5)
 #define CHARGE_STEP		0x11
 
-#define ADC_CLK			3000000
+#define ADC_CLK			(3 * HZ_PER_MHZ)
 #define TOTAL_STEPS		16
 #define TOTAL_CHANNELS		8
 #define FIFO1_THRESHOLD		19
-- 
2.27.0

