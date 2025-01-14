Return-Path: <linux-iio+bounces-14349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDBAA107DF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E107161DA9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48C23245E;
	Tue, 14 Jan 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJE0G3EH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F223242C;
	Tue, 14 Jan 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861567; cv=none; b=tLNm2jTNyx/o93f3bUKAJi1ikuELA5836DFd3jZ61XinpzERsdZAfjza/YJ2glKli1WpHkWJqT1lZO4OuwOirXGSRBcWWnYhc6U70CrqR18M2KAB58Mhcu9n9oOdUFoNUg63sCsY00bLnKtIKFTGzlH6gJ9DHoTmp7cUHY3+xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861567; c=relaxed/simple;
	bh=f6aqgZ46bjyyqVGShYy3BoNKxKRGr6RRMtBGN70l47A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4S3k0wSzB669ClnlAX0V5VlVHtmWR4/+jpF/aE88j6AtK4SetushWACtkqt5UuzB6+2qo41ABDDECNcg3Nk63H8b0kz3G6s+ZryajUJWYBR+8D1BjkLLrZkqg/KHJQvlb5TfHyDyw3tINk50G7O/HEbq0Gsst7MiF4MXAgiq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJE0G3EH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso92706635ad.1;
        Tue, 14 Jan 2025 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736861565; x=1737466365; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bZeG/uMUsF0yO47OSaC/bZ8bFWcz9lonly3sxegxBx4=;
        b=EJE0G3EHfWOz0iv71fyAC/yD+K5aRJL9FUMWogKyOnB44ILqOHvYGJuiAmqpBfojJ3
         mUDwXB5qpbtGEL53e8yKrquhe/AMX8Wxyrr4m06v/fo2bfZmjyeujXrvjBu+8sdNm9Lu
         2GZ6ErwyWh7C7TMYkvcIFgN/YHC5MI/0wm2EmMYJhA6XTZubLhC2StryRKQfMs81GSuR
         m8rjQ84qknFexog/RardveG0u8wOJz0GuUW7zPpdUGYnqoLfK9e5JqkkwVMFWELb3zqE
         QZdkl3V5WAe422MElB9Jmdl9W85ewXG6S6P9f41gooTRQCo4nZZ8YS3OFJm1IfBXpO9N
         HpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736861565; x=1737466365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZeG/uMUsF0yO47OSaC/bZ8bFWcz9lonly3sxegxBx4=;
        b=CXupSVxeL2G6lL01HdqLfJgVF5owlt0mFn+ELCjdUu4iCiWSUh0/9Ms4kZiXLgdSgD
         0sXOUYc7Pqx3U7/ap48qJHWbk1tMgKw8/wbxHi7AzqzREUfAoPHQ/eCN7waJdpk2f33G
         psF9roljAEmaYmEwpyaoBNQ/NbYyY7rYQYcMkkc+0xCez0TglyBrwD924ELUE9+WPWi/
         t4GQo9kpjrq3IPEnE/YPX2To7HbV0+I3HtBZ8Vx6yM9KwulRENMbnoQWLOUukbRGGBKm
         Sn8vQKilbOr9imS3MXj4BRocJWJ87mTTrMv9D5peZoz6qGdZX1xPzsDCoJ+8SICecYJr
         25Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU3qpOnwZDf2fjyHFV2ynUg1B7n0BdV0cM8vVtHIgeJflyn8V8KHCjGib1mZ/YpfKadlLEsXzXWR9/b@vger.kernel.org, AJvYcCUFe7L4CLUGzcKADf9X+rVvzYTir/hWgq0r9BpOqMuhim1miqqTZ89fV1xCCh6SqjCBG51mwIjO6obQ@vger.kernel.org, AJvYcCUfPvUQQ44IiVFkziF4S8ky1B7oWc0fnsdJGP8TW/dbcbHpf0wLJgAzQJufv6KVMLrD1Z+7QiYffOVLgNPx@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJCvSgaSVomwORyfMIOxiOITyxRoiV6eY8bj095s/5yHzP1wk
	s1k9MofOfK1wV1sfKjx87Tms4UQ7BCATEX5dhvb6YoXsK8h38o9p56Ikuc1k
X-Gm-Gg: ASbGncsBCa66pcalRTjnPZJRm5ZyBdsoYDcy2E+g2/61E7hI5aLFiJiNMXL/ONPYTqU
	JdYWenJVVriJPuRAOjJKyAAqw3akLcQoS5ucOKd1Gz1hoFGKlVLT5Yy67GTjg2hcNyC0coKmbPC
	g+FtkwdZzGLlgt7yp4SHprqz7e3UVJ6X5EPBUkrOj77oeXaT8i0DLxyVqpCXbpRgDTqi8E5S5Sl
	iBF6amQLwi42vV4w0u2FjtOYLR3u9FutGfjt+88h01SMDQzq2RraUhbcTUFx5vxIYI=
X-Google-Smtp-Source: AGHT+IEPZZs6Zdmm5r9Le9e5Sf47X5M+vddBclOzbdEarkSPHlYFGoQV9T7jdBGFqx63Ml9jGuURHw==
X-Received: by 2002:a17:902:d4c2:b0:216:393b:23d4 with SMTP id d9443c01a7336-21a83f422c0mr389641255ad.11.1736861564511;
        Tue, 14 Jan 2025 05:32:44 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f26d996sm66762045ad.257.2025.01.14.05.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 05:32:43 -0800 (PST)
Date: Tue, 14 Jan 2025 10:33:18 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ana-maria.cusco@analog.com
Subject: Re: [RFC PATCH 4/4] Documentation: iio: Add ADC documentation
Message-ID: <Z4Znnk0Cz3wvH6Vp@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
 <48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com>
 <a2e76ca6-ec21-4ce5-91f7-4d3a0ed792ce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e76ca6-ec21-4ce5-91f7-4d3a0ed792ce@baylibre.com>

Hi David, thank you for your suggestions.
I think I've applied most of them and will soon send a v2 only with the docs.
Replying here mostly on the comments I didn't comply with.

On 12/18, David Lechner wrote:
> On 12/18/24 8:38 AM, Marcelo Schmitt wrote:
> > ADCs can have different input configurations such that developers can get
> > confused when trying to model some of them into IIO channels.
> > 
...
> > 
> > Add documentation about common ADC characteristics and IIO support for them.
> > 
...
> > +In the ADC driver, `differential = 1` is set into `struct iio_chan_spec` for the
> > +channel. See ``include/linux/iio/iio.h`` for more information.
> > +
> > +1.2.2 Differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> To be consistent with the other sections, move unipolar before bipolar.

I had differential unipolar before differential bipolar on a
preliminary version (not sent to the mailing list), but it lead to a much more
intricate explanation of differential unipolar. That's why I prefer to keep
the Differential Unipolar section after Differential Bipolar.

> 
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
> The diagrams are really helpful, so please add a diagram in this section as well.

There is no diagram for Differential Unipolar. What would be the
Differential Unipolar diagram is the diagram for Pseudo-Differential Unipolar.
Having Differential Unipolar section here also makes it closer to the
Pseudo-Differential Unipolar diagram.

> 
...
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
> The bottom rail should be GND, not IN-. Typically, the common mode voltage is
> VREF / 2. In other words it is halfway between the two rails.

IN- may be above GND (e.g. at VREF / 2 as a typical common mode voltage).
In that case, the minimum voltage for IN+ (i.e. the bottom rail) would be VREF / 2.
The generic constraint would be that IN+ does not fall below IN-.
See bipolar/unipolar configuration section of AD4170 datasheet page 46.
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
On that example, VREF is actually a differential voltage reference that is
2.5V nominal voltage (halfway between 5V AVDD and 0V AVSS).
If IN+ is allowed to go below IN-, then this becomes Pseudo-differential Bipolar.

> 
> > +                                |                    |
> > +  Common-mode voltage -->  --- <  IN-                |
> > +                                \       +VREF  -VREF |
> > +                                 +-------------------+
> > +                                          ^       ^
> > +                                          |       +---- External -VREF
> 
> This is unipolar, so would not expect -VREF here.

I think IN- could in theory be negative (bellow GND) if the ADC inputs are
true bipolar inputs. Though, I have never seen such thing so can't say
for sure. Anyway, -VREF is not doing anything on this setup so I omitted it in v2.

> 
> > +                                   External +VREF
> > +
> > +A **pseudo-differential unipolar** input has the limitations a differential
> > +unipolar channel would have, meaning the analog voltage to the positive input
> > +IN+ must stay within IN- to +VREF. The fixed voltage to IN- is sometimes called
> > +common-mode voltage and it must be within -VREF to +VREF as would be expected
> > +from the signal to any differential channel negative input.
> > +
> > +In pseudo-differential configuration, the voltage measured from IN+ is not
> > +relative to GND (as it would be for a single-ended channel) but to IN-, which
> > +causes the measurement to always be offset by IN- volts. To allow applications
> > +to calculate IN+ voltage with respect to system ground, the IIO channel may
> > +provide an `_offset` attribute to report the channel offset to user space.
> 
> In some chips though, the common mode voltage may be GND. (Example is AD7944
> that calls this "ground sense"). So in that case, there is no common mode
> supply or ``_offset`` attribute.
> 
Added a comment about it omitting the ``_offset`` in those cases.
My understanding is that, because the common mode voltage (or ground sense in
AD7944's case) is at GND, the ``_offset`` is always zero and that's why the
``_offset`` attribute is not needed in that case. Whenever the common mode
voltage is at something other than GND, we would need ``_offset`` to be able to
get the voltage relative to GND.
Oh well, that's just another way of saying what you already told me I guess.

