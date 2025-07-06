Return-Path: <linux-iio+bounces-21373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0CCAFA40A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E151898D41
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9211F9F61;
	Sun,  6 Jul 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF/MP1t2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1C35972;
	Sun,  6 Jul 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751794446; cv=none; b=pvrD0VFwJKmUh43I29klg63PIHqXpNmwk5zaM+PwMXKmDYJMI6uahi+biwma9g+ih3duWU9rwSqjPjVNFGuxzSv8b+bhM59HYqK8mdwV/zpArIoK49xjxi1wbJhnrXrjKLBDxLMf64ZzGqWWx6YsIdZgF9Z8uD/IgrgR9P1tYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751794446; c=relaxed/simple;
	bh=aL1Zrrz6z/GX1s92tmOuCSb81YdX/7rki1eHHVMKrxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPqlii5NrVOlCxh/eQ5esFdSFSOd9c9Pe5na0xgYfDM7GVCXxMX3BHJcIXcVEfTJCYbFamArYMyJdN9w9WQeKs6Qkvh7G1xclV23s3DcUK7VmBSRcvLvqQxClmcRojVEltO49ACJ0kH0bUlCBxtqiHAjpunozHgsQuChaXE9pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF/MP1t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A745C4CEED;
	Sun,  6 Jul 2025 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751794445;
	bh=aL1Zrrz6z/GX1s92tmOuCSb81YdX/7rki1eHHVMKrxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bF/MP1t26Fo8B1kKVCql0AarvJq+7AczeYvI/FCYfqAd3D7hCADu7hXFfChh3hmBf
	 f0Ez0JsQToO1y5kBI7bLmAtU9wkOkba5nIoGlluPu7+wHXHVg6gunnZhna12PhGeyV
	 AdfzEbIJO4CuVsaCmR7LrJiH/WqjcC9FSt42/6y45ptLvornjfIfvngAcWCNG24v4l
	 eoQ+R11asgFAsAM6E7bOonyyfzuqHZhq/wnrRg6gR4lfeGeSIqAchbHP1vs0QUeN74
	 UH87v+GUxNLNN1o1wNlAWa6jnxh5EwRWpo5cf3SHY2pB5+bD/pB/PhQvSktqXmLrJY
	 uUfbx3dH9g9YA==
Date: Sun, 6 Jul 2025 10:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: aEwd4cS7j0Vvypg8@smile.fi.intel.com, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v11 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff
 attribute
Message-ID: <20250706103354.0059d320@jic23-huawei>
In-Reply-To: <aFGVAWi7CZAy0E8k@JSANTO12-L01.ad.analog.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
	<804d66f1858014d7278aec3344d81c223661e878.1749569957.git.Jonathan.Santos@analog.com>
	<aEwd4cS7j0Vvypg8@smile.fi.intel.com>
	<aFGVAWi7CZAy0E8k@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 13:17:05 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 06/13, Andy Shevchenko wrote:
> > On Wed, Jun 11, 2025 at 08:52:03AM -0300, Jonathan Santos wrote:  
> > > Ad7768-1 has a different -3db frequency multiplier depending on
> > > the filter type configured. The cutoff frequency also varies according
> > > to the current ODR.
> > > 
> > > Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> > > the user which bandwidth is being allowed depending on the filter
> > > configurations.  
> >   
> > > +/* -3dB cutoff frequency multipliers (relative to ODR) for each filter type. */
> > > +static const int ad7768_filter_3db_odr_multiplier[] = {
> > > +	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */
> > > +	[AD7768_FILTER_SINC3] = 262,		/* 0.2617 */
> > > +	[AD7768_FILTER_SINC3_REJ60] = 262,	/* 0.2617 */
> > > +	[AD7768_FILTER_WIDEBAND] = 433,		/* 0.433 */  
> > 
> > Just to be sure, is it 0.433 or 0.4333(3) actually? Sometimes datasheets have
> > rounding that even may lead to problems (see TSC issues for some of the Intel
> > CPUs in the past). That's behind my question.
> >   
> 
> Every reference I have specifies it as 0.433, so I believe that is it.
> 
> > > +};  
> > 
> > ...
> >   
> > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > +		temp = st->samp_freq * ad7768_filter_3db_odr_multiplier[st->filter_type];
> > > +		*val = DIV_ROUND_CLOSEST(temp, 1000);  
> > 
> > MILLI? KILO/ MICRO/MILLI? ...?
> >   
> 
> Yes, MILLI.
I fixed this up and added units.h include and applied.


> 
> Thanks,
> Jonathan S.
> 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 


