Return-Path: <linux-iio+bounces-22304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B78B1B01A
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A07188BC5B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957111F30AD;
	Tue,  5 Aug 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjyH4tGk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7C1A5B8C
	for <linux-iio@vger.kernel.org>; Tue,  5 Aug 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381773; cv=none; b=UTu671IgDu/HJhfv/d9DfEyAPCpFfVcgyOVQxXQpxVm6t9UpULEPL/yeQJikoau7zgKMZe8QOQW2jUwcr309buUyHT3CZLYP0FnUV2ncQXDUpXiCURlS6CG4PJ6MVAZqc6L31RZgBt9PPbNwNEQVgDheP24KzATfV4Z2zfhdLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381773; c=relaxed/simple;
	bh=g6si8eJh0xc3DeXG/Opmm/894QDOGzOPcVXhzyEV42I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMm1tdjdR/yM8M2a8ysSzvAp+4aB5g/+UDY7/M+uBwP0HSt2uFfpEl6iiFzkplNUxhmfP+DoFTdIIuMMaT88rZgWQVssamOxBvH+zKEEgeSgQVDCeUlyeKi+lhKXcIUap0FjDI+Y+vyTuOqHNn/DedoJsQ9LIj2oURA7TcWMm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjyH4tGk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af934d7c932so568047966b.3
        for <linux-iio@vger.kernel.org>; Tue, 05 Aug 2025 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754381770; x=1754986570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dMGO+HaB0zXfHLtg8g39zHJMDEjQjrl9X36A+GWEXKo=;
        b=hjyH4tGkpPqVrHMNBf/io0cCUJLtnmB3iX0H3DQz3FQw1berfOlXEXIa1zx1VXnHoi
         s6+SlyJMBirlJs/dnqixIwL+AbsSZajc6uCSGSxjvWTAzD5/8f8yez2k/N9I0RpwVaNA
         1JdXMgJFyXy4W8EdV6Qk8ib52gUzAFJ9m+VomgPb9PXz4Nv4s1vQrvzW5OT/Gy6Gc025
         JAZ1qHiNZi1FYQ8x8GawMn/A55t/bNgZwuxbXkwTIB/FIRogbdjDIGLtePSx3BQ86x5P
         6QeSkstPGXOz6pN96qv/qQz4zYIdyZ9ox5buJo6trEZQgWuL94Z1jAIKKT3maYV8gEQX
         f/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754381770; x=1754986570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMGO+HaB0zXfHLtg8g39zHJMDEjQjrl9X36A+GWEXKo=;
        b=aUaMhuB4f6X0eZ6ymhK2u273mZMuBkFxDDImNafhDGvNfbOV+a7xRfizvC6CDkJYvB
         /8607botTNYz4ekXBrJEhjarNHMj3WLqSk1X0llCXDJv2vz73FOPp5rZoWRQAWgbDPJh
         r6pDlPMDX3iFQfIfdv1r4u6jOTwHGcHtsV3BtJKANuy21txwkzeNN/7x+Vxisr3Q5HZf
         V0ORdfQcj032XlawilktjKGF8d8v/obbf8n8WpYDK3koaW1VcYZZ1KxuC0bYciIrWouT
         JiE5gd5whm0WAfakhZeVtzgpMhvSs6kS4PEqUxaByRXiwBc4Fjey0bD5+GKliwqXxuQx
         7xGg==
X-Forwarded-Encrypted: i=1; AJvYcCXSj6q4li2Ydi2y3jrfw1zVHkLi9jQb7g7pwQpo4P8nfWg2FFQ/IzcHIIYVK+SDGTA9DmvPJGz44vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGY5bINGZxUeeafHEIo2bVmFct/cOH5GeTX+QpxhtAMLcA54fC
	7VbU2R3sTCV0Ap/C2AHeB5mtheFQEIZXaqI7wwx30OQ9veQiFWZnW8Iq
X-Gm-Gg: ASbGncuYEGJXoPlDvrxZVMUFtkItTfd1sjFVlribxhBaie3XslQZB7tKlAGoy6u1ksp
	0//W7qPM7+pv7tM2PQqtLux4MWG+01ZJToKxl5BRyYpA9LdkzLUrkxMKgvsyybt2EomE0rLuh+0
	VUlVC7TEN77rlLjnoCZ3vxrDfLdUsuuKcvJ7/+fqCdDrdVs0x+DogmK27YLbq8L8KZ61hd8hVJF
	Oav9I3+Ig39/225wG8R1ze0t4E6bMME1sWYWaxQmZfjceZDQLTUv6RVMb4Y/j/y1mlJDBxyQbW4
	e8Yu3jIGjDds4QWMoJEJMon6JzX1wN5We/HJirTgiPomv4GjQFT3WColNreWE2oY5YcbBRxjypt
	n1vCQRJyhk4gAUw==
X-Google-Smtp-Source: AGHT+IHQ+7V5/Thlw//tNgLaFg1z0P4CzyXhECwl+t9iycNnGvyEalEPfioL23BrlJrDC26evMvXOw==
X-Received: by 2002:a17:907:7f90:b0:ade:8720:70a0 with SMTP id a640c23a62f3a-af94001cb4cmr1359615766b.20.1754381769752;
        Tue, 05 Aug 2025 01:16:09 -0700 (PDT)
Received: from nsa ([91.205.230.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078cbasm868741166b.5.2025.08.05.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:16:09 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:16:26 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shen Jianping <Jianping.Shen@de.bosch.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
Message-ID: <zaymyis6xp4t6qz6se2xehj4gp4lzaybuu2vzabew3pxqoxtsf@36dykzwuloq6>
References: <20250802171539.518747-1-jic23@kernel.org>
 <73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
 <CAHp75VcuWfQtxrhdZeX4cZ3aNnCZb1mKbZaUPVwF8oOnfpPcFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcuWfQtxrhdZeX4cZ3aNnCZb1mKbZaUPVwF8oOnfpPcFw@mail.gmail.com>

On Mon, Aug 04, 2025 at 06:02:22PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 4, 2025 at 5:37 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Sat, Aug 02, 2025 at 06:15:39PM +0100, Jonathan Cameron wrote:
> 
> ...
> 
> > > +     /* Walk remaining bits of active_scan_mask */
> > > +     in_ind = find_next_bit(indio_dev->active_scan_mask, masklength,
> > > +                            in_ind + 1);
> >
> > I wonder if it matters to check that in_ind + 1 is in fact lower than
> > masklength? Not that it will be an issue for find_next_bit() but we will
> > fail the expectation:
> >
> > if (unlikely(__start >= sz)) [1]
> >
> > And being this a sensible path, I thought it's worth (at least) questioning...
> 
> It doesn't matter. The find_*_bit() are all aligned to return sz for
> anything "not found anymore" cases, so it will be okay.

I know :):

"...Not that it will be an issue for find_next_bit()..."

I was mostly worried by performance as we'll have a compiler hint that
will pretty much fail (that ´if (unlikely(__start >= sz))' for every sample we push and 
I guess the CPU will have to unroll that prediction. Maybe it will be smart enough to
adapt.

But as I said, it might be neglectable but still worth at least
questioning...

- Nuno Sá

> 
> > Other than that kind of nit comment, patch looks good.
> >
> > [1]: https://elixir.bootlin.com/linux/v6.16/source/lib/find_bit.c#L50
> 
> > > +     while (in_ind != masklength) {
> > > +             ret = iio_storage_bytes_for_si(indio_dev, in_ind);
> > > +             if (ret < 0)
> > > +                     goto error_clear_mux_table;
> > > +
> > > +             length = ret;
> > > +             /* Make sure we are aligned */
> > > +             in_loc = roundup(in_loc, length) + length;
> > > +             in_ind = find_next_bit(indio_dev->active_scan_mask,
> > > +                                    masklength, in_ind + 1);
> > > +     }
> 
> -- 
> With Best Regards,
> Andy Shevchenko

