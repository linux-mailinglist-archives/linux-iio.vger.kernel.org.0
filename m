Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62242EB86
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhJOIS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:26 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37187 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbhJOIRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:51 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3D0C820013;
        Fri, 15 Oct 2021 08:15:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 26/48] mfd: ti_am335x_tscadc: Drop unused definitions from the header
Date:   Fri, 15 Oct 2021 10:14:44 +0200
Message-Id: <20211015081506.933180-27-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The STEP ENABLE definitions are highly unclear and not used so drop them.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mfd/ti_am335x_tscadc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index a85643677bef..1cd8cd34f2b7 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -39,13 +39,6 @@
 /* IRQ wakeup enable */
 #define IRQWKUP_ENB		BIT(0)
 
-/* Step Enable */
-#define STEPENB_MASK		(0x1FFFF << 0)
-#define STEPENB(val)		((val) << 0)
-#define ENB(val)		(1 << (val))
-#define STPENB_STEPENB		STEPENB(0x1FFFF)
-#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
-
 /* IRQ enable */
 #define IRQENB_HW_PEN		BIT(0)
 #define IRQENB_EOS		BIT(1)
-- 
2.27.0

