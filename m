Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2367818C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjAWQfo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 11:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjAWQfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 11:35:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2E2B612
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 08:35:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt14so32076144ejc.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0Gxh9AiNJZqPqlkDkjLVBcYYycaXIS8zrXO7C1huyk=;
        b=uRk9GBjR7rCDMx8/44l0h8DBuBbLcsuh0HZRINoQhDYcIvif8GTpEfh5xna3sgxBBZ
         UGhklSqPZB5p2Lza3TNG3DI/U+y1i/ByCQcX7fLwaOn65lGmM75rZ2dHZN+Ki9WFN5t+
         xX8MNtAVSt02mAmOiVTsolwBcL/M8Dkh5SCG5GwXLg55qfJGFtin+rBsrAXvOAk0zDAU
         x0j9JmfymCZGfJhdQF+plzqCf1MhyOvRfaaYuLfvLOETejbek111Rx9WJ/1+ECvhsi7A
         nn1HLzpbYYgLaTSWGN1drWR9uO5kkTlqPEpDV3zlM939HWCaSh5M6Xp+0pAdpHLAbih2
         1/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0Gxh9AiNJZqPqlkDkjLVBcYYycaXIS8zrXO7C1huyk=;
        b=g1QhSNqPOPlzj60ZPyvanH8tpKUSYyDXhAcSTvwNknteSKKNOhK7FiXB8NKysekCmK
         fC8/I5vRzHVL4cCxf91mY+sQBZl4atTiuHr8FQc2+plt4sy9yh0n4ZRi19SkGneWJAqR
         9xjCCDW2B6poNRcz2m8GoElOIoMsbb537yMDmWXpJqPfeWkbEnGSAh5vNSeLx2sc79gP
         zP1Z/jw0eazV7njMzwaspYzN6yIRlT/xC2gCPef/YpRHDS76vnOg4di4mu+EdxLLDbRm
         aXaQzJ0qKXcI5vmgE/tjE9zT6R6M9SqN2p6WVfSktUosxlUbdCvElh+SaXQ0OhlWVwRS
         FvXg==
X-Gm-Message-State: AFqh2kqYRjggCUR0n80ipYx81Hc43UY5ynLv4kYu7d4rEUC6BgkSfpa4
        G+9Tp8e70x6wC4FRZZ5OQhq8Ng==
X-Google-Smtp-Source: AMrXdXvYAMztktTuFtNe8pWfh2/y+eI4NoNWhqyzS+5Ne4GtBPTgyn1QcIOMd4PzPj0633HsMKsLRQ==
X-Received: by 2002:a17:906:489b:b0:850:52f8:5ca9 with SMTP id v27-20020a170906489b00b0085052f85ca9mr25511121ejq.28.1674491741481;
        Mon, 23 Jan 2023 08:35:41 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id kw17-20020a170907771100b0084c4b87aa18sm22392447ejc.37.2023.01.23.08.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:35:41 -0800 (PST)
Message-ID: <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
Date:   Mon, 23 Jan 2023 17:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230122172441.4f8d75f5@jic23-huawei>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230122172441.4f8d75f5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 22.01.2023 18:24, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 12:06:23 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> The node name can contain an address part which is unused
>> by the driver. Moreover, this string is propagated into
>> the userspace label, sysfs filenames *and breaking ABI*.
>>
>> Cut the address part out before assigning the channel name.
>>
>> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
>> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> LGTM, but given it will have ABI impact, I'd like to hear from 
> Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> who has touched this driver fairly recently.
+ Doug

Unless the Chromium folks relied on the old names (they're the
only ones I can think of that actually could have tapped into
this), I say green light!

Konrad
> 
> Mostly I want to be sure they know this exists before it causes surprise.
> 
> Jonathan
> 
>> ---
>> v2: rephrased commit message (Marijn), fixed compilation issue (Marijin)
>>  drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
>> index e90c299c913a..c2d5e06f137a 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -628,12 +628,20 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
>>  				    struct fwnode_handle *fwnode,
>>  				    const struct adc5_data *data)
>>  {
>> -	const char *name = fwnode_get_name(fwnode), *channel_name;
>> +	const char *channel_name;
>> +	char *name;
>>  	u32 chan, value, varr[2];
>>  	u32 sid = 0;
>>  	int ret;
>>  	struct device *dev = adc->dev;
>>  
>> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	/* Cut the address part */
>> +	name[strchrnul(name, '@') - name] = '\0';
>> +
>>  	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
>>  	if (ret) {
>>  		dev_err(dev, "invalid channel number %s\n", name);
> 
