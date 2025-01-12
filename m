Return-Path: <linux-iio+bounces-14205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07BEA0A972
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBA11656F4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4DC1B4245;
	Sun, 12 Jan 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdXbfAMZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72286224D7;
	Sun, 12 Jan 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687601; cv=none; b=Oq1l2rpmNhCEEowF4jugmAa2Oi8yuru39zQhoaeSuyJ5lvJKaCVSuVHShma7+a+j6hb0A0qlVFZZeaXkwxPpkRybW0zKVXgBTmRKrfwsYa05OyjCGxdDjr255S7pCD47530Oakii4fn8HVrxQzIYSfSFXNaSl7mNx2z9FDOo/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687601; c=relaxed/simple;
	bh=QEcnFhl++ltNcvDgJni9HgjGPl7mLIix7BHHZUKp8Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCKccW+BWWakeXvIFrKs7aNtZ4zgc6NgzAh2jLNwRPduxD2pvo8I5k1PvJUTiNLK3QhEqQrhXHmaL0f7aSGOuJ5Dyy/qbWNIx2AtKLCra++LI0n77RJkMrmd8MtJwqatFht7Fj73ZR2bLAJByuEdtG5416cTxGyBO+KGwJPNUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdXbfAMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C697C4CEDF;
	Sun, 12 Jan 2025 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736687600;
	bh=QEcnFhl++ltNcvDgJni9HgjGPl7mLIix7BHHZUKp8Pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JdXbfAMZxB4Uq8m9K9N+2lDUtUxeCmWMgOhqDYDAcvE0OOjcU9kdLRWuzVwgdjyIQ
	 y271YQN83kg1u5GEwxz9yZ5n2odHpl2X5b7xfqOTLpeQEIaJy1vHell32dNJHhp+kX
	 gvV5BrZ6ekSJ3qif4XSsJEnqi6hm3BEYWf16iobtzu+0sPnFAF8ioDIUKEU4lMIxoF
	 N7ymnTiZLBnui0kDVJtoCaUNB0jm5vNO5BgDWyJOl5r/2y3PbAV9m27TF00LMI1D7t
	 KF3toxNw9ZVY+15vVmFDfDVqBpy37XpFl4H0/68RRN3RbdRn+U+PxB3BjRmVFKT4ng
	 MbHDiqfrZNF5g==
Date: Sun, 12 Jan 2025 13:13:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Fix uninitialized variable in
 __bme680_read_raw()
Message-ID: <20250112131313.749b58ec@jic23-huawei>
In-Reply-To: <Z37uRAl18atKgVz0@vamoirid-laptop>
References: <4addb68c-853a-49fc-8d40-739e78db5fa1@stanley.mountain>
	<Z37uRAl18atKgVz0@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 22:29:40 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Wed, Jan 08, 2025 at 12:37:22PM +0300, Dan Carpenter wrote:
> > The bme680_read_temp() function takes a pointer to s16 but we're passing
> > an int pointer to it.  This will not work on big endian systems and it
> > also means that the other 16 bits are uninitialized.
> > 
> > Pass an s16 type variable.
> > 
> > Fixes: f51171ce2236 ("iio: chemical: bme680: Add SCALE and RAW channels")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/iio/chemical/bme680_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 26eb0fa77a43..9d73fd2cf52c 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -879,11 +879,11 @@ static int __bme680_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_RAW:
> >  		switch (chan->type) {
> >  		case IIO_TEMP:
> > -			ret = bme680_read_temp(data, (s16 *)&chan_val);
> > +			ret = bme680_read_temp(data, &temp_chan_val);
> >  			if (ret)
> >  				return ret;
> >  
> > -			*val = chan_val;
> > +			*val = temp_chan_val;
> >  			return IIO_VAL_INT;
> >  		case IIO_PRESSURE:
> >  			ret = bme680_read_press(data, &chan_val);
> > -- 
> > 2.45.2
> >  
> 
> Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Hi Dan,
> 
> I had already applied this for IIO_CHAN_INFO_PROCESSED but not for the
> IIO_CHAN_INFO_RAW channel... Very good that you spotted it!
Applied to the fixes-togreg branch of iio.git and marked for stable.

Most likely will go in during the merge window or slightly after.

> 
> Cheers,
> Vasilis
> 


