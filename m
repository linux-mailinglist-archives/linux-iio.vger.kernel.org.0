Return-Path: <linux-iio+bounces-11162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EECA9AEE6D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2444CB23D5D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC081FF023;
	Thu, 24 Oct 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4BXJJT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8831FE100;
	Thu, 24 Oct 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791773; cv=none; b=rw9ocUNFcbXUcllxLWU2HDGsIcpTCA9L0F+0OmLBOlgJMgjK/mn89qAdas6BOZ+55M7YUpY0x+QfaOLvl2mhPzi0FS+OHb+MTLCEw8175BzO8XED6ez7DY+lbiGx/fd/a13PuwsKm1/sI5S+0YnnvXly+q4mbCYbKZmP6iUJXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791773; c=relaxed/simple;
	bh=rgwkQHONl3k5lKfdipk3SO5F9eAWZNlyVIfQ29lbZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVb3BiNYNukdTp/LykjI6/ZSe2C/Vp+a1yqd/nsc6zyU/IL8+xI60u0E5USm8h03UZElJ8inlXCeTRYkTymm2Aevy4iq+D58/S5BKfi7HpCkSH5SURFIREbbnR8x2JSf6vp8+OZfjRB+EpK75pbPZ5aysEisWao2QaMHSmLmQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4BXJJT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816EFC4CEC7;
	Thu, 24 Oct 2024 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729791772;
	bh=rgwkQHONl3k5lKfdipk3SO5F9eAWZNlyVIfQ29lbZsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z4BXJJT3aWuRhvYRTkGPI59Apy2sdoSkVAv5dFPSmEO8LO8SXDsNQFFyh8gRe4uK3
	 LZEqv1nNXcUn1BimMR7XxSCOUj3R4HLfWkFreNu6O9An5WtWVrJGkQ0R7Sc1fJ0lJf
	 hvocUfCtPb7MNFwwKbzQMWzVHJmHJOjv5YuZNESW96EsOE3EssZ+MsGYV4BCuW3slA
	 DoxW/TLUE+oFevwzmJIMCSjocAmRpiGEKe7RMwBgtQjtdLCmpKCpqRDBeDyKsFXT8V
	 pAuUhY3SigID/oDsLyHmlhOrhDijOI4MjN/jhpPXR6bvjiFN9RHzzMIHyDn9LQHSvZ
	 cJPwEecvAvtew==
Date: Thu, 24 Oct 2024 18:42:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: fix microlux value calculation
Message-ID: <20241024184245.29374611@jic23-huawei>
In-Reply-To: <20241019153359.43f0c1af@jic23-huawei>
References: <20241016-veml6030-fix-processed-micro-v1-1-4a5644796437@gmail.com>
	<20241019153359.43f0c1af@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 15:33:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 16 Oct 2024 19:04:31 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
> > The raw value conversion to obtain a measurement in lux as
> > INT_PLUS_MICRO does not calculate the decimal part properly to display
> > it as micro (in this case microlux). It only calculates the module to
> > obtain the decimal part from a resolution that is 10000 times the
> > provided in the datasheet (0.5376 lux/cnt for the veml6030). The
> > resulting value must still be multiplied by 100 to make it micro.
> > 
> > This bug was introduced with the original implementation of the driver.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> Applied to the fixes-togreg branch of iio.git.

As per the linux-next merge conflict email that I've just +CC linux-iio on,
I messed this up and it landed on the wrong code block.

Tried again...

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > I found this almost by chance while testing new supported devices. The
> > decimal part was always suspiciously small, and when I compared samples
> > to the expected value according to the datasheet, it became clear what was
> > going on.
> > 
> > Example with a veml7700 (same resolution as the veml6030):
> > 
> > Resolution for gain = 1/8, IT = 100 ms: 0.5736 lux/cnt.
> > 
> > cat in_illuminance_raw in_illuminance_input
> > 40
> > 21.005040 -> wrong! 40 * 0.5736 is 21.504.
> > 
> > Tested with a veml6035 and a veml7700, the same will happen with the
> > original veml6030, as the operation is identical for all devices.
> > ---
> >  drivers/iio/light/veml6030.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> > index d6f3b104b0e6..a0bf03e37df7 100644
> > --- a/drivers/iio/light/veml6030.c
> > +++ b/drivers/iio/light/veml6030.c
> > @@ -691,7 +691,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
> >  			}
> >  			if (mask == IIO_CHAN_INFO_PROCESSED) {
> >  				*val = (reg * data->cur_resolution) / 10000;
> > -				*val2 = (reg * data->cur_resolution) % 10000;
> > +				*val2 = (reg * data->cur_resolution) % 10000 * 100;
> >  				return IIO_VAL_INT_PLUS_MICRO;
> >  			}
> >  			*val = reg;
> > 
> > ---
> > base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
> > change-id: 20241016-veml6030-fix-processed-micro-616d00d555dc
> > 
> > Best regards,  
> 
> 


