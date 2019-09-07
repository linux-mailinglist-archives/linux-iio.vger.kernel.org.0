Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD7AC60A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfIGKSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 06:18:54 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfIGKSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2019 06:18:54 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxDck-1iLtp045n6-00xcif; Sat, 07 Sep 2019 12:18:31 +0200
Date:   Sat, 7 Sep 2019 12:18:30 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: hx711: remove unnecessary read cycle
Message-ID: <20190907101828.42ldoqtqey3py4hg@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:dWRbDw8Lij1NVmMnSoh+BX7cYQhDIQbCEYILwqLxTjUFUGeB6/e
 55NdYQMy2Ubuor9vQwhK1dzvOf4wgfeE3Z6OgKr9aqWsEgi4jgp44GQrLSWPMvGIMbaZihW
 CAZT3bsaWjGegfp3QLc3KIdqC+s2DoXSnSIJOek3XxOYUmXtL9e/NZT5xGuUZ8fwF5BgNMA
 Gb1rEkOhmCIg76P4fb06w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfwOsvCBwKs=:xD6gty7sqHXTmzNs3udPKq
 5ygv0QDrvBI7VpS649xx1SGObccJ2C0xA2UsCVbRyPKLCTX+586vUMAxKCRpcjbVFeCe36+O4
 qYFkxuno7H+EXQAAH1tI4kuazjaz0oIOOlFjTulTbCYY5Wjt0fLyR9Q7S8pF44qaRf2y3gcBo
 vBeI3AW8d41Na6VS5O3bFJufmgtWtSdRF/FLJMS8LP0MHlzb9+UlCLav+pU72A8jeEZ32gXpc
 AdS+ASq7MNcVLHEb8Ip5Wgr1MJkuDOkVl1rwYVH0cltjAI7TVd3k+Usbc+44IR79dkgzv3w+q
 sWHIWhmHI3YDjiU6wSTFzRCwqKOCzUH/aVYVhNYbK5tJHvGRvcbqeGRzr5KU6XFRtiX0nAvkJ
 1EDmdvOhNBIl3ScMtv9O0TrmsIcopWuTP37VfsRS43X/GG34817y6m89VtTsVeDIYNIMSqrFq
 itFtz7TLX3z0w5a0LCKcWKMjTrTesvR+qBQnremC2laLUGwBZMd1t9K4yox8gEdZpobdr1+ad
 sZknecywjhJnXS0GRPE4G6986Z0B4bx0tlvfcVZH1fVFigvzqNZhewMv9AnUQSK88gQ/8hSGz
 7QtfkoBCy6Vxe6vAGpmmnnXwaOYdw+Mwif1SYaqq4wXPi2PZZwET8pF/W8j2z1hVgHi2rgJWM
 WaVLeJJkr0b9L6KWGdIZAdW3vDeQxmUP+LN384bbpxG8actvl3G5FvJFXFYHL0DpI6lQEhUhL
 WYWBNKNTVu8jw0BYngLsaIG05WfvEMtrPdaadDhZHEOxz8Du5EmuDN+K0tl+JLyE803bWD2AC
 mJlVHZVDIfsVtojEtedGx63kV1If1clcnxmrmulQvtJXRG3aVs=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set gain in hx711_reset() to its default value after a reset cycle. This
omits one precautionary read cycle, because the read is performed in
hx711_set_gain_for_channel() anyway if gain has changed.

Check for DOUT low and wait some time if it goes down instead of doing a
blind reset cycle when DOUT is not down.

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
2.13.3
