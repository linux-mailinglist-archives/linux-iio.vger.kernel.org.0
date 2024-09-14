Return-Path: <linux-iio+bounces-9582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FABD97922F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5481F22482
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05541D0979;
	Sat, 14 Sep 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ6xiKyQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107D4414;
	Sat, 14 Sep 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332423; cv=none; b=m1BezxWl6rJ8PlOg1HY5k1memlV74wxWQI+XpN1vYGC8Y3Onv4RxhpVr6wSQfx/6KJv0ENxZYqorf1oHVnmMyfb22L9PHjyx286TegkuGUfLcF7njzVSul2GOT4p/gIk/CzatiBhOLmpUWrh90kXLB9j0T3zlt/7z5FPLe0nkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332423; c=relaxed/simple;
	bh=liZKaFwxwXaMkbT/pgS5baf34JjvMUlV1qcvBQ7ER/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxiF2X8kUb9jg7N3v7ltdaO8FP8xnbtOI58rucWsqX0OLv6SQczXtTgmVUUI7iQgD39THtIe2EiXSoQdW6Wmw3whi7pb2Gx8sgW3NanAi3yKvp6b+5vxbrCHgl6ipx2fsiCST9QFmbEb+/+bIKVrehj6ecojFlU6RWv3WTx8HK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ6xiKyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3948C4CEC0;
	Sat, 14 Sep 2024 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726332423;
	bh=liZKaFwxwXaMkbT/pgS5baf34JjvMUlV1qcvBQ7ER/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJ6xiKyQGRkpSj6hLu9NjbLXM94w2g3y5DOcoL1r3sFeTdc85KtFRVD4NGOYowwQD
	 6gxnDDgJ0lWiz6eT/JQ8dPQJZWdM6Vo8ZlUsgTfTQsOvt9FoAjphzFZWoOaNuMXrEf
	 EcQmBDbGnk9uR+EjlFzfYzK3ADHCePTJHn+dW9DsBZprozWIaLR3XamgjKUATNLW1l
	 c+00MsazKymQVF3+HppRD3XmgsinMF+G1v/XNK4z7DXu2tmVjdL8PO+KJGaOvt7Tfx
	 hY4hyIXJeeVz1WlnoPzfy0zb+MREpsmR0yqXA3xyNVK5802/F2QDCjRM1bg3/FWr0Z
	 3Um8DahwhQJxw==
Date: Sat, 14 Sep 2024 17:46:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, Mike
 Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240914174653.1c8788de@jic23-huawei>
In-Reply-To: <CAHp75VdBf6UX7XGVWi0Luw9Bs2tCzcvFFy8Dp-ZGsEU=TqOn1w@mail.gmail.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
	<CAHp75VdBf6UX7XGVWi0Luw9Bs2tCzcvFFy8Dp-ZGsEU=TqOn1w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > +       iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +               switch (mask) {
> > +               case IIO_CHAN_INFO_CALIBSCALE:
> > +                       *val = ad7779_get_calibscale(st, chan->channel);
> > +                       if (*val < 0)
> > +                               return -EINVAL;
> > +                       *val2 = GAIN_REL;
> > +                       return IIO_VAL_FRACTIONAL;
> > +               case IIO_CHAN_INFO_CALIBBIAS:
> > +                       *val = ad7779_get_calibbias(st, chan->channel);
> > +                       if (*val < 0)
> > +                               return -EINVAL;
> > +                       return IIO_VAL_INT;
> > +               case IIO_CHAN_INFO_SAMP_FREQ:
> > +                       *val = st->sampling_freq;
> > +                       if (*val < 0)
> > +                               return -EINVAL;
> > +                       return IIO_VAL_INT;
> > +               }
> > +               return -EINVAL;
> > +       }  
> 
> > +       unreachable();  
> 
> Hmm... Is it necessary? Same Q for other similar cases. I.o.w. what
> will be if we don't add this line?

The compiler can't tell that the contents of iio_device_claim_direct_scoped()
always runs.  Hence normal result is it complains that nothing was returned.

Why the compiler can't figure out?  Who knows... 

Jonathan

