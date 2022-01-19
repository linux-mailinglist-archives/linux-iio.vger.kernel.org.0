Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E984939D4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jan 2022 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbiASLpS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 06:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiASLpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 06:45:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A62C061574
        for <linux-iio@vger.kernel.org>; Wed, 19 Jan 2022 03:45:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nA9Ot-0002Jc-6j; Wed, 19 Jan 2022 12:45:15 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1nA9Os-00BAZK-QA; Wed, 19 Jan 2022 12:45:14 +0100
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1nA9Or-008XZv-0v; Wed, 19 Jan 2022 12:45:13 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-iio@vger.kernel.org, anand.ashok.dumbre@xilinx.com,
        jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, m.tretter@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH] iio: adc: xilinx-ams: Fix num_channels for PS channels
Date:   Wed, 19 Jan 2022 12:45:13 +0100
Message-Id: <20220119114513.2035609-1-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO channels of the PS are not provided in the sysfs even if the
ams_ps is enabled in the device tree. The reason is that the channels of
the PS are not added to the overall number of IIO channels.

The line somehow got lost between v11 and v12 of the patch series.

Add the number of ams_ps_channels to the number of channels to correctly
register all channels.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
---
 drivers/iio/adc/xilinx-ams.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 8343c5f74121..ede968efb77f 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
 
 		/* add PS channels to iio device channels */
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
+		num_channels += ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_property_match_string(fwnode, "compatible",
 						"xlnx,zynqmp-ams-pl") == 0) {
 		ams->pl_base = fwnode_iomap(fwnode, 0);
-- 
2.30.2

