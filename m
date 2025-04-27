Return-Path: <linux-iio+bounces-18724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B889A9E272
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9A05A3448
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817B324A067;
	Sun, 27 Apr 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc+LLps/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14D1E231E;
	Sun, 27 Apr 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745749247; cv=none; b=d/H/3J2fumWUrFydJ34I3un7qiQbDTsZg3U5GkIEbcqbtygM5s2p5L0teQo4EY8oyIapRb0f8dPmn2f3D/522FsenzhsCxoAEiVSDGH1pLog550LjYjfQMDqjnLqZjKlhG4F0Zldvbh5Fx9RwvLAFxLrOfSzd7EKRHeqJnOAdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745749247; c=relaxed/simple;
	bh=UvgX/22nEMLGVHnLX7utgwefDV5CfKGMP+fQPcGv4Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhcBrFpZTrnvApp6XtW+TFkYeY+BMagWhoQ73dHT/LzeW34eW9wFvmZjL6/WgJxOEg3VHyeNaOyQrHUmpnqwmvMFbnMtJfizvyc5tyXnUOWlf9+RJiUvz/ON244mmRL8FKGkD13mbZsMIrSyuRe46z+vZ0QVPVjDVSFRGbCZE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc+LLps/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48CEC4CEE3;
	Sun, 27 Apr 2025 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745749245;
	bh=UvgX/22nEMLGVHnLX7utgwefDV5CfKGMP+fQPcGv4Q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mc+LLps/OnHxQfbiaghh+dEvxoV3Tu6fQOxBLkQ/rdYm27bU20RcLqL3a9YmusXM5
	 CS+/188Z1gv96pms5EKq1PJ/3ynRurt6g+z1sZVQLY4Sr/E8ke8RMIANy4VNuY8ZtU
	 O/csuIRW74bWlRCxv5qi1miUsupmS1z4uxFcnk5cxEkrjiXFxtQcZTZB/YR1zsqizi
	 VcddKI4RMtewnXSIjbuFWddJ/+x8n8F/uB1mLjc1nPmqEoZ4yi+AiSFtA2oTvaJf+A
	 efRx5rTreJQNcidxZ9jMT8nyWtVu38+aKrM1rtQI3Z9BvOF6Lo6LDdzsT6udCocyyk
	 tsRD8/vZCyVsg==
Date: Sun, 27 Apr 2025 11:20:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Message-ID: <20250427112035.112d086d@jic23-huawei>
In-Reply-To: <8a57a332-c2a6-4825-a5f7-d765ea15bd6f@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
	<20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>
	<20250426123509.0b04f0f9@jic23-huawei>
	<8a57a332-c2a6-4825-a5f7-d765ea15bd6f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 17:34:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/26/25 6:35 AM, Jonathan Cameron wrote:
> > On Fri, 25 Apr 2025 16:08:43 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> 
> ...
> 
> >> @@ -777,6 +779,42 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
> >>   * them safe for use with non-coherent DMA.
> >>   */
> >>  #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
> >> +
> >> +#define __IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> >> +	static_assert(count); \  
> > 
> > Why do we care if count is 0?  Or is intent to check if is constant?
> > If the thought is we don't care either way about 0 (as rather nonsensical)
> > and this will fail to compile if not constant, then perhaps a comment would
> > avoid future confusion?  
> 
> I would be inclined to just leave out the check. But yes, it is just checking
> that count is constant and we don't expect 0.
> 
> >   
> >> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) / sizeof(type)]
> >> +
> >> +/**
> >> + * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
> >> + * @type: element type of the buffer
> >> + * @name: identifier name of the buffer
> >> + * @count: number of elements in the buffer
> >> + *
> >> + * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
> >> + * addition to allocating enough space for @count elements of @type, it also
> >> + * allocates space for a s64 timestamp at the end of the buffer and ensures
> >> + * proper alignment of the timestamp.
> >> + */
> >> +#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> >> +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
> >> +
> >> +/**
> >> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
> >> + * @type: element type of the buffer
> >> + * @name: identifier name of the buffer
> >> + * @count: number of elements in the buffer
> >> + *
> >> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
> >> + * to ensure that the buffer doesn't share cachelines with anything that comes
> >> + * before it in a struct. This should not be used for stack-allocated buffers
> >> + * as stack memory cannot generally be used for DMA.
> >> + */
> >> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
> >> +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
> >> +
> >> +static_assert(IIO_DMA_MINALIGN % sizeof(s64) == 0,  
> > That message isn't super helpful if seen in a compile log as we aren't reading the code here
> > "IIO_DECLARE_DMA_BUFFER_WITH_TS() assumes that ...
> >   
> >> +	"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
> >> +  
> 
> Seems we actually have an arch (openrisc) that triggers this [1]. This arch
> doesn't define ARCH_DMA_MINALIGN so it falls back to:
> 
> #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> 
> Apparently this is only of those 32-bit arches that only does 4 byte alignment.
> From the official docs [2]:
> 
> 	Current OR32 implementations (OR1200) do not implement 8 byte alignment,
> 	but do require 4 byte alignment. Therefore the Application Binary
> 	Interface (chapter 16) uses 4 byte alignment for 8 byte types. Future
> 	extensions such as ORVDX64 may require natural alignment.
> 
> [1]: https://lore.kernel.org/linux-iio/20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com/T/#m91e0332673438793ff76949037ff40a34765ca30
> [2]: https://openrisc.io/or1k.html
> 
> 
> It looks like this could work (it compiles for me):
> 
> 	__aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))
> 
> If that is OK we could leave out the static_assert(), unless we think there
> could be an arch with IIO_DMA_MINALIGN not a power of 2?!
> 
That change seems fine.  Non power of 2 arch would be fun but implausible any time soon :)


