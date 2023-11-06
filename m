Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D37E20CD
	for <lists+linux-iio@lfdr.de>; Mon,  6 Nov 2023 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKFMFF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Nov 2023 07:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKFMEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Nov 2023 07:04:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293CBD6D
        for <linux-iio@vger.kernel.org>; Mon,  6 Nov 2023 04:04:48 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc330e8f58so29784835ad.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Nov 2023 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1699272287; x=1699877087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46VzGlmeELEIxClyfdA2R2VNLyfPNxMQefKC5OLuDoE=;
        b=eKvnBqmR55R+XumMhCKheFarKvIURiFVUkB4N1p91yekdXmIPriBjirpyIYqM9yXoc
         zF6wTWgwMsUTNp6B9ei3iZFNqAPWdkxdJTKe4v0tMU0ykilOrwkzgEuDB0jpc7yyj5y3
         7Z4BrieAry2KLr76sPRG1mrbX8eiVakJPQMs16KCRQqYqTbi3vfr4UEjfgxFfe1YeslG
         zzcUJyl5K2b9zMauwZp0OK7LByPSYA7SM84RKO4JJvqzY4zjfeZMkwj9+JT9R8qdf0ab
         MzQB0Bh1p8draq6KbMLBgLsK5X61YkdrYjHvdggAWCGQ9upbXoACazI/wFbxn7ScU/rO
         zPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699272287; x=1699877087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46VzGlmeELEIxClyfdA2R2VNLyfPNxMQefKC5OLuDoE=;
        b=ATDo+cQliY+pIalTimhZ+oXrp/NUppGbhFI0d/iF1Yg980r8/HlaGplCIdpzj+/dLm
         62dLqeqqERLyGsPrfWFwbQrpdMAlH60+UbhMe7j37iCYc9vTO6iXvleKGFBMlerSyfUH
         K06YKCo6hjC2agvYA2V5SQaRt9x3s0i66OT2FuxcHV7uPGcZVevsq2EHJJk1+urPZiCO
         DYqWbBEb/BgbRoJ/j8hiNHBdVZpo+WgM1Ie8Uf2teHXzAomqEmLVBLLGKy8xWYZ+z+QV
         Zl0ySs9kWxYODPuLcZooGjWG/I0GlRFJiSMQsWZrPJr4VcSqzxedglpK7ZNl3TXp4/A6
         WMeQ==
X-Gm-Message-State: AOJu0Yz8cph4D6UuA9Kdiwn3c42mOhK0J41RiRMbisidL6l/fQe9vIM5
        lDxwVvtkj1EO4N8ODQ4bLTgWlw==
X-Google-Smtp-Source: AGHT+IG7DRfNwPDxgoh3F9fkUL2pkjnMpshM1CiC9s8usB7+1pi0S4JLvaytBvlGwNlOI6TWZp2ZGQ==
X-Received: by 2002:a17:902:d502:b0:1cc:6fdb:b640 with SMTP id b2-20020a170902d50200b001cc6fdbb640mr18684146plg.56.1699272287315;
        Mon, 06 Nov 2023 04:04:47 -0800 (PST)
Received: from ?IPV6:2403:580d:82f4:0:afde:b92c:1d26:d50c? (2403-580d-82f4-0-afde-b92c-1d26-d50c.ip6.aussiebb.net. [2403:580d:82f4:0:afde:b92c:1d26:d50c])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001cc2f9fd74csm5744964pld.189.2023.11.06.04.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 04:04:46 -0800 (PST)
Message-ID: <307f93f9-2a41-4704-ac4f-8d1e427e5060@tweaklogic.com>
Date:   Mon, 6 Nov 2023 22:34:40 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <2974aa13-796c-49ef-bef7-fd7f3f9b7f49@tweaklogic.com>
 <20231106111355.2f8dfaa1@jic23-huawei>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231106111355.2f8dfaa1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/11/23 21:43, Jonathan Cameron wrote:
> On Tue, 31 Oct 2023 19:08:08 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>>>    
>>>> +static struct iio_event_spec apds9306_event_spec_als[] = {
>>>> +	{
>>>> +		.type = IIO_EV_TYPE_THRESH,
>>>> +		.dir = IIO_EV_DIR_RISING,
>>>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>>>> +	}, {
>>>> +		.type = IIO_EV_TYPE_THRESH,
>>>> +		.dir = IIO_EV_DIR_FALLING,
>>>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>>>> +	}, {
>>>> +		.type = IIO_EV_TYPE_THRESH,
>>>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
>>>> +	}, {
>>>> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
>>>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
>>>> +			BIT(IIO_EV_INFO_ENABLE),
>>>> +	}, {
>>>> +		.type = IIO_EV_TYPE_THRESH,
>>>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>> This matches an entry above for type. Don't have separate entries.
>>>> +	},
>>>> +};
>>>> +
>>>> +static struct iio_event_spec apds9306_event_spec_clear[] = {
>>>> +	{
>>>> +		.type = IIO_EV_TYPE_THRESH,
>>>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>>> +	},
>>>> +};
>>>> +
>>>> +#define APDS9306_CHANNEL(_type) \
>>>> +	.type = _type, \
>>>> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
>>>> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>>>> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
>>>> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>>>
>>> Scale on the intensity channel is interesting...  What are the units?
>>> There tend not to be any well defined units for intensity (as opposed
>>> to illuminance).  There may be gain on the signal, but it won't be in untils
>>> that map directly to a scale userspace should apply.  This is one of the
>>> rare reasons for using the HARDWARE_GAIN element of the ABI.
>>>
>>> A tricky corner however as relationship between raw value and hardwaregain
>>> is not tightly defined (as it can be really weird!)
>> Hi Jonathan,
>>
>> Thank you for taking time for reviewing and clearing all my tiny doubts and
>> queries especially for the dt and versioning part. Much appreciated.
>>
>> In the above case, should I not expose scale for the "clear" channel? Rather,
>> how should I expose the "clear" channel to userspace?
> What is the scale?  What units to you get after applying it?
The scale is in Lux. The output after applying is Lux.
> 
> I suspect it's not well defined.
> 
> Not sure what we've done in similar cases in the past.  Perhaps have
> a look at those.  There may be precedence for still using scale.
Sure, I'll look it up.
> 
> I'm about to jump on a long haul flight (delayed - sigh) so don't have
> time to look myself!
> 
No worries. I will update notes and application in next version.
Have a good trip to where ever you are going. Are you coming to Australia
by any chance?
Thanks for the reply.

Regards,
Subhajit Ghosh



