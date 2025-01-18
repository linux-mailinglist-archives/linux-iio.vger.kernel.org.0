Return-Path: <linux-iio+bounces-14479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02A7A15EB6
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 21:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E17165A0A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447B1AF0D3;
	Sat, 18 Jan 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3fYzAbD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA41373;
	Sat, 18 Jan 2025 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737231494; cv=none; b=swTXcKluuSTJ024p/mzmyKmUwrSbEKjXbcfQ2GqQscCJFWqiZSNchq1C/YMKAGMdhrxdisL/Mp3549e/ivBNyVxuHslWCg2J+gi/WCVfM33xfh1fl9x2wI8KeHJH55raZJ6uGrNJYpUQnYvVOGL5u0L1GTPe1byWSa/QWAXyjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737231494; c=relaxed/simple;
	bh=/o+TM63KGLl1wZqhGM6c+8BiBqg31x4ZpynGV3iPYlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVxfppUSDzITAPKh+ZVfWHcPY3pGNpTY9b8bF7WnJgq2AFzLUiBAYu2OHen+UFEmCTiEOU0aKaXArqVldFbGAnkhhtC5DWuXrQy6vbCfZowcqQMxYxstid2m+9Y8By8rSva+8lpJo5yG3wgpNqJM2YBa0hTfWVDxcD8G2vPTix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3fYzAbD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166022c5caso54407025ad.2;
        Sat, 18 Jan 2025 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737231491; x=1737836291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+P9/vhZKfExkHISJ+i8hkL1LJGqNUrzF7hH4w/zQtBc=;
        b=b3fYzAbDXSGHlnv7SqIKkslJeI7YGY+yAg/1GgLv+HunRqIDw73CjAJHM8ehd0DgH+
         aDwvlWum/ZzmvEQ/N/A3xAQbZXW9AeiqY1vdvLQPe0zwSV87UwfQOhrPNpaZMcC2OzQH
         0r2vnNuRkU7xQni++swkYygquxXFW2L7V13JyyElYk2tDG1Z7U1XVuQUcKz0XmOxhPPt
         E+Ue2fw5VQ41qPbcRX1LicwQv/pcwuHMAW1Qdg3kEUuN51rO5n6aD/99cHbLpacVvUwY
         cg+CG57A0J0IvKa3ujL9tEfD1wWhPSQOEClVmgjrNPZZcRgh4RpJ9AfvE7FSY8Nf7c2k
         97HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737231491; x=1737836291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+P9/vhZKfExkHISJ+i8hkL1LJGqNUrzF7hH4w/zQtBc=;
        b=EouUWBNJ+M2PWp2A08D3/dvUGfeEZaXa5eevnsBVC/cS7UfhM3v5A5r26e/DMoCeZi
         G6wkMXp3TkVbg4pDeGiwg9rsiueML5TC0M09Uo/VlZ1dpxx9Gqf7eQcAkQmIr9rf+s3H
         6apOQGY+QaDVlhWGDt/+ckDG5PhR0QttS225uQ8Tvhbm5QcNFmMRluS1EK1Z8Lym3zHV
         xpVL4ld5KKKEUPxGf+JSNX1NPIRtWp3tCv9Hzfs/BgrkXE5edzm3IhJ+MGuDdv4tuMTa
         De5uvU6LLaqjpjuVZgN1TUw3Hx+aajxNu+4qqABQGLfjHR6NkszQ+uE1f6Mmh2XCmxyC
         RDhA==
X-Forwarded-Encrypted: i=1; AJvYcCUDYw++26LHvarqEeZydW1pSIeqKrguqbPwuKbQRzC8U6xQt5FVgrqgYy9wCafv6v+DvWMjiCSFihLg@vger.kernel.org, AJvYcCUiF1qNP2gKoTVnidenSZWOPceH7ZohbkqVXnHXJ+3CMDnCANq9Gjt3LNEwcFZGfPpDe5frlZ9IP88=@vger.kernel.org, AJvYcCWOfSY5x6ZfdCDSj5vvNx0PbI884a4lsI9iMNTN0H5/xdu+iwDQ/iaWLCS8NLrxLTqGrYEBvACTOfp3M124@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuyuaxDKDWR8yTD2ZKiekKhS9xoHLmltEZx/hYnDgeaMKf0XB
	ZXHG0Qa5z5/nD1Os9+TRGcPxuF5iWtPrGWU7a9deIcADaBH0D/L7
X-Gm-Gg: ASbGnctBoK8QzhyW74pUlIznNgGqKuiYF9RAwcurtcJpA6yEL1xLuSfIN6aSPmZMHcf
	JB2vTW28Anh/jLAI53Dj94Q+WW9UipSWObwoIln0mnyNOGi/qXl0wuVl2uY4JuM+gt5prR+SiAT
	8iwyExtrEi+KXzRE9yU7HBnJEOeYNOKWkWKjOcMvvdExi4HISQm+og5eUlR/fg9pG4Ev1MPZuv4
	GPIDWLf+ISkw6ETf/4k/E4k4WmEuRCzHah69g7ynpSnCrKTnJ4H8m1Gdsr2TuqIC2HGFwHy/Y9v
	Sg==
X-Google-Smtp-Source: AGHT+IF0BC5nLvh31eJ6pgxo2mzjtgmRTqnury3r2F7fDSB2DZNojwFg5I6bRu/sAr0seJ3greR0rg==
X-Received: by 2002:a05:6a21:6d91:b0:1e0:cbd1:8046 with SMTP id adf61e73a8af0-1eb21174c17mr10610134637.0.1737231491156;
        Sat, 18 Jan 2025 12:18:11 -0800 (PST)
Received: from localhost ([2804:30c:b30:a800:c057:a90:a425:2f39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b450esm3349415a12.69.2025.01.18.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 12:18:10 -0800 (PST)
Date: Sat, 18 Jan 2025 17:18:46 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, corbet@lwn.net
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
Message-ID: <Z4wMpo1jUR5dcu9X@debian-BULLSEYE-live-builder-AMD64>
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
 <3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>

Hi David,

Sort of late reply but hopefully still able to add something to the discussion
or at least help answer to your comments.

Thanks,
Marcelo

On 01/15, David Lechner wrote:
> On 1/14/25 7:53 AM, Marcelo Schmitt wrote:
> > ADCs can have different input configurations such that developers can get
> > confused when trying to model some of them into IIO channels.
> > 
> > For example, some differential ADCs can have their channels configured as
> > pseudo-differential channels. In that configuration, only one input
> > connects to the signal of interest as opposed to using two inputs of a
> > differential input configuration. Datasheets sometimes also refer to
> > pseudo-differential inputs as single-ended inputs even though they have
> > distinct physical configuration and measurement procedure. There has been
> > some previous discussion in the mailing list about pseudo-differential and
> > single-ended channels [1].
> > 
> > Documenting the many possible ADC channel configurations should provide two
> > benefits:
> > A) Consolidate the knowledge from [2] and from [1], and hopefully reduce
> > the reviewing time of forthcoming ADC drivers.
> > B) Help Linux developers figure out quicker how to better support
> > differential ADCs, specially those that can have channels configured as
> > pseudo-differential inputs.
> > 
> > Add documentation about common ADC characteristics and IIO support for them.
> > 
> > [1]: https://lore.kernel.org/linux-iio/0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.com/
> > [2]: https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v1 -> v2
> > - Split apart from AD4170 patch set.
> > - Added disclaimer paragraph about complex ADCs.
> > - Made the input type general description a bit more general, by adding
> >   `general` to the text.
> > - Changed `::` placement to be consistet in all sections.
> > - Improved Differential channels section with more precise explanation.
> > - Improved Differential Unipolar Channels section with comment about common
> >   mode voltage being described in dt as a voltage regulator.
> > - Removed -VREF from Pseudo-differential Unipolar diagram.
> > - Added comment about omitting `_offset` when IN- is at GND.
> > - Improved .rst formating with ``.
> > 
> > Link to v1: https://lore.kernel.org/linux-iio/48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com/
> > 
> > 
> >  Documentation/iio/iio_adc.rst | 290 ++++++++++++++++++++++++++++++++++
> >  Documentation/iio/index.rst   |   1 +
> >  2 files changed, 291 insertions(+)
> >  create mode 100644 Documentation/iio/iio_adc.rst
> > 
> > diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.rst
> > new file mode 100644
> > index 000000000000..b9d30e732a61
> > --- /dev/null
> > +++ b/Documentation/iio/iio_adc.rst
> > @@ -0,0 +1,290 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========================
> > +IIO Abstractions for ADCs
> > +=========================
> > +
> > +1. Overview
> > +===========
> > +
> > +The IIO subsystem supports many Analog to Digital Converters (ADCs). Some ADCs
> > +have features and characteristics that are supported in specific ways by IIO
> > +device drivers. This documentation describes common ADC features and explains
> > +how they are (should be?) supported by the IIO subsystem.
> > +
> > +1. ADC Channel Types
> > +====================
> > +
> > +ADCs can have distinct types of inputs, each of them measuring analog voltages
> > +in a slightly different way. An ADC digitizes the analog input voltage over a
> > +span that is often given by the provided voltage reference, the input type, and
> > +the input polarity. The input range allowed to an ADC channel is needed to
> > +determine the scale factor and offset needed to obtain the measured value in
> > +real-world units (millivolts for voltage measurement, milliamps for current
> > +measurement, etc.).
> > +
> > +Elaborated designs may have nonlinear characteristics or integrated components
> > +(such as amplifiers and reference buffers) that might also have to be considered
> > +to derive the allowed input range for an ADC. For clarity, the sections below
> > +assume the input range only depends on the provided voltage references, input
> > +type, and input polarity.
> > +
> > +There are three general types of ADC inputs (single-ended, differential,
> > +pseudo-differential) and two possible polarities (unipolar, bipolar).
> 
> I think we actually need to say there are 3 polarities as well. As you will
> see, my comments below in the psudo-diffential sections was assuming the
> definition of "bipolar" is "true bipolar" where it means that the input volage
> can be negative. However, it is now clear to me that you have been writing this
> with the perspective of bipolar only being "pseduo bipolar" where uniploar would
> be limited to between a positive common mode voltage and the max voltage (VREF)
> an bipolar would still be limited to a positive voltage but range from 0V to
> VREF.

We can call these three types of polarity I think (unipolar, bipolar, true bipolar).
That's how the SAR ADC Input article describes them. But I think it doesn't make
much difference from IIO perspective. If IN+ is allowed to go below IN- (bipolar)
the measurement should represent a negative quantity and _raw + _offset will
have to evaluate to a negative decimal number (no matter if IN+ < IN- with IN- >= GND
or IN+ < IN- with IN- < GND). And if IN+ > IN- with IN+ < GND then we have
_offset to help user space get to a proper voltage value (a negative value if
the channel is Pseudo-differential (True) Bipolar, a positive value if the
channel is configured for Differential (True Bipolar) input).

This polarity nomenclature seems to come from electrical engineering so yeah it
may not look very intuitive at first (at least for me as a software guy). That's
why I wanted to document it. So we can struggle less to identify how to support
the many input types and configurations we have :)

For the polarity thing, I see it the following way:
- If the electric potential at IN+ is allowed to be lower than the potential at
  IN-, then they call it bipolar.
- If besides IN+ being allowed to go below IN-, IN+ may also go below GND,
  then they call it true bipolar.

I'll try to get somebody from electrical engineering to review the relevant
parts of this doc before sending a v3.

> 
> For ease of understanding, I think we should start with giving diagrams and
> examples of true bipolar, then move on to the more complex and less common
> examples of pseudo bipolar.

I think the true bipolar setups are more complicated than the ones that are just
bipolar. Though I'll change to describing true bipolar setups first if more
people agree that would be preferred.

> 
> So I will leave my commemts below (mostly with regards to psudo-differential)
> as I first wrote them, but take it to mean that we are both right and these are
> two diffent cases that need to be considered.
> 
> > The input
> > +type (single-ended, differential, pseudo-differential) is one channel
> > +characteristic, and is completely independent of the polarity (unipolar,
> > +bipolar) aspect. A comprehensive article about ADC input types (on which this
> > +doc is heavily based on) can be found at
> > +https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
> > +
> > +1.1 Single-ended channels
> > +-------------------------
> > +
> > +Single-ended channels digitize the analog input voltage relative to ground and
> > +can be either unipolar or bipolar.
> > +
> > +1.1.1 Single-ended Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  ---------- VREF -------------
> > +      ´ `           ´ `                  _____________
> > +    /     \       /     \               /             |
> > +   /       \     /       \         --- <  IN    ADC   |
> > +            \   /         \   /         \             |
> > +             `-´           `-´           \       VREF |
> > +  -------- GND (0V) -----------           +-----------+
> > +                                                  ^
> > +                                                  |
> > +                                             External VREF
> > +
> > +The input voltage to a **single-ended unipolar** channel is allowed to swing
> > +from GND to VREF (where VREF is a voltage reference with electrical potential
> > +higher than system ground). The maximum input voltage is also called VFS
> > +(full-scale input voltage), with VFS being determined by VREF. The voltage
> > +reference may be provided from an external supply or derived from the chip power
> > +source.
> > +
> > +A single-ended unipolar channel could be described in device tree like the
> > +following example::
> 
> We should probably mention somewhere that channel@ nodes are only needed for
> chips that don't have uniform inputs.

Good point, I didn't think about it when writing the doc.
Will mention it.

> 
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        channel@0 {
> > +            reg = <0>;
> 
> If a chip has mixed differential and single-ended, single-channel could also
> be needed here in the case where reg is an arbitrary number and doesn't match
> the input pin number.

Ah, yes. That can also happen. Will mention that too.

> 
> > +        };
> > +    };
> > +
> > +See ``Documentation/devicetree/bindings/iio/adc/adc.yaml`` for the complete
> > +documentation of ADC specific device tree properties.
> > +
> > +
> > +1.1.2 Single-ended Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  ---------- +VREF ------------
> > +      ´ `           ´ `                  _____________________
> > +    /     \       /     \               /                     |
> > +   /       \     /       \         --- <  IN          ADC     |
> > +            \   /         \   /         \                     |
> > +             `-´           `-´           \       +VREF  -VREF |
> > +  ---------- -VREF ------------           +-------------------+
> > +                                                  ^       ^
> > +                                                  |       |
> > +                             External +VREF ------+  External -VREF
> > +
> > +For a **single-ended bipolar** channel, the analog voltage input can go from
> > +-VREF to +VREF (where -VREF is the voltage reference that has the lower
> > +electrical potential while +VREF is the reference with the higher one). Some ADC
> > +chips derive the lower reference from +VREF, others get it from a separate
> > +input.  Often, +VREF and -VREF are symmetric but they don't need to be so. When
> > +-VREF is lower than system ground, these inputs are also called single-ended
> > +true bipolar.
> > +
> > +Here's an example device tree description of a single-ended bipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        channel@0 {
> > +            reg = <0>;
> > +            bipolar;
> > +        };
> > +    };
> > +
> > +1.2 Differential channels
> > +-------------------------
> > +
> > +A differential voltage measurement digitizes the voltage level at the positive
> > +input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
> > +In other words, a differential channel measures the potential difference between
> > +IN+ and IN-, which is often denoted by the IN+ - IN- formula.
> > +
> > +1.2.1 Differential Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------
> > +    ´ `       ´ `               +-------------------+
> > +  /     \   /     \   /        /                    |
> > +         `-´       `-´    --- <  IN+                |
> > +  -------- -VREF ------        |                    |
> > +                               |            ADC     |
> > +  -------- +VREF ------        |                    |
> > +        ´ `       ´ `     --- <  IN-                |
> > +  \   /     \   /     \        \       +VREF  -VREF |
> > +   `-´       `-´                +-------------------+
> > +  -------- -VREF ------                  ^       ^
> > +                                         |       +---- External -VREF
> > +                                  External +VREF
> > +
> > +The analog signals to **differential bipolar** inputs are also allowed to swing
> > +from -VREF to +VREF. If -VREF is below system GND, these are also called
> > +differential true bipolar inputs.
> > +
> > +Device tree example of a differential bipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        channel@0 {
> > +            reg = <0>;
> > +            bipolar;
> > +            diff-channels = <0 1>;
> > +        };
> > +    };
> > +
> > +In the ADC driver, ``differential = 1`` is set into ``struct iio_chan_spec`` for
> > +the channel. See ``include/linux/iio/iio.h`` for more information.
> > +
> > +1.2.2 Differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +For **differential unipolar** channels, the analog voltage at the positive input
> > +must also be higher than the voltage at the negative input. Thus, the actual
> > +input range allowed to a differential unipolar channel is IN- to +VREF. Because
> > +IN+ is allowed to swing with the measured analog signal and the input setup must
> > +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
> > +differential unipolar channel setups have IN- fixed to a known voltage that does
> > +not fall within the voltage range expected for the measured signal. This leads
> > +to a setup that is equivalent to a pseudo-differential channel. Thus,
> > +differential unipolar channels are actually pseudo-differential unipolar
> > +channels.
> 
> I don't think this is equevent to pseudo-differential unipolar. That one has
> a common mode voltage supply on the negative input. This one has a full range
> signal on the negative input. This is the diagram I was expecting here.
> 
> ::
> 
>   -------- VREF -------
>     ´ `       ´ `               +-------------------+
>   /     \   /     \   /        /                    |
>          `-´       `-´    --- <  IN+                |
>   ------ GND (0V) -----        |                    |
>                                |            ADC     |
>   -------- VREF -------        |                    |
>         ´ `       ´ `     --- <  IN-                |
>   \   /     \   /     \        \       VREF         |
>    `-´       `-´                +-------------------+
>   ------ GND (0V) -----                  ^        
>                                          |       
>                                   External VREF

I initially thought of a diagram like

::

  -------- +VREF -------
    ´ `       ´ `               +-------------------+
  /     \   /     \   /        /                    |
         `-´       `-´    --- <  IN+                |
  -------- IN- --------        |                    |
                               |            ADC     |
  ------- +VREF -------        |                    |
        ´ `       ´ `     --- <  IN-                |
  \   /     \   /     \        \         +VREF      |
   `-´       `-´                +-------------------+
  ------ -VREF ---------                   ^        
       	                                   |       
                                  External +VREF

for the Differential Unipolar case. Though, one thing I notice from unipolar
setups is that IN+ is expected to always be above IN- (never below). But, since
IN+ is measured with respect to IN-, we would not be able to determine what the
ADC output code would mean with respect to GND if IN- be allowed to change too.
We would only be able to tell the difference between IN+ and IN- and we already
have Differential Bipolar/True Bipolar for that. I think that's why IN- is
always fixed to known voltage (or very narrow voltage range) in those setups.
The same logic applies if IN+ is measured with respect to a common mode pin or
if a common mode voltage is applied to IN-. The thing to which IN+ is measured
with respect to must remain constant.

> 
> > +
> > +1.3 Pseudo-differential Channels
> > +--------------------------------
> > +
> > +There is a third ADC input type which is called pseudo-differential or
> > +single-ended to differential configuration. A pseudo-differential channel is
> > +similar to a differential channel in that it also measures IN+ relative to IN-.
> > +However, unlike differential channels, the negative input is limited to a narrow
> > +(taken as constant) voltage range while only IN+ is allowed to swing. A
> > +pseudo-differential channel can be made out from a differential pair of inputs
> > +by restricting the negative input to a known voltage while allowing only the
> > +positive input to swing. Aside from that, some parts have a COM pin that allows
> > +single-ended inputs to be referenced to a common-mode voltage, making them
> > +pseudo-differential channels. Often, the common mode input voltage
> > +can be nicely described in the device tree as a voltage regulator (e.g.
> > +``com-supply``) since it is basically a constant voltage source.
> > +
> > +1.3.1 Pseudo-differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------          +-------------------+
> > +    ´ `       ´ `               /                    |
> > +  /     \   /     \   /    --- <  IN+                |
> > +         `-´       `-´          |                    |
> > +  --------- IN- -------         |            ADC     |
> 
> The bottom rail should be GND (or -VREF), not IN-. Making it GND in the diagram
> would be consistent with the other unipolar diagrams and reflect most typical
> cases. I think the counterexample you gave of AD4170-4 is the unusual case
> rather than the typical case.

I'm trying to cover unusual cases (such as AD4170's) in this doc too.
I see the example on page 46 of https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
as a case of Figure 2a. Pseudo-Differential Unipolar from https://www.analog.com/media/en/technical-documentation/product-selector-card/2PB_sarinputtypesfb.pdf.
The difference is that AD4170 example has IN- set to 2.5V instead of GND.

> 
> FWIW, when I was first learning this stuff, I didn't really understand bipolar
> vs. unipolar until I saw diagrams that showed 0V as the bottom rail for unipolar
> and negative VREF as the bottom rail for bipolar. Even if it isn't strictly
> true in all cases, seeing the pattern was more helpful. Hard to say if most
> other people think like me though. :-)

Maybe have a "simple case" diagram with the bottom limit for IN+ at 0V like

  -------- +VREF ------          +-------------------+
    ´ `       ´ `               /                    |
  /     \   /     \   /    --- <  IN+                |
         `-´       `-´          |                    |
  ------ GND (0V) -----         |            ADC     |
                                |                    |
             GND (0V) -->  --- <  IN-                |
                                \       +VREF        |
                                 +-------------------+
                                          ^
                                          |
                                   External +VREF

then follow up with the more generic case?

> > +
> > +A **pseudo-differential unipolar** input has the limitations a differential
> > +unipolar channel would have, meaning the analog voltage to the positive input
> > +IN+ must stay within IN- to +VREF. 
> 
> As above, this is not strictyly true. On the chips I have worked with (at least
> two out of three different families), IN- is VREF/2 and IN+ can go from GND to
> VREF.

Hmm, but then the channel is Pseudo-differential Bipolar, no?

> 
> > The fixed voltage to IN- is sometimes called
> > +common-mode voltage and it must be within -VREF to +VREF as would be expected
> > +from the signal to any differential channel negative input.
> > +
> > +In pseudo-differential configuration, the voltage measured from IN+ is not
> > +relative to GND (as it would be for a single-ended channel) but to IN-, which
> 
> This is a bit confusing because you say not relative to GND, but then below, you
> say that GND can be connected to IN-, so it would be relative to GND. So might
> want to qualify this GND is different than external common mode voltage GND.

Yes, it is relative to whatever is connected IN-.
If 2.5V is connected to IN-, then the ADC measures IN+ with respect to 2.5V.
If GND to IN-, then the measurement becomes relative to GND.
I'll try to explain it better, maybe provide some examples?

> 
> > +causes the measurement to always be offset by IN- volts. To allow applications
> > +to calculate IN+ voltage with respect to system ground, the IIO channel should
> > +provide an ``_offset`` sysfs attribute to report the channel offset to user
> > +space. In cases where IN- (or the common mode voltage applied to IN-) is GND,
> > +the ``_offset`` attribute may be omitted.
> > +
> > +Device tree example for pseudo-differential unipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        channel@0 {
> > +            reg = <0>;
> > +            single-channel = <0>;
> > +            common-mode-channel = <1>;
> > +        };
> > +    };
> > +
> > +Do not set ``differential`` in the channel ``iio_chan_spec`` struct of
> > +pseudo-differential channels.
> 
> Some might appritate an explanatin why here since it is odd to have differental
> in the name "pseudo-differential". I.e. because we consider the negative pin
> a voltage supply rather than a second anolog input.

Okay, will add that.

> 
> > +
> > +1.3.2 Pseudo-differential Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------          +-------------------+
> > +    ´ `       ´ `               /                    |
> > +  /     \   /     \   /    --- <  IN+                |
> > +         `-´       `-´          |                    |
> > +  -------- -VREF ------         |            ADC     |
> > +                                |                    |
> > +  Common-mode voltage -->  --- <  IN-                |
> > +                                \       +VREF  -VREF |
> > +                                 +-------------------+
> > +                                          ^       ^
> > +                                          |       +---- External -VREF
> > +                                   External +VREF
> > +
> > +A **pseudo-differential bipolar** input is not limited by the level at IN- but
> > +it will be limited to -VREF or to GND on the lower end of the input range
> 
> 
> If it was limited to GND, then it would be uniploar. It is only bipolar if
> -VREF is less than 0V.

I would still call it bipolar if -VREF can be less than 0V or even true bipolar
to be more precise. Will check out if these naming makes sense with engineering
folk.

> 
> > +depending on the particular ADC. Similar to their unipolar counter parts,
> > +pseudo-differential bipolar channels may define an ``_offset`` attribute to
> > +provide the read offset relative to GND.
> > +
> > +Device tree example for pseudo-differential bipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        channel@0 {
> > +            reg = <0>;
> > +            bipolar;
> > +            single-channel = <0>;
> > +            common-mode-channel = <1>;
> > +        };
> > +    };
> > +
> > +Again, the ``differential`` field of ``struct iio_chan_spec`` is not set for
> > +pseudo-differential channels.
> > diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> > index 5710f5b9e958..48b88044d7cb 100644
> > --- a/Documentation/iio/index.rst
> > +++ b/Documentation/iio/index.rst
> > @@ -7,6 +7,7 @@ Industrial I/O
> >  .. toctree::
> >     :maxdepth: 1
> >  
> > +   iio_adc
> >     iio_configfs
> >     iio_devbuf
> >     iio_dmabuf_api
> > 
> > base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b
> 

