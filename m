Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE34A4FB93
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2019 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFWM3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 23 Jun 2019 08:29:37 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWM3g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jun 2019 08:29:36 -0400
Received: from localhost ([46.78.234.140]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWixU-1i7VnU36Uq-00X7UB; Sun, 23 Jun 2019 14:29:12 +0200
Date:   Sun, 23 Jun 2019 14:29:10 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, zbynek.kocur@fel.cvut.cz,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: srf04: fix wrong limitation in distance measuring
Message-ID: <20190623122909.hhzskp6k5vm4wify@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:NdLtTXvHU/xPnCzbq5Md/U7HJiBQy4o5genzOnWEkXHMH2sFrha
 1N1ihlOVqwDYY00rNklluSMns2mZnN5rDP9SZ/yROh6LBdeJKM0fEzq1yAd0yvdjo5NmPcL
 kWg3ldKYe4Mq3yNp9N7xoLQqrmYz7A6rtcTrgvnceFXbnzlu1ldCmRgp8/5w7apG/5E/I6E
 2Xvp1mvpdimSWSbnBbKjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TSsAfz4Wkwo=:ZWAFNUw0q/HaEpf1AnEQXX
 mPvZEWXyMMbkZ/kVD8me//dPIb/kbsAFYoCV0Z3RaWCxZDReo2Y+Tz2OUYBdAR/l5lOpVRKQi
 6Y2g7Y+uU+PinIevgcVesv0EGEM+hD+Do99zmYP6aZQYKfQC01X9sTOg25JlmLL1lti9Waiyf
 0+n4lFcHqXRRRyDv7eWl03ZhZ8l2EUOkiXAGm2NWc4Rmz6BP29CNI12lKMkdIPDyY7YLc9pGb
 a2tEAQ19CcCaI9gxiUavDbWnxjfwo0AjzRRpMc2HS5wY9BmGmKQjCEOTAWSXRTFk9DC0Goiy2
 /lIAwszraBa8Rk7kWE1Wfxi6X52b1LYGI+p7I2XKbQfnd+e8ifDnOpeZya3h6Q1hNdH5Hk4EA
 taxhZ6DvekRWXsgIUKhCJDqp++noQ8BhBJOnfrQgY1t4q1pox0Dl5r3dLCPad/ky1BL5kiFPg
 F2OW9lF4FWWu3XfTeW2mwyJbs52x858HAMVIDx2QnwX4CGHD6tZF/3aMj8e3NWOP9EgzmEtmS
 hYJmK0DJvY8Igc+aH/W3PV+/rnCY9/nBiLQjTFO9HJdvJvQ9W3JqjOuY0mwJy3eNJYPu0xmQx
 795OlbT/II2bpj5+78eLt0clTfNh+HeaxlZeV1gal/YXwlRMcT5654NVqSDnwdtYMoybeOhE2
 UMANB06wAlAQMiHJnIIuFacfh/4pTzLu2nz4Bu6LJloyZsan8DifxdKSzsIrqZJJshDh7tJ1O
 MUulB/j83e2dJi24nm57J+Ct+lF49pnY3k3HlA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The measured time value in the driver is limited to the maximum distance
which can be read by the sensor. This limitation was wrong and is fixed
by this patch.

It also takes into account that we are supporting a variety of sensors
today and that the recently added sensors have a higher maximum
distance range.

Suggested-by: Zbyněk Kocur <zbynek.kocur@fel.cvut.cz>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf04.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 8b50d56b0a03..01eb8cc63076 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -110,7 +110,7 @@ static int srf04_read(struct srf04_data *data)
 	udelay(data->cfg->trigger_pulse_us);
 	gpiod_set_value(data->gpiod_trig, 0);
 
-	/* it cannot take more than 20 ms */
+	/* it should not take more than 20 ms until echo is rising */
 	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
 	if (ret < 0) {
 		mutex_unlock(&data->lock);
@@ -120,7 +120,8 @@ static int srf04_read(struct srf04_data *data)
 		return -ETIMEDOUT;
 	}
 
-	ret = wait_for_completion_killable_timeout(&data->falling, HZ/50);
+	/* it cannot take more than 50 ms until echo is falling */
+	ret = wait_for_completion_killable_timeout(&data->falling, HZ/20);
 	if (ret < 0) {
 		mutex_unlock(&data->lock);
 		return ret;
@@ -135,19 +136,19 @@ static int srf04_read(struct srf04_data *data)
 
 	dt_ns = ktime_to_ns(ktime_dt);
 	/*
-	 * measuring more than 3 meters is beyond the capabilities of
-	 * the sensor
+	 * measuring more than 6,45 meters is beyond the capabilities of
+	 * the supported sensors
 	 * ==> filter out invalid results for not measuring echos of
 	 *     another us sensor
 	 *
 	 * formula:
-	 *         distance       3 m
-	 * time = ---------- = --------- = 9404389 ns
-	 *          speed       319 m/s
+	 *         distance     6,45 * 2 m
+	 * time = ---------- = ------------ = 40438871 ns
+	 *          speed         319 m/s
 	 *
 	 * using a minimum speed at -20 °C of 319 m/s
 	 */
-	if (dt_ns > 9404389)
+	if (dt_ns > 40438871)
 		return -EIO;
 
 	time_ns = dt_ns;
@@ -159,20 +160,20 @@ static int srf04_read(struct srf04_data *data)
 	 *   with Temp in °C
 	 *   and speed in m/s
 	 *
-	 * use 343 m/s as ultrasonic speed at 20 °C here in absence of the
+	 * use 343,5 m/s as ultrasonic speed at 20 °C here in absence of the
 	 * temperature
 	 *
 	 * therefore:
-	 *             time     343
-	 * distance = ------ * -----
-	 *             10^6       2
+	 *             time     343,5     time * 106
+	 * distance = ------ * ------- = ------------
+	 *             10^6         2         617176
 	 *   with time in ns
 	 *   and distance in mm (one way)
 	 *
-	 * because we limit to 3 meters the multiplication with 343 just
+	 * because we limit to 6,45 meters the multiplication with 106 just
 	 * fits into 32 bit
 	 */
-	distance_mm = time_ns * 343 / 2000000;
+	distance_mm = time_ns * 106 / 617176;
 
 	return distance_mm;
 }
-- 
2.11.0
