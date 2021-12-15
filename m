Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3148F475C79
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbhLOP61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:58:27 -0500
Received: from www381.your-server.de ([78.46.137.84]:35008 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhLOP61 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=cZWRdJxrfYuBDkjFQ06ZtWygZVQNYRIu8tcXd8sLwQg=; b=EeU8BpCI5fdtXLOl1whnT5vqcE
        AnYgH6/Crj6QyafrMsIcOnKiKjjDznDFTA1G83QoRpdoareST1rHY6oapEA3/NO+wimX6O0X/5kDW
        7JxcTvnBwkHNtpecLFseF3069ijXc1AOsfDYSNNvFcWM9XoOh1PB51Acmfw4ZdNb9NvqziGOJjwau
        G/8y2u371HzxmZGOHlcnENuA1kk9iHWXNgPf0WNxfDpeQfcttxqVKHJE32aFoKdWXEP40tUY8blZU
        b/VJmeyclNQrff2Q5ggAVXFJVREAXXt5hSFYBfHMKPH1OG/9ERNgGfqzYmSP2Wp2vzHUPP73xt6wt
        +NVesgdA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxWfg-000FpF-NW; Wed, 15 Dec 2021 16:58:24 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxWfg-000THC-Fg; Wed, 15 Dec 2021 16:58:24 +0100
Subject: Re: [PATCH 1/3] iio: dac: add support for ltc2688
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
 <20211214165608.7903-2-nuno.sa@analog.com>
 <001b1c03-3d46-291f-e732-21514a9fd721@metafoo.de>
 <PH0PR03MB67862614BE38CEA3A5C5831599769@PH0PR03MB6786.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b6c526db-9a21-37c7-70bd-c4de708de566@metafoo.de>
Date:   Wed, 15 Dec 2021 16:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <PH0PR03MB67862614BE38CEA3A5C5831599769@PH0PR03MB6786.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26388/Wed Dec 15 08:24:21 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/15/21 2:40 PM, Sa, Nuno wrote:
>
>>> +		}
>>> +[...]
>>> +	return ltc2688_tgp_setup(st, clk_msk, tgp);
>>> +}
>>> +
>>> +static int ltc2688_setup(struct ltc2688_state *st, struct regulator
>> *vref)
>>> +{
>>> +	struct gpio_desc *gpio;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * If we have a reset pin, use that to reset the board, If not, use
>>> +	 * the reset bit.
>>> +	 */
>> Looking at the datasheet I do not see a reset pin on the chip.
> IIRC, it's called CLR... But looking at it again if feels like a reset pin but
> without directly saying so in the datasheet.
ok, but then the gpio should be called "clr" and not "reset".
>
>>> +	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset",
>> GPIOD_OUT_HIGH);
>> Usually when we have a reset which is active low we define it in the DT
>> as active low rather than doing the inversion in the driver.
> And that's how I tested it in dts. The ' GPIOD_OUT_HIGH' is to request
> it in the asserted state and then we just have to de-assert it to take it
> out of reset. It's actually the same pattern used in the adis lib. IIRC,
> you were actually the one to suggest this :)
I'm stupid... just read it the wrong way, code is correct the way it is
>>> +	if (IS_ERR(gpio))
>>> +		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
>>> +				     "Failed to get reset gpio");
>>> +	if (gpio) {
>>> +		usleep_range(1000, 1200);
>>> +		/* bring device out of reset */
>>> +		gpiod_set_value_cansleep(gpio, 0);
>>> +	} else {
>>> +		ret = regmap_update_bits(st->regmap,
>> LTC2688_CMD_CONFIG,
>>> +					 LTC2688_CONFIG_RST,
>>> +					 LTC2688_CONFIG_RST);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +
>>> +	usleep_range(10000, 12000);
>>> +
>>> +	ret = ltc2688_channel_config(st);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (!vref)
>>> +		return 0;
>>> +
>>> +	return regmap_update_bits(st->regmap,
>> LTC2688_CMD_CONFIG,
>>> +				  LTC2688_CONFIG_EXT_REF, BIT(1));
>> This is a bit confusing since you are using LTC2688_CONFIG_EXT_REF
>> for
>> the mask and BIT(1) for the value, even though both are the same.
> I tried to be more or less consistent. So, for masks I used a define and
> for the actually value I used the "raw" BIT, FIELD_PREP, FIELD_GET as
> I think Jonathan prefers that way. If that's also the preferred way for masks,
> I'm happy to update it.

Just 5 lines above you use the define for both the mask and the value :)

I don't think it is a good idea to use raw BIT(x) in the code. They are 
just as magic of a value as writing 0x8. There is no way for a reviewer 
to quickly see whether that BIT(x) actually is the right value for the mask.

If you wanted to go the FIELD_PREP route you could write this as

..., LTC2688_CONFIG_EXT_REF, FIELD_PREP(LTC2688_CONFIG_EXT_REF, 1)

But my personal preference is just to pass the mask as the value when 
changing a single bit value. Makes it clear that it is a single bit 
field and you are setting it. Or just use regmap_set_bits().

>> There is a new API regmap_set_bits()/regmap_clear_bits() that allows
>> you
>> to write this in a more compact way. There are a few other places in
>> the
>> driver where they can be used as well.
> Hmm, will look at the new API...
>
> - Nuno Sá


