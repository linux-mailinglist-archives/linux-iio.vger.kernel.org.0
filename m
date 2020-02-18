Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9771629B6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 16:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRPpI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 10:45:08 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:38172 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgBRPpI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 10:45:08 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id BFF141044D6;
        Tue, 18 Feb 2020 16:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net BFF141044D6
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v2 2/2] iio: light: vcnl4000: update sampling periods for vcnl4040
Date:   Tue, 18 Feb 2020 16:44:51 +0100
Message-Id: <20200218154451.13066-3-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200218154451.13066-1-tomas@novotny.cz>
References: <20200218154451.13066-1-tomas@novotny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Vishay has published a new version of "Designing the VCNL4200 Into an
Application" application note in October 2019. The new version specifies
that there is +-20% of part to part tolerance. Although the application
note is related to vcnl4200, according to support the vcnl4040's "ASIC
is quite similar to that one for the VCNL4200".

So update the sampling periods (and comment), including the correct
sampling period for proximity. Both sampling periods are lower. Users
relying on the blocking behaviour of reading will get proximity
measurements much earlier.

Fixes: 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Tested-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/vcnl4000.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 98428bf430bd..e5b00a6611ac 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -174,9 +174,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		data->al_scale = 24000;
 		break;
 	case VCNL4040_PROD_ID:
-		/* Integration time is 80ms, add 10ms. */
-		data->vcnl4200_al.sampling_rate = ktime_set(0, 100000 * 1000);
-		data->vcnl4200_ps.sampling_rate = ktime_set(0, 100000 * 1000);
+		/* Default wait time is 80ms, add 20% tolerance. */
+		data->vcnl4200_al.sampling_rate = ktime_set(0, 96000 * 1000);
+		/* Default wait time is 5ms, add 20% tolerance. */
+		data->vcnl4200_ps.sampling_rate = ktime_set(0, 6000 * 1000);
 		data->al_scale = 120000;
 		break;
 	}
-- 
2.16.4

