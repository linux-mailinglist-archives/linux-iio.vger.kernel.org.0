Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A461E2D6EB2
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 04:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405255AbgLKDfE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 22:35:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34239 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405250AbgLKDe4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 22:34:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id s75so8388209oih.1;
        Thu, 10 Dec 2020 19:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5X4INTOHYkiv4qJceNlizwSZ2F4yaORFWqNAvCdXmig=;
        b=X0WGyrPTDte7nV+MMAEUhedlrDFhd90oxs3xkAy4/Q0RhtwVF3aFec8d4iDGqPlma0
         5a72IBHx7iN9MKsyxhCuV0Gm6AFCWxmEqo5RCIv6BsV0LJz510tIfSmzXCJdpW/WIrf0
         +Uq6GcZ3Jhn6rqEUjd5nJpymGYfmzU6M66Sx81RpyXGVyjA+euOd1K+1H6e8/7JJYeVk
         T4J7btwupHUV7opJvcv3v2f/I9euetEGBnmuUFENDn2SSfZWOOmsERJhxYEFOkOC/Zpl
         eIh2MxWefs8oRCvT2WibYJ9D0p+lnNClCcd3kyZz7guvvk0DBwjgqqs9hA69NfzpWJsx
         1fog==
X-Gm-Message-State: AOAM533H/JjKkjjfvw5fLDkB9TUna40u2VJlIvwgPX24J/wUaWHMB/Wl
        0S5WzwytR8vMBQanClIkSQ==
X-Google-Smtp-Source: ABdhPJx3Vfhhuz3O0orNqKdlqcTcD08QNbyPLmKrJ/Gw+Puo6Ap+WJIrHuJ01GXCsDNGsXvhVmzL+g==
X-Received: by 2002:aca:6087:: with SMTP id u129mr8031458oib.173.1607657655459;
        Thu, 10 Dec 2020 19:34:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s9sm1577098otb.6.2020.12.10.19.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:34:14 -0800 (PST)
Received: (nullmailer pid 3585740 invoked by uid 1000);
        Fri, 11 Dec 2020 03:34:13 -0000
Date:   Thu, 10 Dec 2020 21:34:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio:pressure:ms5637: add ms5803 support
Message-ID: <20201211033413.GA3584721@robh.at.kernel.org>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
 <20201209234857.1521453-7-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209234857.1521453-7-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 10, 2020 at 12:48:57AM +0100, Alexandre Belloni wrote:
> The ms5803 is very similar to the ms5805 but has less resolution options
> and has the 128bit PROM layout.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  drivers/iio/pressure/ms5637.c                          | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ab623ba930d5..84b0e44235c1 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -132,6 +132,8 @@ properties:
>            - mcube,mc3230
>              # MEMSIC 2-axis 8-bit digital accelerometer
>            - memsic,mxc6225
> +            # Measurement Specialities I2C pressure and temperature sensor
> +          - meas,ms5803

Alphabetical order please.

>              # Microchip differential I2C ADC, 1 Channel, 18 bit
>            - microchip,mcp3421
>              # Microchip differential I2C ADC, 2 Channel, 18 bit
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 2943b88734b3..39830a51ca78 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -192,8 +192,15 @@ static const struct ms_tp_hw_data ms5637_hw_data  = {
>  	.max_res_index = 5
>  };
>  
> +static const struct ms_tp_hw_data ms5803_hw_data  = {
> +	.prom_len = 8,
> +	.max_res_index = 4
> +};
> +
>  static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
>  
> +static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
> +
>  static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
>  
>  static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
> @@ -205,6 +212,7 @@ static const struct ms_tp_data ms8607_data = {
>  
>  static const struct of_device_id ms5637_of_match[] = {
>  	{ .compatible = "meas,ms5637", .data = &ms5637_data },
> +	{ .compatible = "meas,ms5803", .data = &ms5803_data },
>  	{ .compatible = "meas,ms5805", .data = &ms5805_data },
>  	{ .compatible = "meas,ms5837", .data = &ms5837_data },
>  	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
> -- 
> 2.28.0
> 
