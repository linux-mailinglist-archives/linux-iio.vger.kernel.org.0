Return-Path: <linux-iio+bounces-13622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00929F6F07
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF617A4075
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BC1FC0E9;
	Wed, 18 Dec 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M4hOlcKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE66F50F
	for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554782; cv=none; b=NPfI2KAiVrnHbIl39CxHfix2VYH9VEZqfVOP7LY1ZlfMrU9Kx4RuxpQbEvn7q9ZSjN+tqiHSVNlT145AmcMvPErfhxM7F4R4Vv4iNmrql02JDNKxUFwWAXhevwOzdRYkqLhfj/VvC+Nx/zaOPsMcgAEHjgN5P2Otsmo//rUCl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554782; c=relaxed/simple;
	bh=3GRuOQXhLX5wzyCu0HOlmCijKnb+i4WtZXoK7vxMpO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsgPaeUPJtL4i5LSCntlJbr0p4n7FH6nW20AKZaOdMuDQIbB1RIlIkvslOnxrnygjO/SVnhEsE+VAXB3+bWn+0X5u0y6FMXIVZwsYKot4dEv36utx9OYtUIKAWgEJkAeAxLE+oxWguAs93Uc6BArxnXKn4fgV6jwFjC2AP+e3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M4hOlcKN; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27d0e994ae3so5169fac.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734554777; x=1735159577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKAvhMFQ20/EBQvmaQoGUPn3HJy1rkTqe1t15xH4pDA=;
        b=M4hOlcKN6xl4X/NnatPpozTOxElOm5uSO6+3pTQ98TrAZxzn85Jc4ZkBBDNq1tizm8
         Fj2kUqKDSE/FV6e8zj6DYVzHJ6qrUQVOQ/6/IR6Vux3RCuQ7Dv8if1GAhV5jH98y//CS
         AICUDqBQiJev3j0mpAdtQUueb/a1FZX66zk6Li6kWD1iV2UqpraMg8DxUXwCwlOjllKm
         ZCgeFA3DeRaiocdh7mH0CYq6qQbMU26a3M8j/ciHme5uLj0r1rART/437uIZ4t+LK+p5
         OyoUrnYOz7L9VxTRGprUafbabiOyyfnfGq9KtTHKgutKdmdrPY5fbRXA5IAbW3mQUGpb
         9JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734554777; x=1735159577;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKAvhMFQ20/EBQvmaQoGUPn3HJy1rkTqe1t15xH4pDA=;
        b=icZSf0hI/JtM+gQ4JDjvp8vMG1q0u0oXr6qgrYday9G6y0RvkHvfczQxuoZ9dyyp/b
         y2SknmpTHJMwunFDCKOFVJ+rAASMpdjth59UN6HgBq+6jao9Wj0rVwQNQ+Yc+lIq6+xC
         7fy6SeepZim7CKAF3qYau2hOuiuia+XiY2WEoGVK4oBYnUJ4TlH/bm8Pe7es2tLCMhvJ
         nxj2BaBiyN5E8yB1g++qWJl1ThLf2viM8oy/T2o13wzaohKZ5+dNZdw0136OSBC/I/YU
         a4e1KPal8CdhTz8d574gUfb7e598cotvgbAxlm01XskS1MoAnD59xdkdH3LdGbV1acT/
         VhVA==
X-Forwarded-Encrypted: i=1; AJvYcCUG2Ef5IBun5AafrQInyTYjjAnGqvzjCvyypGoEneDH32wj0m+BXt9pEcsUNA4g7+HtEjZm8aG66/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XK/zHSklz7qHg6UNPA55oE6LN9E163dMpqHeCv1jyyUciccR
	a0c72JGtin/c/RUlDGKP3fzXev1ZXvWBZyx5pDxY2sl+Lo3TVPoPGVaKNBl5EkU=
X-Gm-Gg: ASbGnctopiFSS8QUXn+wq3XvS0RzWEa43L8yX0OXPcfMk0ObLKIUAUZn4PZxt7DxP/i
	Y6qq2SC/scIg1gu+tEwO9BEOIOpcCOs0bG3mlIqEXfrUBClmwGkIbiEjGKEoYk3dTbK7maqoJsV
	xlJTO4uOyFqR1utyp95tka0iXNS6jq8wfQnx76nZkIbetE2ON9VKWhGPUXW1pnlzGfoCqpujVyk
	IKXEyhtTX7+Y35GuzcrNX392w/Xvsh/jETbFHVkfv3xeNlJHiT0gluoteq61AK1R/iNiddPiQ1n
	vSfyErGCo/RpBbsXuA==
X-Google-Smtp-Source: AGHT+IELjcbzDbytKYdhZ46b3/I+pNOvZsESIGOu25HQIeZSDtQpRPztNVLOGe9VAKSV7WHqKjC8BQ==
X-Received: by 2002:a05:6871:7246:b0:29e:362b:2148 with SMTP id 586e51a60fabf-2a7d0841a78mr559204fac.19.1734554777195;
        Wed, 18 Dec 2024 12:46:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2645500sm3691594fac.20.2024.12.18.12.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 12:46:15 -0800 (PST)
Message-ID: <a2e76ca6-ec21-4ce5-91f7-4d3a0ed792ce@baylibre.com>
Date: Wed, 18 Dec 2024 14:46:14 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] Documentation: iio: Add ADC documentation
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ana-maria.cusco@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
 <48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/24 8:38 AM, Marcelo Schmitt wrote:
> ADCs can have different input configurations such that developers can get
> confused when trying to model some of them into IIO channels.
> 
> For example, some differential ADCs can have their channels configured as
> pseudo-differential channels. In that configuration, only one input
> connects to the signal of interest as opposed to using two inputs of a
> differential input configuration. Datasheets sometimes also refer to
> pseudo-differential inputs as single-ended inputs even though they have
> distinct physical configuration and measurement procedure. There has been
> some previous discussion in the mailing list about pseudo-differential and
> single-ended channels [1].
> 
> Documenting the many possible ADC channel configurations should provide two
> benefits:
> A) Consolidate the knowledge from [2] and from [1], and hopefully reduce
> the reviewing time of forthcoming ADC drivers.
> B) Help Linux developers figure out quicker how to better support
> differential ADCs, specially those that can have channels configured as
> pseudo-differential inputs.
> 
> Add documentation about common ADC characteristics and IIO support for them.
> 
> [1]: https://lore.kernel.org/linux-iio/0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.com/
> [2]: https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

This is really nice to have!

>  Documentation/iio/iio_adc.rst | 280 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 281 insertions(+)
>  create mode 100644 Documentation/iio/iio_adc.rst
> 
> diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.rst
> new file mode 100644
> index 000000000000..43b8cad547c9
> --- /dev/null
> +++ b/Documentation/iio/iio_adc.rst
> @@ -0,0 +1,280 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +IIO Abstractions for ADCs
> +=========================
> +
> +1. Overview
> +===========
> +
> +The IIO subsystem supports many Analog to Digital Converters (ADCs). Some ADCs
> +have features and characteristics that are supported in specific ways by IIO
> +device drivers. This documentation describes common ADC features and explains
> +how they are (should be?) supported by the IIO subsystem.
> +
> +1. ADC Channel Types
> +====================
> +
> +ADCs can have distinct types of inputs, each of them measuring analog voltages
> +in a slightly different way. An ADC digitizes the analog input voltage over a
> +span given by the provided voltage reference, the input type, and the input
> +polarity. The input range allowed to an ADC channel is needed to determine the
> +scale factor and offset needed to obtain the measured value in real-world
> +units (millivolts for voltage measurement, milliamps for current measurement,
> +etc.).
> +
> +There are three types of ADC inputs (single-ended, differential,
                  ^
                  | general

> +pseudo-differential) and two possible polarities (unipolar, bipolar). The input
> +type (single-ended, differential, pseudo-differential) is one channel
> +characteristic, and is completely independent of the polarity (unipolar,
> +bipolar) aspect. A comprehensive article about ADC input types (on which this
> +doc is heavily based on) can be found at
> +https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
> +
> +1.1 Single-ended channels
> +-------------------------
> +
> +Single-ended channels digitize the analog input voltage relative to ground and
> +can be either unipolar or bipolar.
> +
> +1.1.1 Single-ended Unipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +  ---------- VREF -------------
> +      ´ `           ´ `                  _____________
> +    /     \       /     \               /             |
> +   /       \     /       \         --- <  IN    ADC   |
> +            \   /         \   /         \             |
> +             `-´           `-´           \       VREF |
> +  -------- GND (0V) -----------           +-----------+
> +                                                  ^
> +                                                  |
> +                                             External VREF
> +
> +The input voltage to a **single-ended unipolar** channel is allowed to swing
> +from GND to VREF (where VREF is a voltage reference with electrical potential
> +higher than system ground). The maximum input voltage is also called VFS
> +(full-scale input voltage), with VFS being determined by VREF. The voltage
> +reference may be provided from an external supply or derived from the chip power
> +source.
> +
> +A single-ended unipolar channel could be described in device tree like the
> +following example::
> +
> +    adc@0 {
> +        ...
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +            reg = <0>;
> +        };
> +    };
> +
> +See ``Documentation/devicetree/bindings/iio/adc/adc.yaml`` for the complete
> +documentation of ADC specific device tree properties.
> +
> +
> +1.1.2 Single-ended Bipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +  ---------- +VREF ------------
> +      ´ `           ´ `                  _____________________
> +    /     \       /     \               /                     |
> +   /       \     /       \         --- <  IN          ADC     |
> +            \   /         \   /         \                     |
> +             `-´           `-´           \       +VREF  -VREF |
> +  ---------- -VREF ------------           +-------------------+
> +                                                  ^       ^
> +                                                  |       |
> +                             External +VREF ------+  External -VREF
> +
> +For a **single-ended bipolar** channel, the analog voltage input can go from
> +-VREF to +VREF (where -VREF is the voltage reference that has the lower
> +electrical potential while +VREF is the reference with the higher one). Some ADC
> +chips derive the lower reference from +VREF, others get it from a separate
> +input.  Often, +VREF and -VREF are symmetric but they don't need to be so. When
> +-VREF is lower than system ground, these inputs are also called single-ended
> +true bipolar.
> +
> +Here's an example device tree description of a single-ended bipolar channel.
> +::

To be consistent with other sections, put :: at the end of the text.

	Here's an example device tree description of a single-ended bipolar channel::

> +
> +    adc@0 {
> +        ...
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +            reg = <0>;
> +            bipolar;
> +        };
> +    };
> +
> +1.2 Differential channels
> +-------------------------
> +
> +A differential voltage measurement digitizes the voltage level at the positive
> +input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
> +In other words, a differential channel measures how many volts IN+ is away from
> +IN- (IN+ - IN-).

Suggest using the word "difference" or the "the potential difference between"
instead of saying "is away from".

> +
> +1.2.1 Differential Bipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +  -------- +VREF ------
> +    ´ `       ´ `               +-------------------+
> +  /     \   /     \   /        /                    |
> +         `-´       `-´    --- <  IN+                |
> +  -------- -VREF ------        |                    |
> +                               |            ADC     |
> +  -------- +VREF ------        |                    |
> +        ´ `       ´ `     --- <  IN-                |
> +  \   /     \   /     \        \       +VREF  -VREF |
> +   `-´       `-´                +-------------------+
> +  -------- -VREF ------                  ^       ^
> +                                         |       +---- External -VREF
> +                                  External +VREF
> +
> +The analog signals to **differential bipolar** inputs are also allowed to swing
> +from -VREF to +VREF. If -VREF is below system GND, these are also called
> +differential true bipolar inputs.
> +
> +Device tree example of a differential bipolar channel::
> +
> +    adc@0 {
> +        ...
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +            reg = <0>;
> +            bipolar;
> +            diff-channels = <0 1>;
> +        };
> +    };
> +
> +In the ADC driver, `differential = 1` is set into `struct iio_chan_spec` for the
> +channel. See ``include/linux/iio/iio.h`` for more information.
> +
> +1.2.2 Differential Unipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To be consistent with the other sections, move unipolar before bipolar.

> +
> +For **differential unipolar** channels, the analog voltage at the positive input
> +must also be higher than the voltage at the negative input. Thus, the actual
> +input range allowed to a differential unipolar channel is IN- to +VREF. Because
> +IN+ is allowed to swing with the measured analog signal and the input setup must
> +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
> +differential unipolar channel setups have IN- fixed to a known voltage that does
> +not fall within the voltage range expected for the measured signal. This leads
> +to a setup that is equivalent to a pseudo-differential channel. Thus,
> +differential unipolar channels are actually pseudo-differential unipolar
> +channels.

The diagrams are really helpful, so please add a diagram in this section as well.

> +
> +1.3 Pseudo-differential Channels
> +--------------------------------
> +
> +There is a third ADC input type which is called pseudo-differential or
> +single-ended to differential configuration. A pseudo-differential channel is
> +similar to a differential channel in that it also measures IN+ relative to IN-.
> +However, unlike differential channels, the negative input is limited to a narrow
> +voltage range while only IN+ is allowed to swing. A pseudo-differential channel
> +can be made out from a differential pair of inputs by restricting the negative
> +input to a known voltage while allowing only the positive input to swing. Aside
> +from that, some parts have a COM pin that allows single-ended inputs to be
> +referenced to a common-mode voltage, making them pseudo-differential channels.

I think it would be helpful to mention here that the common mode input voltage is
usually described in the devicetree as a voltage regulator since it is basically
a constant  voltage source, e.g. ``com-supply`` to correspond to the example COM
pin.

> +
> +1.3.1 Pseudo-differential Unipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +  -------- +VREF ------          +-------------------+
> +    ´ `       ´ `               /                    |
> +  /     \   /     \   /    --- <  IN+                |
> +         `-´       `-´          |                    |
> +  --------- IN- -------         |            ADC     |

The bottom rail should be GND, not IN-. Typically, the common mode voltage is
VREF / 2. In other words it is halfway between the two rails.

> +                                |                    |
> +  Common-mode voltage -->  --- <  IN-                |
> +                                \       +VREF  -VREF |
> +                                 +-------------------+
> +                                          ^       ^
> +                                          |       +---- External -VREF

This is unipolar, so would not expect -VREF here.

> +                                   External +VREF
> +
> +A **pseudo-differential unipolar** input has the limitations a differential
> +unipolar channel would have, meaning the analog voltage to the positive input
> +IN+ must stay within IN- to +VREF. The fixed voltage to IN- is sometimes called
> +common-mode voltage and it must be within -VREF to +VREF as would be expected
> +from the signal to any differential channel negative input.
> +
> +In pseudo-differential configuration, the voltage measured from IN+ is not
> +relative to GND (as it would be for a single-ended channel) but to IN-, which
> +causes the measurement to always be offset by IN- volts. To allow applications
> +to calculate IN+ voltage with respect to system ground, the IIO channel may
> +provide an `_offset` attribute to report the channel offset to user space.

In some chips though, the common mode voltage may be GND. (Example is AD7944
that calls this "ground sense"). So in that case, there is no common mode
supply or ``_offset`` attribute.

> +
> +Device tree example for pseudo-differential unipolar channel::
> +
> +    adc@0 {
> +        ...
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +            reg = <0>;
> +            single-channel = <0>;
> +            common-mode-channel = <1>;
> +        };
> +    };
> +
> +Do not set `differential` in the channel `iio_chan_spec` struct of

Needs `` for .rst formatting.

> +pseudo-differential channels.
> +
> +1.3.2 Pseudo-differential Bipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +  -------- +VREF ------          +-------------------+
> +    ´ `       ´ `               /                    |
> +  /     \   /     \   /    --- <  IN+                |
> +         `-´       `-´          |                    |
> +  -------- -VREF ------         |            ADC     |
> +                                |                    |
> +  Common-mode voltage -->  --- <  IN-                |
> +                                \       +VREF  -VREF |
> +                                 +-------------------+
> +                                          ^       ^
> +                                          |       +---- External -VREF
> +                                   External +VREF
> +
> +A **pseudo-differential bipolar** input is not limited by the level at IN- but
> +it will be limited to -VREF or to GND on the lower end of the input range
> +depending on the particular ADC. Similar to their unipolar counter parts,
> +pseudo-differential bipolar channels may define an `_offset` attribute to
> +provide the read offset relative to GND.
> +
> +Device tree example for pseudo-differential bipolar channel::
> +
> +    adc@0 {
> +        ...
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +            reg = <0>;
> +            bipolar;
> +            single-channel = <0>;
> +            common-mode-channel = <1>;
> +        };
> +    };
> +
> +Again, the `differential` field of `struct iio_chan_spec` is not set for
> +pseudo-differential channels.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 074dbbf7ba0a..15f62d304eaa 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -7,6 +7,7 @@ Industrial I/O
>  .. toctree::
>     :maxdepth: 1
>  
> +   iio_adc

Maybe make this iio_adc_inputs in case we make a general adc page in the future.

>     iio_configfs
>     iio_devbuf
>     iio_dmabuf_api


