Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA454535E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiFIRur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbiFIRur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 13:50:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD521D;
        Thu,  9 Jun 2022 10:50:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y19so48956332ejq.6;
        Thu, 09 Jun 2022 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=gXcE6wxEZaP+bBDc88LJAQk22rXvPFk5Q6tlaHsBuyA=;
        b=XyyhqqGv7jXlYrpM4ABumXRCwO9wRs36xgqlBa1Uo8RV6lqaVRhTDHj5DbdBZ0nZ1g
         /BOy0mXiW2sCkpyclw00gb4FFmq6v7wzqSWPufJVQuV5Bwr+EDZ3g/uCkA46PpWjF8BL
         vmMnrCcJESM7YtXgyulkqBlYqSl06wRXKdvizhPtqJjAl+iMsP65nfDWvGhfU/kyuXzp
         rh/GyGzrvgnBV23cFquRMXzQ7Mw2R6gePS2lM7zliCrN/DTybHpDZsMNdI+99AeJ17Tm
         Fo+p10PUBP487eslU4BEN7Dpnpn1qeS14Qr3BKzYW7fQD5RKQrGVbN9S+KG2MlcM2xk8
         dtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=gXcE6wxEZaP+bBDc88LJAQk22rXvPFk5Q6tlaHsBuyA=;
        b=rDIlBhfVEH4oHuJ+ftB/QMiEpdzp6RRmOY9X0l+ldBw181b3z25pkcWVmrQW6i2DFq
         833Sx9ZwASnChkc6pepc1M7TlZR/EX0P1cy7Ycj6Xcuha9TLyYlqcBO3Wu/oo6jkw82Q
         7//XxtnxqY8HYsl2/VQ9vlHTwHn0p+QDLJxP0NLP+0pxN+YFZpGtF71ia/oUGwfHWaEA
         k55Yfd6vWFS9rgwU7CpE7qnHWik1VdDt+g97qmKUjATh8vsvQAIC4jXQQ4ZgvIn6Etok
         tcOcXTOvTj6xTGgAIuO8ke/Qso7J6f6v75lj113QFgY3I9RKbqX3mFCqRDJcQew7Ow6w
         hYcw==
X-Gm-Message-State: AOAM530Ow+dXk1E/0a9NlNWQVfZQYYmUO9JNvVVmVUoTun/6DP7HA7x7
        gU5xL91M8nVykwDpmq9drRPHXrGOawe0aw==
X-Google-Smtp-Source: ABdhPJw+8nSbv9vhs+OkAxIY1IK3e3DuVkMtDoo4H9hM6FQP4voVPAug19zfl62xU/oPnifV1xRjiA==
X-Received: by 2002:a17:906:7a4a:b0:712:c6d:46df with SMTP id i10-20020a1709067a4a00b007120c6d46dfmr3226717ejo.314.1654797044096;
        Thu, 09 Jun 2022 10:50:44 -0700 (PDT)
Received: from localhost (92.40.202.100.threembb.co.uk. [92.40.202.100])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm8870390ejp.96.2022.06.09.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:50:43 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-11-aidanmacdonald.0x0@gmail.com>
 <20220608142240.00001161@Huawei.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 10/17] iio: adc: axp20x_adc: Minor code cleanups
Date:   Wed, 08 Jun 2022 23:58:11 +0100
In-reply-to: <20220608142240.00001161@Huawei.com>
Message-ID: <O77RhgXy1hTudLgL6W1viJAUs7PAkVuZ@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue,  7 Jun 2022 16:53:17 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> The code may be clearer if parameters are not re-purposed to hold
>> temporary results like register values, so introduce local variables
>> as necessary to avoid that. Also, use the common FIELD_PREP macro
>> instead of a hand-rolled version.
>> 
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>
> Hi Aidan,
>
> Looks good.  One trivial further suggestion inline.
>
> Also, am I fine picking up the IIO patches, or does the whole
> set need to go in via mfd?
>
> Thanks,
>
> Jonathan
>

I think it has to go through mfd because of the GPIO2-3 ADC registers
which are added in the mfd patch. Cleanups are okay to pick up though.

>> ---
>>  drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
>>  1 file changed, 33 insertions(+), 28 deletions(-)
>> 
>> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
>> index 53bf7d4899d2..9d5b1de24908 100644
>> --- a/drivers/iio/adc/axp20x_adc.c
>> +++ b/drivers/iio/adc/axp20x_adc.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/property.h>
>>  #include <linux/regmap.h>
>>  #include <linux/thermal.h>
>> +#include <linux/bitfield.h>
>>  
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/driver.h>
>> @@ -22,20 +23,20 @@
>>  #include <linux/mfd/axp20x.h>
>>  
>>  #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
>> -
>>  #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
>> +
>>  #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
>>  
>>  #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
>>  #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
>> -#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
>> -#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
>>  
>>  #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
>> -#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
>> -#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>>  #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
>> +
>>  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
>> +
>> +#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
>> +#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>>  #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
>>  #define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
>>  #define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
>> @@ -234,7 +235,7 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>>  			  struct iio_chan_spec const *chan, int *val)
>>  {
>>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> -	int size = 12;
>> +	int ret, size;
>>  
>>  	/*
>>  	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
>> @@ -246,10 +247,11 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
>>  	else
>>  		size = 12;
>>  
>> -	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
>> -	if (*val < 0)
>> -		return *val;
>> +	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
>> +	if (ret < 0)
>> +		return ret;
>>  
>> +	*val = ret;
>>  	return IIO_VAL_INT;
>>  }
>>  
>> @@ -257,11 +259,13 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>>  			  struct iio_chan_spec const *chan, int *val)
>>  {
>>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> +	int ret;
>>  
>> -	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
>> -	if (*val < 0)
>> -		return *val;
>> +	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
>> +	if (ret < 0)
>> +		return ret;
>>  
>> +	*val = ret;
>>  	return IIO_VAL_INT;
>>  }
>>  
>> @@ -269,11 +273,13 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
>>  			  struct iio_chan_spec const *chan, int *val)
>>  {
>>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> +	int ret;
>>  
>> -	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
>> -	if (*val < 0)
>> -		return *val;
>> +	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
>> +	if (ret < 0)
>> +		return ret;
>>  
>> +	*val = ret;
>>  	return IIO_VAL_INT;
>>  }
>>  
>> @@ -443,27 +449,27 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>>  				     int *val)
>>  {
>>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> +	unsigned int regval;
>>  	int ret;
>>  
>> -	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, val);
>> +	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, &regval);
>>  	if (ret < 0)
>>  		return ret;
>>  
>>  	switch (channel) {
>>  	case AXP20X_GPIO0_V:
>> -		*val &= AXP20X_GPIO10_IN_RANGE_GPIO0;
>> +		regval &= AXP20X_GPIO10_IN_RANGE_GPIO0;
>
> Maybe use FIELD_GET() here to be clear you are extracting that
> field (even though we don't care about the shift).
>
> Hopefully the compiler will be clever enough to remove the shift
> anyway and using FIELD_GET() would act as slightly more 'documentation
> in code'.
>

You're probably right; I erred on the side of premature optimization.
I'll go back to FIELD_GET in the v3 since I've got to resend anyway.

>>  		break;
>>  
>>  	case AXP20X_GPIO1_V:
>> -		*val &= AXP20X_GPIO10_IN_RANGE_GPIO1;
>> +		regval &= AXP20X_GPIO10_IN_RANGE_GPIO1;
>>  		break;
>>  
>>  	default:
>>  		return -EINVAL;
>>  	}
>>  
>> -	*val = *val ? 700000 : 0;
>> -
>> +	*val = regval ? 700000 : 0;
>>  	return IIO_VAL_INT;
>>  }
>>  
>> @@ -548,7 +554,7 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>>  			    long mask)
>>  {
>>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>> -	unsigned int reg, regval;
>> +	unsigned int regmask, regval;
>>  
>>  	/*
>>  	 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
>> @@ -560,25 +566,24 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>>  	if (val != 0 && val != 700000)
>>  		return -EINVAL;
>>  
>> -	val = val ? 1 : 0;
>> +	regval = val ? 1 : 0;
>>  
>>  	switch (chan->channel) {
>>  	case AXP20X_GPIO0_V:
>> -		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
>> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
>> +		regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
>> +		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);
>>  		break;
>>  
>>  	case AXP20X_GPIO1_V:
>> -		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
>> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
>> +		regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
>> +		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);
>>  		break;
>>  
>>  	default:
>>  		return -EINVAL;
>>  	}
>>  
>> -	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, reg,
>> -				  regval);
>> +	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
>>  }
>>  
>>  static const struct iio_info axp20x_adc_iio_info = {

