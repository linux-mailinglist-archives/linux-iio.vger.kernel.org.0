Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF836592
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2019 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFEUgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 16:36:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44860 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUgD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 16:36:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id w187so67358qkb.11;
        Wed, 05 Jun 2019 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CAnC+wdfkUeaurm1Ol5XgkbBFWcJSDA54dS6qStgNNo=;
        b=Kez/1+upBfuCN4OBJvZLZoxpT9cEZQmdWuw9GCVS/t4GCB91yKTRfAEHId3fOLhfpc
         bzfXqY6HOmkhUbgn9I8CV2/bzslaEw8APrDoMP7icqH/Z3zO4Mug+OYHF4/NXl98X0Ib
         o8oMy4wSDLJe9ZF24yUqipi3sJ3taIlag84pEoWNbYBYAxn1wpaAA0vmXj2W9prrqrhC
         3xkX9wF9bUoYEefySX/ltmh2bRGxedR+F6g8AgGs+oQFajKfpHiUCli0KHWKNKUX7OQw
         xaXfIA71YJJjlTHnac0hNw1GwtUk+9iIgpp6EQgjOHgfP9b1gNPMolmrditB0pSWiPK5
         ZBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CAnC+wdfkUeaurm1Ol5XgkbBFWcJSDA54dS6qStgNNo=;
        b=Ehwn7QZD/vzO8Os3DVdiu5Z4hNwuWmMlYdnKrAW8LYMP5ODYxo+/HkVoCppiAql5TI
         soJlw9XFjiQ+fPoU/Qeba2HM5nJVqIT9sNmUPGL8pH5wNgKrUo7czxUPQnJhi7HWiBJ3
         oHiDxoY2wUr/AWc79gpA6ZQITGsHLYNU+1pkY6F8jmbMHdoZ21qbirQgfwkjnJOhIUGc
         sRwYc/m1MhDiZGXBpT6ILoOXcbsVWfobMVIvsu/oRuIQlwqC+dM+ksNQDoE6ysQ9Nb6E
         AOY9p8GWmjIJumTh+acKf7Tvq5/y0JXKVr6V4AsLjJUWx/l2aO7/eJUCIIW/CJAUBnA6
         Va0A==
X-Gm-Message-State: APjAAAV64ttGHSeNkTwzihok2rbOTplyozombYpWnudzgL4wHEKsRV6C
        DuOfaMyQuL5MrQtnCeQCsDM=
X-Google-Smtp-Source: APXvYqx9wAT2rnwnZPKWjF3Cc6LRy7IPHIbFjqhvs138P6JEtql0S+NdiL//EvkPyh82nNPbkt3S0w==
X-Received: by 2002:a37:9ece:: with SMTP id h197mr16112882qke.50.1559766961826;
        Wed, 05 Jun 2019 13:36:01 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n10sm6932589qtp.81.2019.06.05.13.35.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:36:01 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Wed, 5 Jun 2019 17:35:56 -0300
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Message-ID: <20190605203554.podktlonhp527iqq@renatolg>
References: <cover.1558746978.git.renatogeh@gmail.com>
 <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
 <20190526173911.57ae3d11@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190526173911.57ae3d11@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/26, Jonathan Cameron wrote:
>On Fri, 24 May 2019 22:26:30 -0300
>Renato Lui Geh <renatogeh@gmail.com> wrote:
>
>> This patch adds a YAML binding for the Analog Devices AD7780/1 and
>> AD7170/1 analog-to-digital converters.
>>
>> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
>Looks good to me, but I'm still finding my feet with these so will
>leave it for a few days for others to have time to comment.
>
>Michael, looking for a quick reply from you to say if you are happy
>being explicitly listed as maintainer for this one, or if you'd
>rather land it on someone else.  Same applies for patch 2.
>
>Renato, if I seem to have forgotten this in a week or so, feel
>free to give me a poke. I've been known to loose patches entirely!

Hi Jonathan,

Just here to give you a poke. :)

By the way, in these cases, which would be easier for you? To send you
an email like I'm doing right now on last week's thread; or to resend
the entire patch(set)?

Thanks,
Renato
>
>Thanks,
>
>Jonathan
>> ---
>> Changes in v2:
>>  - vref-supply to avdd-supply
>>  - remove avdd-supply from required list
>>  - include adc block in an spi block
>>
>>  .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
>>  .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
>>  2 files changed, 87 insertions(+), 48 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
>> deleted file mode 100644
>> index 440e52555349..000000000000
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
>> +++ /dev/null
>> @@ -1,48 +0,0 @@
>> -* Analog Devices AD7170/AD7171/AD7780/AD7781
>> -
>> -Data sheets:
>> -
>> -- AD7170:
>> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
>> -- AD7171:
>> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
>> -- AD7780:
>> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
>> -- AD7781:
>> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
>> -
>> -Required properties:
>> -
>> -- compatible: should be one of
>> -	* "adi,ad7170"
>> -	* "adi,ad7171"
>> -	* "adi,ad7780"
>> -	* "adi,ad7781"
>> -- reg: spi chip select number for the device
>> -- vref-supply: the regulator supply for the ADC reference voltage
>> -
>> -Optional properties:
>> -
>> -- powerdown-gpios:  must be the device tree identifier of the PDRST pin. If
>> -		    specified, it will be asserted during driver probe. As the
>> -		    line is active high, it should be marked GPIO_ACTIVE_HIGH.
>> -- adi,gain-gpios:   must be the device tree identifier of the GAIN pin. Only for
>> -		    the ad778x chips. If specified, it will be asserted during
>> -		    driver probe. As the line is active low, it should be marked
>> -		    GPIO_ACTIVE_LOW.
>> -- adi,filter-gpios: must be the device tree identifier of the FILTER pin. Only
>> -		    for the ad778x chips. If specified, it will be asserted
>> -		    during driver probe. As the line is active low, it should be
>> -		    marked GPIO_ACTIVE_LOW.
>> -
>> -Example:
>> -
>> -adc@0 {
>> -	compatible =  "adi,ad7780";
>> -	reg =	      <0>;
>> -	vref-supply = <&vdd_supply>
>> -
>> -	powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
>> -	adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
>> -	adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>> new file mode 100644
>> index 000000000000..d1109416963c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices AD7170/AD7171/AD7780/AD7781 analog to digital converters
>> +
>> +maintainers:
>> +  - Michael Hennerich <michael.hennerich@analog.com>
>> +
>> +description: |
>> +  The ad7780 is a sigma-delta analog to digital converter. This driver provides
>> +  reading voltage values and status bits from both the ad778x and ad717x series.
>> +  Its interface also allows writing on the FILTER and GAIN GPIO pins on the
>> +  ad778x.
>> +
>> +  Specifications on the converters can be found at:
>> +    AD7170:
>> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
>> +    AD7171:
>> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
>> +    AD7780:
>> +      https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
>> +    AD7781:
>> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,ad7170
>> +      - adi,ad7171
>> +      - adi,ad7780
>> +      - adi,ad7781
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  avdd-supply:
>> +    description:
>> +      The regulator supply for the ADC reference voltage.
>> +    maxItems: 1
>> +
>> +  powerdown-gpios:
>> +    description:
>> +      Must be the device tree identifier of the PDRST pin. If
>> +      specified, it will be asserted during driver probe. As the
>> +      line is active high, it should be marked GPIO_ACTIVE_HIGH.
>> +    maxItems: 1
>> +
>> +  adi,gain-gpios:
>> +    description:
>> +      Must be the device tree identifier of the GAIN pin. Only for
>> +      the ad778x chips. If specified, it will be asserted during
>> +      driver probe. As the line is active low, it should be marked
>> +      GPIO_ACTIVE_LOW.
>> +    maxItems: 1
>> +
>> +  adi,filter-gpios:
>> +    description:
>> +      Must be the device tree identifier of the FILTER pin. Only
>> +      for the ad778x chips. If specified, it will be asserted
>> +      during driver probe. As the line is active low, it should be
>> +      marked GPIO_ACTIVE_LOW.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    spi0 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@0 {
>> +            compatible = "adi,ad7780";
>> +            reg = <0>;
>> +
>> +            avdd-supply      = <&vdd_supply>;
>> +            powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
>> +            adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
>> +            adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
>> +        };
>> +    };
>
