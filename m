Return-Path: <linux-iio+bounces-19629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD211ABB0C6
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02071176CBC
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617B20458A;
	Sun, 18 May 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoCi8d8w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E1A55;
	Sun, 18 May 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747584825; cv=none; b=TNZkGtBu5F67q4PkHhF5hBlP3c50bm1EF5G5gxgN/pjPozKwHwjOU1vh7MNtB6+p9K5Rt1GQfzH34G0TNIXf1a4KUKurBbW1f94aEfCnLlxseVwDNyn+kqFc6UqY32FIkeFKmYCkvyKnPXwJCttpdt7f91boSh4tyLw/zVTQClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747584825; c=relaxed/simple;
	bh=1svjkY+/k9jmjd+tXvYFCXgAUpAsK7A2JK8DYcztVwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFIU80FHLQkoO9aPKBKp/oDGW9GRZVWlCNJbg2vqwpFPMGpgScEq9VO17VCD+Q8pMJT+JkCKvAD5OL1iQNI0rtkRnyKw6uf3DROEZ9/uc0Y/jmu7c/qH+ozozUT2GG7lNJ6Lyi0kJ2ORgIIyfdzY+ZVWTrBdyc446PhcJBZhbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoCi8d8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA3FC4CEE7;
	Sun, 18 May 2025 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747584825;
	bh=1svjkY+/k9jmjd+tXvYFCXgAUpAsK7A2JK8DYcztVwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VoCi8d8wtEat28qdfe5li+uyOhQ4R3Ws2DbirxJnb4clNERgbG6PXCJ8NGTRDIW+G
	 EpgP6WukJ0Gv44LAunCqrfhDiu7vqvYH+qyI9lYmBGSp+88I14EUfcThWWjPM9oLVC
	 KEonYiTMS/+zr+vvrk2BQvA3n3Gtvt5+HQ2C1aKgv03grwPp8RnI3a20aWOnIoHdXB
	 IGmERMFgqqhtRJJAk2polHyHlgN3VTxww5UgYrQdxrfzNqf7QQa2y6JSZ4jbCDXVNZ
	 4/fd6/nG6efNw1UABG3FAOv76tUWgDu7lRdIkGpvrB25fviandl1DDQPuj/U9DJk0G
	 uY+4smI4BWVOg==
Date: Sun, 18 May 2025 17:13:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Pop Ioan Daniel <pop.ioan-daniel@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dh?=
 =?UTF-8?B?bHZlcw==?= <joao.goncalves@toradex.com>, Herve Codina
 <herve.codina@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: backend: update
 iio_backend_oversampling_ratio_set
Message-ID: <20250518171334.6deb684b@jic23-huawei>
In-Reply-To: <8e5a9176-1652-41a5-bb8c-cea0d44e4d2d@baylibre.com>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
	<20250516105810.3028541-2-pop.ioan-daniel@analog.com>
	<8e5a9176-1652-41a5-bb8c-cea0d44e4d2d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 10:06:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/16/25 5:58 AM, Pop Ioan Daniel wrote:
> > In the function iio_backend_oversampling_ratio_set the chan parameter
> > was added. The function can be used in contexts where the channel
is added

(tense is wrong given this patch is doing it).  However it should be
in imperative.

"Add chan parameter to iio_backed_oversampling_ration_set() to allow
for contexts where the channel must be specified. Modify all
existing users."


> > must be specified. All affected files have been modified.
> > 
> > Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> > ---
> > changes in v3:
> >  - fix ad4851_set_oversampling_ratio function channel error
> >  drivers/iio/adc/ad4851.c           | 6 +++---
> >  drivers/iio/adc/adi-axi-adc.c      | 3 ++-
> >  drivers/iio/industrialio-backend.c | 3 ++-
> >  include/linux/iio/backend.h        | 3 ++-
> >  4 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> > index 98ebc853db79..fccfca256670 100644
> > --- a/drivers/iio/adc/ad4851.c
> > +++ b/drivers/iio/adc/ad4851.c
> > @@ -294,7 +294,7 @@ static int ad4851_scale_fill(struct iio_dev *indio_dev)
> >  }
> >  
> >  static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> > -					 const struct iio_chan_spec *chan,
> > +					 unsigned int chan,  
> 
> I think passing the channel here is misleading since this is setting the
> oversampling ratio for all channels, not just the one specified.
> 
> I would suggest to make a separate patch that removes the unused
> const struct iio_chan_spec *chan parameter first.
> 
> >  					 unsigned int osr)
> >  {
> >  	struct ad4851_state *st = iio_priv(indio_dev);
> > @@ -321,7 +321,7 @@ static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> >  			return ret;
> >  	}
> >  
> > -	ret = iio_backend_oversampling_ratio_set(st->back, osr);
> > +	ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);  
> 
> 
> Then in this patch, just pass 0 here instead of chan with a comment that
> the channel is ignored by the backend being used here.

Is it implausible that such a backend could be written for this device?  If
so then I agree.

J
> 
> >  	if (ret)
> >  		return ret;
> >    
> 


