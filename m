Return-Path: <linux-iio+bounces-25389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610CC02B7D
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 19:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2B4E1DF6
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0FB346E60;
	Thu, 23 Oct 2025 17:25:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697F29B793;
	Thu, 23 Oct 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240343; cv=none; b=HVFi30s/kaxzCKTJmDWENXJnsMNbTkIHnvygTSkAK425aoxAj7qkZz0oyppXrfjnc4gO7veMi56C/8O/Yr+dKLj47pqXU/5K3Diy5FMqI10TueFn6gL86ihtXwQc3Z/qzZbJ7a/hbGonJGNhrX52Gt+F01fyhiV1lczSZNWBBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240343; c=relaxed/simple;
	bh=9c3jFP7HcUJ7ZrWMij/S2fNE8Kn0ggPJcf6DUIM6C9Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG2JfX2QTTdb2SjfGghKA1h+sOzE+idwf+CMlG1IxYcPSRQlng99EwwYuep0Xk4S1LS3oqYbVTgOGSy5YoWQhZADtelT0y2Ve6YEkNj3rwIJ45UdjNIwfUWxqamB2fphz90D/+ypOfQ1gr0Efh65eVPBEeCjW9EWHm7JNAoWMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cstBF4GMnz6M4kP;
	Fri, 24 Oct 2025 01:21:57 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CBDE1402FD;
	Fri, 24 Oct 2025 01:25:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:25:38 +0100
Date: Thu, 23 Oct 2025 18:25:37 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
CC: Jonathan Cameron <jic23@kernel.org>, <dlechner@baylibre.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <marcelo.schmitt1@gmail.com>,
	<vassilisamir@gmail.com>, <salah.triki@gmail.com>,
	<skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<akhileshpatilvnit@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251023182537.000069be@huawei.com>
In-Reply-To: <20251021-54542-354166@bhairav-test.ee.iitb.ac.in>
References: <cover.1760374257.git.akhilesh@ee.iitb.ac.in>
	<0b72866f4e5ac28c78f6d683a1ca659a4239b68e.1760374257.git.akhilesh@ee.iitb.ac.in>
	<20251018174746.4a76af1d@jic23-huawei>
	<20251021-54542-354166@bhairav-test.ee.iitb.ac.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 11:15:42 +0530
Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

> On Sat, Oct 18, 2025 at 05:47:46PM +0100, Jonathan Cameron wrote:
> > On Mon, 13 Oct 2025 22:32:35 +0530
> > Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> >   
> > > Add driver for Aosong adp810 differential pressure and temperature sensor.
> > > This sensor provides an I2C interface for reading data.
> > > Calculate CRC of the data received using standard crc8 library to verify
> > > data integrity.
> > > 
> > > Tested on TI am62x sk board with sensor connected at i2c-2.
> > > 
> > > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>  
> > 
> > A few comments inline and it seems your rebase when wrong and you've
> > picked up unrelated build file changes.
> > 
> > Thanks
> > 
> > Jonathan  
> 
> Hi Jonathan, Thanks for the review, I will share v3 addressing these comments.
> 
> Regards,
> Akhilesh
> 
> >   
> > > diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> > > index 6482288e07ee..a21443e992b9 100644
> > > --- a/drivers/iio/pressure/Makefile
> > > +++ b/drivers/iio/pressure/Makefile
> > > @@ -5,6 +5,7 @@
> > >  
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
> > 
> > Rebase gone wrong I assume.    
> 
> These are intentional changes.
> 
> This addresses Andy's suggestion in v1, to keep entries alphabetically
> arranged in Makefile. Along with adp810 location, fixed other files as well
> hp206 and st_pressure_* to make entries alphabetically arranged in
> the entire Makefile.

That reorder of others needs to be a separate patch so that it can
explicitly call out that it is tidying up ordering.

Jonathan





