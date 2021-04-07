Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2C35694B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhDGKTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 06:19:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2781 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhDGKTu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 06:19:50 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFgHD3pH2z687Zx;
        Wed,  7 Apr 2021 18:14:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:19:38 +0200
Received: from localhost (10.47.92.157) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 11:19:37 +0100
Date:   Wed, 7 Apr 2021 11:18:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jean Delvare" <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 07/19] dt-bindings: fix references for
 iio-bindings.txt
Message-ID: <20210407111814.000046a8@Huawei.com>
In-Reply-To: <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
        <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.157]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Apr 2021 10:20:46 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

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

Given the spread of this one across various other binding docs, perhaps this is one
for Rob to pick up?

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt   | 2 +-
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

