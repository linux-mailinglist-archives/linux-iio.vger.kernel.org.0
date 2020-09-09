Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68942630D6
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgIIPqJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 11:46:09 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:43570 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbgIIPpg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 11:45:36 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4BmmYw5Cf1zMnC1;
        Wed,  9 Sep 2020 17:45:24 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BmmYT72k8z2TRlN;
        Wed,  9 Sep 2020 17:45:01 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.93) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 9 Sep
 2020 17:45:01 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] iio: light: as73211: Increase measurement timeout
Date:   Wed, 9 Sep 2020 17:44:39 +0200
Message-ID: <20200909154439.10308-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.93]
X-RMX-ID: 20200909-174501-4BmmYT72k8z2TRlN-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We found some sensors which are much slower (20% at room temperature)
than nominal. According to the data sheet, up to 27% is possible. Now I
add 33% to the nominal time out, hopefully this is enough.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/iio/light/as73211.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 25e5c386d678..457bf7f4b1f4 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -259,10 +259,9 @@ static int as73211_req_data(struct as73211_data *data)
 	data->osr &= ~AS73211_OSR_SS;
 
 	/*
-	 * Add some extra margin for the timeout. sensor timing is not as precise
-	 * as our one ...
+	 * Add 33% extra margin for the timeout. fclk,min = fclk,typ - 27%.
 	 */
-	time_us += time_us / 8;
+	time_us += time_us / 3;
 	if (data->client->irq) {
 		ret = wait_for_completion_timeout(&data->completion, usecs_to_jiffies(time_us));
 		if (!ret) {
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

