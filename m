Return-Path: <linux-iio+bounces-10533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F899B804
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 04:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01CB1C21D25
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD0EAC5;
	Sun, 13 Oct 2024 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="fEfMazUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQYeS6+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D258C06;
	Sun, 13 Oct 2024 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728787404; cv=none; b=cwLKTyZHXLT/uC4N9U3IEDNHbxp+PV7+Z3JxWhu527RSeJFKCVUu/timZsZ+r1urCLKhMmIuxt04xduqhRyNVSaoxaRCom63llr9Zs1yn6C+5NzJRH+3YC25yQAyrwiSWi/+0PPIphAh2zfr+iK3f8+6yf33aVaCXIgX2/fhXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728787404; c=relaxed/simple;
	bh=KOPdsozRShs8YsYa+OAEmn6UhDOS515BKt4WweIhfQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXLmDsrJda1Qw6h8KnYyj83LNDKecJxpwXbQn8CbCDsGB1n8QR3UIn1qWaf9JZe8CJHRJg/Ye5nr9tE3eoERG+w8+lYOujXxinvOExXrggkDOQq3g17uRq+cOY7Iz+60Qdv2Bgn2VWdPiWA/iIKfEXPK21ccgWIdgm6GdDA5RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=fEfMazUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQYeS6+1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 591F01380278;
	Sat, 12 Oct 2024 22:43:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 12 Oct 2024 22:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728787401; x=
	1728873801; bh=SO+35268UXqdIdcn9MiSTKbfgL7tUv+dzHyyrirsFQA=; b=f
	EfMazUMwroibqwRsrxQawTjQ870C7j9zBkHEOwWABjDmR+vGbRSOzEU+6FiYSIJ2
	asayhdMfPSKmkYAInVSZSPFNLmMqnY3rUhbie0h9h+vFGRejVILz3jE6ejfcqf0V
	X+S4mgCP8mA2aI7KxNZO856kPWNH7QMGASoDSirTr6SrS5ZpS0bPcIeXQHnBVOpC
	ZgfAWPuZGgadAqPbyziotkZ5tF0iQDUdLJXKU71ID69cfObKh9X1hZA5w8NP+Se3
	hSmN6c1eGn4cimCucWFIhA7pvGuy5oKZ8WOzAh4ZPAsRojELltYb1HciiOBHQ/1r
	vSbPbsJReqsUIe4l8v21g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728787401; x=1728873801; bh=SO+35268UXqdIdcn9MiSTKbfgL7t
	Uv+dzHyyrirsFQA=; b=XQYeS6+1fDJ0304mLp0BNM/0VoPukaUN1aEusrM0NAQy
	x2Bc+dB5ExUOyJXu7+o8RrRetOevOi38Lv/ESvFoqAuv4Z049kTfHwxuky5CkbD3
	SyXMQWjP7XU9wKyImFHA19GyyrT3/la16O24Ptpm+j+j/3CxuIPEGg+yIXKRmAxM
	YdYDZ7oCJS+EKCoc8OaAnDkmNUk2rA5xsiRNofmJIyzNSitaLQUol7J9vPbaxbO/
	2XrwxjMKsTUL8f6gfm7lWjkj5LYAaOIxgh4iatuzq6wb09dMwJLnuccaPn0VrMwy
	0PIgkHK5+HlI1UDRAvqXttAVNMvVyamC07AvVUw2vw==
X-ME-Sender: <xms:yTMLZ7ie6mFWbo8lJdUu1EYaeDAkh9qjkz0LOCEeNnczSTonscJaPA>
    <xme:yTMLZ4AAFaUzP_k1lEZjlmDCHs6Q1qd7VVXe393tQt2kJ8x__KHL130FsujO-9Mrt
    iWCEoI8680pPL1m0Q>
X-ME-Received: <xmr:yTMLZ7GOxJVsgHjichNrzts3Dxroa9R1ZKJMvR8MQnhdyFTIL5bXcUnF_w-lsPirND-OsQbUd1CRJpD49yPMmM_N1vgmLAv48-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpefgueegueeiheffkeektdetfffgffeu
    ieekvdefieejvdefiefgvefhiefhfefgveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhlmhesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopeguvghrvghkjhhohhhnrdgt
    lhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdrug
    gvpdhrtghpthhtoheplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yTMLZ4Qz86or-vG7J8AJXnwG0Q-ksr2IprsF_UmBJ7QbqVSCf5d4QA>
    <xmx:yTMLZ4xLyXsGeEn91nuEPMZ1hphusnqeRXxUO8EDi-mrL1XGEEfbDQ>
    <xmx:yTMLZ-6Oixx23sOaKZWvVo6ZQL1EtY03UfYaGGXehfy6E1u8_Vqmkw>
    <xmx:yTMLZ9xA2yN-i_PgJR45dcHVJrpCgWRRRCy4ZGHL2y1jLK98BhrSnA>
    <xmx:yTMLZ7yqv0B0-v8qqTx2lI9-395bb1HSr2B1ax3FRUZHMoX4TR_41_gn>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 22:43:20 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 2/3] iio: imu: Add triggered buffer for Bosch BMI270 IMU
In-Reply-To: <20241012121812.0c62ba51@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 12 Oct 2024 12:18:12 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-3-justin@justinweiss.com>
	<20241012121812.0c62ba51@jic23-huawei>
Date: Sat, 12 Oct 2024 19:43:19 -0700
Message-ID: <87wmicpvso.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 11 Oct 2024 08:37:48 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Set up a triggered buffer for the accel and angl_vel values.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> Hi Justin
>
> A few suggestions inline. Other than the DMA safe buffer thing, looks good
> but you might want to consider using a single bulk read.
>
> My cynical view is that if someone paid for an IMU they probably want all
> the channels, so optimizing for that case is a good plan.
>
>> ---
>>  drivers/iio/imu/bmi270/Kconfig       |  1 +
>>  drivers/iio/imu/bmi270/bmi270.h      |  8 +++++
>>  drivers/iio/imu/bmi270/bmi270_core.c | 47 ++++++++++++++++++++++++++++
>>  3 files changed, 56 insertions(+)
>> 
>> diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
>> index 0ffd29794fda..6362acc706da 100644
>> --- a/drivers/iio/imu/bmi270/Kconfig
>> +++ b/drivers/iio/imu/bmi270/Kconfig
>> @@ -6,6 +6,7 @@
>>  config BMI270
>>  	tristate
>>  	select IIO_BUFFER
>
> Hmm. The IIO_BUFFER select shouldn't have been here as no obvious use
> in the driver. Ah well - this patch 'fixes' that :)
>
>> +	select IIO_TRIGGERED_BUFFER
>>  
>>  config BMI270_I2C
>>  	tristate "Bosch BMI270 I2C driver"
>> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
>> index 51e374fd4290..335400c34b0d 100644
>> --- a/drivers/iio/imu/bmi270/bmi270.h
>> +++ b/drivers/iio/imu/bmi270/bmi270.h
>> @@ -11,6 +11,14 @@ struct bmi270_data {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>>  	const struct bmi270_chip_info *chip_info;
>> +
>> +	/*
>> +	 * Ensure natural alignment for timestamp if present.
>> +	 * Max length needed: 2 * 3 channels + 4 bytes padding + 8 byte ts.
>> +	 * If fewer channels are enabled, less space may be needed, as
>> +	 * long as the timestamp is still aligned to 8 bytes.
>> +	 */
>> +	__le16 buf[12] __aligned(8);
>>  };
>>  
>>  enum bmi270_device_type {
>> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
>> index e5ee80c12166..f49db5d1bffd 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_core.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
>> @@ -7,6 +7,8 @@
>>  #include <linux/regmap.h>
>>  
>>  #include <linux/iio/iio.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>>  
>>  #include "bmi270.h"
>>  
>> @@ -66,6 +68,7 @@ enum bmi270_scan {
>>  	BMI270_SCAN_GYRO_X,
>>  	BMI270_SCAN_GYRO_Y,
>>  	BMI270_SCAN_GYRO_Z,
>> +	BMI270_SCAN_TIMESTAMP,
>>  };
>>  
>>  const struct bmi270_chip_info bmi270_chip_info[] = {
>> @@ -82,6 +85,29 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
>>  };
>>  EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
>>  
>> +static irqreturn_t bmi270_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
>> +	int i, ret, j = 0, base = BMI270_ACCEL_X_REG;
>> +	__le16 sample;
>> +
>> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
>> +		ret = regmap_bulk_read(bmi270_device->regmap,
>> +				       base + i * sizeof(sample),
>> +				       &sample, sizeof(sample));
>
> This is always a fun corner.
> regmap doesn't guarantee to bounce buffer the data used by the underlying
> transport. In the case of SPI that means we need a DMA safe buffer for bulk
> accesses.  In practice it may well bounce the data today but there are optmizations
> that would make it zero copy that might get applied in future.
>
> Easiest way to do that is put your sample variable in the iio_priv structure
> at the end and mark it __aligned(IIO_DMA_MINALIGN)
>
> Given you are reading a bunch of contiguous registers here it may well make
> sense to do a single bulk read directly into buf and then use
> the available_scan_masks to let the IIO core know it always gets a full set
> of samples. Then if the user selects a subset the IIO core will reorganize
> the data that they get presented with.

That's convenient :-)

It should make this much simpler. To clarify, I'll use regmap_bulk_read
to read all of the registers at once into a stack-allocated buffer, and
then push that buffer. Then I can remove bmi270_device->buf entirely,
and avoid the DMA problem that way.

Then I'll provide one avail_mask that sets all of the
BMI270_SCAN_ACCEL_* and BMI270_SCAN_GYRO_* bits.

> Whether that makes sense from a performance point of view depends on
> the speed of the spi transfers vs the cost of setting up the individual ones.
>
> You could optimize contiguous reads in here, but probably not worth that
> complexity.
>
>> +		if (ret)
>> +			goto done;
>> +		bmi270_device->buf[j++] = sample;
>
> It's not a huge buffer and you aren't DMAing into it, so maybe just put this
> on the stack?
>
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, bmi270_device->buf, pf->timestamp);
>> +done:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +	return IRQ_HANDLED;
>> +}

