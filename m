Return-Path: <linux-iio+bounces-13020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37F9E1BFA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2908167529
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F01E5705;
	Tue,  3 Dec 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJLzxgE7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE71E4908;
	Tue,  3 Dec 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228347; cv=none; b=fDfWw7K8SctupJQc8+T6fhMK3+jdznhFg2ZzkSw8RL559ui57JUJ47IQ3pEsbNlUbG4RLGliIA7uUURdRFYVZvnMrxJaxvtN0ehUpyuE+avvPY3KhEiNryYUzWrAg0aVxzrqX0QPCyAgnQwe+VxM0qLEG41/2QqIOowBqsoipuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228347; c=relaxed/simple;
	bh=ndKEPt7of7/kxIz3Ya4S9dp3qvpwDd3rQMoPCIHXakQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6SThhRi+bvTw4jNtDZpqXfIOebpiK3AOPxzyo/O8SCqeyQvCoH+j4g3inwHtWv4iiVH+4qGfiQ27y0rjFTobGu1+ZPnyiEn4I+T6XEyxgDXZeopRNbiTf/QfmcIGpCGtERPsgxVin5vO6EUteO3uWGa7a+xanAoJ/0yxPH0Qi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJLzxgE7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so3113981a91.1;
        Tue, 03 Dec 2024 04:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733228345; x=1733833145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9N4bf5lFwCp0Geh+81OBCgf6RNbshA4H4t2xhZyJ0I=;
        b=IJLzxgE71U5bjJU9Rx1E5GXZFltE5dC7QPaNjq3joI8PcmZbkJHECMqnGzUw0Suq1V
         yaQ+i3N7g0ffX6oaBYCgBWz3IkuJgLsYuUNi8D7s6hRy4yfG312tcNikCgIkFAKnAU51
         kjbGLk0easiyfmRegKW9ld//K3VM7N5Erh4I2RsIrC47gz4QdfoozGwfIrU0i1seU3bU
         24RfBOhCEsNg3ZdKTI3IZJvgoSz3FosOGrk7sOpcmyEp5QNlr0claUpso7MjYOuHYVI8
         q2u/BH5tLCsC9lRgLH4cND8s3qtpQQsS/IyIRfbSaZN2XKHipcCcmafHRHAHJHQlIdSk
         gt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228345; x=1733833145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9N4bf5lFwCp0Geh+81OBCgf6RNbshA4H4t2xhZyJ0I=;
        b=XB42rBaM2KXMR4KYHYiDWxr4VVPteRzWu6oWLajeVBRLIRvDVbM68gZGN4dXIk9nl2
         lhQ96N4jVRTBF5ofEDFOXWk/5sQ0xPLWleOx13ys/xaBrm3pKVMYgmb8nz3jkGnoL3a7
         X737w2AdAAfIUBUvVVDoJFMG0evu481Yzaw3OGFQk6lID1dIG3dykVzvJljBtkZ34AHI
         KsDPZ0o5slpc/cxAs6ZYyso7fbeKv6YGY+dsFM7KnSZyueYVATH17dRQlafGxJ0PY83Y
         lsIAB6FfNBlYYONbVYn9PYfQH3KsFsJefIHNsrInKIDfVYC82jaR8m/DKO6gqRK14dpP
         fWyw==
X-Forwarded-Encrypted: i=1; AJvYcCV1mQVMnrXbeCcQAp42fNlLRAv4aSxOH8LVDBfD07IAKAkUdELHmI2WbzBuRLYEc+DezYspr7k4dBPSyWY0@vger.kernel.org, AJvYcCWM5e4w3F5n+QMLwEDMzY8IofRgJd23vS26pd1YksNTtBPmi8/C5atKSdLC0o1BiGVYRIwd+4jVfXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgtUhWXsrPZdFECwp87jUAceGUXo6Wjz1bhYIcHfiywk0t3mH
	2uakvOMtTvmneiGj7x/SOa6pMWp6I8UDcMZ9EZiUGeexwVO9jVVi
X-Gm-Gg: ASbGncvk8QqbwWzEE/vpcJVgZD0vJojBwrI9TjscdOMZwqYRL5VG89Hr4k2k/Eca9ty
	evoUFT6T3baZgwJ2p8HKICTDWXNQ2v2nMGQHerrxbXk3I8v7yheH7x089wrMhqpRWMdKSYUMCBD
	qAuf4HC6R9zGKJBn534n4mCC/LjwbYEa7XCwWUWOC5tCMic0CweHiZeKZkUJvEqskEtz9qvfLLW
	3Huqu6B4Kx0nrVkOUKRwJARHCRiGHfcA95T3ezsX16oRH/NBdo/tk0pJSM=
X-Google-Smtp-Source: AGHT+IFpphu+frZ+0DihURUZf8DhfsSFTBOlZqNjtMtBQudjLmN08seIWfD4cJJjCl+fZZFpr+d/qQ==
X-Received: by 2002:a17:90b:1c07:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ef012101demr2966167a91.20.1733228344698;
        Tue, 03 Dec 2024 04:19:04 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeab112db4sm4585179a91.43.2024.12.03.04.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:19:03 -0800 (PST)
Date: Tue, 3 Dec 2024 09:19:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Guillaume Ranquet <granquet@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 1/1] Documentation: ABI: IIO: Re-add
 filter_type/filter_mode
Message-ID: <Z073UvHZToWl88f9@debian-BULLSEYE-live-builder-AMD64>
References: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
 <52513d34-8484-4c4b-8f87-29cbbdcefc06@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52513d34-8484-4c4b-8f87-29cbbdcefc06@baylibre.com>

On 12/02, David Lechner wrote:
> On 12/2/24 12:22 PM, Marcelo Schmitt wrote:
> > The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> > in_voltage-voltage_filter_mode_available attributes to user space.
> > The ad7779 driver exports filter_type and filter_type_available.
> > Add (back again) documentation for filter_type/filter_mode attributes.
> > 
> > Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Digressing a bit away from the specific ABI used by ad4130 and ad7779,
> > the sinc3/4/5 filters are called `filter_mode` in ad4130 driver while other
> > drivers (ad7779, ad7124, ad7768-1) call sinc3/4/5 filters a `filter_type`.
> > Datasheets use the term `filter type`.
> > 
> > Depending on the particular ADC chip/design, the sinc3/4/5 filter configuration
> > may have an impact on the output data rate (ODR) (which is equivalent to the
> > sampling frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff
> > frequency of the filter (`_low_pass_3db_frequency` attributes), or settling
> > time.
> > 
> > ad7768-1 sets sinc3/4/5 according to the sampling_frequency attribute. No
> > filter_type attribute.
> > 
> > ad7173 sets the filter_type according to sampling_frequency too, though it
> > looks like support for only one filter type is implemented.
> > 
> > ad7124 sets sinc3/4/5 filters according to a filter_low_pass_3db_frequency
> > attribute so it doesn't export filter type attributes to user space.
> > Missing `in_voltageY-voltageZ_filter_low_pass_3db_frequency` documentation?
> > follow up patch?
> 
> cc: Guillaume and Uwe since they are working on these last two drivers
> currently. Maybe something they could address?
> 
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index f83bd6829285..704c9033cb5b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2268,6 +2268,20 @@ Description:
> >  		An example format is 16-bytes, 2-digits-per-byte, HEX-string
> >  		representing the sensor unique ID number.
> >  
> > +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> > +voltageY_filter_type_available
> > +KernelVersion:	6.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Set the filter mode of the channel. When the filter mode
> > +		changes, the in_voltageY-voltageZ_sampling_frequency and
> > +		in_voltageY-voltageZ_sampling_frequency_available attributes
> > +		might also change to accommodate the new filter mode.
> > +		If the current sampling frequency is out of range for the new
> > +		filter mode, the sampling frequency will be changed to the
> > +		closest valid one.
> 
> I think it can be safely assumed that changing any IIO attribute can
> cause any other to change, so we probably don't need to mention the
> sampling frequency interaction here, especially since it doesn't apply
> to every possible user of these attributes.

Besides these filter attributes, the _offset attribute was allowed to change
after a change in _scale for a different driver so I'm also thinking IIO
attribute changes are allowed to cause updates to other device attributes.
The description above is roughly the same that was removed in 01bb12922b60.
Can think of something more accurate if that would be appreciated.

Jonathan, let me know if you prefer to re-add ABI doc as it was or if we
can re-add an updated version of it.

> 
> Some other useful things to add instead:
> * Mention that the values are the same as the ones listed in the
>   "..._available" attribute docs.
Sure, will do if going to update the ABI description.

> * We should deprecate one of the names and recommend the other for
>   future drivers to use. Since "type" is used more than once and
>   "mode" only once, it seems natural to keep using "type" going
>   forward.
Agree.

> 
> > +
> >  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> >  KernelVersion:	6.1
> > 

