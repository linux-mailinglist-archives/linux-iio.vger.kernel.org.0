Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869D07B9EF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGaGtC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 02:49:02 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:39773 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfGaGtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 02:49:02 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 02:49:01 EDT
Received: (qmail 11222 invoked by uid 5089); 31 Jul 2019 06:42:20 -0000
Received: by simscan 1.2.0 ppid: 11129, pid: 11130, t: 0.0583s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 31 Jul 2019 06:42:20 -0000
Subject: Re: [PATCH v6 19/57] iio: Remove dev_err() usage after
 platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-20-swboyd@chromium.org>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <f28e8440-a57d-e269-f3a8-5bf5b9fcd41f@electromag.com.au>
Date:   Wed, 31 Jul 2019 14:42:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730181557.90391-20-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

G'day Stephen,

A comment unrelated to your change.

On 31/07/2019 02:15, Stephen Boyd wrote:
....

> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 32f1c4a33b20..abe99856c823 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1179,10 +1179,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>   	idev->info = &at91_adc_info;
>   
>   	st->irq = platform_get_irq(pdev, 0);
> -	if (st->irq < 0) {
> -		dev_err(&pdev->dev, "No IRQ ID is designated\n");
> +	if (st->irq < 0)
>   		return -ENODEV;
Should this be returning st->irq instead of -ENODEV?
eg: platform_get_irq can return -EPROBE_DEFER

Pattern is repeated in a number of other places.


> -	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
Regards
Phil Reid

