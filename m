Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94DD165C8
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEGOgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 10:36:25 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:63401 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbfEGOgZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 10:36:25 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Cd-00044q-T8; Tue, 07 May 2019 16:36:19 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Cd-0008oW-Km; Tue, 07 May 2019 16:36:19 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>, dev@pschenker.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] iio: stmpe-adc: Add compatible name
Date:   Tue,  7 May 2019 16:36:11 +0200
Message-Id: <20190507143615.28477-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the compatible name to the driver so it gets loaded when the proper
node in DT is detected.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/iio/adc/stmpe-adc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 37f4b74a5d32..9ec338ba3440 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -354,9 +354,14 @@ static struct platform_driver stmpe_adc_driver = {
 		.pm	= &stmpe_adc_pm_ops,
 	},
 };
-
 module_platform_driver(stmpe_adc_driver);
 
+static const struct of_device_id stmpe_adc_ids[] = {
+	{ .compatible = "st,stmpe-adc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
+
 MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
 MODULE_DESCRIPTION("STMPEXXX ADC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

