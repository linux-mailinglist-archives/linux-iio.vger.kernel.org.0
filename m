Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0A151107
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 21:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCUbi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 15:31:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37567 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCUbi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 15:31:38 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iyiNY-0001AT-K6; Mon, 03 Feb 2020 21:31:32 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iyiNW-0001pl-B3; Mon, 03 Feb 2020 21:31:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de
Subject: [PATCH 4/3] iio: dac: ltc2632: remove some unused defines
Date:   Mon,  3 Feb 2020 21:31:26 +0100
Message-Id: <20200203203126.7003-1-u.kleine-koenig@pengutronix.de>
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

These two defines are unused since the driver was introduced in commit
02b829f9e11f ("iio: dac: Add support for ltc2632 DACs").

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/dac/ltc2632.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 1e7ffa0f6071..7adc91056aa1 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -12,9 +12,6 @@
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 
-#define LTC2632_ADDR_DAC0                       0x0
-#define LTC2632_ADDR_DAC1                       0x1
-
 #define LTC2632_CMD_WRITE_INPUT_N               0x0
 #define LTC2632_CMD_UPDATE_DAC_N                0x1
 #define LTC2632_CMD_WRITE_INPUT_N_UPDATE_ALL    0x2
-- 
2.25.0

