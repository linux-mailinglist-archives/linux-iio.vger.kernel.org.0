Return-Path: <linux-iio+bounces-24527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB49BA6EE8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687A91894934
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4112DCBFB;
	Sun, 28 Sep 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqB1B6Wg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FD22FE02;
	Sun, 28 Sep 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054808; cv=none; b=VL9ft9GcE4gyISz0jFeSF3QnnriO5ZY1yLj6TR3DINT9Effqs9g20Y48IlbEYMQin4MQiIEoWLIZXvAZ/s1JWVBZePObpmOAkRIHsZreEswP5uvFXd8aD1EZ6b3SVlVzPtZuCxA7SbV1U5e+9tl9fzNhYlGyyoQ86PMx+V5bQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054808; c=relaxed/simple;
	bh=vK4ndFlqtxsvXqHg2ZJL3Yj6TDbkiLlo5PGDeaNd7Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETncszrjme8kqdosk7Mol+IEOBiiWwitnI9dBlTaH3SsZ2k2Ndy0F5zgi0qA/4/v8ut6umdHc8MnrAO3rXG/GULXj8iqSLzqxh5DkvB/YLhAPStsmIq7CWZs5EpMLpCIhOKVRIboKZMANPDU+naSJ4F9xamjyuVo/LVj/jLStFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqB1B6Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54776C4CEF0;
	Sun, 28 Sep 2025 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759054808;
	bh=vK4ndFlqtxsvXqHg2ZJL3Yj6TDbkiLlo5PGDeaNd7Wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IqB1B6WgwgNxNq5zfrH8TZI14/q9llUnEDWdkqibFMVkN80VKbWdIAgK9hJtQvGuR
	 9MDfM1eh7u/nMVg+/caE3eK0eruPjg6s2YmVY7ZRieq63YgnNaObn0xftjh/Pn67QX
	 jWl9RYTvfr406XOjo91P7CVhRer7d+GMVlUn+2+sIbglO1Wv4SMovlclmXfN9z4PPQ
	 4C51YqVju/VsgC0wqlg0BmYM7lqia0R9WDpAJeM2x3RR60gioJwOfHhgXvezCUVtd9
	 RAEBbfd57T4g3aSn2N3zeJKntjoDORIb3eRq113lh8846bMkD6K+VfIL1sGr3tsAlb
	 wfvLjfyaXBo6w==
Date: Sun, 28 Sep 2025 11:19:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <michael.hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20250928111955.175680cb@jic23-huawei>
In-Reply-To: <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
	<5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 17:40:47 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> and A1) that set one of four possible signal gain configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> - PGA gain now described in decibels.
> 
> The PGA gain is not going to fit well as a channel property because it may
> affect more than one channel as in AD7191.
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> 
> I consulted a very trustworthy source [1, 2] and learned that describing signal
> gains in decibels is a common practice. I now think it would be ideal to describe
> these PGA and PGA-like gains with properties in decibel units and this patch
> is an attempt of doing so. The only problem with this approach is that we end up
> with negative values when the gain is lower than 1 (the signal is attenuated)
> and device tree specification doesn't support signed integer types. As the
> docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
> Any chance of dt specification eventually support signed integers?
> Any suggestions appreciated.
> 
> [1] https://en.wikipedia.org/wiki/Decibel
> [2] https://en.wikipedia.org/wiki/Gain_(electronics)

I still wonder if the better way to describe this is to ignore that it
has anything to do with PGA as such and instead describe the pin strapping.

DT folk, is there an existing way to do that? My grep skills are failing to
spot one.

We've papered over this for a long time in various IIO drivers by controlling
directly what the pin strap controls with weird and wonderful device specific
bindings. I wonder if we can't have a gpio driver + binding that rejects all
config and just lets us check the current state of an output pin.  Kind of a
fixed mode regulator equivalent for gpios.

+CC Linus, Bartosz and gpio list.

> 
> Thanks,
> Marcelo
> 
>  .../bindings/iio/adc/adi,ad4030.yaml          | 84 +++++++++++++++++--
>  1 file changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 564b6f67a96e..20462fa6c39d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -19,6 +19,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -31,6 +33,8 @@ properties:
>        - adi,ad4630-24
>        - adi,ad4632-16
>        - adi,ad4632-24
> +      - adi,adaq4216
> +      - adi,adaq4224
>  
>    reg:
>      maxItems: 1
> @@ -54,6 +58,14 @@ properties:
>      description:
>        Internal buffered Reference. Used when ref-supply is not connected.
>  
> +  vddh-supply:
> +    description:
> +      PGIA Positive Power Supply.
> +
> +  vdd-fda-supply:
> +    description:
> +      FDA Positive Power Supply.
> +
>    cnv-gpios:
>      description:
>        The Convert Input (CNV). It initiates the sampling conversions.
> @@ -64,6 +76,26 @@ properties:
>        The Reset Input (/RST). Used for asynchronous device reset.
>      maxItems: 1
>  
> +  pga-gpios:
> +    description:
> +      A0 and A1 pins for gain selection. For devices that have PGA configuration
> +      input pins, pga-gpios should be defined if adi,gain-milli is absent.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,pga-gain-db:
> +    description: |
> +      Should be present if PGA control inputs are pin-strapped. The values
> +      specify the rounded decibel gain calculated from the voltage gain.
> +      Possible values:
> +      -10 (A1=0, A0=0), (1/3 V/V gain)
> +      -5 (A1=0, A0=1), (5/9 V/V gain)
> +      7 (A1=1, A0=0), (20/9 V/V gain)
> +      16 (A1=1, A0=1), (20/3 V/V gain)
> +      If defined, pga-gpios must be absent.
> +    enum: [-10, -5, 7, 16]
> +    default: -10
> +
>    pwms:
>      description: PWM signal connected to the CNV pin.
>      maxItems: 1
> @@ -86,11 +118,33 @@ required:
>    - vio-supply
>    - cnv-gpios
>  
> -oneOf:
> -  - required:
> -      - ref-supply
> -  - required:
> -      - refin-supply
> +allOf:
> +  - oneOf:
> +      - required:
> +          - ref-supply
> +      - required:
> +          - refin-supply
> +  # ADAQ devices require a gain property to indicate how hardware PGA is set
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: ^adi,adaq
> +    then:
> +      allOf:
> +        - required: [vddh-supply, vdd-fda-supply]
> +          properties:
> +            ref-supply: false
> +        - oneOf:
> +            - required:
> +                - adi,pga-value
> +            - required:
> +                - pga-gpios
> +    else:
> +      properties:
> +        adi,pga-value: false
> +        pga-gpios: false
> +
>  
>  unevaluatedProperties: false
>  
> @@ -114,3 +168,23 @@ examples:
>              reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,adaq4216";
> +            reg = <0>;
> +            spi-max-frequency = <80000000>;
> +            vdd-5v-supply = <&supply_5V>;
> +            vdd-1v8-supply = <&supply_1_8V>;
> +            vio-supply = <&supply_1_8V>;
> +            ref-supply = <&supply_5V>;
> +            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> +            adi,pga-gain-db = <-5>;
> +        };
> +    };
> +...


