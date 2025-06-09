Return-Path: <linux-iio+bounces-20337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9FAD27CA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 22:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A417150F
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6592222C0;
	Mon,  9 Jun 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYtANG+U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974B221F04;
	Mon,  9 Jun 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501474; cv=none; b=GRMPCfqAN8Nb7GWQQcbFKtmbJ/H6z4LYS0njIgeK9VX0Xd3ZyPXr+BuX9A2v9AGiXatvtqBR9xi/Zin6jPmjD4rv8qJ59/06OtZS3yufD35guYXJN6E6cxez5RG5Kd8Ey8ZorCJPDBvcIKbwQfuLe2K63hpar23U5uJZYnmGlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501474; c=relaxed/simple;
	bh=UE4n9Qnosa2235rzDwGPsvTcvXQdaZ0oSidraCV0XZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCQKT6LPFGRPOwioZergIymvEfjOM20xwaBkdxnXZrBToyijg9f3f8Tv/IBkXur04MuYQ4L6p4sW3e6YRryz8WP5HCKljAm9UZfIQ715UiPMGl9f7W3izsPl1yzi9r7kt6ESidSaS16knaAr07bievf7Ns/rG3MSdwrgEdjnNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYtANG+U; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso315756241.0;
        Mon, 09 Jun 2025 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749501471; x=1750106271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gE1gVQ5/0tpKyFzIE8Tmr8d8PMFcEbwVcWJ4zzHlSw=;
        b=FYtANG+UvBskz/rArW67QsauoKDhXIMNCwctcTuqSbm2uyWQ95zO6yx4BUjFP/XFd3
         ep9prhDl18maPFp4KA5qh19qIgWrr+pLlgMoMAbc/9nBssXL+CexEy61nxlYGZ5zKSi6
         uUdFdchqprVsvHFJxazoOuPr0h+ZnRjI9f1oRLuZIZxiDQhalQPghbJHVWIoL1nAquZ3
         kWHPUhEqQ+ftqchObKmd5YNJ27oIqTVEadYP0AS6UruVceATf4P7d91cgDnocoqUtYVn
         B6qbx3aMwj1ej6TTy50AFuJ0BM2avPfSxcGiauOq6QtcVAqlXg5wSeEBLd2RTo2hafLb
         Mvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749501471; x=1750106271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gE1gVQ5/0tpKyFzIE8Tmr8d8PMFcEbwVcWJ4zzHlSw=;
        b=A3aoDl3qF01U8zavbk5gMonLKI8Wj7wPb8/iShN8GsNk9Wr6pr9WCu9bHgBav8MK20
         E0ji3wC7UBER8ERB35E3qTwnIjKDXIDm8gzeX9CNKNi68+p/RhaWUdwx2jIy51U2xxdj
         Dki3RgTziBQXVBOn2U5+jIm4reOlfKchM/t1pquqeJXsUCr+cI/SSuLuTQ20ZJ1G0eWV
         2sSSK5zoThV63gH8lZkML/xQau83YGe7UtWQ+Xy2hh1EPlMoppm085sZod572l37RRtC
         P5VgIEysF68osvXA/Pjj7oNyYRyV3m4cO06C5YpYilGYjpy87FU2Zw6pBRDVfRDwlYep
         ynMA==
X-Forwarded-Encrypted: i=1; AJvYcCUtD7gaRg/N28w4SSNL5ewtoBwnqSZl4dYdbO00l/gNdrFw5o4hoxgYAhHVnJcwbwyAdANzq1rL4wvR@vger.kernel.org, AJvYcCW2n6w1oWEBwBel1mGQUzveCNs19gSpzer5kJ3XqkJIWG+PxuBE6NCva9rAi+l0pt9q4AHmdd7f3TpZ@vger.kernel.org, AJvYcCWvGnyfAnSLktoHwaTInYexfWFrDCp6sHy00g3VXql3EDzIZ/MUCQ65itynVyssjBgLBHFO+O/oP92DIet9@vger.kernel.org, AJvYcCXSEkG7UGLIhR3JCHDjQNYYuCIGnYNaToLDoDpH77NaejhQwPuP9CwxRlPeIQZpuTgaefEC5QAhrFvo7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVOn512deoLS2Ql55P3iRASLXGl6kpCGhjOnqdIcNJ5I4h2ml
	XowwLeVDK8mB3MTWZbiFzP3sSlzs/TZngzpNFTYJirSoo3bekbvp7mgq
X-Gm-Gg: ASbGncuKCw1xd8NT2sfcPYZ+Y2tMAcjfHEJ6f/gCqpFSkPJu13xUQradkLn3HAVwo8V
	8/9T3vgsykR3qieK4xj7pc/gSTv8ZUsyyOw+sebj0ZMFoxZQgkPCwbMXW8ll0KGe31zsAh6uRHI
	2pbiDqqnErpaDYWyijeHCIklNvZmaD0keBtsgUeTj0OGovTcmlzKa8irJ/iy+YLImNY1sEwQWiC
	A+AF/SOi4bcG67M5pqprRShOCe4A4iQlwcBZNKpd1bJEQyQ5z/CJ3czxL3pfdmXfQXrdLAI9jl/
	A6zTlQLQIA1uHktDJH8Msz/oQho+dplAqTl6preKKyXwwuiUsxIl6ER0WlainQ7f8kzfCZM=
X-Google-Smtp-Source: AGHT+IGxyPfY31CgCfnmOutOq6qrJe0QJCngN+4qSSYmv5qx2dzdvpEyT3+QADqh6cykAvhVRDrT6A==
X-Received: by 2002:a05:6102:b0a:b0:4e7:596e:ec11 with SMTP id ada2fe7eead31-4e7a820015bmr167378137.5.1749501471520;
        Mon, 09 Jun 2025 13:37:51 -0700 (PDT)
Received: from localhost ([2804:30c:4000:5900:b4c4:6073:1a92:4077])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-87eeaf3b6b0sm246816241.16.2025.06.09.13.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 13:37:50 -0700 (PDT)
Date: Mon, 9 Jun 2025 17:39:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v4 06/11] iio: adc: ad4170: Add support for buffered data
 capture
Message-ID: <aEdGhYOJ36IcZFW7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <1e966af21b33b7dd969e1faa8126159c5dc501f7.1748829860.git.marcelo.schmitt@analog.com>
 <20250607180658.7db5271c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607180658.7db5271c@jic23-huawei>

...
> > diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> > index 3d83c3ace569..86ef70acbf21 100644
> > --- a/drivers/iio/adc/ad4170.c
> > +++ b/drivers/iio/adc/ad4170.c
> > @@ -13,7 +13,11 @@
> 
> > +static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
> > +				      const unsigned long *scan_mask)
> > +{
> > +	unsigned int masklength = iio_get_masklength(indio_dev);
> 
> If this becomes a useability issue we could probably generative appropriate
> available_scan_masks entries and let the demuxer in the IIO core deal with
> dropping the unwanted first channel.  That might be preferable to just
> failing if the channel isn't enabled.

Yes, we can do that. I also think that would probably be the preferred way from
the user's perspective. Though, that tinkering may result in a few more tens of
lines of code, which I'm reluctant to add, given the size of this set.

> 
> As a general rule, I think we've always used validate_scan_mask
> to prevent too many channels being turned on, or incompatible sets of channels
> rather than to prevent too few being enabled.
> 
> Anyhow that would be a relaxation of constraints so can be done if it
> turns out to be needed later.
> 

Added to my list of patch ideas :)

> > +
> > +	/*
> > +	 * The channel sequencer cycles through the enabled channels in
> > +	 * sequential order, from channel 0 to channel 15, bypassing disabled
> > +	 * channels. When more than one channel is enabled, channel 0 must
> > +	 * always be enabled. See datasheet channel_en register description at
> > +	 * page 95.
> > +	 */
> > +	if (bitmap_weight(scan_mask, masklength) > 1)
> > +		return test_bit(0, scan_mask);
> > +
> > +	return bitmap_weight(scan_mask, masklength) == 1;
> > +}

