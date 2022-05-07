Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6152051E89D
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446651AbiEGQxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 May 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbiEGQxH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 12:53:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B48205FB;
        Sat,  7 May 2022 09:49:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks9so13184951ejb.2;
        Sat, 07 May 2022 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SAg5g+MiD3SG38RHNPJNJCdug7OG18gamo1tHYzZ8K0=;
        b=i280AkyD/k7YYL+1wJ2wfg36XhNIeBxwb63mwCGKrwGWwPnYi7vvPpdABCp9jAgfO5
         /7t99u/THmPeXURNtVM3XaR9gF/t3ozQuEvp67qY5PAwN6+o5t5RgWfY3MEX/Ytu8kNH
         lNZH4Bs/lZgMj0wR7FeOZjvBGMhX/qMiJyoL+xD0ERceWe4elZe9d2G0aePPQiANX5TC
         Ods2Uu/GvRNv6E44FWoCxjhjqbqwLvtcEYz1bCKOQM2mYUaLLhBBsUHLoNfY0uBdicqF
         L6KSqAVeRM8LYRlZNW2P/amybZD2RxqKY9NBQATl9PS3o2ME4KoTzdyoWDi3IFM8piPP
         htLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SAg5g+MiD3SG38RHNPJNJCdug7OG18gamo1tHYzZ8K0=;
        b=TFNg+vsiMMQHU63iixVUnw5FVttJLyl/jM4tFBnfxvqBwGqExpmQ1TNwAxgHw3V2d/
         y2jsiZT4UxE9vd/tKyrGWuhDIIAeb01R6cJBQZLek6fooqz1VLtEnCp7+L9+nyDwjfvL
         7vAYVL1tWxuIbKrh2Tc08SGly2mEUVmDUsnSGbz5n4ymSqEzUnrMdYwIC1n0sX8D+PXd
         mT9y+MyNiCNMqwFCQukpVvkeoDAZ05jZOwjjaAaMFwUE3GVa8kc5Ma7MLS0hs/gwZLKs
         bG+COlBICQaj0MkWeXq87nzDVuje3B6WR67CzB1JleqZA/HcmND7yrm03g0GTIGs90A5
         r0XA==
X-Gm-Message-State: AOAM530VxfFynbMuCNiz68KaXykXDdXVSGylGpO3rMmE2MTw+EZS6Ozx
        IGYHI3y/HCAZq00jq5ODGZ38I5tB5+E=
X-Google-Smtp-Source: ABdhPJyY7NZz5O1Ou2jPQWoXPiPcoJ8tzBFNQMEhwsFaVLYA9qvu2eCeb8hFet3EJ9fenZxzjJJJDw==
X-Received: by 2002:a17:906:c114:b0:6f5:db6f:71a1 with SMTP id do20-20020a170906c11400b006f5db6f71a1mr5467780ejc.338.1651942158054;
        Sat, 07 May 2022 09:49:18 -0700 (PDT)
Received: from [192.168.0.182] ([188.26.79.139])
        by smtp.gmail.com with ESMTPSA id lh25-20020a170906f8d900b006f3ef214e04sm3149047ejb.106.2022.05.07.09.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:49:17 -0700 (PDT)
Message-ID: <39cb9ade-14af-c53b-bd42-06a9b965b57f@gmail.com>
Date:   Sat, 7 May 2022 19:49:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-3-cosmin.tanislav@analog.com>
 <20220501170807.1e728524@jic23-huawei>
 <5d932a4a-790e-ca95-c5de-c2267e1f365c@gmail.com>
 <20220507173551.1bc45a82@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220507173551.1bc45a82@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 5/7/22 19:35, Jonathan Cameron wrote:
> 
>>>    
>>>> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
>>>> +{
>>>> +	struct ad4130_state *st = iio_priv(indio_dev);
>>>> +	unsigned int eff;
>>>> +	int ret;
>>>> +
>>>> +	if (val > AD4130_FIFO_SIZE)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/*
>>>> +	 * Always set watermark to a multiple of the number of enabled channels
>>>> +	 * to avoid making the FIFO unaligned.
>>>> +	 */
>>>> +	eff = rounddown(val, st->num_enabled_channels);
>>>> +
>>>> +	mutex_lock(&st->lock);
>>>> +
>>>> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
>>>> +				 AD4130_WATERMARK_MASK,
>>>> +				 FIELD_PREP(AD4130_WATERMARK_MASK,
>>>> +					    ad4130_watermark_reg_val(eff)));
>>>> +	if (ret)
>>>> +		goto out;
>>>> +
>>>> +	st->effective_watermark = eff;
>>>> +	st->watermark = val;
>>>
>>> Hmm this is a potential inconsistency in the IIO ABI.
>>> ABI docs describes watermark as being number of 'scan elements' which is
>>> not the clearest text we could have gone with...
>>>
>>> Now I may well have made a mistake in the following as it's rather a long time
>>> since I last looked at the core handling for this...
>>>
>>> The core treats it as number datum (which is same as a scan) when using
>>> it for the main watermark attribute and also when using watermarks with the
>>> kfifo (the IIO fifo is made up of objects each of which is a scan. So kfifo_len()
>>> returns the number of scans.
>>>    
>>> Looking very quickly at a few other drivers
>>> adxl367 seems to use number of samples.
>>> adxl372 is using number of scans.
>>> bmc150 hardware seems to work on basis of frame count which I 'think' is probably scans.
>>> fxls8962 uses 'samples count' which is not clearly defined in the datasheet but there
>>> is an example showing that it's scans (I think)...
>>> lsm6dsx - some of the fifos used with this are based on tagged data so the connection to
>>> what hits the front end buffers is non obvious.
>>>
>>> So, not great for consistency :(
>>>
>>> Going forwards i think we should standardize the hardware fifo watermark on what is being
>>> used for the software watermark which I believe is number of scans.
>>> Not necessary much we can do about old drivers though due to risk of breaking ABI...
>>> We should make the documentation clearer though.
>>>    
>>
>> I was confused too, but this seemed more logical to me at the time, and
>> since you didn't say anything regarding it on ADXL367, I did it the same
>> way here. I guess we can't go back and change it now on ADXL367, I'm
>> sorry for this. I'll fix it.
> 
> I missed it.  Review is never perfect (mine definitely aren't!)
> 
> Thinking more on the adxl367. We still have a window to  fix that as
> the driver isn't yet in a release kernel.  Would you mind spinning a
> patch to fix that one?  Even if we miss the rc cycle (it's a bit tight
> timing wise) we can sneak it in as an early fix in stable without
> significant risk of breaking anyone's userspace.
> 

I hope Monday is not too late to do it?
I can also try to do the changes tomorrow but I don't have the hardware
anymore so I won't be able to test until I get it back, which is only
next week.

> There might be other drivers that have that interpretation we can't
> fix but if we can reduce the scope of the problem by changing the adxl367
> that would be great.
> 
> We should also definitely improve the docs and perhaps add a note to say
> that due to need to maintain ABI, a few drivers use scans * number of channels
> rather than scans.

I guess I could also do that at the same time.
