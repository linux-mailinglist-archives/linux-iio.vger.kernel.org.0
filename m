Return-Path: <linux-iio+bounces-25431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABAC08AB0
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 06:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F2D434F860
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 04:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47D277CA4;
	Sat, 25 Oct 2025 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="CyHJ7K2d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01E1F1534
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761365965; cv=none; b=ILTHC440lbjPWoVVQtUkbCzeB5GXTfJCsfgQfiCVTiJzbhaIdhZl/R3CChX3RdZ+P1p1EJ2x0VKRQh1yfdzrtDWqKrcMs0WavzVYmmmGSDkMuY4YNN4a+mztu8rCVc7T2UuvZqNVJ0l8IRZEW+yC7CkZ2TAt20h6m9KKhJN6ktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761365965; c=relaxed/simple;
	bh=F86fr8wwYZ21rbw8o2/5qJLCIUEAZCdjoizMf+qNyQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpywc+9GEDKlTCJsocUFkLcyITW4k/odIDTu+zApGZeU1RPjUOhIhYhe2toFSinsYpoNYyQpl41lzi5L74PMfdqM4D0bNWuzV76pg1pRINw+YAr9RQEksROw7SdrGReImuTxf2xTniV+Ix/t6s/btZDcO8KLr05ugNM3pMdvK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=CyHJ7K2d; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 63127104C1F8
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 09:49:17 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 63127104C1F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761365957; bh=F86fr8wwYZ21rbw8o2/5qJLCIUEAZCdjoizMf+qNyQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyHJ7K2dWlBIO+0+jcFsCaEU/OFjp3bsWfbP12SFWsCveEh2zgnfvr+TijaZBzXT7
	 38F52JnUGBv12mkNhLqv3m7G/WZ3YoLVYbkyeRq6fjfmW+f59FC7PLRqPJ3qf0ogfU
	 mxyWkFjImTwP76XYVu5LwvbJcnrNBsV1oZwtKywI=
Received: (qmail 10983 invoked by uid 510); 25 Oct 2025 09:49:17 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 0.699238 secs; 25 Oct 2025 09:49:17 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 25 Oct 2025 09:49:16 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id B2B81360048;
	Sat, 25 Oct 2025 09:49:15 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 656061E815F3;
	Sat, 25 Oct 2025 09:49:14 +0530 (IST)
Date: Sat, 25 Oct 2025 09:49:08 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v3 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251025-4198-933453@bhairav-test.ee.iitb.ac.in>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
 <5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
 <aPek1GqhhyOWFfLG@smile.fi.intel.com>
 <20251023182721.00002112@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023182721.00002112@huawei.com>

On Thu, Oct 23, 2025 at 06:27:21PM +0100, Jonathan Cameron wrote:
> 
> > 
> > >  # When adding new entries keep the list in alphabetical order
> > >  obj-$(CONFIG_ABP060MG) += abp060mg.o
> > > +obj-$(CONFIG_ADP810) += adp810.o
> > >  obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
> > >  obj-$(CONFIG_BMP280) += bmp280.o
> > >  bmp280-objs := bmp280-core.o bmp280-regmap.o
> > > @@ -15,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
> > >  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
> > >  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
> > >  obj-$(CONFIG_HP03) += hp03.o
> > > +obj-$(CONFIG_HP206C) += hp206c.o
> > >  obj-$(CONFIG_HSC030PA) += hsc030pa.o
> > >  obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
> > >  obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
> > > @@ -34,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
> > >  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
> > >  st_pressure-y := st_pressure_core.o
> > >  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> > > +obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > > +obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> > >  obj-$(CONFIG_T5403) += t5403.o
> > > -obj-$(CONFIG_HP206C) += hp206c.o
> > >  obj-$(CONFIG_ZPA2326) += zpa2326.o
> > >  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
> > >  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> > > -
> > > -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > > -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o  
> > 
> > I would split order fix into a separate change, but if maintainers are okay
> > with this approach, I would not object.
> 
> I was late to replying to v2 on this.  Split it out please.

Sure. I will take reordering of other entries as an independent patch.
In this series, let's add adp810.o only at alphabetically correct place.

Regards,
Akhilesh


