Return-Path: <linux-iio+bounces-17009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10BA66BEF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC38017E4D2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4D1EF378;
	Tue, 18 Mar 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5nMP8H1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FE1DE3A5;
	Tue, 18 Mar 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283317; cv=none; b=lK6iHMQT3uxrkfq5QCqRc5L3rzJc8YAgnQgBA24s6V99bMU77guwbXj10lE098rZwpmpPgXt+/HDjHkZzF9/B7iRa9QgXVWqAQvX6nHrKsyFGRzbfTlFgdUlg+Dl/PXvPqABS7evER3U5QakDNx0QSvTCP12bsHwEe2/Eb3BKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283317; c=relaxed/simple;
	bh=CdrnbCbpERxds1M40v8LPQpCyzWJmtgtsiHTLRMk2oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AF5DSeu8OxFCzKidB9DEdqMfVYf8s5mr+8cdEOJtTNkedwuLPkyxnYv8haBDPpn5nf1dNeeNImKIf2woofHXn8csLqo4UprvQcF1OZj6S3OwjaQDTBoOoZeyKO+ZaR7k6xmj11SswoMhrlwp8SJHdhfoQZiVcwzaXXcZ61zdR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5nMP8H1; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307bc125e2eso59485961fa.3;
        Tue, 18 Mar 2025 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742283312; x=1742888112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3+pPJcTPMx2maNnNdw4UmJM5I2Qnzl3F0S274dS2No=;
        b=M5nMP8H1Ifa5vb00mj6q002ZRate3LHs3Wu6dQjFHmgPs+aiUExX29PSG4Xa8gT6X2
         VuUrvyQUW7roD7/oa0ykjV+d3X9l/ufwcGWnWXLRDb02u4ROz9eWJCEpifrIJjOAUmqq
         hO6IcRHgwjp+rSFc2Pm9piLseogM7clfOx5mlZ14Hdgggp6eowgLVFf0m8e07EO6mBwU
         wV/OSDK/KR3TtP28QH7qrXMGb0QWMtiB0ucGzlZbkLTktDsZKDLiOxOS3ht+zcfdjb3s
         SfIHOKg86bp08h0kWzR8s/rClXAwRn81yHgEnOg5V1Ou0D6K/kE5tKKwnLH5Jsd1Ayuh
         eRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283312; x=1742888112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3+pPJcTPMx2maNnNdw4UmJM5I2Qnzl3F0S274dS2No=;
        b=XrSc9YnPhzMP7C1o/5I0ARmfrH476MRfryU5FylKtZmtGugNFCt4zL3jmO/WYTEI6Q
         7RALN0kX2LP83vKwRcuvmwamR77Bz02behqnt9NU8vpIdgbRFl8JRBzHuy6f4TVZGo4Z
         xM++A/mFuS+z8o5SQL2A8eZah/+2bs1FLszGzOxoU2/oiBg74ZJ2YfP1Fvci1xiI18oM
         Upmw0eC+hquTntaMjVb1DVFLjlbY3Cju07k9gjKSGoAN320rQ1rDYhjUzAE3o7ZxJrmb
         iedtDq7RD0CooJyC9Rf4RrbP8f4rK+GKHJg59QfYUgdnDMXsRKnExc7+TDN8UB2ivnKX
         rnjA==
X-Forwarded-Encrypted: i=1; AJvYcCU48kPNTySOOP5V0+IykGYITIwJLTqcjfFAv+Ua1FpRpUcmXOPldvGxB5S2D5k0MGmNmtLETeL8aY1RcJQf@vger.kernel.org, AJvYcCXqkYG+igW/mYcqTrFFu9oTUX5TkMdzrk7IFhWcsP9HgzrOiRXCCMnmIebYf1DgqEqeOtTfnRaQ8Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUekIaP4XQGsUs4E5+XH7mGtdxMI8FfkMjASRA+a5aXQCzmLO
	+Bca220ERPIxrAGFkp5tAe/AFC3DrNWMOsParbW/9hDoFJHYTz8/+tqa+A==
X-Gm-Gg: ASbGncvH+7VhU88TB7xwWgP1vHDgul3U08BN6zl9+x0efoK+TjLCE8cThGY3TTz6clS
	+4DbjS25l4cDZOzAl+1HIPKRRkEfhUtlJaxPM6MdazhlxgDjBzzmZxws3cZvqjDg/649Z6fsYDh
	fkBz3EhORvYkLJzlpORzllFsgLLqVFAfneyqprlbcR1aI8x0+FlOJCBPQVcN6vMkoYwfDkNS1V/
	Qfh/lH8Gp8zoBJzk7UbVQPHlhzBROlB/qZHng+TabmvELkziW/PlKSf3WE8nr7WaiLiDBl6Sesz
	bEWrTjU3C/oTi1oxGCSAq7kYu9bfkOn7tHME8z+FxUtIdjgVySkgv4tyFVywF/DHeZ2gX+wztRf
	igqjOtEOg/IxGqa3oNmTwxBnETg==
X-Google-Smtp-Source: AGHT+IFalA5I/nuNYKe3ZRIDHqh94uhpvFy7N5wvzLKmYLMEL0j/S2iatAaykRJC5Cau9S1DcI8rSQ==
X-Received: by 2002:a05:6512:3082:b0:545:4cb:b25d with SMTP id 2adb3069b0e04-549c38e5550mr9211833e87.13.1742283312127;
        Tue, 18 Mar 2025 00:35:12 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a6cc1sm1551353e87.211.2025.03.18.00.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 00:35:10 -0700 (PDT)
Message-ID: <dc241efd-fcb1-4d2d-9009-b5e4d9fc9b68@gmail.com>
Date: Tue, 18 Mar 2025 09:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] iio: adc: Support ROHM BD79124 ADC
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
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <2b7ebdbeaa163e320b4071c040ee8e24241d693d.1742225817.git.mazziesaccount@gmail.com>
 <Z9hRSLXCihCGwcT3@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9hRSLXCihCGwcT3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 18:43, Andy Shevchenko wrote:
> On Mon, Mar 17, 2025 at 05:51:25PM +0200, Matti Vaittinen wrote:
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus do not support the BD79124's manual measurement mode but implement
>> the measurements using automatic measurement mode, relying on the
>> BD79124's ability of storing latest measurements into register.
>>
>> Support also configuring the threshold events for detecting the
>> out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus, prevent the user-space from choking
>> on the events and mask the received event for a fixed duration (1 second)
>> when an event is handled.
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Make those pins which don't have corresponding ADC channel node in the
>> device-tree controllable as GPO.
> 
> ...
> 
>> +#include <linux/bitfield.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/bits.h>
> 
> bits.h is guaranteed by bitmap.h, but it's up to you to leave
> or remove this line.
> 
>> +#include <linux/byteorder/generic.h>
> 
> This is incorrect. In some cases it even may produce build failures.
> Should be asm/byteorder.h...

I had no idea. Thanks.

>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +#include <linux/devm-helpers.h>
>> +#include <linux/err.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/regmap.h>
>> +#include <linux/types.h>
> 
> ...somewhere here.

What is the rationale having the "asm/byteorder.h" located down here?

> 
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/adc-helpers.h>
> 
> ...
> 
>> +#define BD79124_GET_LIMIT_REG(ch, dir) ((dir) == IIO_EV_DIR_RISING ?		\
>> +		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))
> 
> It's hard to read, better to split over few lines:
> 
> #define BD79124_GET_LIMIT_REG(ch, dir)						\
> 	((dir) == IIO_EV_DIR_RISING ?						\
> 		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))
> 
> or alike.
> 
> ...
> 
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
> 
>> +	struct gpio_chip gc;
> 
> Hmm... Have you tried to shuffle fields to see if you gain a better code
> generation.

No, I haven't. Effects of such suffling would in any case depend on the 
architecture. Furthermore, it is not expected there will be really many 
instances of this structure so potential savings would be negligible.

> Also I don't remember if I asked about struct device *dev to be
> the same as in regmap and would it be worse code without it?

Not sure I understood your comment. Are you suggesting I would extract 
the device pointer from the regmap in every function where it is needed, 
instead of storing it here?

If so, I prefer storing the pointer in probe and have it directly usable 
where prints are wanted/needed. Results cleaner looking code with the 
cost of one pointer. And again, it is not expected to see this struct 
instantiated a lot. If this happens we can go optimizing, but until that 
I prefer cleaner code.

>> +	u8 gpio_valid_mask;
> 
> ...
> 
>> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
>> +{
>> +	struct bd79124_data *data = gpiochip_get_data(gc);
>> +
>> +	if (value)
>> +		regmap_set_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
>> +	else
>> +		regmap_clear_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
> 
> regmap_assign_bits()

Thanks. I think I've missed introduction of this function :)

> 
>> +}
> 
> ...
> 
>> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>> +				    unsigned long *bits)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +	struct bd79124_data *data = gpiochip_get_data(gc);
> 
>> +	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
> 
> This sounds like it can utilise valid_mask, but it seems you already have it.

Yes.

> So the question is what is the practical issue here? I believe the condition
> below will never be the case.

It can until this gets merged:
https://lore.kernel.org/all/cd5e067b80e1bb590027bc3bfa817e7f794f21c3.1741180097.git.mazziesaccount@gmail.com/

Furthermore, the cost of the check is fairly low. Knowing that the 
drivers tend to get backported (because very few if any device makers 
use latest kernels) I will keep it here for couple of cycles.

>> +	ret = regmap_read(data->map, BD79124_REG_PINCFG, &val);
>> +	if (ret)
>> +		return;
> 
>> +	if ((val & *mask) != *mask) {
>> +		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
>> +		/* Do not set value for pins configured as ADC inputs */
>> +		*mask &= val;
>> +	}
>> +
>> +	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
> 
> Can you rather utilise the respective bitmap APIs?

Please elaborate. Which APIs and what's the added benefit? It's not easy 
for me to see how this could get much simpler.

> 
>> +}
> 
> ...
> 
>> +struct bd79124_raw {
>> +	u8 bit0_3; /* Is set in high bits of the byte */
>> +	u8 bit4_11;
>> +};
>> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
>> +#define BD79124_INT_TO_RAW(val) {					\
>> +	.bit4_11 = (val) >> 4,						\
>> +	.bit0_3 = (val) << 4,						\
>> +}
>> +
>> +/*
>> + * The high and low limits as well as the recent result values are stored in
>> + * the same way in 2 consequent registers. The first register contains 4 bits
>> + * of the value. These bits are stored in the high bits [7:4] of register, but
>> + * they represent the low bits [3:0] of the value.
> 
> I believe this comment should go on top of the data structure.

Not sure. I think having this comment preceding the functions which are 
actually used to read/write the register makes sense. The structs / 
macros are only used from this function. Anyone who needs to be reading 
this code _after_ the review stage, is likely to trace the execution of 
the functions (and see the structure definitions only when they're used 
from a function) and not go jumping through the structures alone. Hence, 
having the explanation of a register layout on top of a function which 
reads / writes the register.

> Also this is
> still confusing as variable name above suggests one bit mapping, while text
> here is referencing to another. Can you elaborate this more, please?

Huh? Sorry, but I think the text and variable names match.

Variable names in:
struct bd79124_raw {
	u8 bit0_3; /* Is set in high bits of the byte */
	u8 bit4_11;
};

represent the value. Eg, first byte contains the bits [3:0] of the 12bit 
value. Comment tells that these bits are stored to the high bits of the 
register.
Similarly the "bit4_11" represents the bits of the value. I am fairly 
sure you didn't think the "bit4_11" was referring to bits of a 8-bit 
register...

> 
> Like
> 
> 	u8 foo_1; // represents bits 3 2 1 0 x x x x
> 	// ? or represents bits 0 1 2 3 x x x x

Now, I don't understand what you're saying here. I've a feeling that 
type of comment would just make it more confusing - at least for me.

I suppose I could do:
  struct bd79124_raw {
-       u8 bit0_3; /* Is set in high bits of the byte */
-       u8 bit4_11;
+       u8 val_bit0_3; /* Is set in high bits of the byte */
+       u8 val_bit4_11;
  };

but I am not at all sure this would help?

>> + * The value bits [11:4] are stored in the next register.
>> + *
>> + * Read data from register and convert to integer.
>> + */
> 
> ...
> 
>> +static int bd79124_read_reg_to_int(struct bd79124_data *data, int reg,
>> +				   unsigned int *val)
>> +{
>> +	int ret;
>> +	struct bd79124_raw raw;
>> +
>> +	ret = regmap_bulk_read(data->map, reg, &raw, sizeof(raw));
>> +	if (ret) {
> 
>> +		dev_dbg(data->dev, "bulk_read failed %d\n", ret);
> 
> Do we need this (and alike)? It can be achieved via regmap tracepoints.

I can't speak on anyone else's behalf, but when things fail I am still 
looking at the prints as a first step. This includes enabling the debugs 
too. Something like regmap tracepoints would come to play only if I 
can't find anything using the prints - although, I am not sure I 
wouldn't try _adding_ prints prior using tracepoints.

This is especially true in use-case like this one. This is a path which 
handles the user's data-reading. Imagine you're reading ADC data:

cat /sys/bus/iio/.../..._raw

and get an error. I (and I believe many others) would say "dmesg" (or 
equivalent) as next step. If nothing is visible, changing log level and 
retrying would be my next step.

regmap tracepoints? Maybe after seeing the "bulk_read failed" - but not 
as a first thing to try. And, it's not like the driver has polluted each 
regmap call-site with prints, so cost is again negligible.

>> +		return ret;
>> +	}
>> +
>> +	*val = BD79124_RAW_TO_INT(raw);
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +/*
>> + * The high and low limits as well as the recent result values are stored in
>> + * the same way in 2 consequent registers. The first register contains 4 bits
>> + * of the value. These bits are stored in the high bits [7:4] of register, but
>> + * they represent the low bits [3:0] of the value.
>> + * The value bits [11:4] are stored in the next register.
> 
> Same as above, rather comment once at data type.

I think this comment is tightly related to the purpose of this function.
> 
>> + * Convert the integer to register format and write it using rmw cycle.
>> + */
> 
> ...
> 
>> +	raw.bit0_3 |= (0xf & tmp);
> 
> Btw, why Yoda style?

I had to google the Yoda style. So, I assume you mean why:

0xf & tmp
and not
tmp & 0xf.

Absolutely for no reason. I suppose it has just been flowing out of my 
fingers that way :) It can be flipped if it bothers.

>> +static int bd79124_stop_measurement(struct bd79124_data *data, int chan)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	/* See if already stopped */
>> +	ret = regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
>> +	if (!(val & BIT(chan)))
>> +		return 0;
>> +
>> +	ret = regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
>> +				BD79124_MSK_SEQ_START);
>> +
>> +	/* Clear the channel from the measured channels */
>> +	ret = regmap_write(data->map, BD79124_REG_AUTO_CHANNELS,
>> +			   ~BIT(chan) & val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Stop background conversion for power saving if it was the last
>> +	 * channel
>> +	 */
>> +	if (!(~BIT(chan) & val)) {
> 
> Seems to me as you have the same above, perhaps just update the val?

Good catch. This gets much more readable if the 'val' is renamed as 
'enabled_chans' and updated in place. Thanks!

>> +		int regval = FIELD_PREP(BD79124_MSK_CONV_MODE,
>> +					BD79124_CONV_MODE_MANSEQ);
>> +
>> +		ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
>> +					 BD79124_MSK_CONV_MODE, regval);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
>> +			       BD79124_MSK_SEQ_START);
>> +}

...

> Can be done here, as it's only 83 characters.

The 80 char lines is something we already discussed several times. Won't 
reply on other places.

> ...
> 
>> +{
>> +	struct bd79124_data *data = iio_priv(iio_dev);
>> +	int reg;
>> +
>> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
>> +		return -EINVAL;
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		if (dir == IIO_EV_DIR_RISING) {
>> +			guard(mutex)(&data->mutex);
> 
> What does this mutex protect? chan->channel access? I don't think so, then it
> can be scoped_guard().

I am not sure I understand what you are after here. I'd be grateful if 
you explained.

In any case, after taking another look at this, I think the check for 
suppressed/monitored alarms below is racy. It looks like the mutex 
should be held for the duration of the whole "case IIO_EV_INFO_VALUE" 
here. So, thanks.

> 
>> +			data->alarm_r_limit[chan->channel] = val;
>> +			reg = BD79124_GET_HIGH_LIMIT_REG(chan->channel);
>> +		} else if (dir == IIO_EV_DIR_FALLING) {
>> +			guard(mutex)(&data->mutex);
> 
> Ditto.
> 
>> +			data->alarm_f_limit[chan->channel] = val;
>> +			reg = BD79124_GET_LOW_LIMIT_REG(chan->channel);
>> +		} else {
>> +			return -EINVAL;
>> +		}
>> +		/*
>> +		 * We don't want to enable the alarm if it is not enabled or
>> +		 * if it is suppressed. In that case skip writing to the
>> +		 * register.
>> +		 */
>> +		if (!(data->alarm_monitored[chan->channel] & BIT(dir)) ||
>> +		    data->alarm_suppressed[chan->channel] & BIT(dir))
>> +			return 0;
>> +
>> +		return bd79124_write_int_to_reg(data, reg, val);
>> +
>> +	case IIO_EV_INFO_HYSTERESIS:
>> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
>> +		val >>= 3;
>> +
>> +		return regmap_update_bits(data->map, reg, BD79124_MSK_HYSTERESIS,
>> +					  val);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> ...
 >
>> +static int __bd79124_event_ratelimit(struct bd79124_data *data, int reg,
>> +				     unsigned int limit)
>> +{
>> +	int ret;
>> +
>> +	if (limit > BD79124_HIGH_LIMIT_MAX)
>> +		return -EINVAL;
>> +
>> +	ret = bd79124_write_int_to_reg(data, reg, limit);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * We use 1 sec 'grace period'. At the moment I see no reason to make
>> +	 * this user configurable. We need an ABI for this if configuration is
>> +	 * needed.
>> +	 */
>> +	schedule_delayed_work(&data->alm_enable_work,
>> +			      msecs_to_jiffies(1000));
> 
> Perfectly one line even for the 80 character limit fanatics :-)

Thanks!

> 
>> +	return 0;
>> +}
> 
>> +static int bd79124_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
>> +{
>> +	int i, gpio_channels;
>> +
>> +	/*
>> +	 * Let's initialize the mux config to say that all 8 channels are
>> +	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
>> +	 * bits for found ADC channels.
>> +	 */
>> +	gpio_channels = GENMASK(7, 0);
>> +	for (i = 0; i < num_channels; i++)
>> +		gpio_channels &= ~BIT(cs[i].channel);
>> +
>> +	return gpio_channels;
>> +}
> 
> ...
> 
>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, template,
>> +		BD79124_MAX_NUM_CHANNELS - 1, &cs);
>> +	if (ret < 0) {
>> +		if (ret == -ENOENT)
>> +			goto register_gpios;
>> +		return ret;
>> +	}
> 
> Also can be written as
> 
> 	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, template,
> 		BD79124_MAX_NUM_CHANNELS - 1, &cs);
> 	/* Register all channels as GPIOs in case no ADC functionality required */

I like the comment you added.

> 	if (ret == -ENOENT)
> 		goto register_gpios;
> 	if (ret < 0)
> 		return ret;

We don't need the other check when return value is > 0. This should be 
the majority of cases. The no ADC channels case is very unlikely because 
this IC is meant to be an ADC. Original code reflects that better.

Thanks for the review.

Yours,
	-- Matti

