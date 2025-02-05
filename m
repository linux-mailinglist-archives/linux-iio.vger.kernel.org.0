Return-Path: <linux-iio+bounces-15054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA7A29B54
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 21:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CFE3A374A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEA21420E;
	Wed,  5 Feb 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l0wgI+yj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C12144AD
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787909; cv=none; b=HIDji07ApXL5VWnczPRyHtY/lGLNjo4Tys07t18DyrDDzvGa0EljQuMr8vPvEpDwabeuuYXOGjhvkqmw/UF7muskO5kDvO4V9NB6WF2TzDZRT6VTupI4pjOMehPM5BpzOZeG2lnBTXYL5me8VON9fhf31WvWlxUdCQQBCuiwYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787909; c=relaxed/simple;
	bh=p5vvGDd+XCls+VIBm2GDPAVbFu38ZZMqN0PTDrROqgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWMELj2WjP0IUGY5RwfIQZDm9NPQN4SIPfDv2CFsvyCNaUimXj9SSZ1qTs2d/4EPy8qda1nDvVUBWQTFQk9xAjrsGNhM8e/cW0gdcYchJwa4nH6t5MBouLBq7mVZ9x9q18mUB4SqFgx+1NLpFWPi2jlf/GtVm8tyTWaqGlyAU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l0wgI+yj; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f1c94936c5so95997b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738787904; x=1739392704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iExqtUF1xBRaz231FnUdlgq5xqb1L6JdrHNcxz8aKk=;
        b=l0wgI+yjLI0A/FiHNrDWO2uTYj6gqE3TMDXAEx2W5HM05tfL2459XsBcSfYvy2aZik
         7PHOxK+jcT6w1y7CPcaMI4DRR+yot++LwoJT0Nc9ybOdJtDwv7iWhwOgsQmGvn58PgY6
         /egNpCfFs2vpli09oTCyC7YnXy/auSnbl9AD4UeNbN/4A5SYHOwdmRMY0KcEe4ABrxbc
         tAYKpPIkY5OIHCmpWnRJ2RkNUYDPcfX292PZjKVXsoedUBUfY2qsHCmgstl/c4YRjHxZ
         +HWLCcy+yu01eZvu62MkEG8SRqXb7j9ekYkdmjvmgQljw+MPwDBfDsnpvZSwr0qnfiBG
         SjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787904; x=1739392704;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iExqtUF1xBRaz231FnUdlgq5xqb1L6JdrHNcxz8aKk=;
        b=nwPMX5Rg+DbsO9w4jAI3HxAWlduPyU4JAC+C6wRh8IuO9k7Gi9YWbe205AW09oH12X
         3mTZSsCfdmlEAypqdN1FznTfZvIlDFNcBC/hydfRHgUH7AEWoaJ+lrlGGTwyOIbdVEYD
         HiAJwYbJKfqMcNoTNGFtaat7zSiByVPv9dGGjpDMTKb3I0u0S/VkjA3n3muEWBbm9vKw
         ARZ8D6p+O31y8envbMMht+kQK2rE9o7j57cLrkVRS6AROwmcQOijVmmVQVDfub93WA+/
         QaVF+Wx0xWJeb6CCnSs0XuHoJZ+SG9/ZxmzLNfp+MxWlGUCa0r7QAZh6hcipRkC4fvIW
         O1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWYyW++wK81HJVLei9Zu4W5NaPNI6dLoZVMqGl2/bJuHGPbjvZEvBE55LhZ43PIBIKciP0LuNmqMTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk4NDeydi83hUaF9OD4JO8L4oL1FjY9M8ZUkCqFHKf1aHwOkX
	mWpUsPLLIfOxkUAwnazdPln8upAa938oJtesAyX6qjasTYd37Owab/mKqMoCr5M=
X-Gm-Gg: ASbGnct73hhgdD569Hp+jMNL6z0HUsMkvvcCRC8yl7iJYmm17mfcB0phWShLtQuOvrP
	TogzuIBufwIAnOZAibE+9rDMSnZkloeX2J/a/84z+8XClvl4OgGjICSolv7bu7Ai+rKZoG9NF7j
	RXFH0E8E1uSFoHF/B35M7/Oi4wCZ+6Hd1Y8evzJUy65b6oktIgXo7T+KJX39s2Ma5rMEsBXkUJe
	lfBTy2bVM9tk7OrBN06/lDoBciYjuqF6I57gHaszA/6VubKzF4gwRkZm/fh/9hJkaJDt6+S3pRc
	6+evq6B7v5v5nd+FCc/EjwqhZqgzWwWm08GlK6zeW+xoTCSVgba5
X-Google-Smtp-Source: AGHT+IF9+ByeI4iK6e7Mj0x6J8z2pOxDd8eSUJcWxQz1CQu0TjNdIb01mzwEX2uO4V9CuZbqlQ7Kkg==
X-Received: by 2002:a05:6808:2386:b0:3eb:7c84:a808 with SMTP id 5614622812f47-3f38679291dmr700873b6e.5.1738787903608;
        Wed, 05 Feb 2025 12:38:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333523be4sm3637162b6e.4.2025.02.05.12.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 12:38:22 -0800 (PST)
Message-ID: <5084aed7-1b39-4cbd-b136-610bceb05c92@baylibre.com>
Date: Wed, 5 Feb 2025 14:38:20 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Documentation: iio: Add ADC documentation
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, corbet@lwn.net,
 marcelo.schmitt1@gmail.com
References: <c21b89367510c3d56d8d17adc24b46c7c63a14b2.1738759798.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <c21b89367510c3d56d8d17adc24b46c7c63a14b2.1738759798.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/5/25 6:53 AM, Marcelo Schmitt wrote:
> ADC inputs can be classified into a few different types according to how
> they measure the input signal, how restrained the signal is, and number of
> input pins. Even though datasheets tend to provide many details about their
> inputs and measurement procedures, it may not always be clear how to model
> those inputs into IIO channels.
> 
> For example, some differential ADCs can have their inputs configured into
> pseudo-differential channels. In that configuration, only one input
> connects to the signal of interest as opposed to using two inputs of a
> differential input configuration. Datasheets sometimes also refer to
> pseudo-differential inputs as single-ended inputs even though they have
> distinct physical configuration and measurement procedure.
> 
> Document consolidated ADC input types and how they are usually described
> and supported in device tree and IIO, respectively.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> - Adjusted text to match acronym (Voltage input Full-Scale, or VFS for short).
> - Mentioned that channel nodes are optional when the ADC has a uniform set of channels.
> - Mentioned that single-channel nodes need to provide single-channel property
>   if reg doesn't match the physical input pin number.
> - Dropped phrase advising to not set ``differential`` in the channel
>   ``iio_chan_spec`` struct in pseudo-differential sections since it looked a
>   bit odd to mention differential properties in pseudo-differential sections.
> - Reworded Pseudo-differential Unipolar section to hopefully make it less confusing.
>   Also added a phrase to mention the provided common-mode voltage is typically GND.
> - No longer documenting differential unipolar channels as if they were always
>   the same as pseudo-differential unipolar.
> - Reworded 1.3 Pseudo-differential Channels section to better phrase IN- being
>   often taken as constant and to also mention that the input provided to IN- is
>   sometimes called common-mode voltage.
> - Re-added -VREF to pseudo-diff unipolar diagram.
>   Sorry to insist on this but I do think -VREF was missing in the diagram when
>   I read the related paragraph.
> - Centralized inputs in differential input diagram.
> - Rewritten commit body
> 
> Change log v1 -> v2
> - Split apart from AD4170 patch set.
> - Added disclaimer paragraph about complex ADCs.
> - Made the input type general description a bit more general, by adding
>   `general` to the text.
> - Changed `::` placement to be consistet in all sections.
> - Improved Differential channels section with more precise explanation.
> - Improved Differential Unipolar Channels section with comment about common
>   mode voltage being described in dt as a voltage regulator.
> - Removed -VREF from Pseudo-differential Unipolar diagram.
> - Added comment about omitting `_offset` when IN- is at GND.
> - Improved .rst formatting with ``.
> 
> Link to v2: https://lore.kernel.org/linux-iio/efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com/
> Link to v1: https://lore.kernel.org/linux-iio/48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com/
> 
>  Documentation/iio/iio_adc.rst | 299 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 300 insertions(+)
>  create mode 100644 Documentation/iio/iio_adc.rst
> 
> diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.rst
> new file mode 100644
> index 000000000000..08447cd5e62f
> --- /dev/null
> +++ b/Documentation/iio/iio_adc.rst
> @@ -0,0 +1,299 @@
> +.. SPDX-License-Identifier: GPL-2.0

More specific GPL-2.0-only or GPL-2.0-or-later is preferred.

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

I think we can be more confident here, drop the punctuation and just say, "how
they should be supported".

> +
> +1. ADC Channel Types
> +====================
> +
> +ADCs can have distinct types of inputs, each of them measuring analog voltages
> +in a slightly different way. An ADC digitizes the analog input voltage over a
> +span that is often given by the provided voltage reference, the input type, and
> +the input polarity. The input range allowed to an ADC channel is needed to
> +determine the scale factor and offset needed to obtain the measured value in
> +real-world units (millivolts for voltage measurement, milliamps for current
> +measurement, etc.).
> +
> +Elaborated designs may have nonlinear characteristics or integrated components

s/Elaborated/Elaborate/

> +(such as amplifiers and reference buffers) that might also have to be considered
> +to derive the allowed input range for an ADC. For clarity, the sections below
> +assume the input range only depends on the provided voltage references, input
> +type, and input polarity.
> +
> +There are three general types of ADC inputs (single-ended, differential,
> +pseudo-differential) and two possible polarities (unipolar, bipolar). The input
> +type (single-ended, differential, pseudo-differential) is one channel
> +characteristic, and is completely independent of the polarity (unipolar,
> +bipolar) aspect. A comprehensive article about ADC input types (on which this
> +doc is heavily based on) can be found at
> +https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.

It could be worth reiterating here that although there are 3 different input
types, in IIO, differential is only a bool, so there is no special distinction
between single-ended and pseduo-differential (other than possibly having a
common mode voltage input). And unipolar/bipolar is only considered on the
difference between the two inputs and not the individual input, so in IIO there
is no special distinction between bipolar and true biploar - they are modeled
the same.

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
> +(Voltage input Full-Scale), with VFS being determined by VREF. The voltage
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
> +One is always allowed to include ADC channel nodes in the device tree. Though,
> +if the device has a uniform set of inputs (e.g. all inputs are single-ended),
> +then declaring the channel nodes is optional.
> +
> +One caveat for devices that support mixed single-ended and differential channels
> +is that single-ended channel nodes also need to provide a ``single-channel``
> +property when ``reg`` is an arbitrary number that doesn't match the input pin
> +number.
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
> +Here's an example device tree description of a single-ended bipolar channel::
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

Suggest to insert here:

> +A differential voltage measurement,

sometimes also called "fully differential" or "true differential",

> digitizes the voltage level at the positive
> +input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
> +In other words, a differential channel measures the potential difference between
> +IN+ and IN-, which is often denoted by the IN+ - IN- formula.
> +
> +1.2.1 Differential Bipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +  -------- +VREF ------         +-------------------+
> +    ´ `       ´ `              /                    |
> +  /     \   /     \   /   --- <  IN+                |
> +         `-´       `-´         |                    |
> +  -------- -VREF ------        |                    |
> +                               |            ADC     |
> +  -------- +VREF ------        |                    |
> +        ´ `       ´ `          |                    |
> +  \   /     \   /     \   --- <  IN-                |
> +   `-´       `-´               \       +VREF  -VREF |
> +  -------- -VREF ------         +-------------------+
> +                                         ^       ^
> +                                         |       +---- External -VREF
> +                                  External +VREF
> +
> +The analog signals to **differential bipolar** inputs are also allowed to swing
> +from -VREF to +VREF. If -VREF is below system GND, these are also called
> +differential true bipolar inputs.

I still think it would be helpful here to explicitly state that it is the
resulting value of the difference, not the individual inputs that makes it
bipolar.

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
> +In the ADC driver, ``differential = 1`` is set into ``struct iio_chan_spec`` for
> +the channel. See ``include/linux/iio/iio.h`` for more information.
> +
> +1.2.2 Differential Unipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +For **differential unipolar** channels, 

I think it would be nice to have a short first paragraph that just says that
this configuration is quite unusual and that the difference would have to always
be positive. Then follow with the rest of the info for the curious in a separate
paragraph. Then it will be easy for those not interested in the unusual case to
skip over that part.

> the analog voltage at the positive input
> +must also be higher than the voltage at the negative input. Thus, the actual
> +input range allowed to a differential unipolar channel is IN- to +VREF. Because
> +IN+ is allowed to swing with the measured analog signal and the input setup must
> +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
> +differential unipolar channel setups have IN- fixed to a known voltage that does
> +not fall within the voltage range expected for the measured signal. That leads
> +to a setup that is equivalent to a pseudo-differential channel. Thus,
> +differential unipolar setups can often be supported as pseudo-differential
> +unipolar channels.

I think we should just leave out the sentence about being supported as pseudo-
differential. There is already a different section that describes that and it
would be simpler to just stick with describing the fully differential case here.
The differential bipolar section also only describes the fully differential case
so mentioning pseduo-differential here seems inconsistent.

> +
> +1.3 Pseudo-differential Channels
> +--------------------------------
> +
> +There is a third ADC input type which is called pseudo-differential or
> +single-ended to differential configuration. A pseudo-differential channel is
> +similar to a differential channel in that it also measures IN+ relative to IN-.
> +However, unlike differential channels, the negative input is limited to a narrow

                  ^ true

> +voltage range (taken as a constant voltage) while only IN+ is allowed to swing.
> +A pseudo-differential channel can be made out from a differential pair of inputs
> +by restricting the negative input to a known voltage while allowing only the
> +positive input to swing. Sometimes, the input provided to IN- is called
> +common-mode voltage. Besides, some parts have a COM pin that allows single-ended
> +inputs to be referenced to a common-mode voltage, making them
> +pseudo-differential channels. Often, the common mode input voltage can be
> +described in the device tree as a voltage regulator (e.g. ``com-supply``) since
> +it is basically a constant voltage source.
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
> +                                |                    |
> +  Common-mode voltage -->  --- <  IN-                |
> +                                \       +VREF  -VREF |
> +                                 +-------------------+
> +                                         ^       ^
> +                                         |       +---- External -VREF
> +                                  External +VREF
> +
> +A **pseudo-differential unipolar** input has the limitations a differential
> +unipolar channel would have, meaning the analog voltage to the positive input
> +IN+ must stay within IN- to +VREF. The fixed voltage to IN- is often called
> +common-mode voltage and it must be within -VREF to +VREF as would be expected
> +from the signal to any differential channel negative input.
> +
> +The voltage measured from IN+ is relative to IN- but, unlike differential
> +channels, pseudo-differential setups are intended to gauge single-ended input
> +signals. To enable applications to calculate IN+ voltage with respect to system
> +ground, the IIO channel may provide an ``_offset`` sysfs attribute to be added
> +to ADC output when converting raw data to voltage units. In many setups, the
> +common-mode voltage input is at GND level and the ``_offset`` attribute is
> +omitted due to being always zero.
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
> +Do not set ``differential`` in the channel ``iio_chan_spec`` struct of
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
> +pseudo-differential bipolar channels ought to declare an ``_offset`` attribute
> +to enable the conversion of raw ADC data to voltage units. For the setup with
> +IN- connected to GND, ``_offset`` is often omitted.
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
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 5710f5b9e958..48b88044d7cb 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -7,6 +7,7 @@ Industrial I/O
>  .. toctree::
>     :maxdepth: 1
>  
> +   iio_adc
>     iio_configfs
>     iio_devbuf
>     iio_dmabuf_api
> 
> base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b


