Return-Path: <linux-iio+bounces-6052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394499011D2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A1C1F21D2E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E82176FA3;
	Sat,  8 Jun 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez+Z5wzY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3E1E526
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717855913; cv=none; b=juT4lkwavn486P8KgbOpce+PHkGsZuDA1n6zu3JhyTzmQ+PvwriZZlZdPSH5ZgTuuVD4Rk6Xa2sMfeBQ9J+JBOeMMwrjOErnKtQkIMsjLzqIOtbREDiiUkEL0Cm8d0FjyJGkymo5CMUGBj5J+SzipSTBo6y0CYY/ZQbkkemrxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717855913; c=relaxed/simple;
	bh=1cs8wAQiEJV+/Iu6ddtGab4oo8qvOz6NwbiW/2LBNZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CozpKwP11YOrfbmD+SFUbhQXdkjKYf1LNCOyptOGgFohbvBf6XQXZt9Pk2Wt/8PgasUYPGr/xAp8jAE8cGax0KMUKO9h8+PYpc4bz2fFjw5TGA9vc0Q2n9ZJmoMtEyA80YnEDu3AC+TeQQ5Hy2I2V6Mi88CXNzYZU7A3P9Y9iBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez+Z5wzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F21CC2BD11;
	Sat,  8 Jun 2024 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717855912;
	bh=1cs8wAQiEJV+/Iu6ddtGab4oo8qvOz6NwbiW/2LBNZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ez+Z5wzYqWu18l7lHcwghW+XOtkwcuOnEAb8YFMXwAp5XH8nA0I2UQVjvThpIaXD9
	 RSP9nED5vs0LA+wp3wEzqmML6eawJokPjX44rUaXgkYkOa3UqJcWhFFZVydctR3LFD
	 MZxd6qRZEayMSQ69BnXVO/6AS6BUqm/UP4B+RItc1dXnaTIp6yVX2op07JN3apIDcJ
	 vRslUJuPmUX9O/ZXsOqteUlJfi7FDsFUvwChWlSxmgd9e1ixpRCAUUP2dbnSZOJE76
	 sBI6JFR3KS9ZDoTIr6vqleSnUj/k3qTg1EbODkkoRlMZzECJ5cRs6Xo9F5Z8yAtcEg
	 QYipI507m4+EQ==
Date: Sat, 8 Jun 2024 15:11:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Fernando Yang <hagisf@usp.br>, linux-iio@vger.kernel.org,
 Michael.Hennerich@analog.com, lars@metafoo.de
Subject: Re: [PATCH v2 1/3] iio: adc: ad7266: Fix variable checking bug
Message-ID: <20240608151147.70fe5f06@jic23-huawei>
In-Reply-To: <ZmPmzV7BOBZIlwFA@debian-BULLSEYE-live-builder-AMD64>
References: <20240508155435.183850-1-hagisf@usp.br>
	<20240603180757.8560-1-hagisf@usp.br>
	<ZmPmzV7BOBZIlwFA@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jun 2024 02:06:21 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Fernando,
> 
> This patch looks good.
> I think a fixes tag would also be appropriate for this one.
> 
> Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")
Agreed. 
I've picked this one for the fixes-togreg branch of iio.git and marked it
for inclusion in linux-stable.

Note this will delay when I can pick up v3 of the other two patches, but
good to get this fix upstream in the meantime.

Thanks,

Jonathan

> 
> On 06/03, Fernando Yang wrote:
> > The ret variable was not checked after iio_device_release_direct_mode(),
> > which could possibly cause errors
> > 
> > Signed-off-by: Fernando Yang <hagisf@usp.br>
> > ---
> >  drivers/iio/adc/ad7266.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> > index 353a97f9c..13ea8a107 100644
> > --- a/drivers/iio/adc/ad7266.c
> > +++ b/drivers/iio/adc/ad7266.c
> > @@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
> >  		ret = ad7266_read_single(st, val, chan->address);
> >  		iio_device_release_direct_mode(indio_dev);
> >  
> > +		if (ret < 0)
> > +			return ret;
> >  		*val = (*val >> 2) & 0xfff;
> >  		if (chan->scan_type.sign == 's')
> >  			*val = sign_extend32(*val,
> > -- 
> > 2.34.1
> > 
> >   


