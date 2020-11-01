Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFA2A1F02
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgKAPZU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgKAPZT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 10:25:19 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B9C061A04
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 07:25:18 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b19so5533842pld.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VH0HcOD/HyLyz679Sr10V4mcuoyEyaQ8h18ysS24SLs=;
        b=re48gDOk5jKRnsXWbhNhyZQW4O6hluxEJhPdN0FIP50xBtQJiW53FaL3GY1vgyVN2n
         Ct6DXIUaQt+KOeAqerft1ZgyZSuujuntAAco22oKPYvD+AoPltaHoLyXyRl8I6Y03sJR
         9qbdYcPYvjkBpjo2hWPjnFlIW7Gd7MsWReM8apEVnHgUB2IUjGgNN+SYIqoELl2/wsZL
         JL/kPmbTDl9XToW4C6KRS8WQvwaGDJHrBNaTSCQ4smjbSiDltXr1ivcNnTVSX00VLnq5
         QG0Bd/c9HhtQ+m50YIlIXmnufHd6MwoD6+y3GCMe1QadwaTJPZKJ5f1IS2ZXxrpJfzcN
         nEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VH0HcOD/HyLyz679Sr10V4mcuoyEyaQ8h18ysS24SLs=;
        b=ozEa9T1fW1Ziv5GDMP0/z4Rc414XMKzkEmnoqZeHLTz39SaJtIhLg/dml2jHij1nnW
         YHK2k/HfwQgbglQCT6WN2Z5QzK4zkzbTMaFa3+RDGwJWsxAgD1GpGGPTR8XXthIQRpVG
         TO3ZmAxcXv6VnVtVCbJcDh5uGyMlQLsu3UKTV+pAkY19WfWYw45JW1qhMXxGKYzbpBoR
         +902AbNOQch/WuCJdiQ5tpLMfwxf//4HIfD1VoItTPQTkqcKMj+scH8rJ7k67QpNEzvJ
         nHsYyCpVGnqzdGSsmB9bV4ttcFxuBNCCUZ0Ncz0APHBP2BGJZhoFiG0kxMG9gMO9rujj
         OBpg==
X-Gm-Message-State: AOAM533oN65Iq+iSo7kEI5wCvbqM9rZonVagQn1jbG52EutPY/3SCYCr
        kdkhw7kPPcvRbcLXb8Soqwug
X-Google-Smtp-Source: ABdhPJzGAMaXCqDXrYk3berOf7kOwD0JRrmQfvgYGkXomNu1w6He22hZnIOgMUtVVX1ZQsElRWM+CQ==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr1861466pju.99.1604244317812;
        Sun, 01 Nov 2020 07:25:17 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6d8d:be1b:b0c0:14ff:1364:f14c])
        by smtp.gmail.com with ESMTPSA id q16sm978745pff.114.2020.11.01.07.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Nov 2020 07:25:16 -0800 (PST)
Date:   Sun, 1 Nov 2020 20:55:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 26/29] dt-bindings:iio:temperature:meas,tsys01 move to
 trivial-devices.yaml
Message-ID: <20201101152509.GA5384@Mani-XPS-13-9360>
References: <20201031134110.724233-1-jic23@kernel.org>
 <20201031134110.724233-27-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031134110.724233-27-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 01:41:07PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The existing binding description brings little value and the similar
> meas,* parts are in trivial-devices.yaml so move this one there
> to join them.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/iio/temperature/tsys01.txt       | 19 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  2 ++
>  2 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt b/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
> deleted file mode 100644
> index 0d5cc5595d0c..000000000000
> --- a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -* TSYS01 - Measurement Specialties temperature sensor
> -
> -Required properties:
> -
> -	- compatible: should be "meas,tsys01"
> -	- reg: I2C address of the sensor (changeable via CSB pin)
> -
> -		------------------------
> -		| CSB | Device Address |
> -		------------------------
> -		   1         0x76
> -		   0	     0x77
> -
> -Example:
> -
> -tsys01@76 {
> -	compatible = "meas,tsys01";
> -	reg = <0x76>;
> -};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 8d8eadbab473..cb4fd8f29675 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -144,6 +144,8 @@ properties:
>            - meas,ms8607-humidity
>              # Measurement Specialities temp and pressure part of ms8607 device
>            - meas,ms8607-temppressure
> +            # Measurement Specialties temperature sensor
> +          - meas,tsys01
>              # Microchip differential I2C ADC, 1 Channel, 18 bit
>            - microchip,mcp3421
>              # Microchip differential I2C ADC, 2 Channel, 18 bit
> -- 
> 2.28.0
> 
