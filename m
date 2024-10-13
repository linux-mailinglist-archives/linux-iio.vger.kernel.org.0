Return-Path: <linux-iio+bounces-10536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339B99B9F2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E20B21022
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D928143C5D;
	Sun, 13 Oct 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILPrDjlx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFD13D2A9;
	Sun, 13 Oct 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832650; cv=none; b=mCTRD5FCrzVDpzP3qjyuEY1i6fdDSIlV0c3aVifoYrAI3AaYKFyL5GVnIY5ZJdNTCNJxKBt+MR9MBhBugyvpEEnWG/C7ZMhE+KToIGAxLAJLmYxIs0CrTiv7uoJAqBZ65GqG3nwl0asEBxA5x54Ey0bkI4UBU/PhCkAsYuMAH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832650; c=relaxed/simple;
	bh=JVnc1j0mWKQBNdNpDe0f7EtJQgFGHmxyd9P2vLE+dyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Feuv6X8esHjt+mavdfReCrEQsxqDVJooUGu61tquNdxOHnJpaa/51p5+VkexfMgAroBJHTtL5u8mufNh8CUiTpCsIIvDTI1znPnmufa0Tmccz0g0LV8O3RFyDEmjlDsd1naIv5fLEX3Hqd9D8MS9DCTibqtLgfuvrfh3z3KEW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILPrDjlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC34C4CEC5;
	Sun, 13 Oct 2024 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728832649;
	bh=JVnc1j0mWKQBNdNpDe0f7EtJQgFGHmxyd9P2vLE+dyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILPrDjlxuztYux4mYStVB0P2qnX3NVL6N3wH37iFTXEBITG9cdDVHNYmYaGBusqWt
	 IlHLZjdnEiYaMKf+1fK9iyklDTckUrMbensNMa39LUjujDcH3oSpWhM4kLWGIJV1M+
	 fH29rLSefg6U8wFXYrsz6YzoFgoNIyn2Lh94o4/65hjxuDHmpyaOtXLJxeFSyctaY7
	 gPG3dibuUp9LghfLff7F94Sl3XedSZ/QpgVQewl+0akeUYmA0bhXr6KaGTq5/n+O6r
	 yDxA+uscSmgFQsIvdJ/YFtsxqAUDTRQ5nn9ALz9+piByywMCGiSOsb9XxQYlls69Hk
	 XnRBXnEMvDdYg==
Date: Sun, 13 Oct 2024 16:17:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 2/3] iio: imu: Add triggered buffer for Bosch BMI270 IMU
Message-ID: <20241013161722.5cb25eb3@jic23-huawei>
In-Reply-To: <87wmicpvso.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-3-justin@justinweiss.com>
	<20241012121812.0c62ba51@jic23-huawei>
	<87wmicpvso.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 19:43:19 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Fri, 11 Oct 2024 08:37:48 -0700
> > Justin Weiss <justin@justinweiss.com> wrote:
> >  
> >> Set up a triggered buffer for the accel and angl_vel values.
> >> 
> >> Signed-off-by: Justin Weiss <justin@justinweiss.com>  
> > Hi Justin
> >
> > A few suggestions inline. Other than the DMA safe buffer thing, looks good
> > but you might want to consider using a single bulk read.
> >
> > My cynical view is that if someone paid for an IMU they probably want all
> > the channels, so optimizing for that case is a good plan.
> >  
> >> ---
> >>  drivers/iio/imu/bmi270/Kconfig       |  1 +
> >>  drivers/iio/imu/bmi270/bmi270.h      |  8 +++++
> >>  drivers/iio/imu/bmi270/bmi270_core.c | 47 ++++++++++++++++++++++++++++
> >>  3 files changed, 56 insertions(+)
> >> 
> >> diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
> >> index 0ffd29794fda..6362acc706da 100644
> >> --- a/drivers/iio/imu/bmi270/Kconfig
> >> +++ b/drivers/iio/imu/bmi270/Kconfig
> >> @@ -6,6 +6,7 @@
> >>  config BMI270
> >>  	tristate
> >>  	select IIO_BUFFER  
> >
> > Hmm. The IIO_BUFFER select shouldn't have been here as no obvious use
> > in the driver. Ah well - this patch 'fixes' that :)
> >  
> >> +	select IIO_TRIGGERED_BUFFER
> >>  
> >>  config BMI270_I2C
> >>  	tristate "Bosch BMI270 I2C driver"
> >> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> >> index 51e374fd4290..335400c34b0d 100644
> >> --- a/drivers/iio/imu/bmi270/bmi270.h
> >> +++ b/drivers/iio/imu/bmi270/bmi270.h
> >> @@ -11,6 +11,14 @@ struct bmi270_data {
> >>  	struct device *dev;
> >>  	struct regmap *regmap;
> >>  	const struct bmi270_chip_info *chip_info;
> >> +
> >> +	/*
> >> +	 * Ensure natural alignment for timestamp if present.
> >> +	 * Max length needed: 2 * 3 channels + 4 bytes padding + 8 byte ts.
> >> +	 * If fewer channels are enabled, less space may be needed, as
> >> +	 * long as the timestamp is still aligned to 8 bytes.
> >> +	 */
> >> +	__le16 buf[12] __aligned(8);
> >>  };
> >>  
> >>  enum bmi270_device_type {
> >> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> >> index e5ee80c12166..f49db5d1bffd 100644
> >> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> >> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> >> @@ -7,6 +7,8 @@
> >>  #include <linux/regmap.h>
> >>  
> >>  #include <linux/iio/iio.h>
> >> +#include <linux/iio/triggered_buffer.h>
> >> +#include <linux/iio/trigger_consumer.h>
> >>  
> >>  #include "bmi270.h"
> >>  
> >> @@ -66,6 +68,7 @@ enum bmi270_scan {
> >>  	BMI270_SCAN_GYRO_X,
> >>  	BMI270_SCAN_GYRO_Y,
> >>  	BMI270_SCAN_GYRO_Z,
> >> +	BMI270_SCAN_TIMESTAMP,
> >>  };
> >>  
> >>  const struct bmi270_chip_info bmi270_chip_info[] = {
> >> @@ -82,6 +85,29 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
> >>  };
> >>  EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
> >>  
> >> +static irqreturn_t bmi270_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
> >> +	int i, ret, j = 0, base = BMI270_ACCEL_X_REG;
> >> +	__le16 sample;
> >> +
> >> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> >> +		ret = regmap_bulk_read(bmi270_device->regmap,
> >> +				       base + i * sizeof(sample),
> >> +				       &sample, sizeof(sample));  
> >
> > This is always a fun corner.
> > regmap doesn't guarantee to bounce buffer the data used by the underlying
> > transport. In the case of SPI that means we need a DMA safe buffer for bulk
> > accesses.  In practice it may well bounce the data today but there are optmizations
> > that would make it zero copy that might get applied in future.
> >
> > Easiest way to do that is put your sample variable in the iio_priv structure
> > at the end and mark it __aligned(IIO_DMA_MINALIGN)
> >
> > Given you are reading a bunch of contiguous registers here it may well make
> > sense to do a single bulk read directly into buf and then use
> > the available_scan_masks to let the IIO core know it always gets a full set
> > of samples. Then if the user selects a subset the IIO core will reorganize
> > the data that they get presented with.  
> 
> That's convenient :-)
> 
> It should make this much simpler. To clarify, I'll use regmap_bulk_read
> to read all of the registers at once into a stack-allocated buffer, and
> then push that buffer. Then I can remove bmi270_device->buf entirely,
> and avoid the DMA problem that way.

Given this supports SPI. The target buffer can't be on the stack.
You still need the __aligned(IIO_DMA_MINALIGN) element in your iio_priv()
structure.

> 
> Then I'll provide one avail_mask that sets all of the
> BMI270_SCAN_ACCEL_* and BMI270_SCAN_GYRO_* bits.
Otherwise your description is what I'd expect to see.

> 
> > Whether that makes sense from a performance point of view depends on
> > the speed of the spi transfers vs the cost of setting up the individual ones.
> >
> > You could optimize contiguous reads in here, but probably not worth that
> > complexity.
> >  
> >> +		if (ret)
> >> +			goto done;
> >> +		bmi270_device->buf[j++] = sample;  
> >
> > It's not a huge buffer and you aren't DMAing into it, so maybe just put this
> > on the stack?
This would only be correct for the case where you aren't DMAing directly into it.
I guess I confused the message above with this point!

Jonathan

> >  
> >> +	}
> >> +
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, bmi270_device->buf, pf->timestamp);
> >> +done:
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +	return IRQ_HANDLED;
> >> +}  


