Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62351955C7
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgC0K4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 06:56:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34683 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgC0K4R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 06:56:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 26so9840860wmk.1;
        Fri, 27 Mar 2020 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dL7gv6sWkyNmltNkwBKTpfHTf5artkuk2jHExaT5rwo=;
        b=Ze8UpfUOyNHJABjYlb+idMeSG10f0yfqmZUnvbVOEj3iDSKX7gfB2FevnOMYvfNV3C
         ZZXd2rRAVBtQwWnftG5y18IwPNORXt3sjFNPKZ7EvPgFPL5q9ba2ZetUQUEX6KXOpsoe
         neTuZVAUj150z1mZZ07MayLtYg0R/UYdYF7DThmpt3QpObFENcU2NjZspBDtmHp5jBLG
         GLiUuWTYKv6SrUF5Hu4AcDUw/grtzmCCO+6IG8vs5qjy6sNE3g+17S20cFG4gi4CvBri
         VJjV+HAr845oJiKBLhoZSAvo3A5QaLRM3upfdKFZ2W0UeLZ269wC2ok5Npfaa2WfdKqR
         eP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dL7gv6sWkyNmltNkwBKTpfHTf5artkuk2jHExaT5rwo=;
        b=dGnr6ID4sirKML1LdzaOE7F62/xBD6wlJspId0XVt68lwX01yVUyxR+33BtZMP7vba
         bOKCB3ApC//8m0ZHBgr1tyd5tzZgUGFSsxVAtXBfWnSGk4EG6W291vAgKKJO7mtxsbAm
         rx/KG8oulT6x4CeccVPGc7TTUI5fbBafJms618KO6xnf9/+iWpu1K+cw3/9a5M8SKGAL
         TWw2HaIxInJ/Wu7juee9Ng/rv81rkuUVHMqoAiUUIwl8T4bvT1p8FvycINXwnaQpYcyo
         CwW/58fqH85VRuEHv0KWzB1KMuFaiB4OYXT+dk0IGon+zu1+kpgLalRmv0ueUvZTNjvf
         dlYA==
X-Gm-Message-State: ANhLgQ2Ni8kxMxHPaSUZrHXoK9NL1y+BpWvAd77+gXD5GjyO/6Y+HNhP
        TRbyppBfYobT6Aalp/FHPhH4bJ+B
X-Google-Smtp-Source: ADFU+vtvhuSZJjurIGRCsgdKkflRiS/mvFRDEymYBxWuLgfQjZc0ZtIPYOpBb4EhyF82lAEDddKD0g==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr4864337wme.172.1585306573821;
        Fri, 27 Mar 2020 03:56:13 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6E13.dip0.t-ipconnect.de. [91.63.110.19])
        by smtp.gmail.com with ESMTPSA id f9sm8456599wrs.36.2020.03.27.03.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 03:56:13 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com> <20200327075541.GF603801@dell>
 <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com> <20200327102221.GA3383@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com>
Date:   Fri, 27 Mar 2020 11:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327102221.GA3383@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,


On 27/03/20 11:22 am, Lee Jones wrote:
> Saravanan, Jonathan,
>
> On Fri, 27 Mar 2020, saravanan sekar wrote:
>> On 27/03/20 8:55 am, Lee Jones wrote:
>>> On Sun, 22 Mar 2020, Saravanan Sekar wrote:
>>>
>>>> mp2629 is a highly-integrated switching-mode battery charge management
>>>> device for single-cell Li-ion or Li-polymer battery.
>>>>
>>>> Add MFD core enables chip access for ADC driver for battery readings,
>>>> and a power supply battery-charger driver
>>>>
>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>> ---
>>>>    drivers/mfd/Kconfig        |   9 +++
>>>>    drivers/mfd/Makefile       |   2 +
>>>>    drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/mp2629.h |  22 +++++++
>>>>    4 files changed, 149 insertions(+)
>>>>    create mode 100644 drivers/mfd/mp2629.c
>>>>    create mode 100644 include/linux/mfd/mp2629.h
> [...]
>
>>>> +static int mp2629_probe(struct i2c_client *client)
>>>> +{
>>>> +	struct mp2629_info *info;
>>> Call this ddata instead of info.
>> Not sure the reason, I will do.
> Because this is device data.  Info is too loose of a definition.


Ok, noted

>>>> +	struct resource	*resources;
>>>> +	int ret;
>>>> +	int i;
>>>> +
>>>> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
>>>> +	if (!info)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	info->dev = &client->dev;
>>>> +	i2c_set_clientdata(client, info);
>>>> +
>>>> +	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
>>>> +	if (IS_ERR(info->regmap)) {
>>>> +		dev_err(info->dev, "Failed to allocate regmap!\n");
>>>> +		return PTR_ERR(info->regmap);
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < MP2629_MFD_MAX; i++) {
>>>> +		mp2629mfd[i].platform_data = &info->regmap;
>>>> +		mp2629mfd[i].pdata_size = sizeof(info->regmap);
>>> You don't need to store this in platform data as well.
>>>
>>> You already have it in device data (ddata [currently 'info']).
>> "The IIO parts seems fine (minor comments inline) but I'm not keep on
>> directly accessing the internals of the mfd device info structure.
>> To my mind that should be opaque to the child drivers so as to provide
>> clear structure to any such accesses.
>>
>> This mess in layering with the children directly using the parents
>> regmap is a little concerning. It means that the 3 drivers
>> really aren't very well separated and can't really be reviewed
>> independently (not a good thing)."
>>
>> This is the review comments form Jonathan on V2, not to access parent data
>> structure directly.
>> Am I misunderstood his review comments? please suggest the better option to
>> follow as like in V2
>> or V2 + some improvements or V4 + improvements?
> I will take this up with Jonathan separately if necessary.
>
> For your FYI (and Jonathan if he's Cc'ed), it's very common for a
> child of an MFD to acquire resources from their parent.  That is the
> point of a lot of MFDs, to obtain and register shared resources and
> pass them onto their offspring.  There are 10's of examples of this.
>
> Things like Regmaps aren't platform data, they are device/driver data,
> which is usually passed though platform_set_drvdata().

Thanks for clarification, I will go as like in V2 sharing mfd struct to 
the childs.


> [...]
>
>>>> + */
>>>> +
>>>> +#ifndef __MP2629_H__
>>>> +#define __MP2629_H__
>>>> +
>>>> +#include <linux/types.h>
>>>> +
>>>> +struct device;
>>>> +struct regmap;
>>> Why not just add the includes?
>> Some more shared enum added in ADC driver
> Sorry?

I misunderstood your previous question that you are asking to remove 
this mp2629.h file

"No user here. (Hint: Use forward declaration of struct device instead)" 
- review comments on V1 from Andy Shevchenko.
So remove the includes


>>>> +struct mp2629_info {
>>>> +	struct device *dev;
>>>> +	struct regmap *regmap;
>>>> +};
>>>> +
>>>> +#endif


Thanks,

Saravanan

