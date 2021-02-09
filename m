Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEED314AA3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 09:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBIIpq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 03:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBIIpG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 03:45:06 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7770C061788
        for <linux-iio@vger.kernel.org>; Tue,  9 Feb 2021 00:44:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id i8so29939449ejc.7
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2021 00:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LFiJFSMqDML6i34Le0xeGBj3MQlh5EPlWd1NXHji1Hg=;
        b=FRjINoJSc57/iT3BSNXK35G4cyQ8cmtBIoXNUGaKBtukVFLkV2RCD9qv+IpnQ56yMW
         lfEcOwxRDBiz39+vuqVZq65ad3hvPU3rfYfqsALqoblheiN6hFwOPBtxMyfyBCXXaTnU
         dzgS7jVxmQoIvwecUdev51Xy5iwnHiki2y47MBIucQ7yvmdf2Z3IH0Tvqty2l19AJLsL
         IJwVv49AYDDyfcd9zL9V7ZUJRqOmm2je5pAKZ+byK1k4FMG4gsCv53J/cy/iYggweRrK
         BoIp5weIseL4C7Gsn+WLOoMMLxZMiUCq7fOlJEO7MiLTbaKa/yg5SM2a5+fKRlS8nRg3
         MiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LFiJFSMqDML6i34Le0xeGBj3MQlh5EPlWd1NXHji1Hg=;
        b=knqmfFCoMoYVwei8+eO8J29bYoNoP5p8Sc/S1gIJvtr4QZmoBVkS4d4ebmkYkzZ9Er
         sl3/NWj28dcd8l5AlzgSuQwXteKaGCkqueCAkjYGU6ZfJ5j/UXnvm2Ji5hoxkQPFtlD6
         DZiEiU6qQwHSHxX+m9ri0z0T/jVDQNvkenM46jCL+eJ4/PklITfBma0r7xETDP3ABe7E
         YP/hlrAUdSYgbf/92BQwxe7Nt4tgmKWxFEdtxJI1NBeD3rYxNkZaZeowSShTdEKulnNZ
         1VMnGN+b41+pQWrVngD8eX5xz8SBTLtM5iTMr9X9mD2J3+Sk8zbHN/tQOkjlHLyQASWB
         PETQ==
X-Gm-Message-State: AOAM5329ov8vV+433Ajmbrjyv06oz7JADAd5wP4J6XRygrf6QJQu6iTc
        0rc1i5ylFzrXlJQoJO+P5Ovd9w==
X-Google-Smtp-Source: ABdhPJwF7haTbrg7WCY5VMnHd59iLnaihdheiYE33A2dbeRbdB+Md/U7/KpEhuiIvMWobBOpNUnpGQ==
X-Received: by 2002:a17:906:cf86:: with SMTP id um6mr21906822ejb.426.1612860264649;
        Tue, 09 Feb 2021 00:44:24 -0800 (PST)
Received: from ?IPv6:2a02:a03f:c936:a500:2016:2032:5a6c:22d3? ([2a02:a03f:c936:a500:2016:2032:5a6c:22d3])
        by smtp.gmail.com with ESMTPSA id y8sm10852865edd.97.2021.02.09.00.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 00:44:24 -0800 (PST)
Subject: Re: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect bit
 mask
To:     Wilfried Wessner <wilfried.wessner@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210208142705.GA51260@ubuntu>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <b856fe85-2187-88ed-81c8-740a79e4546a@essensium.com>
Date:   Tue, 9 Feb 2021 09:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208142705.GA51260@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-FR
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 08/02/2021 à 15:27, Wilfried Wessner a écrit :
> Fixes a wrong bit mask used for the ADC's result, which was caused by an
> improper usage of the GENMASK() macro. The bits higher than ADC's 
> resolution are undefined and if not masked out correctly, a wrong result 
> can be given. The GENMASK() macro indexing is zero based, so the mask has 
> to go from [resolution - 1 , 0].
>
> Fixes: 7f40e0614317f ("iio:adc:ad7949: Add AD7949 ADC driver family")
>
> Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
>
> ---
>
> The issue was found in combination of an AD7682 ADC with an ARM based 
> iMX7-CPU. The SPI line was analyzed with a logic analyzer and a 
> discrepancy between applied voltage level and the ADC reported value 
> in user space was observed. Digging into the driver code revealed an 
> improper mask used for the ADC-result.
>
>
>  drivers/iio/adc/ad7949.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 5d597e5050f6..1b4b3203e428 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	int ret;
>  	int i;
>  	int bits_per_word = ad7949_adc->resolution;
> -	int mask = GENMASK(ad7949_adc->resolution, 0);
> +	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
>  	struct spi_message msg;
>  	struct spi_transfer tx[] = {
>  		{

Hi,

Thank you for the fix. :)

Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>

Regards,

Charles-Antoine Couret

