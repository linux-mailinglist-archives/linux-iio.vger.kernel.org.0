Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974EC79824E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Sep 2023 08:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbjIHGYg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Sep 2023 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjIHGYf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Sep 2023 02:24:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804B19A6;
        Thu,  7 Sep 2023 23:24:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so28718221fa.0;
        Thu, 07 Sep 2023 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694154269; x=1694759069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poqBFblIGkZYzM95ib/AwQKqF/vFUuMutfef2/uB2EU=;
        b=N3tTQ7XF+FP3pj/k3T5B5AqO6VTOzi182r34DgWTm7EnMAr3af6g6NnG3hwmY3Ie6o
         F7gRs5ftwYX9LjELY++gxpNUy7EM3fvmCLGmOxOgUelbR3nwIr1ewjhpzExCoAXIOUdI
         CnbwesfLef3vBoeLtpbQGq5aFvC0AWH+sGXoCKeYibLHWo8O4YRO2heHCQEz2t0Nhk3h
         BdlERc5rDZj2hUPtABBLEtlEhGHQw1TWjaiikR5G14xV4BM+8KoRkayFz3LUJhT/MfoQ
         YMhe6Hn+bfWS/q6Wlz3pJ4MVz730E6iK4dd5GLgWskALmTtAS/zKCmbHLQBIG68BE7h/
         cyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154269; x=1694759069;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poqBFblIGkZYzM95ib/AwQKqF/vFUuMutfef2/uB2EU=;
        b=HF8LSj0FZ4I0eNQ6dddD+bF30citapfK5fskbcwVx8/1kiY370Um6/vDQOG23Hg6kF
         VbUhb30HnGGYnZdDt72ucACfLSpwpQPeWwIul3M8mgKEMvxrOGlSOtaes8xP5fyc5N0M
         MhNqA8GZJWaS7PRav6wp6981p+I7x9hPKu8cRkDGzaC7PLFi50s0yDD8LVHqXYIm/4Dh
         E4s8SPCgOBhLK0eJ6D2W6JNVgGNWgGQ03Wvl6Q185X4QDG45NOOKqTOcSnfviuphE3UL
         jZLRiNSdD0IKfPDoqGse5tzld/+VJ6XRx800n5GuqM9rkdEAxPPfEM5G+TxZiZslqweP
         0dNg==
X-Gm-Message-State: AOJu0YwlGYQ7p911kH0qbG/e3w5qcZkMqvGR0HcfKeYvVMh3o1XN80Dd
        zgwqRimnvCGDSydZaC9Yt7Q=
X-Google-Smtp-Source: AGHT+IGATGlK1TdeR750Ftd5ipdwsL6GfW9TwVuipKbbBDeBAb+eAzwbBDPSTwo0Ffh29N67kaBcFA==
X-Received: by 2002:a2e:b60a:0:b0:2b7:11f8:27d with SMTP id r10-20020a2eb60a000000b002b711f8027dmr1067893ljn.7.1694154268606;
        Thu, 07 Sep 2023 23:24:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e2c0a000000b002b836d8c839sm185078ljs.40.2023.09.07.23.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 23:24:27 -0700 (PDT)
Message-ID: <e5cdcce2-98b6-ac4e-7e21-0bd73c7e9dfe@gmail.com>
Date:   Fri, 8 Sep 2023 09:24:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
 <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
 <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
 <ZPnW38eO6by1NjIr@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <ZPnW38eO6by1NjIr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/7/23 16:57, Andy Shevchenko wrote:
> On Thu, Sep 07, 2023 at 08:57:17AM +0300, Matti Vaittinen wrote:
>> On 9/6/23 18:48, Andy Shevchenko wrote:
>>> On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +struct bm1390_data {
>>>> +	int64_t timestamp, old_timestamp;
>>>
>>> Out of a sudden int64_t instead of u64?
>>
>> Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), IIO
>> operates with signed timestamps. One being s64, the other int64_t.
>>
>>>> +	struct iio_trigger *trig;
>>>> +	struct regmap *regmap;
>>>> +	struct device *dev;
>>>> +	struct bm1390_data_buf buf;
>>>> +	int irq;
>>>> +	unsigned int state;
>>>> +	bool trigger_enabled;
>>>
>>>> +	u8 watermark;
>>>
>>> Or u8 instead of uint8_t?
>>
>> So, uint8_t is preferred? I don't really care all that much which of these
>> to use - which may even show up as a lack of consistency... I think I did
>> use uint8_t when I learned about it - but at some point someone somewhere
>> asked me to use u8 instead.. This somewhere might have been u-boot though...
>>
>> So, are you Suggesting I should replace u8 with uint8_t? Can do if it
>> matters.
> 
> Consistency matters, since I do not know the intention behind, I suggest use
> either, but be consistent in the entire code. However, uXX are specific Linux
> kernel internal types and some maintainers prefer them. Also you may grep for
> the frequency of intXX_t vs. sXX or their unsigned counterparts.
> 
>>>> +	/* Prevent accessing sensor during FIFO read sequence */
>>>> +	struct mutex mutex;
>>>> +};
> 
> ...
> 
>>>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>>>> +{
>>>> +	u8 temp_reg[2] __aligned(2);
>>>
>>> Why?! Just use proper bitwise type.
>>
>> What is the proper bitwise type in this case?
>>
>> I'll explain my reasoning:
>> What we really have in hardware (BM1390) and read from it is 8bit registers.
>> This is u8 to me. And as we read two consecutive registers, we use u8
>> arr[2]. In my eyes it describes the data perfectly well, right?
> 
> Two different registers?! Why bulk is used in that case?
> To me looks like you are reading 16-bit (or one that fits in 16-bit) register
> in BE notation.

As I wrote, it is two 8 bit registers at consecutive addresses. And this 
is what u8 arr[2]; also says.

Bulk read is mandatory as HW has a special feature of preventing the 
update of these registers when a read is ongoing. If we do two reads we 
risk of getting one of the registers updated between the accesses - 
resulting incorrect value.

> 
>>>> +	__be16 *temp_raw;
>>>> +	int ret;
>>>> +	s16 val;
>>>> +	bool negative;
>>>> +
>>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
>>>> +			       sizeof(temp_reg));
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (temp_reg[0] & 0x80)
>>>> +		negative = true;
>>>> +	else
>>>> +		negative = false;
>>>
>>>> +	temp_raw = (__be16 *)&temp_reg[0];
>>>
>>> Heck no. Make temp_reg be properly typed.
>>
>> As I explained above, to me it seems ur arr[2} is _the_ proper type to
>> represent data we read from the device.
>>
>> What we need to do is to convert the 16bits of data to an integer we can
>> give to the rest of the system. And, we happen to know how to 'manipulate'
>> the data to get it in format of understandable integer. As we have these 16
>> bits in memory, aligned to 2 byte boundary - why shouldn't we just
>> 'manipulate' the data and say - here we have your integer, please be my
>> guest and use it?
> 
> Because it smell like a hack and is a hack here.
> Either it's a single BE16 register, or it's two different registers that by
> very unknown reason you are reading in a bulk.

It is two registers. The bulk read might warrant a comment - although I 
believe this is nothing unusual. If it is a hack or not is an opinion. 
To me it looks like a code that explicitly shows what data is and how it 
is being handled. It does what it is supposed to do and shows it in all 
dirty details.

Still, I am open to suggestions but I'd prefer seeing a real improvement 
instead of claiming that the hardware is something it is not (eg, having 
16bit registers or should be read by individual accesses).

The code in this form is no
> go.
> 
>> Well, I am keen to learn the 'correct bitwise type' you talk about - can you
>> please explain me what this correct type for two 8bit integers is? Maybe I
>> can improve.
> 
> If the registers are not of the same nature the bulk access is wrong.
> Use one by one reads.

Of same nature? As I said, there is 2 8bit registers at consecutive 
addresses. They have no other 'nature' as far as I can tell.

Data in these registers in not in standard format - it needs to be 
manipulated to make it an ordinary integer. The code shows this very 
clearly by not reading it in any standard integer.

> ...
> 
>>>> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
>>>> +{
>>>> +	int ret;
>>>> +	u8 raw[3];
>>>> +
>>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
>>>> +			       &raw[0], sizeof(raw));
> 
> &raw[0] --> raw
> 
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
> 
> This, btw, looks like le24, but I'm puzzled with right shift.
> I need to read datasheet carefully to understand this.

It's not just le24. We, again, have data placed in registers so that it 
needs some suffling. The data-sheet does decent job explaining it 
though. AFAIR, there was a 'gap' in bits so it needed some more suffling 
to sift the bits so that they're consecutive. I think this indeed is 
something that needs to be looked up from data-sheet to understand why 
this play with bits is done.

> ...
> 
>>>> +	mutex_lock(&data->mutex);
>>>
>>> Wouldn't you like to start using cleanup.h?
>>
>> The new macro "thingee" for C++ destructor like constructs?
> 
> I was talking about these: guard() / scoped_guard().

Right, this was a bit more precise than "The new macro thingee", thanks 
:) This, however is what I was referring to so what I wrote below still 
applies :)

> 
>> TBH, I am not really in a rush with it for two reasons.
>> 1) The syntax looks very alien to me. I would like to get some time to get
>> used to it before voluntarily ending up maintaining a code using it. (I
>> don't like practicing things upstream as practicing tends to include making
>> more errors).
>>
>> 2. Related to 1). I am not (yet) convinced incorporating changes in stuff
>> using these cleanups is easy. I'm a bit reserved and would like to see how
>> things play out.
>>
>> 3. I expect I will get a few requests to backport the code to some older
>> kernels used by some big customers. (I've been doing plenty of extra work
>> when backporting my kernel improvements like regmap_irq stuff, linear
>> ranges, regulator pickable ranges, gts-helpers to customer kernels to get my
>> drivers working - or working around the lack of thiose features. I have been
>> willing to pay this prize to get those helpers upstream for everyone to use.
>> The cleanup.h however is there so it does not _need_ new users. I don't
>> think _all_ existing drivers will be converted to use it so one more should
>> probably not hurt. I think that in a year at least some customers will be
>> using kernel containing the cleanup.h - so by latest then it is time for me
>> to jump on that train. I hope I am used to reading those macros by then).
> 
> OK.
> 
> ...
> 
>>>> +	case IIO_CHAN_INFO_SCALE:
>>>> +		if (chan->type == IIO_TEMP) {
>>>> +			*val = 31;
>>>> +			*val2 = 250000;
>>>> +
>>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>>> +		} else if (chan->type == IIO_PRESSURE) {
>>>> +			*val = 0;
>>>> +			/*
>>>> +			 * pressure in hPa is register value divided by 2048.
>>>> +			 * This means kPa is 1/20480 times the register value,
>>>> +			 * which equals to 48828.125 * 10 ^ -9
>>>> +			 * This is 48828.125 nano kPa.
>>>> +			 *
>>>> +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
>>>> +			 * get 48828 - which means we lose some accuracy. Well,
>>>> +			 * let's try to live with that.
>>>> +			 */
>>>> +			*val2 = 48828;
>>>> +
>>>> +			return IIO_VAL_INT_PLUS_NANO;
>>>> +		}
>>>> +
>>>> +		return -EINVAL;
>>>
>>> Why not switch-case like other drivers do?
>>
>> In my eyes avoiding the very simple if - else if does not warrant nested
>> switches which look ugly to me.
> 
> Okay, yet another disagreement.
> 

Yes, we have a few :) Luckily most are more on a styling side of things. 
I do still appreciate you reviewing the patches as I think I do agree 
with most of your suggestions - and having an extra pair of eyes looking 
at the code never hurts :)

> ...
> 
>>>> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
>>>
>>>> +
>>>
>>> Unneeded blank line.
>>>
>>>> +	if (smp_lvl > 4) {
>>>> +		/*
>>>> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
>>>> +		 * bit errors in I2C line. Don't overflow if this happens.
>>>> +		 */
>>>> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>>>> +		smp_lvl = 4;
>>>> +	}
>>>
>>>> +	if (!smp_lvl)
>>>> +		return ret;
>>>
>>> This can be checked first as it's and error condition
>>
>> I wouldn't say it is an error condition.
> 
> Returning ret suggests otherwise.

Yes. I agree.

> 
>> It just means there was no samples
>> collected in buffer.
> 
> But as you explained below, the code is actually 0 there.
> In any case bailing out conditionals are better to be first.

Kind of agree. Or by very least it should be else if. But as you said, 
early return is probably better here, thanks.

> 
>>   and previous branch has
>>> no side effects on this. Also, wouldn't be better to use error code explicitly?
>>
>> Yes. For the clarity we definitely should explicitly do "return 0" here.
>> Thanks.
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

