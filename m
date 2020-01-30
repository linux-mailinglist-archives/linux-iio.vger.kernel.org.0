Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2314DB65
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2020 14:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgA3NQI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jan 2020 08:16:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59915 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3NQH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2020 08:16:07 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ix9fp-0000WZ-TJ; Thu, 30 Jan 2020 14:15:57 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ix9fo-0000Ll-A9; Thu, 30 Jan 2020 14:15:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: [PATCH 2/3] iio: dac: ltc2632: drop some duplicated data
Date:   Thu, 30 Jan 2020 14:15:48 +0100
Message-Id: <20200130131549.1170-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The channel data for ltc2632l12 and ltc2632h12 are identical. So there
is no gain in using two different (but identical) channel descriptions.
The only side effect of this change is some memory savings.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/dac/ltc2632.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 643d1ce956ce..7ab92e178496 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -192,37 +192,33 @@ static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
 		LTC2632_CHANNEL(1, _bits), \
 	}
 
-static DECLARE_LTC2632_CHANNELS(ltc2632l12, 12);
-static DECLARE_LTC2632_CHANNELS(ltc2632l10, 10);
-static DECLARE_LTC2632_CHANNELS(ltc2632l8, 8);
-
-static DECLARE_LTC2632_CHANNELS(ltc2632h12, 12);
-static DECLARE_LTC2632_CHANNELS(ltc2632h10, 10);
-static DECLARE_LTC2632_CHANNELS(ltc2632h8, 8);
+static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
+static DECLARE_LTC2632_CHANNELS(ltc2632x10, 10);
+static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
 
 static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
 	[ID_LTC2632L12] = {
-		.channels	= ltc2632l12_channels,
+		.channels	= ltc2632x12_channels,
 		.vref_mv	= 2500,
 	},
 	[ID_LTC2632L10] = {
-		.channels	= ltc2632l10_channels,
+		.channels	= ltc2632x10_channels,
 		.vref_mv	= 2500,
 	},
 	[ID_LTC2632L8] =  {
-		.channels	= ltc2632l8_channels,
+		.channels	= ltc2632x8_channels,
 		.vref_mv	= 2500,
 	},
 	[ID_LTC2632H12] = {
-		.channels	= ltc2632h12_channels,
+		.channels	= ltc2632x12_channels,
 		.vref_mv	= 4096,
 	},
 	[ID_LTC2632H10] = {
-		.channels	= ltc2632h10_channels,
+		.channels	= ltc2632x10_channels,
 		.vref_mv	= 4096,
 	},
 	[ID_LTC2632H8] =  {
-		.channels	= ltc2632h8_channels,
+		.channels	= ltc2632x8_channels,
 		.vref_mv	= 4096,
 	},
 };
-- 
2.25.0

