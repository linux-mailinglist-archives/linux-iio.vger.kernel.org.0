Return-Path: <linux-iio+bounces-25390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A72BC02B9D
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D963AD5F8
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED730347BD6;
	Thu, 23 Oct 2025 17:27:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E031347BBD;
	Thu, 23 Oct 2025 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240446; cv=none; b=YPk5qVLwemT8y6rrqHbMs5NAKhQbbW8Z3bosBEF5qJJvqGp4q1UQOmLBxYHiDNDlyXnZW8htEpY6ZfU+cRkpj8nCz976FnDlhbXIJspBlYQ48gOtfgOyKXuYPnlG4MLgfO//V3DojjR2dNufotVYWZGZ4b2vBLw/y7l0SmYND4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240446; c=relaxed/simple;
	bh=uCMEyX7zv7yoSPfjhZ0JlEAaMTV0X3LUFKE+agW2X8I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnhQ4dwlqqr0cT4FW2jgmWg5giQJpm/ztR7HC98IZ9xHd2ob1TOjS9DH565SaZXzhyb7r0J7eeCgKVn3LeSbfLgVUH/hxoZwYc7hKPk2x03uR+gkvPOKEbXkeXw+RSHFLuCEUlrs6ScVM4ZWlRxTZlh32D/e2Wf/ageOPSyEmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cstGp6hglz6L4xD;
	Fri, 24 Oct 2025 01:25:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 270FC140279;
	Fri, 24 Oct 2025 01:27:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:27:22 +0100
Date: Thu, 23 Oct 2025 18:27:21 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<marcelo.schmitt1@gmail.com>, <vassilisamir@gmail.com>,
	<salah.triki@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <akhileshpatilvnit@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251023182721.00002112@huawei.com>
In-Reply-To: <aPek1GqhhyOWFfLG@smile.fi.intel.com>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
	<5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
	<aPek1GqhhyOWFfLG@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)


> 
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_ABP060MG) += abp060mg.o
> > +obj-$(CONFIG_ADP810) += adp810.o
> >  obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
> >  obj-$(CONFIG_BMP280) += bmp280.o
> >  bmp280-objs := bmp280-core.o bmp280-regmap.o
> > @@ -15,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
> >  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
> >  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
> >  obj-$(CONFIG_HP03) += hp03.o
> > +obj-$(CONFIG_HP206C) += hp206c.o
> >  obj-$(CONFIG_HSC030PA) += hsc030pa.o
> >  obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
> >  obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
> > @@ -34,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
> >  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
> >  st_pressure-y := st_pressure_core.o
> >  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> > +obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > +obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> >  obj-$(CONFIG_T5403) += t5403.o
> > -obj-$(CONFIG_HP206C) += hp206c.o
> >  obj-$(CONFIG_ZPA2326) += zpa2326.o
> >  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
> >  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> > -
> > -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o  
> 
> I would split order fix into a separate change, but if maintainers are okay
> with this approach, I would not object.

I was late to replying to v2 on this.  Split it out please.



