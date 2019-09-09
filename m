Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE67DAD928
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfIIMiI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:38:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfIIMiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 08:38:07 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M27Bp-1i9mpb45bV-002a2d; Mon, 09 Sep 2019 14:37:51 +0200
Date:   Mon, 9 Sep 2019 14:37:48 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: adc: hx711: optimize performance in read cycle
Message-ID: <20190909123746.lvd2q3dwgaksktuy@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2r6WQaikpwqG7k81U+l+sZ8AUOML4uXyn3ufomrEmSckU9Rlh61
 kmF07rREvzVOdRFAjr/o0h4Vh6yFmhKHJkCYKf3ZNzkWAyK5QcQCpeevDbsQH4MON5fJnAE
 44B9V2N9R1hrSf7hbtfxNfYFi1JV0j4tP9mfUJaGYJ298sLcgWSHSBpm4zzOTKA0ZxvZBsW
 x4ukdQYbYl+qmlALvdQiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vr+21FCK1aA=:ikqRx4OngkgZ0qB7j8VmzP
 FFPQiCoA6Z4iTI27Pd9EZsI55lNmMD4afUPRns5ubL9z1dD/yeL0OglGNDmrJdPpuC7ZX1gfM
 NdDmxzigmOtBKIIUrqQiXetWWCC0xz4invZD1jS1HXl/LONXqv4JAC5xw+BYjQMlotjIGCsWY
 tunsDD2iM01S/ovrE3S2eZkuqzK9EJSvL5zv9GEBjNZyF7ebq0DyvPbXi3ViJp/cb/eAlnHbw
 ucrE5ISiv2R0SPczCn91UVzhdG7KENYc5jhJ3fISEBgFgYRA7GQHuY9JE+d7sB7wRI8XG+Xef
 TrfPgRSKri4H9Uncy6NLt4FfmqHQf/IzjxzEwmb2Y1FPINasV2kf0IcpwiooEjFq8/gbOgk/d
 Pi0299ORDn+vJUP1ry73EtjqsiCVUDzEK80zVhxyDsSy7mxjqYQF53iD8I3SDMjhy45x+9ue5
 3IA1J1jtj1OHtnw8uJwSMNlX0LaX4WQhYtqMc2wHEaHMDFIeobhDa/I4TlayK7AaB1yXNt1yA
 b1GBjVwvF8TDmGTt8rCEFBnYDe6v/dZWmKNocbnOh7KnrzsPTL5Yc/7wHfTRe2Zq00vAmAYF2
 KbcDa91BEg+Q2uXt8Z8rIVjsl/oAYBMBK+19gU4RBwS/C9IpQxNvu+TiDCUtBYsORloZgLu8r
 06u0yLL7AwVU4dG8Ex6LmAS0YN5QrvK+OLUhs9+F6no+DW/yCY5Y+KAvxauMvoCng+XF/cjsk
 2RCf5bsfKrbGuZ+8YmH/e0sGsqYnzc40xBdluU34840xROLEStNDS/zBMHM+Ad3poYaJx309N
 TgtfAwacLsqyABlk2TL0Ht5qYbmgKY2FBDjWm5hj/Qr3z5lgzY=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set gain in hx711_reset() to its default value after a reset cycle. This
omits one precautionary read cycle, because the read is performed in
hx711_set_gain_for_channel() anyway if gain has changed.

Check for DOUT low and if its high wait some time if it goes down
instead of doing a blind reset cycle when DOUT is not down.

This is a performance optimization which allows to query the sensor with
a higher frequency.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 0678964dbd21..c8686558429b 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -23,6 +23,7 @@
 
 /* gain to pulse and scale conversion */
 #define HX711_GAIN_MAX		3
+#define HX711_RESET_GAIN	128
 
 struct hx711_gain_to_scale {
 	int			gain;
@@ -100,7 +101,6 @@ struct hx711_data {
 
 static int hx711_cycle(struct hx711_data *hx711_data)
 {
-	int val;
 	unsigned long flags;
 
 	/*
@@ -186,8 +186,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int ret;
-	int val = gpiod_get_value(hx711_data->gpiod_dout);
+	int val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
 		/*
@@ -203,22 +202,10 @@ static int hx711_reset(struct hx711_data *hx711_data)
 		msleep(10);
 		gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
 
-		ret = hx711_wait_for_ready(hx711_data);
-		if (ret)
-			return ret;
-		/*
-		 * after a reset the gain is 128 so we do a dummy read
-		 * to set the gain for the next read
-		 */
-		ret = hx711_read(hx711_data);
-		if (ret < 0)
-			return ret;
-
-		/*
-		 * after a dummy read we need to wait vor readiness
-		 * for not mixing gain pulses with the clock
-		 */
 		val = hx711_wait_for_ready(hx711_data);
+
+		/* after a reset the gain is 128 */
+		hx711_data->gain_set = HX711_RESET_GAIN;
 	}
 
 	return val;
-- 
2.11.0
