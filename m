Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22A555065B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 19:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiFRR1G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRR1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 13:27:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684815FDC;
        Sat, 18 Jun 2022 10:27:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so9354978wrg.7;
        Sat, 18 Jun 2022 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DoIZZ1NTKy4Vr/t9RCJI3Po/KaMoN7vfri8esvxKoD4=;
        b=Nxp8r11G1j4iGd99hYd/4zZmf4jaIWbqEAANLSikI9r7y+gNhjPgOCLQFs4/9aJH31
         c+8+WR98KfXuEMxxgWDNoCrj3VIE8bcpmNi1ICx32OC21eN0En0dCMerkwQHqiXPesye
         eCifP9XKvchch6dq+DgJXRScVnhSzv9FbDWeUP7QrvzzkE2sj7c5IIox23CiexDBY35P
         q6EC1AY8WLHKMptrZnFeZYLW2ax28xXjDr31oyYErLr4Whgeo47fi9jlWvYl+EpGFU7k
         YkrAxW98hKX3xQfh6tp6KLRLioihYQj9RnMiwQz1UItsOl2nEm4JWZbjooaupZc1EWLG
         1lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DoIZZ1NTKy4Vr/t9RCJI3Po/KaMoN7vfri8esvxKoD4=;
        b=zd4BhiFiV75BKOTWnYTee+IzO2aVIvRP9v6qCsSpS7TRKy6Jko630ZrD7xN2JZlMQR
         7lCdozNuPDmcQwTaaavjd7hZbSDUa5b795h/Fb6Q8oneJy3meY3y3SNTxarcpsBdANaZ
         pIhFFcHODJI9V7RIvFffIj+trWqxMUzCBQMSbU9GJstePR9TxRNbHXMUh9MuJzgCi3RN
         IOKA1Hu21RYy8CITqmpVFFrYIDOLsd0vBtTmGxCaSBcD0BrW0bX3nspZuxELs5bYJMn9
         e4EVi/SctApvB2WyG6ZnFNqSPC5qnG/jOU53ZOgfjgzmqD7xucSLRQ6km6At8gt/nnYB
         EdrQ==
X-Gm-Message-State: AJIora+w1audyV90BsDGNy62w80ckcUzLeJs/jjyDhFtkm/xasCKD+43
        UDlmidHCWbJv5hlxR5T2DdY=
X-Google-Smtp-Source: AGRyM1tMtCZM/na5Zlkzt1FCoJ/jorGoHxo7DCEfL73cpnVS2Ejl7E66gpXYLOo7mKevuop/PG3jBg==
X-Received: by 2002:a05:6000:12c3:b0:21a:3795:70ac with SMTP id l3-20020a05600012c300b0021a379570acmr12455037wrx.175.1655573222361;
        Sat, 18 Jun 2022 10:27:02 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f781c.dip0.t-ipconnect.de. [91.63.120.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0039c4f53c4fdsm16882283wmq.45.2022.06.18.10.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 10:27:01 -0700 (PDT)
Message-ID: <fb16197e-d5a1-eec3-af6d-19b2f5a5779e@gmail.com>
Date:   Sat, 18 Jun 2022 19:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/6] iio: adc: mp2629: fix wrong comparison of channel
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-2-sravanhome@gmail.com>
 <20220618172301.44363feb@jic23-huawei>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20220618172301.44363feb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/06/22 18:23, Jonathan Cameron wrote:
Hello Jonathan,

> On Wed, 15 Jun 2022 16:53:52 +0200
> Saravanan Sekar <sravanhome@gmail.com> wrote:
> 
>> Input voltage channel enum is compared against iio address instead
>> of the channel.
>>
>> Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> So how do you want to handle this?  If I take it as a separate fix it will
> take a while to get upstream so that the later part of this series can be
> applied on top of it.
> 
> If the fix isn't super urgent, then perhaps we just queue it up with the
> rest of the series and Lee picks up through MFD?
> 

Thanks for the review. It is not urgent to integrate now, may wait for 
Lee to take along with the series.

> On basis we might go that way.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Also, this probably wants a stable tag.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/adc/mp2629_adc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
>> index aca084f1e78a..e7fbfe92e884 100644
>> --- a/drivers/iio/adc/mp2629_adc.c
>> +++ b/drivers/iio/adc/mp2629_adc.c
>> @@ -73,7 +73,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>>   		if (ret)
>>   			return ret;
>>   
>> -		if (chan->address == MP2629_INPUT_VOLT)
>> +		if (chan->channel == MP2629_INPUT_VOLT)
>>   			rval &= GENMASK(6, 0);
>>   		*val = rval;
>>   		return IIO_VAL_INT;
> 


Thanks,
Saravanan
