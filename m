Return-Path: <linux-iio+bounces-10254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E588991EF3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803DE1F21A35
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C874C08;
	Sun,  6 Oct 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzXH+HzN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02568273DC;
	Sun,  6 Oct 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225796; cv=none; b=NvMSduS7X+sczHjvMgAE5AAAcVdcjnPqJuHx6rHBGmcovz62Wc3pEKVMPMoG40004oJb5jWqoABiLVWrfHiW2dtjvdiXcMFRlgmLIEFU8SiRrHUaPBMPGp4sAs7CTYzPiVnMzDVNf+Qr8i8XwuncpaUKcc8SM+xB6J9HRLu4FX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225796; c=relaxed/simple;
	bh=yw0YpB9rK2tU6C+etLif3D2HyoGw03c7kDYJQ4i20mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XO9jfKgeJe3Wt1+UZlCF+BYmzPuAMbO7sY+ZQ9s6ctcL8tQdWdf0RylaIZQbbjUElsOe0gNTNR+YPklPyyFS25NJnan4pUFJl112IId7ylATp3wyPBlpKkN6OE0rhty44fCxjf5tvYf7IFkYIZwtCFvMPhs0r0ZKQ3H0V9nl67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzXH+HzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872C3C4CEC5;
	Sun,  6 Oct 2024 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728225795;
	bh=yw0YpB9rK2tU6C+etLif3D2HyoGw03c7kDYJQ4i20mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JzXH+HzNGHIicfYULq0cOtSL4AjoS19fgIbn2TuXIk8xRltRYx7niCMtbBAFXG+oi
	 rBkuLyg6Bx2iL1ZXrBe5WIK6YECjF8ptHtLHLz0ORM8+2e0zSmI+5PpBVKmcmV+xIf
	 iJKMZ3uTj2AkaM2pCeT9asp6pdvIjBXVvxxCIRJffyYth2GU5e8//xlqKJHi/DgGnz
	 BUUmLxVj9SU71LztphN68wCuCt48AlRRF8l1SRXSl6UTZvuDVSBkd+a1GC45qNStPW
	 Q0crj1nfCu8tkmU+u8pOZQVIPi2+TigTVTMVI8So1c2a1g8C4sP4rSx6RZe17Jockt
	 aUhQduKV0suAw==
Date: Sun, 6 Oct 2024 15:42:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Hennerich <michael.hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iioc: dac: ltc2664: Fix span variable usage in
 ltc2664_channel_config function
Message-ID: <20241006154253.1a7824bf@jic23-huawei>
In-Reply-To: <20241006152533.329d9b59@jic23-huawei>
References: <20241005170722.19542-1-pvmohammedanees2003@gmail.com>
	<20241006152533.329d9b59@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2024 15:25:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  5 Oct 2024 22:37:22 +0530
> Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:
> 
> > In the current implementation of the ltc2664_channel_config function,
> > a variable named span is declared and initialized to 0, intended to
> > capture the return value of the ltc2664_set_span function. However,
> > the output of ltc2664_set_span is directly assigned to chan->span,
> > leaving span unchanged. As a result, when the function later checks
> > if (span < 0), this condition will never trigger an error since
> > span remains 0, this flaw leads to ineffective error handling. The
> > current patch resolves this issue by using the ret variable for 
> > getting the return value, later assigning if successful and also 
> > effectively removing span variable.
> > 
> > Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> > Fixes: 4cc2fc445d2e4e63ed6bd5d310752d88d365f8e4
Hmm. I see you had a v3. For some reason that hasn't reached my inbox.
Also note the fixes tag was wrong and you've fixed that.

I've picked up v3 and applied it to the fixes-togreg branch of iio.git
and marked it for stable inclusion.

Thanks,

J
> > ---
> > v2:
> > - Using the ret variable to store the result from ltc2664_set_span
> > ---
> >  drivers/iio/dac/ltc2664.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> > index 5be5345ac5c8..7dafcba7ece7 100644
> > --- a/drivers/iio/dac/ltc2664.c
> > +++ b/drivers/iio/dac/ltc2664.c
> > @@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
> >  	const struct ltc2664_chip_info *chip_info = st->chip_info;
> >  	struct device *dev = &st->spi->dev;
> >  	u32 reg, tmp[2], mspan;
> > -	int ret, span = 0;
> > +	int ret;
> >  
> >  	mspan = LTC2664_MSPAN_SOFTSPAN;
> >  	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> > @@ -579,20 +579,24 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
> >  		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
> >  						     tmp, ARRAY_SIZE(tmp));
> >  		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
> > -			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
> > +			ret = ltc2664_set_span(st, tmp[0] / 1000,
> >  						      tmp[1] / 1000, reg);
> > -			if (span < 0)
> > -				return dev_err_probe(dev, span,
> > +			if (ret < 0)
> > +				return dev_err_probe(dev, ret,
> >  						     "Failed to set span\n");
> > +			else  
> else is unnecessary here as we have the standard check and error and return
> if set pattern.
> 
> 
> > +				chan->span = ret;
> >  		}
> >  
> >  		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
> >  						     tmp, ARRAY_SIZE(tmp));
> >  		if (!ret) {
> > -			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> > -			if (span < 0)
> > -				return dev_err_probe(dev, span,
> > +			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> > +			if (ret < 0)
> > +				return dev_err_probe(dev, ret,
> >  						     "Failed to set span\n");
> > +			else  
> and here.
> > +				chan->span = ret;
> >  		}
> >  	}
> >    
> 
> 


