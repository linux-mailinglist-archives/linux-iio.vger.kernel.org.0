Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA869CD248
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJFOaN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 6 Oct 2019 10:30:13 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfJFOaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 10:30:13 -0400
Received: from localhost ([89.204.130.45]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNLVU-1iSZav0beM-00OpG8; Sun, 06 Oct 2019 16:29:59 +0200
Date:   Sun, 6 Oct 2019 16:29:56 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        zbynek.kocur@fel.cvut.cz, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: srf04: fix wrong limitation in distance measuring
Message-ID: <20191006142952.hgfg2agypwpf2v55@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:GUb3m0K463edewsRDr0B7VLz9NqLUELgR6i1MrrydrWzpiXEO+F
 TsQfZOFDBrrBtcjSSL6IlI/X1B9maqeTAC32PiptKQa14+Uy72pupBcoF0vxl9xe2Ec1czc
 cok0oFOy2OodjgReADT6ox1pfVDBVkxlSTo6Yfaqb4HEMc70kzMOnAP7TiRlt43cP3o5MsC
 nXzSN+scMDZliOw5/4iIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ec2NcWgi04U=:18823FXOelPimO46P/M1O0
 P8XY24fWsVCgSguzBnHdWDwefOl0tp2V1cBKzgt1Xb+RF+RzPZujpFNVLwW6NuzekJDRF3Xcw
 wIFxJi4yYiwxQvTm05x9RKFq8V0puvaniPAM07764QGrezxcqnU5RyGGSmwBcGgZ9+xREBues
 M4decoP9AhSFZLQF3n2n4F+2QQn1Ne5/6A3BTW2vut+uIUqp4slBAtHI+K7aReMp4meR/vG6V
 +pfJ0G0sYD6jxK/JLNCSWVY6E9T5eQ0xm4BDzPOu3t/6ER3NDTQrjWD2cCnxQDKg8HokEOWAh
 J3c60zCLnDU5emH2ZsiZGHwz8bH5WCJ4GD/OGFsaHJGPoYUHjkEl2luWNLnL1BWQuD5AMKJZ1
 wVUMnO94Zrom19Ka+35fGCgYBEnXkDU4rsu3BfnxfOGkJc8NnZ4EylZn5dfIi/WrDekFPtGnl
 v2Z2eaiFKV1MaAXIYtep85K3lN2iO5hQWW8tJuX80+oe9GQYXzbaf3IPa1OnsLHV0qkfZecds
 F4lt1218s2I5qQGUyQdRGXwr1ShxlJGn6VCcXpQTP0NGZLZn/zmS3M5HEdD9+zBZRiPQxHIFd
 ArlBdiKydeQNehMu/KMWZnYEdlBg+AQhWoyJGipNvHK0+s35jMxwWWMOJ4gKJJbGN0eDmVCnc
 Fc2U5MPfP95BU34xzVkkqwDzJGO5520mkRXQI+QAEWwqStIaTiJtaZw0VB+zZn68/GOfWQkAL
 hFTR7nBhJE7YsmBcFwc9CJTH9FZE9w68d6YgqS4Y8pzt8j231wzvusjlj18/f9PvhuE/bQQo1
 Vm5zJzUCIbEZWVMWXsYrG7p9+gEA0z1jmV12UXm83vaEzZxCzht+Obs73vap7oC4SWataBbIq
 1n18L6QDK4Uz0aek7aHA==
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

Changes in v2:
- Added a Tested-by

Suggested-by: Zbyněk Kocur <zbynek.kocur@fel.cvut.cz>
Tested-by: Zbyněk Kocur <zbynek.kocur@fel.cvut.cz>
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
