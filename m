Return-Path: <linux-iio+bounces-16808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C09A60A0E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495C4189878A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44442146585;
	Fri, 14 Mar 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhryAnpR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A404D8D1;
	Fri, 14 Mar 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937525; cv=none; b=uyT1yGLPf6XUEui/OMrX/556BJktbYJcCNG+RztXnd8PanIA3i+LV2D1uMuuaTfB4R5Wm1ceLgiAfUstTE1gcO+zSgx4Ml+3FdpzwafjpWt0vJ5iIsN2dC1xPO/g7SrTC7/tu9XfI70Wr7hBKKSnOkCkU2enQfnhyYZUhg6MZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937525; c=relaxed/simple;
	bh=U4MB/1OSYcO5xPco/HtNwaheWo473aM56nvkuE6ciTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFSxXWhxFW/ycCq7N5r0PIVjgZ+Y/7wosV51O31qpKg3fg4vXTpLmjz73pe4GfNwaBpmMPlwsPaCX3rcL1eguo7msvrQGdB7PuUvpa4kF1ZpYOmRP21MPHw4Coz+3UEP7J0fIS8S71/Ev7tspsDNB7PaDrFahPRNFl2EqzShXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhryAnpR; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bae572157so18572761fa.3;
        Fri, 14 Mar 2025 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741937521; x=1742542321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiF3p5wcbjaBc2gpg6f5VD4fiFsRG7nPpd8GZIgN3OA=;
        b=lhryAnpRCn4J/12gfAQFvcsNBqrQ698Ne8sPGB1iA2Dv8Zp9TpBVCi6/lQOt2Z6Lpw
         GZZPjPUjiPvBYuy8yrcyKtFSgBZ9QkDKgmAn5Ja+7UBAHFTiW0ws58BgvQpdU+bCBgKi
         p0xf9NR0N9mk9lscQuLczA7zTZed+SZw5CroCedYkR6xQlLuchx19QFWsQi9skGlcmFG
         OjaN8vql9wvCRw6/aE9b9CtwSuN5J/mAbhcD9H9eN4rtuwq3Sy23Th5Nm6WXoLwrEzUB
         iRiqFi1o2ZboVTjI6l8N9gvYCBy9hAp04T6Vs2xXaesh85M5MN4YJ+uwFv6OOROnzOqT
         YdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741937521; x=1742542321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiF3p5wcbjaBc2gpg6f5VD4fiFsRG7nPpd8GZIgN3OA=;
        b=AjC3Nydi1hrj2XLVfQqC7rNO8Yax2dKYftkPo+29+ByQ8gX9pVC7FrIOw5Ugz/Fduw
         yKg1Gt4TIxV392GbR0MDl2/W5ryFCNiwZbCAiU6Kz3j8i5wyClS8o75JCcZe8FUXi3Q4
         CAW3qA3PvvO9BApBMomqwiN+HHGtnwFMlrRtupK9STnC8owV8DvAjjEwKQsYronxrn/w
         151eD7wB90CW3Lxzj2w1hwaM9xDM9cNlWm4nI3Sf4MK39R2czcEOCMv/HhvTkUz28fv7
         lQmHwRWxdRr/Lpbxmecv4+UOvo0Noklv2+0l8NwYtA4k6dl4k46Qisc+gTA+LiwHM1Fa
         uLpw==
X-Forwarded-Encrypted: i=1; AJvYcCVC6RRha4Kb72EXVMyMfr/GWgOnY74rbKWicDR3IG8Q+hEx84l5dWVx9I25RZZ7cS/GYOuPkJ8spFc=@vger.kernel.org, AJvYcCXMjPm91OLB3HwWYxZRD/jqXIf+u2y/NwdB4hKSTu98f0Sdq2rKUSsE+i+x0hFHD7M3Ca4SXdNwJq5eTLjQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxFg3GApi9LBSlQjeN/xb3YwjD11EIuKAz3n5zEZXFN4oPlfzom
	4yPvP8Ag2lz50GxGWMy1FCulGmtN1/CcNT3SUFiswTa7MP61mjBu
X-Gm-Gg: ASbGncszcqAZYyHS4C4GQmHEV6lrav0pHkPug4oqFnWA904iRU0HvTuNhwG+RP+nzhW
	waBEhjUQDAGIYTStgNlEWFcPSTKi5kQuV5fjE3GnpXvM755cet0MH6zS7UMRAvEVpNNDqkpGKwB
	wp30loWvte4gXdm/wd0EhzI5Xn18adzU42m+bZ2jzNaKBGkz+8fSfEd3mZm5ou2mAoIssTl+LnE
	f37fBUNzrkr/NrNz8SXKtl3G2obUs2WrkD/1vuoq7oNp6XWerKmfJ1+etZtmEPhpTKIUvTNDeaV
	AMTGzkvLJ7hwJO7TgntL1sWipWYlwiP9hlyadUu/aRmwfRjDTvFftV8LmqZMsQD4aP5U6RBQBsJ
	lmfzO4eKc52Nqnvm3Gbywm+76OqMf5cBxptK5
X-Google-Smtp-Source: AGHT+IFtvoH3YizwSlhkDNI5tcSlczqUsWu797EkVVaDmyadcUJXVLVSiXdrpJ78Otx4mC5XsgZLLQ==
X-Received: by 2002:a2e:be9e:0:b0:30b:d156:9e7e with SMTP id 38308e7fff4ca-30c4a748736mr5120451fa.2.1741937520506;
        Fri, 14 Mar 2025 00:32:00 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c2dd6sm4841371fa.78.2025.03.14.00.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 00:31:59 -0700 (PDT)
Message-ID: <bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com>
Date: Fri, 14 Mar 2025 09:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2025 15:19, Andy Shevchenko wrote:
> On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus the driver does not support the BD79124's manual measurement mode
>> but implements the measurements using automatic measurement mode relying
>> on the BD79124's ability of storing latest measurements into register.
>>
>> The driver does also support configuring the threshold events for
>> detecting the out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus the driver masks the received event
>> for a fixed duration (1 second) when an event is handled. This prevents
>> the user-space from choking on the events
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Those pins which don't have corresponding ADC channel node in the
>> device-tree will be controllable as GPO.
> 
> ...
> 
>> +#define BD79124_REG_SYSTEM_STATUS	0x0
> 
> I would expect to see 0x00

ok.

> 
>> +#define BD79124_REG_GEN_CFG		0x01
>> +#define BD79124_REG_OPMODE_CFG		0x04
>> +#define BD79124_REG_PINCFG		0x05
>> +#define BD79124_REG_GPO_VAL		0x0B
>> +#define BD79124_REG_SEQUENCE_CFG	0x10
>> +#define BD79124_REG_MANUAL_CHANNELS	0x11
>> +#define BD79124_REG_AUTO_CHANNELS	0x12
>> +#define BD79124_REG_ALERT_CH_SEL	0x14
>> +#define BD79124_REG_EVENT_FLAG		0x18
>> +#define BD79124_REG_EVENT_FLAG_HI	0x1a
>> +#define BD79124_REG_EVENT_FLAG_LO	0x1c
>> +#define BD79124_REG_HYSTERESIS_CH0	0x20
>> +#define BD79124_REG_EVENTCOUNT_CH0	0x22
>> +#define BD79124_REG_RECENT_CH0_LSB	0xa0
>> +#define BD79124_REG_RECENT_CH7_MSB	0xaf
> 
> ...
> 
> Wouldn't be better...
> 
>> +#define BD79124_MASK_CONV_MODE GENMASK(6, 5)
>> +#define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
>> +#define BD79124_CONV_MODE_MANSEQ 0
>> +#define BD79124_CONV_MODE_AUTO 1
>> +#define BD79124_INTERVAL_750_US 0
> 
> To group masks and values of the same bitfields?
> 
> #define BD79124_MASK_CONV_MODE GENMASK(6, 5)
> #define BD79124_CONV_MODE_MANSEQ 0
> #define BD79124_CONV_MODE_AUTO 1
> #define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
> #define BD79124_INTERVAL_750_US 0

ok.

> 
>> +#define BD79124_MASK_DWC_EN BIT(4)
>> +#define BD79124_MASK_STATS_EN BIT(5)
>> +#define BD79124_MASK_SEQ_START BIT(4)
>> +#define BD79124_MASK_SEQ_MODE GENMASK(1, 0)
>> +#define BD79124_MASK_SEQ_MANUAL 0
>> +#define BD79124_MASK_SEQ_SEQ 1
>> +
>> +#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
>> +#define BD79124_LOW_LIMIT_MIN 0
>> +#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)
> 
> These masks are not named after registers (or I don't see it clearly),

Naming is hard. I usually try to make a balance between:

1) using names which explain the purpose when seen in the code (at call 
site)
2) keeping names short enough
3) following the naming convention in the data sheet
4) maintain relation to the register.

I put most emphasis to the 1, while 2 is important to me as well. 3 is 
_very_ nice to have, but it is often somehow contradicting with 1 and 2. 
4 is IMO just nice to have. The register is usually clearly visible at 
call site, and if someone adds new functionality (or checks the 
correctness of the masks/registers), then 3 is way more important.

I am open to any concrete suggestions though.

> it's
> hard to understand which one relates to which register. Also, why not using
> bitfield.h?

I saw no need for it?

> ...
> 
>> + * These macros return the address of the 1.st reg for the given channel
> 
> first

Huh?

> (and missing period at the end).

Ok.

>> +#define BD79124_GET_HIGH_LIMIT_REG(ch) (BD79124_REG_HYSTERESIS_CH0 + (ch) * 4)
>> +#define BD79124_GET_LOW_LIMIT_REG(ch) (BD79124_REG_EVENTCOUNT_CH0 + (ch) * 4)
>> +#define BD79124_GET_LIMIT_REG(ch, dir) ((dir) == IIO_EV_DIR_RISING ?		\
>> +		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))
>> +#define BD79124_GET_RECENT_RES_REG(ch) (BD79124_REG_RECENT_CH0_LSB + (ch) * 2)
> 
> Don't we want to have something in bitfield.h for arrays in the register, i.e.
> when register(s) is(are) split to 2+ bits per an element in an array of the
> same semantics. Would be nice to eliminate such a boilerplate here and in many
> other drivers.

Not necessarily a bad idea. Still, I am not willing to expand this 
series any more - currently there is 10 patches, 2 of which are directly 
related to the BD79124. I don't want to delay this driver for another 
cycle due to added helpers.

>> +/*
>> + * The hysteresis for a channel is stored in the same register where the
>> + * 4 bits of high limit reside.
>> + */
>> +#define BD79124_GET_HYSTERESIS_REG(ch) BD79124_GET_HIGH_LIMIT_REG(ch)
>> +
>> +#define BD79124_MAX_NUM_CHANNELS 8
>> +
>> +struct bd79124_data {
>> +	s64 timestamp;
>> +	struct regmap *map;
>> +	struct device *dev;
>> +	int vmax;
>> +	/*
>> +	 * Keep measurement status so read_raw() knows if the measurement needs
>> +	 * to be started.
>> +	 */
>> +	int alarm_monitored[BD79124_MAX_NUM_CHANNELS];
>> +	/*
>> +	 * The BD79124 does not allow disabling/enabling limit separately for
>> +	 * one direction only. Hence, we do the disabling by changing the limit
>> +	 * to maximum/minimum measurable value. This means we need to cache
>> +	 * the limit in order to maintain it over the time limit is disabled.
>> +	 */
>> +	u16 alarm_r_limit[BD79124_MAX_NUM_CHANNELS];
>> +	u16 alarm_f_limit[BD79124_MAX_NUM_CHANNELS];
>> +	/* Bitmask of disabled events (for rate limiting) for each channel. */
>> +	int alarm_suppressed[BD79124_MAX_NUM_CHANNELS];
>> +	/*
>> +	 * The BD79124 is configured to run the measurements in the background.
>> +	 * This is done for the event monitoring as well as for the read_raw().
>> +	 * Protect the measurement starting/stopping using a mutex.
>> +	 */
>> +	struct mutex mutex;
>> +	struct delayed_work alm_enable_work;
>> +	struct gpio_chip gc;
>> +	u8 gpio_valid_mask;
>> +};
> 
> ...
> 
>> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
> 
> You should use .set_rv()
> 
> ...
> 
>> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>> +				    unsigned long *bits)
> 
> Ditto, .set_multiple_rv().

As you know, this started at v6.14 cycle which is still ongoing. I don't 
think .set_rv() and .set_multiple_rv() are available?

> 
>> +{
>> +	int ret, val;
> 
> Here and everywhere else, the returned value by regmap is unsigned int.

Ack.

> 
>> +	struct bd79124_data *data = gpiochip_get_data(gc);
>> +
>> +	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
>> +	ret = regmap_read(data->map, BD79124_REG_PINCFG, &val);
>> +	if (ret)
>> +		return;
>> +
>> +	if ((val & *mask) != *mask) {
>> +		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
>> +		/* Do not set value for pins configured as ADC inputs */
>> +		*mask &= val;
>> +	}
>> +
>> +	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
>> +}
> 
> ...
> 
>> +struct bd79124_raw {
>> +	u8 bit0_3; /* Is set in high bits of the byte */
>> +	u8 bit4_11;
>> +};
>> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
> 
> And how this is different from treating it as __le16? Needs a good comment
> about bit layout.

You don't think:
 >> +struct bd79124_raw {
 >> +	u8 bit0_3; /* Is set in high bits of the byte */
 >> +	u8 bit4_11;
 >> +};
suffices? It's hard for me to think how to explain bit layout more 
explicitly.

This was discussed during the RFC review. I explained the rationale why 
I rather represent this as two 8 bit variables than le16 with 
(mysterious to me) shift. As a result, Jonathan told me he's not feeling 
(too) strong about this (but also warned we may see follow-up patches 
converting this to le and shift - which, by the way, is harder for me to 
understand).

> 
> ...
> 
>> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
>> +				    unsigned int val)
>> +{
>> +	struct bd79124_raw raw;
>> +	int ret, tmp;
> 
>> +	raw.bit4_11 = (u8)(val >> 4);
>> +	raw.bit0_3 = (u8)(val << 4);
> 
> Why casting?

To make it clear storing unsigned int to u8 is considered to be Ok. I 
can drop it though if you feel strong about it.

> 
> Make sense to have a symmetrical macro instead of hiding it in the code.

Ok.

>> +	ret = regmap_read(data->map, reg, &tmp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	raw.bit0_3 |= (0xf & tmp);
> 
> GENMASK() ?

For me 0xf is both shorter and clearer. (For me 0xf - or, 0x0f if you 
like, 0xf0 and 0xff are clear by a glance).

I can go for GENMASK() if it is absolutely required, but for me it is in 
this case just making this harder to read. I like GENMASK() for 
something like 0xe or 0x60 though.

>> +	return regmap_bulk_write(data->map, reg, &raw, sizeof(raw));
>> +}
> 
> ...
> 
>> +	return (data->alarm_monitored[chan->channel] & BIT(dir));
> 
> Unneeded parentheses.

ok

> ...
> 
>> +	case IIO_EV_INFO_HYSTERESIS:
>> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
>> +		val >>= 3;
> 
> Second time I see this. Perhaps you need a macro to explain this right shift?

Not really sure about this. I think it's kind of obvious why this is 
shifted - and in case it's not, there is a comment explaining it.

I could have a macro like REGVAL2HYSTERESIS() - but I don't think it is 
a great idea, because then anyone interested in understanding the value 
read from register would need to dig out the macro to find how value 
needs to be converted. Doing the shift here shows the register format to 
a reader right away - and honestly, it should be pretty obvious to the 
reader that this shift converts register value to proper format.

> 
>> +		return regmap_update_bits(data->map, reg, BD79124_MASK_HYSTERESIS,
>> +					  val);
> 
> Can be one line.

I still prefer to have lines < 80 to make them fit my terminal.
I think we have discussed this before. I don't think we will agree on 
this as I have a very real reason for short lines. It does directly 
impact on my daily work. I don't think you're going to like it no matter 
how I explain this.

> ...
> 
>> +static irqreturn_t bd79124_event_handler(int irq, void *priv)
>> +{
>> +	int ret, i_hi, i_lo, i;
>> +	struct iio_dev *iio_dev = priv;
>> +	struct bd79124_data *data = iio_priv(iio_dev);
>> +
>> +	/*
>> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
>> +	 * subsystem to disable the offending IRQ line if we get a hardware
>> +	 * problem. This behaviour has saved my poor bottom a few times in the
>> +	 * past as, instead of getting unusably unresponsive, the system has
>> +	 * spilled out the magic words "...nobody cared".
>> +	 */
>> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
>> +	if (ret)
>> +		return IRQ_NONE;
> 
> Only I don't get why you can't use bulk read here.
> The registers seem to be sequential.

I think using bulk_read is a good idea. Thanks.

> 
>> +	if (!i_lo && !i_hi)
>> +		return IRQ_NONE;
>> +
>> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
>> +		u64 ecode;
>> +
>> +		if (BIT(i) & i_hi) {
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +						     IIO_EV_TYPE_THRESH,
>> +						     IIO_EV_DIR_RISING);
>> +
>> +			iio_push_event(iio_dev, ecode, data->timestamp);
>> +			/*
>> +			 * The BD79124 keeps the IRQ asserted for as long as
>> +			 * the voltage exceeds the threshold. It causes the IRQ
>> +			 * to keep firing.
>> +			 *
>> +			 * Disable the event for the channel and schedule the
>> +			 * re-enabling the event later to prevent storm of
>> +			 * events.
>> +			 */
>> +			ret = bd79124_event_ratelimit_hi(data, i);
>> +			if (ret)
>> +				return IRQ_NONE;
>> +		}
>> +		if (BIT(i) & i_lo) {
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +						     IIO_EV_TYPE_THRESH,
>> +						     IIO_EV_DIR_FALLING);
>> +
>> +			iio_push_event(iio_dev, ecode, data->timestamp);
>> +			ret = bd79124_event_ratelimit_lo(data, i);
>> +			if (ret)
>> +				return IRQ_NONE;
>> +		}
>> +	}
>> +
>> +	ret = regmap_write(data->map, BD79124_REG_EVENT_FLAG_HI, i_hi);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	ret = regmap_write(data->map, BD79124_REG_EVENT_FLAG_LO, i_lo);
>> +	if (ret)
>> +		return IRQ_NONE;
> 
> In the similar way bulk write.

agree.

> 
>> +	return IRQ_HANDLED;
>> +}
> 
> ...
> 
>> +static int bd79124_chan_init(struct bd79124_data *data, int channel)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel), 4095);
> 
> BD79124_HIGH_LIMIT_MAX ?
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel), 0);
> 
> BD79124_HIGH_LIMIT_MIN ?

I think I originally had these defines but I was probably asked to drop 
the defines and use raw values instead.

>> +}
> ...
> 
>> +static const struct i2c_device_id bd79124_id[] = {
>> +	{ "bd79124", },
> 
> Redundant inner comma.

ok.

