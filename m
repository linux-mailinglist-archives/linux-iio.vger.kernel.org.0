Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C71356BE5
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352073AbhDGMPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhDGMPe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 08:15:34 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86621C061756;
        Wed,  7 Apr 2021 05:15:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m13so18500808oiw.13;
        Wed, 07 Apr 2021 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X46wYGgERGWtFUFMoQTCYrTkwk/QDw/vSdYLKa9FS1g=;
        b=p11ZjmbHqdldMKTtphZYW0A6SLeVRnWzYgza6U9UehEhcLpa7n+XlU0peLdUTZiEWB
         PBAzFhIRYMEWxFOLHBE8wTVIff1J2bHUT8e85s2oZL9rtmZQdmMgy3b7TysEhGWwHK2q
         ZUzcWKq4j0Fpw+EgIvcUYKgrTePsJZ3mrRmmyP9cEmw8p2eAw7Y1L/xiu8FH6kBMI+8O
         88PudxLBx/2jE559SmKmKPyHcFEMc4dbHjA+/FnMbzSzXsS5zO7gfLR671s5DeslIPMx
         dST1XDN6bo7ygDWc0i0p0dWjSXCydEtuoS0ikZwqTQ8PoME/RgHErEa78Xqwh3fVDT2x
         CXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X46wYGgERGWtFUFMoQTCYrTkwk/QDw/vSdYLKa9FS1g=;
        b=iok2bwLlweuyU0D7Q2csHkHBMcZpgK2LB+lI8hBU/1xeEFpxi6IL+MgPIyIjDfKDX+
         Xb8x4g+thlV+whoT/k45+nI0ZkcSb6swckS3Xrahq9ah3GP7M/yRLHJWXH5rLKivrC52
         UsFdLx9Q4mi1Wibv5VhWk+JT/rmBcRDWWeg7HB0p1D0KAlGD83XHDBcHLvQaN2lYP9lp
         yYISGSlA88VafiHUwmbQlvKF+GX1OhYv6Pz+NJjcTDkjphalL9cTwNCiX3OHwXbADhbY
         S7Gi7ft04YEmaE6n1duQErKc7TT+7vUIFa/CugZ5rwSqdEeTY84Au9LkomsGC96NlpDr
         Q5Zg==
X-Gm-Message-State: AOAM5302xWH+OsW8kOH7BukTEJ68KVB8ayZoR+jtCBj7FO+xHSFH0ePj
        Wvp2CtZKu5tR8vs9lU9q9SdfHvDYsx4=
X-Google-Smtp-Source: ABdhPJyM7woO7fL7ogf7HacLA8rrZFOXScexRkYOvjb0KhXvYs9PYut3VFWrj8xFe2pfuye1s4S7rA==
X-Received: by 2002:aca:37c3:: with SMTP id e186mr2043392oia.111.1617797723677;
        Wed, 07 Apr 2021 05:15:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i4sm4175868oik.21.2021.04.07.05.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 05:15:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 07/19] dt-bindings: fix references for iio-bindings.txt
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
 <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ad7e53b8-3d43-13d9-1f3e-5393201c1740@roeck-us.net>
Date:   Wed, 7 Apr 2021 05:15:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/7/21 1:20 AM, Mauro Carvalho Chehab wrote:
> The iio-bindings.txt was converted into two files and merged
> at the dt-schema git tree at:
> 
> 	https://github.com/devicetree-org/dt-schema
> 
> Yet, some documents still refer to the old file. Fix their
> references, in order to point to the right URL.
> 
> Fixes: dba91f82d580 ("dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt   | 2 +-

Acked-by: Guenter Roeck <linux@roeck-us.net>

>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml   | 5 +++--
>  Documentation/devicetree/bindings/input/adc-joystick.yaml    | 4 +++-
>  .../bindings/input/touchscreen/resistive-adc-touch.txt       | 5 ++++-
>  Documentation/devicetree/bindings/mfd/ab8500.txt             | 4 +++-
>  .../devicetree/bindings/power/supply/da9150-charger.txt      | 2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
> index 37f18d684f6a..4c5c3712970e 100644
> --- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
> @@ -32,7 +32,7 @@ Optional node properties:
>  - "#thermal-sensor-cells" Used to expose itself to thermal fw.
>  
>  Read more about iio bindings at
> -	Documentation/devicetree/bindings/iio/iio-bindings.txt
> +	https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/
>  
>  Example:
>  	ncp15wb473@0 {
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> index 9f414dbdae86..433a3fb55a2e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> @@ -14,8 +14,9 @@ description: >
>    Industrial I/O subsystem bindings for ADC controller found in
>    Ingenic JZ47xx SoCs.
>  
> -  ADC clients must use the format described in iio-bindings.txt, giving
> -  a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> +  ADC clients must use the format described in
> +  https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml,
> +  giving a phandle and IIO specifier pair ("io-channels") to the ADC controller.
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> index 054406bbd22b..721878d5b7af 100644
> --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -24,7 +24,9 @@ properties:
>      description: >
>        List of phandle and IIO specifier pairs.
>        Each pair defines one ADC channel to which a joystick axis is connected.
> -      See Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
> +      See
> +      https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
> +      for details.
>  
>    '#address-cells':
>      const: 1
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
> index fee0da12474e..af5223bb5bdd 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
> @@ -5,7 +5,10 @@ Required properties:
>   - compatible: must be "resistive-adc-touch"
>  The device must be connected to an ADC device that provides channels for
>  position measurement and optional pressure.
> -Refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details
> +Refer to
> +https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
> +for details
> +
>   - iio-channels: must have at least two channels connected to an ADC device.
>  These should correspond to the channels exposed by the ADC device and should
>  have the right index as the ADC device registers them. These channels
> diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
> index d2a6e835c257..937b3e5505e0 100644
> --- a/Documentation/devicetree/bindings/mfd/ab8500.txt
> +++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
> @@ -72,7 +72,9 @@ Required child device properties:
>                                                 pwm|regulator|rtc|sysctrl|usb]";
>  
>    A few child devices require ADC channels from the GPADC node. Those follow the
> -  standard bindings from iio/iio-bindings.txt and iio/adc/adc.txt
> +  standard bindings from
> +  https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
> +  and Documentation/devicetree/bindings/iio/adc/adc.yaml
>  
>    abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
>  			   temperatures.
> diff --git a/Documentation/devicetree/bindings/power/supply/da9150-charger.txt b/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
> index f3906663c454..033a9b6e1dd5 100644
> --- a/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
> @@ -7,7 +7,7 @@ Optional properties:
>  - io-channels: List of phandle and IIO specifier pairs
>  - io-channel-names: List of channel names used by charger
>        ["CHAN_IBUS", "CHAN_VBUS", "CHAN_TJUNC", "CHAN_VBAT"]
> -  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
> +  (See https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml for further info)
>  
>  
>  Example:
> 

