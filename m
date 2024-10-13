Return-Path: <linux-iio+bounces-10534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A93399B806
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 04:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FA51C21985
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78023BF;
	Sun, 13 Oct 2024 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="Yl9FKCka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o34fwCOt"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AE28FA;
	Sun, 13 Oct 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728787523; cv=none; b=oRRjP8RNCom9zrDBaDqoaWTjTOqJ2TwN9ftY/WZ84JCpMNWwTiy/FkLq/drQBeIuyyGmVN3KQnjZNRPWwooEEaAmBuEognouT/SzXqA6BFM+Vb5BzxjJ3CeptedgOrXKKcddLv/j2cdbGcBSVRmCguoWNmSoV59hmA4ukYPgLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728787523; c=relaxed/simple;
	bh=VhLzKfhl5eKJ6FdVd+6ZXnjYC7ckhrBqsPbWW4WMIxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1VWM9Ny2bXoIVDXLOPUP9KXV1IuloCk/0f3stldy8xy5zei96oUk0EM7hAVNAmzDDEsZORLWF3tdixmCAXY/IjoJOtlLokdOAQWfPWgKYPvozNt7GLHkxf2isNLYVB3+UJlF35Ok7pJp8B3GPAzyyaWvJAeQAn9X4x3hfKGxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=Yl9FKCka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o34fwCOt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C09D61380278;
	Sat, 12 Oct 2024 22:45:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Oct 2024 22:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728787520; x=
	1728873920; bh=kk5xhrjM4uJHkDUx8akntYiGpQanizZ4772wO/oVjbk=; b=Y
	l9FKCkabl/+B4K/0Lp5gcv1OAswg3wnwXFk7rdW/0SvY1hU3nejFlceSlRxoAff9
	KGMiw69EBosy67xBYvB/umnxbFEya3FCahCSWjUaW0CWxVb2KIN4VjlC3Q0zyKGQ
	dYO/VMSuWf8rizxnkNQYj/MYNl+74sxRQSAAwR8PA12XlJg4Hkl75n34XUhczIg2
	Ix7a87wjUPRVFTLnt55+8ExmK2bVS0rBNvo7D39vIWAJN7PmvurbWKW42GEdJAUp
	l8CTO7c2j8eZvynKShrpsrcyMFelivBtD/ig4nBTuGlX6A2QLEHOn5zhNl+nGtWN
	pqsUxmjiXzgQ9+KmIloYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728787520; x=1728873920; bh=kk5xhrjM4uJHkDUx8akntYiGpQan
	izZ4772wO/oVjbk=; b=o34fwCOtwQcuMxWHDGUN4IvjWOxJVEtnWGhDJgjB860/
	/h4Zw3a/oDYtxVYVHye5NjJUPY7JrbrFT9Teq0xhm0f9NCHfDMJbsVOagLYI7gUn
	2vVVLXLiqcSwNWAnSzBxa3bIt/IUS8hM6AmPFNEjX5indhLBe5/jFn3Cm9CwPBMp
	85kERxLu51DkjKtkYv4gi1iE8HVcj/gdxCEiXpmVhUx9ANMzYYrc1nF+nf7DlNfE
	219n6EccE8RL/VlRkDM90jwJTND8hj+Ng/TKqGogoa5keR7NjoOAhnoe3erPeTTf
	+BbhUonJKqJcROnS2vSymerDhZhjP8ehZ840unPbhw==
X-ME-Sender: <xms:QDQLZ7oL9cKjNDKONjnVbkC0xV0YL2FsWxrwnIFcThIpEO3NY6tDAw>
    <xme:QDQLZ1o2TY7L50YwDWPd2LECjQMDu9AGT2CcLxxF9YdcyMh7LH4-ATaKcvwxdDSRc
    FigTQ_jvl5tv9eyCg>
X-ME-Received: <xmr:QDQLZ4NYDRRhSZrtjT0HC_yQfgxOGXWh5qj7qkY8FWeSO5ir00UtAB4yqdZMgnbKUOwJJLkw6i3oHepSWu7agOgVyy2IkcZub9I>
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
X-ME-Proxy: <xmx:QDQLZ-7N2_7pz80-vMdtlSypv7uQ0PP9KWzO0nZHYIbrjz0Rukwo8w>
    <xmx:QDQLZ65GRnZ9PxKIZ6yDjbN4ACvJWTHQDwFAn3LpxmCadO5tsn4ukg>
    <xmx:QDQLZ2gIuwykr7fOnYjEl4v_9kQmrv32bHlY79wKEQqsvB2YLEPdoA>
    <xmx:QDQLZ86VrdfkLSTBuOrtR6UN4sX3If74CafXe6gI0zkiGF50UkKG7g>
    <xmx:QDQLZxYLOQ_gZSNK17Npjukf-sIQ6s4DW-jwAcfZtE4OkKGTwxTseYzt>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 22:45:19 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
In-Reply-To: <20241012123535.1abe63bd@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 12 Oct 2024 12:35:35 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
	<20241012123535.1abe63bd@jic23-huawei>
Date: Sat, 12 Oct 2024 19:45:18 -0700
Message-ID: <87jzecpvpd.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 11 Oct 2024 08:37:49 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Add read and write functions and create _available entries. Use
>> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
>> the BMI160 / BMI323 drivers.
>
> Ah.  Please break dropping _FREQUENCY change out as a separate fix
> with fixes tag etc and drag it to start of the patch. It was never
> wired to anything anyway
>
> That's a straight forward ABI bug so we want that to land ahead
> of the rest of the series.

Thanks, I'll pull that into its own change and make it the first patch.

> Does this device have a data ready interrupt and if so what affect
> do the different ODRs for each type of sensor have on that?
> If there are separate data ready signals, you probably want to 
> go with a dual buffer setup from the start as it is hard to unwind
> that later.

It has data ready interrupts for both accelerometer and gyroscope and a
FIFO interrupt. I had held off on interrupts to keep this change
simpler, but if it's a better idea to get it in earlier, I can add it
alongside the triggered buffer change.

>
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
>> ---
>>  drivers/iio/imu/bmi270/bmi270_core.c | 293 ++++++++++++++++++++++++++-
>>  1 file changed, 291 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
>> index f49db5d1bffd..ce7873dc3211 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_core.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/regmap.h>
>>  
>>  #include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>>  #include <linux/iio/triggered_buffer.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  
>> @@ -34,6 +35,9 @@
>>  #define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
>>  #define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
>>  
>> +#define BMI270_ACC_CONF_RANGE_REG			0x41
>> +#define BMI270_ACC_CONF_RANGE_MSK			GENMASK(1, 0)
>> +
>>  #define BMI270_GYR_CONF_REG				0x42
>>  #define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
>>  #define BMI270_GYR_CONF_ODR_200HZ			0x09
>> @@ -42,6 +46,9 @@
>>  #define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
>>  #define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
>>  
>> +#define BMI270_GYR_CONF_RANGE_REG			0x43
>> +#define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
>> +
>>  #define BMI270_INIT_CTRL_REG				0x59
>>  #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
>>  
>> @@ -85,6 +92,236 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
>>  };
>>  EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
>>  
>> +enum bmi270_sensor_type {
>> +	BMI270_ACCEL	= 0,
>> +	BMI270_GYRO,
>> +};
>> +
>> +struct bmi270_scale {
>> +	u8 bits;
>> +	int uscale;
>> +};
>> +
>> +struct bmi270_odr {
>> +	u8 bits;
>> +	int odr;
>> +	int uodr;
>> +};
>> +
>> +static const struct bmi270_scale bmi270_accel_scale[] = {
>> +	{ 0x00, 598},
> 	{ 0x00, 598 },
>
> So space before } for all these.

Will fix in v2.

>> +	{ 0x01, 1197},
>> +	{ 0x02, 2394},
>> +	{ 0x03, 4788},
>> +};
>> +
>> +static const struct bmi270_scale bmi270_gyro_scale[] = {
>> +	{ 0x00, 1065},
>> +	{ 0x01, 532},
>> +	{ 0x02, 266},
>> +	{ 0x03, 133},
>> +	{ 0x04, 66},
>> +};
>> +
>> +struct bmi270_scale_item {
>> +	const struct bmi270_scale *tbl;
>> +	int num;
>> +};
>> +
>> +static const struct bmi270_scale_item bmi270_scale_table[] = {
>> +	[BMI270_ACCEL] = {
>> +		.tbl	= bmi270_accel_scale,
>> +		.num	= ARRAY_SIZE(bmi270_accel_scale),
>> +	},
>> +	[BMI270_GYRO] = {
>> +		.tbl	= bmi270_gyro_scale,
>> +		.num	= ARRAY_SIZE(bmi270_gyro_scale),
>> +	},
>> +};
>> +
>> +static const struct bmi270_odr bmi270_accel_odr[] = {
>> +	{0x01, 0, 781250},
>> +	{0x02, 1, 562500},
>> +	{0x03, 3, 125000},
>> +	{0x04, 6, 250000},
>> +	{0x05, 12, 500000},
>> +	{0x06, 25, 0},
>> +	{0x07, 50, 0},
>> +	{0x08, 100, 0},
>> +	{0x09, 200, 0},
>> +	{0x0A, 400, 0},
>> +	{0x0B, 800, 0},
>> +	{0x0C, 1600, 0},
>> +};
>> +
>> +static const struct bmi270_odr bmi270_gyro_odr[] = {
>> +	{0x06, 25, 0},
>> +	{0x07, 50, 0},
>> +	{0x08, 100, 0},
>> +	{0x09, 200, 0},
>> +	{0x0A, 400, 0},
>> +	{0x0B, 800, 0},
>> +	{0x0C, 1600, 0},
>> +	{0x0D, 3200, 0},
>> +};
>> +
>> +struct bmi270_odr_item {
>> +	const struct bmi270_odr *tbl;
>> +	int num;
>> +};
>> +
>> +static const struct  bmi270_odr_item bmi270_odr_table[] = {
>> +	[BMI270_ACCEL] = {
>> +		.tbl	= bmi270_accel_odr,
>> +		.num	= ARRAY_SIZE(bmi270_accel_odr),
>> +	},
>> +	[BMI270_GYRO] = {
>> +		.tbl	= bmi270_gyro_odr,
>> +		.num	= ARRAY_SIZE(bmi270_gyro_odr),
>> +	},
>> +};
>> +
>> +static int bmi270_set_scale(struct bmi270_data *data,
>> +			    int chan_type, int uscale)
>> +{
>> +	int i;
>> +	int reg;
>> +	struct bmi270_scale_item bmi270_scale_item;
>> +
>> +	switch (chan_type) {
>> +	case IIO_ACCEL:
>> +		reg = BMI270_ACC_CONF_RANGE_REG;
>> +		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
>> +		break;
>> +	case IIO_ANGL_VEL:
>> +		reg = BMI270_GYR_CONF_RANGE_REG;
>> +		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < bmi270_scale_item.num; i++)
>> +		if (bmi270_scale_item.tbl[i].uscale == uscale)
>> +			break;
>> +
>> +	if (i == bmi270_scale_item.num)
>> +		return -EINVAL;
>> +
>> +	return regmap_write(data->regmap, reg,
>> +			    bmi270_scale_item.tbl[i].bits);
> Maybe do the write in the if above, (or use the continue approach mentioned
> below + do the write in the for loop.
> Then any exit from the loop that isn't a return is a failure and you an save the check.

Thanks for this suggestion, I'll change all of these loops to use continue / return.

>> +}
>> +
>> +static int bmi270_get_scale(struct bmi270_data *bmi270_device,
>> +			    int chan_type, int *uscale)
>> +{
>> +	int i, ret, val;
>> +	int reg;
>> +	struct bmi270_scale_item bmi270_scale_item;
>> +
>> +	switch (chan_type) {
>> +	case IIO_ACCEL:
>> +		reg = BMI270_ACC_CONF_RANGE_REG;
>> +		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
>> +		break;
>> +	case IIO_ANGL_VEL:
>> +		reg = BMI270_GYR_CONF_RANGE_REG;
>> +		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_read(bmi270_device->regmap, reg, &val);
>> +	if (ret)
>> +		return ret;
>
> No masking?

Looks like I missed this. I'll fix it in v2.

>
>> +
>> +	for (i = 0; i < bmi270_scale_item.num; i++)
>> +		if (bmi270_scale_item.tbl[i].bits == val) {
> Flip the condition to reduce indent
>
> 		if (bmi270_scale_item.tbl[i].bits != val)
> 			continue;
>
> 		*uscale.
>
>> +			*uscale = bmi270_scale_item.tbl[i].uscale;
>> +			return 0;
>> +		}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int bmi270_set_odr(struct bmi270_data *data, int chan_type,
>> +			  int odr, int uodr)
>> +{
>> +	int i;
>> +	int reg, mask;
>> +	struct bmi270_odr_item bmi270_odr_item;
>> +
>> +	switch (chan_type) {
>> +	case IIO_ACCEL:
>> +		reg = BMI270_ACC_CONF_REG;
>> +		mask = BMI270_ACC_CONF_ODR_MSK;
>> +		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
>> +		break;
>> +	case IIO_ANGL_VEL:
>> +		reg = BMI270_GYR_CONF_REG;
>> +		mask = BMI270_GYR_CONF_ODR_MSK;
>> +		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < bmi270_odr_item.num; i++)
>> +		if (bmi270_odr_item.tbl[i].odr == odr &&
>> +		    bmi270_odr_item.tbl[i].uodr == uodr)
>> +			break;
>> +
>> +	if (i >= bmi270_odr_item.num)
>> +		return -EINVAL;
>> +
>> +	return regmap_update_bits(data->regmap,
>> +				  reg,
>> +				  mask,
>> +				  bmi270_odr_item.tbl[i].bits);
>
> combine parameters on each line to get nearer to 80 char limit.

Will fix in v2.

>
>> +}
>> +
>> +static int bmi270_get_odr(struct bmi270_data *data, int chan_type,
>> +			  int *odr, int *uodr)
>> +{
>> +	int i, val, ret;
>> +	int reg, mask;
>> +	struct bmi270_odr_item bmi270_odr_item;
>> +
>> +	switch (chan_type) {
>> +	case IIO_ACCEL:
>> +		reg = BMI270_ACC_CONF_REG;
>> +		mask = BMI270_ACC_CONF_ODR_MSK;
>> +		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
>> +		break;
>> +	case IIO_ANGL_VEL:
>> +		reg = BMI270_GYR_CONF_REG;
>> +		mask = BMI270_GYR_CONF_ODR_MSK;
>> +		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_read(data->regmap, reg, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val &= mask;
>
> I'd just duplicate the regmap_read to allow easy use FIELD_GET etc.
>
>
> 	switch (chan_type) {
> 	case IIO_ACCEL:
> 		ret = regmap_read(data->regmap, BMI270_ACC_CONF_REG, &val);
> 		if (ret)
> 			return ret;		
> 		val = FIELD_GET(val, BMI270_ACC_CONF_ODR_MSK);
> 		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
> 		break;
> 	case IIO_ANGL_VEL:
> 		ret = regmap_read(data->regmap, BMI270_GYR_CONF_REG, &val);
> 		if (ret)
> 			return ret;
> 		val = FIELD_GET(val, BMI270_GYR_CONF_ODR_MSK);
> 		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
> 		break;
> 	default:
> 		return -EINVAL;
> 	}

Thanks, that's nicer. I'll fix it in v2.

>> +
>> +	for (i = 0; i < bmi270_odr_item.num; i++)
>> +		if (val == bmi270_odr_item.tbl[i].bits)
>> +			break;
>> +
>> +	if (i >= bmi270_odr_item.num)
>> +		return -EINVAL;
>> +
>> +	*odr = bmi270_odr_item.tbl[i].odr;
>> +	*uodr = bmi270_odr_item.tbl[i].uodr;
>> +
>> +	return 0;
>> +}
>> +
>> +static
>> +IIO_CONST_ATTR(in_accel_sampling_frequency_available,
>> +	       "0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600");
>> +static
>> +IIO_CONST_ATTR(in_anglvel_sampling_frequency_available,
>> +	       "25 50 100 200 400 800 1600 3200");
>> +static
>> +IIO_CONST_ATTR(in_accel_scale_available,
>> +	       "0.000598 0.001197 0.002394 0.004788");
>> +static
>> +IIO_CONST_ATTR(in_anglvel_scale_available,
>> +	       "0.001065 0.000532 0.000266 0.000133 0.000066");
>> +
>> +static struct attribute *bmi270_attrs[] = {
>> +	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
>> +	&iio_const_attr_in_anglvel_sampling_frequency_available.dev_attr.attr,
>> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>> +	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
> Please use the read_avail callback and info_mask_xxx_avail masks to specify
> these exist for all the channels.
>
> Doing this as custom attrs predates that infrastructure and we are
> slowly converting drivers over.  The main advantage beyond enforced
> ABI is that can get to the values from in kernel consumers of the data.
>

Great, I'll remove these and implement read_avail.

>> +	NULL,
> No comma here.

Will fix in v2.

>> +};
>> +
>> +static const struct attribute_group bmi270_attrs_group = {
>> +	.attrs = bmi270_attrs,
>> +};

