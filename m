Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615DF3FFB74
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbhICIBQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 04:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348076AbhICIBJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 04:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630656007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InxKCwkaY+BSOwQRBiaO8xW0lNamfxvr6pOVA9nU0nQ=;
        b=QkyXCzTOlf3km0KSamF3vOkrQBloePaJmiH5hGsXDghVNG3CLjY0NXYuG7A7okxsxut9E4
        jWLe4oJYWVjDvg9cLoRQlmTjZ0zdsiBcLQi+QaStkwS7GwWEG7rrf3XKPrQyS6r9VmUYKK
        +bRez9rIJH+C3XJ61Jd2v8xLO/5d1fo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-rmG0jbwyN0KEFPahzCLyoQ-1; Fri, 03 Sep 2021 04:00:06 -0400
X-MC-Unique: rmG0jbwyN0KEFPahzCLyoQ-1
Received: by mail-ej1-f71.google.com with SMTP id jw25-20020a17090776b900b005ca775a2a00so2329308ejc.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 01:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=InxKCwkaY+BSOwQRBiaO8xW0lNamfxvr6pOVA9nU0nQ=;
        b=lLqKaXjxkVIpV3rN3PZMDwZOoWIi/+37BKaJUz/O1qU2tIc8PfVnjmJ5qAFFYyuU3h
         yUg9Q11rGz1OpT0PDpPgxES1fbSXMzFTDMwkO4005U08/sAUNSGFmSRshBzKl7zNwUHI
         CIdBzlVCkKxh5sIPQTUavzk0ClHcYz4gwKG4beJEpUqh5itItdlmEqk69ReuI3vztXNC
         oegROjf5LnI8z61pFlgFa4Tez6WBqD5/m8lKbfga1FAPMmDQt4CZBPYlzq4t39Mptf92
         rbn9SuNN6DutvBS02cxYvjlISR0hiWBnWqABo54VKEee/SB4W1OdhiBBmVmhuj6G18EN
         HekA==
X-Gm-Message-State: AOAM532kWB7i3oX7mhFD6FhmjMxnIlJq1tH4kjhF4YzXDQuIhFvJiujl
        RRRbJtuWbfIxrwgopaR9vIPr8b0xR4QVctVuEHWNPD24277/7e1cFLPNZru5gXWfSdGNT3BTlhi
        DIrbC5dCskL1kBjdcy7oN
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr2884987eju.254.1630656005554;
        Fri, 03 Sep 2021 01:00:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8fQU/ds5USfJd2Tckg+EXgt7GKbH1YbqcBJ6WAavCdiwLIBnSSmb8NLjjEqZaYwQzo4sQEQ==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr2884963eju.254.1630656005317;
        Fri, 03 Sep 2021 01:00:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r16sm2554300edt.15.2021.09.03.01.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 01:00:04 -0700 (PDT)
Subject: Re: [PATCH 3/5] iio: adc: axp288_adc: convert probe to full
 device-managed
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     jic23@kernel.org, wens@csie.org, andriy.shevchenko@linux.intel.com
References: <20210903072917.45769-1-aardelean@deviqon.com>
 <20210903072917.45769-4-aardelean@deviqon.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1e26dd27-475c-7815-9a9d-240546fa9088@redhat.com>
Date:   Fri, 3 Sep 2021 10:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210903072917.45769-4-aardelean@deviqon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 9/3/21 9:29 AM, Alexandru Ardelean wrote:
> This change converts the probe of this driver to use device-managed
> functions only, which means that the remove hook can be removed.
> The remove hook has only 2 calls to iio_device_unregister() and
> iio_map_array_unregister(). Both these can now be done via devm register
> functions, now that there's also a devm_iio_map_array_register() function.
> 
> The platform_set_drvdata() can also be removed now.
> 
> This change also removes the error print for when the iio_device_register()
> call fails. This isn't required now.
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/iio/adc/axp288_adc.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 5f5e8b39e4d2..a4b8be5b8f88 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -259,7 +259,7 @@ static int axp288_adc_probe(struct platform_device *pdev)
>  	info->irq = platform_get_irq(pdev, 0);
>  	if (info->irq < 0)
>  		return info->irq;
> -	platform_set_drvdata(pdev, indio_dev);
> +
>  	info->regmap = axp20x->regmap;
>  	/*
>  	 * Set ADC to enabled state at all time, including system suspend.
> @@ -276,31 +276,12 @@ static int axp288_adc_probe(struct platform_device *pdev)
>  	indio_dev->num_channels = ARRAY_SIZE(axp288_adc_channels);
>  	indio_dev->info = &axp288_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	ret = iio_map_array_register(indio_dev, axp288_adc_default_maps);
> +
> +	ret = devm_iio_map_array_register(&pdev->dev, indio_dev, axp288_adc_default_maps);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "unable to register iio device\n");
> -		goto err_array_unregister;
> -	}
> -	return 0;
> -
> -err_array_unregister:
> -	iio_map_array_unregister(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int axp288_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_map_array_unregister(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  
>  static const struct platform_device_id axp288_adc_id_table[] = {
> @@ -310,7 +291,6 @@ static const struct platform_device_id axp288_adc_id_table[] = {
>  
>  static struct platform_driver axp288_adc_driver = {
>  	.probe = axp288_adc_probe,
> -	.remove = axp288_adc_remove,
>  	.id_table = axp288_adc_id_table,
>  	.driver = {
>  		.name = "axp288_adc",
> 

