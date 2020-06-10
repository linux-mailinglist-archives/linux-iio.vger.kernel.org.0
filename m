Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2DB1F5625
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgFJNuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 09:50:32 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52326 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJNub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 09:50:31 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 09:50:30 EDT
Received: by isilmar-4.linta.de (Postfix, from userid 10654)
        id CC058200512; Wed, 10 Jun 2020 13:45:07 +0000 (UTC)
Date:   Wed, 10 Jun 2020 15:45:07 +0200
From:   Hendrik Hoeth <hendrik.hoeth@air-avionics.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: BME-280 humidity over-/underflow
Message-ID: <20200610134507.GT2681@linta.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've discovered an over-/underflow problem for relative humidity
measurements in drivers/iio/pressure/bmp280-core.c. At very low
humidities the value measured by the sensor can fluctuate into the
negative humidity range. The kernel driver then reports this as
extremely large value (e.g. 4193085, corresponding to 4193% RH). The
same probably happens at high humidity values, but with our climate
chamber I was only able to look at the low end.

To avoid this, the reference code in the BME-280 datasheet catches
values < 0% RH and > 100% RH. These two lines are currently missing in
the kernel driver.

Attached you find a patch that fixed the problem for us. You can find
the sensor datasheet at
https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280-DS002.pdf
The code I'm talking about is in section 4.2.3 on page 25/26.

Thanks a lot,

   Hendrik

-- 
Garrecht Avionik GmbH | Wieslocher Str. 38 | 69190 Walldorf
https://www.air-avionics.com/
Tel.: +49 6224 98 96 999

--1UWUbFP1cBYEclgG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="bmp280-core.c.patch"

Fix underflow / overflow for humidity measurements

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 29c209cc1108..d1f36b044f05 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -270,6 +270,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
 		+ (s32)2097152) * calib->H2 + 8192) >> 14);
 	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
+	var = ((var < 0) ? 0 : var);
+	var = ((var > 419430400) ? 419430400 : var);
 
 	return var >> 12;
 };

--1UWUbFP1cBYEclgG--
