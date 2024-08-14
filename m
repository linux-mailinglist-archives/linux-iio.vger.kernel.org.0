Return-Path: <linux-iio+bounces-8474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24C95221D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66577B2356C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CE1BD504;
	Wed, 14 Aug 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2WB8x2O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F83A29F;
	Wed, 14 Aug 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660701; cv=none; b=r8mKV/iZaO9WtpIA84w2QauvjW6hA/bJzgcTqe55zfWlgTjutU2WXDsXNkBmVc4k5BBPia28DGLraHbjV2lPHIeoeHcYRYCClwVFDJdSWM1FEGLEpApXssr83DdXnIytME1Zg+LJmfuy2FhkaD39l5csuErCCqAPMfxAO/Hdsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660701; c=relaxed/simple;
	bh=vGF0QSEyIIf8oya8zUvZy6m2ncGcyi8HNxLhUwwMTIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ++6xFHgmmYxlWbJXye95UyvRuFjE09g8lIUUzC6hmWoLDSEhIE2EDjnumjfj2JJZpGVieer4/tVNIimUf2SFIDi6LMAdsOzFK9jpaWS87zaK1wK3twDEYMygpyokqV1t25BjzKlUnSqDXUZ05jKVHfqSCRGg3OE8EUNBoyb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2WB8x2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF6C116B1;
	Wed, 14 Aug 2024 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723660700;
	bh=vGF0QSEyIIf8oya8zUvZy6m2ncGcyi8HNxLhUwwMTIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c2WB8x2OWIhqHYkdJbrClouSIaEQfnqzA+9VZBU2I9BYwwivyBnyQTMKqn45DSgi+
	 ha3ndWZfeJkxKQq4RJZK2xYIM9zISsq2N9oA938C404LHpbUZVwuNfi83TUbSCGz3m
	 OsxTjb3pocw5OQp1BoIZNJpxO3glvmHVqo797UDuQBv9Z9ZU6fFrd964Q1x43VdljB
	 6UoYNl0HMEGEexXZ0Wyc8ZKumOomWisbD4Xw90hStT81Zeq0XqnrClYhI+gYJdtSEr
	 K/m+5/XI2yf2uDhTCOTLou2X17gmNtXG/gVccGkcN8Ak/efAACw1+kp6Tg7Ura/htk
	 0po+jXA1Fva/Q==
Date: Wed, 14 Aug 2024 19:38:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Esteban Blanc" <eblanc@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 0/5] iio: adc: ad4030: new driver for AD4030 and
 similar ADCs
Message-ID: <20240814193814.78fe45cc@jic23-huawei>
In-Reply-To: <D3FNL323ZXLQ.2D0QLACO67VTP@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240629174039.3e6053e5@jic23-huawei>
	<D3FNL323ZXLQ.2D0QLACO67VTP@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 15:02:42 +0200
"Esteban Blanc" <eblanc@baylibre.com> wrote:

> On Sat Jun 29, 2024 at 6:40 PM CEST, Jonathan Cameron wrote:
> > On Thu, 27 Jun 2024 13:59:11 +0200
> > Esteban Blanc <eblanc@baylibre.com> wrote:
> >  
> > > This is adding DT bindings and a new driver for AD4030, AD4630 and
> > > AD4632 ADCs.
> > > 
> > > This work is being done in collaboration with Analog Devices Inc.,
> > > hence they are listed as maintainers rather than me.
> > > 
> > > The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
> > > an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
> > > board for AD4632 the support can't be tested at the moment. The main
> > > difference is the reduced throughput.
> > > 
> > > This series is taged as RFC because I think I'm misusing
> > > IIO_CHAN_INFO_CALIB*. For CALIBBIAS the doc in sysfs-bus-iio says
> > > "Hardware applied calibration offset (assumed to fix production
> > > inaccuracies)" but AD4030 offset in on 24bits and I would argue that at
> > > this point it's not just here to fix production inaccuracies. Same this
> > > for CALIBSCALE. What IIO attributes should I use instead?  
> >
> > Interesting.   So awkward question for you.  What's the point in applying
> > a digital offset?  calibbias is normally about tweaking the Analog side.
> > This just seems to be adding a value on.  I'm not sure it affects what
> > can actually be captured without saturation.  
> 
> True, both scale and offset applied with thoses registers can lead to
> saturation.
> 
> > Maybe it has influence by changing the input range and scale for the
> > block averaging filter?  I'm not sure.
> >
> > You can use offset for this given it's a simple linear value and not
> > anything to do with calibration. It's a little awkward though as that
> > is post scale rather than the other way around which is rather more
> > common.
> > Controls are in the form
> > voltage = (raw + offset) * scale 
> >
> > So here
> > voltage = (raw + offset_reg / (gain_reg * other scaling)) * gain_reg * otherscaling.
> >
> > Hence your offset is a bit fiddly to compute.  
> 
> After talking to ADI engineer about this, the conclusion is that I was
> wrong and this is indeed mostly for calibration. They left the range
> of values quite wide in case a user wanted to use this to apply an
> offset or scale to the raw value directly in order to avoid doing some
> post processing later on. But the main goal is calibration.
> 
> If that's ok with you I will keep CALIBBIAS and CALIBSCALE for the next
> round and remove the RFC tag.
Sure.  Bit odd to do this post processing on device but I guess it made
sense for some customers.

Jonathan

> 
> Thanks for your time and sorry for the confusion,
> 


