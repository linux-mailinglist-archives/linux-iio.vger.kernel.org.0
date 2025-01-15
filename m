Return-Path: <linux-iio+bounces-14380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DBA129BF
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05891673E8
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9B157484;
	Wed, 15 Jan 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vG2QnwS+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857A1B0F3D
	for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961812; cv=none; b=ekzUCE6znGMIisUt3bKYxubSD8aSPEb4yYaf9t+xQKM9TKliI8DR2ZEIa1jnQ4oQO0kEhSs04aebXaTsvs1kIV1o9X1GkJOjEo63dTdqxGUx/6eygsiWRCRwOGPOFEUImUMxc/J/7apPZ0PvmUDYrmz9CIK+NjCsp9PtrICS0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961812; c=relaxed/simple;
	bh=c9d8Sx6Ws9qeN9kDX0zZBO7NNNe72M1KyPiOE502MiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5AvuLlLJunaVIJ3N6ic2kXSV5nA5mu9quOQAtIG2R5k+xUh6yVSX/bpnoUQGoaCULGJEQaUfAXIA+i8J3GlAVlOMZg8OSbbAuOV5ey/wRzhpuHoWnxhq1NDiHiCEEOI76NbFsG1YFllx6UbYAY6hsXwwcg0FvXKLWQdwYxlaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vG2QnwS+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f89aa7a101so1671632eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736961806; x=1737566606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lpef76kfpXRjb9TPRyrkD25HM3lSPw4I0HtKV4oHH4=;
        b=vG2QnwS+KS49YoQ17xbWx7hSNQKifcO9v0SDoCSDpLJbqzgnrHE2AA0ZAoPX/2wbi/
         m5dgZx482+li9DK7ywZPMIKUR231Lfu4z3jQel9FeAbnBVyY4OVoGec5DWe32xrUSLy8
         RTwbyBdKKq7c9mg7UAagRkQq6RHTMKfc1bIuDiLaTNQJMgm1CYMkRF9BIHUxsBMql59H
         F8+0kdKPQP6JaIxSCPaLpUZbnLhnU5uAgfatiK4OCWAf46Xv36p0WkrWHNeRJFAchgSa
         LKb0j4OsicLxtW3RqOUqQCuo+8ccDkugtErXr14WeOn7cBR4Ga3M1aWmkuqnK08OPPId
         SfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736961806; x=1737566606;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lpef76kfpXRjb9TPRyrkD25HM3lSPw4I0HtKV4oHH4=;
        b=A+Ad95mJXlqHmx/EdmCPEK6o7scT1L+vlvBtz/wiu8h3uYJvGBpoS4jeOS7ax7G8ue
         gRaztCWJiJutJZcuhEp58WUfcBCMkCUYTnRHnoWxO8y8COz+pgwyvkQPPcJEViZxofSm
         9aUavnmKCrjdyCfgTRe8XC9q/I1UbJf6Mn2VQ4Dv5/unGWsbYucwrMIiGWANXMDZud2P
         X/WcaoBWoTdQp5SBi62kGumx+P6vr9UkObTZKo+iwegQMfoGEryuNzekMf5Vkp/LaOie
         VO/nCFiPmtLul8a6F0lTrEZBFoZ78Uz66EDTq5Lz1wux7WIioLrHpXYyV3ovPP4YvgQl
         vPhA==
X-Forwarded-Encrypted: i=1; AJvYcCW7A9giTUJbv7mkS02zxQwAki3qONQdhZT4BCq4G/XomLz1TXUE6XlyA4PYnUZ70KAwuKgbaujGHRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDy+cmqTBEeosGF9N3g2TJGiJb++6zAM124ifqeZaogagIUt6w
	opdD/llUZnu9aqtK7UaoxPJz96J1GBHa9a2N+rqUFWiEc8Hqzsyush9Pb/E+8Os=
X-Gm-Gg: ASbGncsi0sHDG1MdQDwqeR2L8u0L/xv/OwnPuNE3GEepXq9kKbTSpRJxPPHGObeknVN
	hHc9x9La0WzG6FUzwJYgxu0wPi9d6tNnidbWne55w6aOvgbbzUdCZ1jgHsf5v3U9Tf4mKKUzS0a
	uGjF22BslSGv+HOwNkPmExp3pPP2JOxQgVRTjIPVIu4pkokHoGyOyz+zzC9TVXt/aiQNRC4oubc
	m8hArQOtJX+mLqhczbPBH7smexSOSqO/FTISLsjIuYDY1YMt0BO6WhUBnaKmvKds6M+o1lzrOp5
	Xyg5DK0xtDBk3s9RrQ==
X-Google-Smtp-Source: AGHT+IH4iZKIUZyAwpv+iMSmzDhyz+FpmQwhrbQ0wrubJ2D35DuGP1D1qGLcGHHllmaO4wa+0PUbRQ==
X-Received: by 2002:a05:6820:4506:b0:5f9:1da8:3a48 with SMTP id 006d021491bc7-5f91da844edmr2097932eaf.0.1736961805782;
        Wed, 15 Jan 2025 09:23:25 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231862a38csm5756082a34.68.2025.01.15.09.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:23:25 -0800 (PST)
Message-ID: <3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
Date: Wed, 15 Jan 2025 11:23:24 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, corbet@lwn.net,
 marcelo.schmitt1@gmail.com
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/14/25 7:53 AM, Marcelo Schmitt wrote:
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
> - Improved .rst formating with ``.
> 
> Link to v1: https://lore.kernel.org/linux-iio/48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com/
> 
> 
>  Documentation/iio/iio_adc.rst | 290 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 291 insertions(+)
>  create mode 100644 Documentation/iio/iio_adc.rst
> 
> diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.rst
> new file mode 100644
> index 000000000000..b9d30e732a61
> --- /dev/null
> +++ b/Documentation/iio/iio_adc.rst
> @@ -0,0 +1,290 @@
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
> +span that is often given by the provided voltage reference, the input type, and
> +the input polarity. The input range allowed to an ADC channel is needed to
> +determine the scale factor and offset needed to obtain the measured value in
> +real-world units (millivolts for voltage measurement, milliamps for current
> +measurement, etc.).
> +
> +Elaborated designs may have nonlinear characteristics or integrated components
> +(such as amplifiers and reference buffers) that might also have to be considered
> +to derive the allowed input range for an ADC. For clarity, the sections below
> +assume the input range only depends on the provided voltage references, input
> +type, and input polarity.
> +
> +There are three general types of ADC inputs (single-ended, differential,
> +pseudo-differential) and two possible polarities (unipolar, bipolar).

I think we actually need to say there are 3 polarities as well. As you will
see, my comments below in the psudo-diffential sections was assuming the
definition of "bipolar" is "true bipolar" where it means that the input volage
can be negative. However, it is now clear to me that you have been writing this
with the perspective of bipolar only being "pseduo bipolar" where uniploar would
be limited to between a positive common mode voltage and the max voltage (VREF)
an bipolar would still be limited to a positive voltage but range from 0V to
VREF.

For ease of understanding, I think we should start with giving diagrams and
examples of true bipolar, then move on to the more complex and less common
examples of pseudo bipolar.

So I will leave my commemts below (mostly with regards to psudo-differential)
as I first wrote them, but take it to mean that we are both right and these are
two diffent cases that need to be considered.

> The input
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

We should probably mention somewhere that channel@ nodes are only needed for
chips that don't have uniform inputs.

> +
> +    adc@0 {
> +        ...
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +            reg = <0>;

If a chip has mixed differential and single-ended, single-channel could also
be needed here in the case where reg is an arbitrary number and doesn't match
the input pin number.

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
> +A differential voltage measurement digitizes the voltage level at the positive
> +input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
> +In other words, a differential channel measures the potential difference between
> +IN+ and IN-, which is often denoted by the IN+ - IN- formula.
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
> +In the ADC driver, ``differential = 1`` is set into ``struct iio_chan_spec`` for
> +the channel. See ``include/linux/iio/iio.h`` for more information.
> +
> +1.2.2 Differential Unipolar Channels
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

I don't think this is equevent to pseudo-differential unipolar. That one has
a common mode voltage supply on the negative input. This one has a full range
signal on the negative input. This is the diagram I was expecting here.

::

  -------- VREF -------
    ´ `       ´ `               +-------------------+
  /     \   /     \   /        /                    |
         `-´       `-´    --- <  IN+                |
  ------ GND (0V) -----        |                    |
                               |            ADC     |
  -------- VREF -------        |                    |
        ´ `       ´ `     --- <  IN-                |
  \   /     \   /     \        \       VREF         |
   `-´       `-´                +-------------------+
  ------ GND (0V) -----                  ^        
                                         |       
                                  External VREF

> +
> +1.3 Pseudo-differential Channels
> +--------------------------------
> +
> +There is a third ADC input type which is called pseudo-differential or
> +single-ended to differential configuration. A pseudo-differential channel is
> +similar to a differential channel in that it also measures IN+ relative to IN-.
> +However, unlike differential channels, the negative input is limited to a narrow
> +(taken as constant) voltage range while only IN+ is allowed to swing. A
> +pseudo-differential channel can be made out from a differential pair of inputs
> +by restricting the negative input to a known voltage while allowing only the
> +positive input to swing. Aside from that, some parts have a COM pin that allows
> +single-ended inputs to be referenced to a common-mode voltage, making them
> +pseudo-differential channels. Often, the common mode input voltage
> +can be nicely described in the device tree as a voltage regulator (e.g.
> +``com-supply``) since it is basically a constant voltage source.
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

The bottom rail should be GND (or -VREF), not IN-. Making it GND in the diagram
would be consistent with the other unipolar diagrams and reflect most typical
cases. I think the counterexample you gave of AD4170-4 is the unusual case
rather than the typical case.

FWIW, when I was first learning this stuff, I didn't really understand bipolar
vs. unipolar until I saw diagrams that showed 0V as the bottom rail for unipolar
and negative VREF as the bottom rail for bipolar. Even if it isn't strictly
true in all cases, seeing the pattern was more helpful. Hard to say if most
other people think like me though. :-)

> +                                |                    |
> +  Common-mode voltage -->  --- <  IN-                |
> +                                \       +VREF        |
> +                                 +-------------------+
> +                                          ^
> +                                          |
> +                                   External +VREF
> +
> +A **pseudo-differential unipolar** input has the limitations a differential
> +unipolar channel would have, meaning the analog voltage to the positive input
> +IN+ must stay within IN- to +VREF. 

As above, this is not strictyly true. On the chips I have worked with (at least
two out of three different families), IN- is VREF/2 and IN+ can go from GND to
VREF.

> The fixed voltage to IN- is sometimes called
> +common-mode voltage and it must be within -VREF to +VREF as would be expected
> +from the signal to any differential channel negative input.
> +
> +In pseudo-differential configuration, the voltage measured from IN+ is not
> +relative to GND (as it would be for a single-ended channel) but to IN-, which

This is a bit confusing because you say not relative to GND, but then below, you
say that GND can be connected to IN-, so it would be relative to GND. So might
want to qualify this GND is different than external common mode voltage GND.

> +causes the measurement to always be offset by IN- volts. To allow applications
> +to calculate IN+ voltage with respect to system ground, the IIO channel should
> +provide an ``_offset`` sysfs attribute to report the channel offset to user
> +space. In cases where IN- (or the common mode voltage applied to IN-) is GND,
> +the ``_offset`` attribute may be omitted.
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

Some might appritate an explanatin why here since it is odd to have differental
in the name "pseudo-differential". I.e. because we consider the negative pin
a voltage supply rather than a second anolog input.

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


If it was limited to GND, then it would be uniploar. It is only bipolar if
-VREF is less than 0V.

> +depending on the particular ADC. Similar to their unipolar counter parts,
> +pseudo-differential bipolar channels may define an ``_offset`` attribute to
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
> +Again, the ``differential`` field of ``struct iio_chan_spec`` is not set for
> +pseudo-differential channels.
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


