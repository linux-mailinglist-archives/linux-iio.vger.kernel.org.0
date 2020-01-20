Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD14D142E47
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgATPFR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 10:05:17 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53846 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPFQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jan 2020 10:05:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id EB472FB03;
        Mon, 20 Jan 2020 16:05:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Ka0lCVAhWGn; Mon, 20 Jan 2020 16:05:12 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 55768404A3; Mon, 20 Jan 2020 16:01:24 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: vcnl4000: Use a single return when getting IIO_CHAN_INFO_RAW
Date:   Mon, 20 Jan 2020 16:01:23 +0100
Message-Id: <8ed27a3935cd0e5324bd397a33dfa429b4746719.1579531608.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1579531608.git.agx@sigxcpu.org>
References: <cover.1579531608.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This will be useful when introducing runtime pm.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/iio/light/vcnl4000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b0e241aaefb4..8f198383626b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -335,17 +335,18 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = data->chip_spec->measure_light(data, val);
-			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
+			if (!ret)
+				ret = IIO_VAL_INT;
+			break;
 		case IIO_PROXIMITY:
 			ret = data->chip_spec->measure_proximity(data, val);
-			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
+			if (!ret)
+				ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type != IIO_LIGHT)
 			return -EINVAL;
-- 
2.23.0

