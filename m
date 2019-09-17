Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E60B50CF
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfIQO4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 10:56:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfIQO4r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 10:56:47 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAEuG-0007Or-Gf; Tue, 17 Sep 2019 16:56:40 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAEuE-0007Ob-Ml; Tue, 17 Sep 2019 16:56:38 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, angus@akkea.ca,
        tomas@novotny.cz
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] iio: light: add missing vcnl4040 of_compatible
Date:   Tue, 17 Sep 2019 16:56:37 +0200
Message-Id: <20190917145637.22605-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917145637.22605-1-m.felsch@pengutronix.de>
References: <20190917145637.22605-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040
proximity and light sensor") added the support for the vcnl4040 but
forgot to add the of_compatible. Fix this by adding it now.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/iio/light/vcnl4000.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index f522cb863e8c..16dacea9eadf 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -408,6 +408,10 @@ static const struct of_device_id vcnl_4000_of_match[] = {
 		.compatible = "vishay,vcnl4020",
 		.data = (void *)VCNL4010,
 	},
+	{
+		.compatible = "vishay,vcnl4040",
+		.data = (void *)VCNL4040,
+	},
 	{
 		.compatible = "vishay,vcnl4200",
 		.data = (void *)VCNL4200,
-- 
2.20.1

