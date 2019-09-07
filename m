Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04D2AC60F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfIGKTO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 06:19:14 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIGKTO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2019 06:19:14 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPXlM-1hk5H72K0I-00Mdi2; Sat, 07 Sep 2019 12:18:51 +0200
Date:   Sat, 7 Sep 2019 12:18:50 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: hx711: remove unnecessary returns
Message-ID: <20190907101848.hl4vgaostftr4ddj@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:j9n30ghBHU5Pbg82DQrU7DqahcuCtaXSZNag+SbTi+EIN1PZ6kt
 zwz7zg5Hnz3XFjDSE/OHkpmTLTS7Y9STm/wd0Xr+e5DQGIwTuVM7ZdGl8/uLi7Dou00+E++
 FcJSkKK5H8zD67b4bwE38wucxQKAvQQ1jM0rXWggtUSok0lKI4DrTNmhA+rUxdHUyCttG0t
 D64Qn+aFR9XNcT1BIewJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gtdGpxCIa+s=:G2AsiXA6l0rJtlhNZ2YqbX
 gW8qhWvNWNJrVl5eiPkKSD48IOEr230tb6gptvH4VhsMnM7VqusEXAIga3JsvAEbI8VU3/614
 3+bvXhD0E8W6iswi5EfraACfByUXPr63px3+xFFP/Rxk4J2roKH3rThcCnd1eN5WyHAiAJu3R
 HTPi1S5rEgSmwrP0FqdK8SGgkrhRpoWvTySZTPbecGVLwzGhv62zKYkLmyayklxl0EWuYYRIp
 UkxygjCt00+S/5+yuv/ozRtcuoZeKIsiCKcywMMuNU/0FCGHPUhqmtpeoIaaYTS8IAfuG+oXG
 avGxQ4NdZLsHndz1UsWI5EzspPr827gnYgoI3b1fE+npOFXkILpEBn3DI586CrdMhxO5HCfre
 dIc+7ZM5nGwzeVCxCU9AnlqEnolEjP2FIlH2V2VhsBYJeRfoJNgJcojzCy5AYSQRF20Ek5MSC
 qFstw1FKRhBpE2U3q225SN2VHwHO42YwdVTzvQ0K/U5Sa/aWwUJAwuR55DE+7uK94R1as3Eoi
 G5A0JEwF7OvZNhm3Lq57Wq6fTqsqymGTXngdpIMotaBvhYMaKcC2olcKEjfl9e4LtM5/up08A
 Uj9rgXSPKxwPrk0UfWo/lwzxKFWc2Sy0MnnO7mdyyEYHkdQIrBv1pxMM3uigMzR9NpVOMN8xM
 vs8AeA5gZz0PZTZ2ylljYfO/AI/rm544kFcfwgC9/CPz7Wwqtud5OwB47lkgSCN7hh1Nu+8LZ
 4z1qSizFvdJB0iqqCAx+iQY8tW4qesrJv6PWw/bLXN+5h3+5W3lzDlPY78iRkmKaZWTDI1iIb
 iqa2WRiiBlnhuZnOZxxobmeUVPAFv2tbxXUaiJi8iZBXGwGXhc=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Optimize use of return in hx711_set_gain_for_channel().

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index c8686558429b..20c249f502c0 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -213,7 +213,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
 static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 {
-	int ret;
+	int ret = 0;
 
 	if (chan == 0) {
 		if (hx711_data->gain_set == 32) {
@@ -224,8 +224,6 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 				return ret;
 
 			ret = hx711_wait_for_ready(hx711_data);
-			if (ret)
-				return ret;
 		}
 	} else {
 		if (hx711_data->gain_set != 32) {
@@ -236,12 +234,10 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 				return ret;
 
 			ret = hx711_wait_for_ready(hx711_data);
-			if (ret)
-				return ret;
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
-- 
2.13.3
