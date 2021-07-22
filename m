Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213C33D1D54
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 07:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhGVEnP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 00:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhGVEnP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jul 2021 00:43:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0CC061575;
        Wed, 21 Jul 2021 22:23:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u15so5404703oiw.3;
        Wed, 21 Jul 2021 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBmBOeOTp9wsebKiYoD8S+Tua4vUPaPjzUkiuEBNNr0=;
        b=DZ7vjU1jaMzboYsAhFeDeIz3ClzR60U4+XyDJVIqg8ekaDcpVUe7xkUmLQZnPuIRM2
         9jRHTQOIGylxPFFwcLu6nnY0vjpNHCnJTF9c49wwU4kDjy69X0ONtzsBA6RCkRhlkiZd
         ArwdKevsJZUTvuLmeKs7v5wBOuQ8q78vr2GfQFDlcalJK+q4Fa6vUwRjyUlFxdGllLkQ
         9lhkfg0OGq4OjJl7T+d7/OczifQbWP4xWGDERd2XKnM0VaNBZAuLpuC19sUwoCwQlDNZ
         sLtw0qYLxPGfdl1rHFlyjtzbfWa/DyBgQQ8AmAifQL3Vtk7YDaqsKMQDygVsRf1NazWA
         3/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBmBOeOTp9wsebKiYoD8S+Tua4vUPaPjzUkiuEBNNr0=;
        b=Aiw3mart8AZeWS7kbmSUCy7L3pjhyoXdxge8J6ybrQaBXEvOTXNHMa704jvPyRxCmv
         TBv/YPMFVL48x9QZRoDq+1dY63lqtl7PynJNHyhAogdVnX0zf5SjMlX12kIeVdY4VGlw
         XiH3T/P9ROAeK0/mZ+9kA+QXidfp+hYQ70jL1oXj7yXjRai9Wuz54kVN88vASPGeliB4
         LHYUpQsSURZPWhuK8I0u4VRM68gAeYvTaoalrTPsAtn/KCTahvCDn375KSvtY/Cn9bGl
         hHBHug5WY7ZPgLTCzEhXqrRGx6HAUgQcGAH1pAffrX3BI/KXo8OcCxg+eU7JFclkvyk4
         g/cA==
X-Gm-Message-State: AOAM532lDYHFfqdTOjgrzc9x5W7seEZDSAM27GzU+Mmk2K5upK0gutQH
        3wn1CVvpIFl1qT0GneJU7LdmDnB70EU=
X-Google-Smtp-Source: ABdhPJz4yeBMAAISf2BNZmioufJ7UTGJnFGpwgHGnuHw0lDRSUQwHWoZ85HfQjx9eJvLmN77m063Bg==
X-Received: by 2002:a05:6808:aaf:: with SMTP id r15mr4712010oij.80.1626931430128;
        Wed, 21 Jul 2021 22:23:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 63sm905289otc.52.2021.07.21.22.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 22:23:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/6] iio/adc: ingenic: add JZ4760 support to the sadc
 driver
To:     Christophe Branchereau <cbranchereau@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu
References: <20210721105317.36742-1-cbranchereau@gmail.com>
 <20210721105317.36742-4-cbranchereau@gmail.com>
 <BEXLWQ.Q6JDGD8HI0S31@crapouillou.net>
 <CAFsFa86rDydfvumcA7Ld5Vx=hJyYb9_soeYfRk_we1ZofFxUgQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
Date:   Wed, 21 Jul 2021 22:23:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFsFa86rDydfvumcA7Ld5Vx=hJyYb9_soeYfRk_we1ZofFxUgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/21/21 10:09 PM, Christophe Branchereau wrote:
> Hello Paul, thank you for all the feedback, duly noted I will V2,
> there is just one I disagree with:
> 
> On Wed, Jul 21, 2021 at 8:15 PM Paul Cercueil <paul@crapouillou.net> wrote:
>>
>> Hi Christophe,
>>
>> Le mer., juil. 21 2021 at 12:53:14 +0200, citral23
>> <cbranchereau@gmail.com> a écrit :
>>> Signed-off-by: citral23 <cbranchereau@gmail.com>
>>> ---
>>>   drivers/iio/adc/ingenic-adc.c | 64
>>> +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 64 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/ingenic-adc.c
>>> b/drivers/iio/adc/ingenic-adc.c
>>> index 40f2d8c2cf72..285e7aa8e37a 100644
>>> --- a/drivers/iio/adc/ingenic-adc.c
>>> +++ b/drivers/iio/adc/ingenic-adc.c
>>> @@ -71,6 +71,7 @@
>>>   #define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS   10
>>>   #define JZ4740_ADC_BATTERY_HIGH_VREF         (7500 * 0.986)
>>>   #define JZ4740_ADC_BATTERY_HIGH_VREF_BITS    12
>>> +#define JZ4760_ADC_BATTERY_VREF                      2500
>>>   #define JZ4770_ADC_BATTERY_VREF                      1200
>>>   #define JZ4770_ADC_BATTERY_VREF_BITS         12
>>>
>>> @@ -295,6 +296,10 @@ static const int
>>> jz4740_adc_battery_scale_avail[] = {
>>>        JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
>>>   };
>>>
>>> +static const int jz4760_adc_battery_scale_avail[] = {
>>> +     JZ4760_ADC_BATTERY_VREF, JZ4770_ADC_BATTERY_VREF_BITS,
>>> +};
>>> +
>>>   static const int jz4770_adc_battery_raw_avail[] = {
>>>        0, 1, (1 << JZ4770_ADC_BATTERY_VREF_BITS) - 1,
>>>   };
>>> @@ -339,6 +344,8 @@ static int jz4725b_adc_init_clk_div(struct device
>>> *dev, struct ingenic_adc *adc)
>>>        return 0;
>>>   }
>>>
>>> +
>>> +
>>
>> Unrelated cosmetic change - remove it.
> 
> This is not cosmetic, but to add a VREF of 2.5V for the jz4760, as per specs
> 

Two added empty lines are not cosmetic ?

Guenter

>>
>>>   static int jz4770_adc_init_clk_div(struct device *dev, struct
>>> ingenic_adc *adc)
>>>   {
>>>        struct clk *parent_clk;
>>> @@ -400,6 +407,47 @@ static const struct iio_chan_spec
>>> jz4740_channels[] = {
>>>        },
>>>   };
>>>
>>> +static const struct iio_chan_spec jz4760_channels[] = {
>>> +     {
>>> +             .extend_name = "aux0",
>>> +             .type = IIO_VOLTAGE,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>> +             .indexed = 1,
>>> +             .channel = INGENIC_ADC_AUX0,
>>> +             .scan_index = -1,
>>> +     },
>>> +     {
>>> +             .extend_name = "aux",
>>> +             .type = IIO_VOLTAGE,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>> +             .indexed = 1,
>>> +             .channel = INGENIC_ADC_AUX,
>>> +             .scan_index = -1,
>>> +     },
>>
>> A couple of things. First, ".extend_name" is deprecated now... But
>> since the driver used it before, I suppose it doesn't make sense to use
>> labels just for this SoC (as we can't remove .extend_name for other
>> SoCs because of ABI). So I suppose it works here, but maybe Jonathan
>> disagrees.
>>
>> Also, you should probably use "aux1" as the channel's name instead of
>> "aux", independently of the macro name you used in the .channel field.
>>
>>> +     {
>>> +             .extend_name = "battery",
>>> +             .type = IIO_VOLTAGE,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>> +             .info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                             BIT(IIO_CHAN_INFO_SCALE),
>>> +             .indexed = 1,
>>> +             .channel = INGENIC_ADC_BATTERY,
>>> +             .scan_index = -1,
>>> +     },
>>
>> Swap the battery channel at the end, no? First the three AUX then the
>> battery channel?
>>
>> The rest looks pretty good to me.
>>
>> Cheers,
>> -Paul
>>
>>> +     {
>>> +             .extend_name = "aux2",
>>> +             .type = IIO_VOLTAGE,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>> +             .indexed = 1,
>>> +             .channel = INGENIC_ADC_AUX2,
>>> +             .scan_index = -1,
>>> +     },
>>> +};
>>> +
>>>   static const struct iio_chan_spec jz4770_channels[] = {
>>>        {
>>>                .type = IIO_VOLTAGE,
>>> @@ -526,6 +574,20 @@ static const struct ingenic_adc_soc_data
>>> jz4740_adc_soc_data = {
>>>        .init_clk_div = NULL, /* no ADCLK register on JZ4740 */
>>>   };
>>>
>>> +static const struct ingenic_adc_soc_data jz4760_adc_soc_data = {
>>> +     .battery_high_vref = JZ4760_ADC_BATTERY_VREF,
>>> +     .battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
>>> +     .battery_raw_avail = jz4770_adc_battery_raw_avail,
>>> +     .battery_raw_avail_size = ARRAY_SIZE(jz4770_adc_battery_raw_avail),
>>> +     .battery_scale_avail = jz4760_adc_battery_scale_avail,
>>> +     .battery_scale_avail_size =
>>> ARRAY_SIZE(jz4760_adc_battery_scale_avail),
>>> +     .battery_vref_mode = false,
>>> +     .has_aux_md = true,
>>> +     .channels = jz4760_channels,
>>> +     .num_channels = ARRAY_SIZE(jz4760_channels),
>>> +     .init_clk_div = jz4770_adc_init_clk_div,
>>> +};
>>> +
>>>   static const struct ingenic_adc_soc_data jz4770_adc_soc_data = {
>>>        .battery_high_vref = JZ4770_ADC_BATTERY_VREF,
>>>        .battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
>>> @@ -621,6 +683,7 @@ static int ingenic_adc_read_raw(struct iio_dev
>>> *iio_dev,
>>>                return ingenic_adc_read_chan_info_raw(iio_dev, chan, val);
>>>        case IIO_CHAN_INFO_SCALE:
>>>                switch (chan->channel) {
>>> +             case INGENIC_ADC_AUX0:
>>>                case INGENIC_ADC_AUX:
>>>                case INGENIC_ADC_AUX2:
>>>                        *val = JZ_ADC_AUX_VREF;
>>> @@ -832,6 +895,7 @@ static int ingenic_adc_probe(struct
>>> platform_device *pdev)
>>>   static const struct of_device_id ingenic_adc_of_match[] = {
>>>        { .compatible = "ingenic,jz4725b-adc", .data =
>>> &jz4725b_adc_soc_data, },
>>>        { .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data,
>>> },
>>> +     { .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data,
>>> },
>>>        { .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data,
>>> },
>>>        { },
>>>   };
>>> --
>>> 2.30.2
>>>
>>
>>
> KR
> CB
> 

