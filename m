Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4641346FC
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAHQA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 11:00:27 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:46228 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgAHQA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 11:00:27 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 3AE3D1048F2;
        Wed,  8 Jan 2020 17:00:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 3AE3D1048F2
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH 1/2] iio: light: vcnl4000: update sampling rates for vcnl4200
Date:   Wed,  8 Jan 2020 16:58:51 +0100
Message-Id: <20200108155852.32702-2-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200108155852.32702-1-tomas@novotny.cz>
References: <20200108155852.32702-1-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Vishay has published a new version of "Designing the VCNL4200 Into an
Application" application note in October 2019. The new version specifies
that there is +-20% of part to part tolerance. This explains the drift
seen during experiments. The proximity pulse width is also changed from
32us to 30us. According to the support, the tolerance also applies to
ambient light.

So update the sampling rates. As the reading is blocking, current users
may notice slightly longer response time.

Fixes: be38866fbb97 ("iio: vcnl4000: add support for VCNL4200")
Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/vcnl4000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b0e241aaefb4..98428bf430bd 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -167,10 +167,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
 	switch (id) {
 	case VCNL4200_PROD_ID:
-		/* Integration time is 50ms, but the experiments */
-		/* show 54ms in total. */
-		data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
-		data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
+		/* Default wait time is 50ms, add 20% tolerance. */
+		data->vcnl4200_al.sampling_rate = ktime_set(0, 60000 * 1000);
+		/* Default wait time is 4.8ms, add 20% tolerance. */
+		data->vcnl4200_ps.sampling_rate = ktime_set(0, 5760 * 1000);
 		data->al_scale = 24000;
 		break;
 	case VCNL4040_PROD_ID:
-- 
2.16.4

