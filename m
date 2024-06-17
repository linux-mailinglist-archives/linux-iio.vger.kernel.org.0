Return-Path: <linux-iio+bounces-6422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21A90BB95
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D0B1C2361D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CB18F2F5;
	Mon, 17 Jun 2024 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCK1JBT2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C617C7B3
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654253; cv=none; b=f2ukSsAbctKrwSFPB+/x1L2vXWe9V9JU5WOz3bnJYr1jNxfo2cDGyvhejhTMa5WCADCBBm65EYZAJpnuk7aOVEyJ0HhwSOOmx64vzjhgKbzPTd5svNZj3ZG0xf2eAx+l32bDjGD0GLBaU/uEKL0I+OkxpkQDTe9sDU1CK+FDtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654253; c=relaxed/simple;
	bh=Y10WcRQ+W39lGTLUsQBxeqcuERKY1bXIUsvwJamJ9fU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwL/3M0HePOWIJq+VNjFWUFXyITCPoNvP2Jkq/4l4TZwHSMmAPh9A70EPxZ3MFqyuHFBDPwhhfSZ6EXBU9kF5/+Jn+K/qACPRguhdu3TgaiFf4HItm7j64IG8fbTxdGusPfABpjzX/gkNxRp5XWvFj8q7XWYFifLQOn6Jf3PvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCK1JBT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F293C2BD10;
	Mon, 17 Jun 2024 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718654252;
	bh=Y10WcRQ+W39lGTLUsQBxeqcuERKY1bXIUsvwJamJ9fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCK1JBT24Mj1xDJnqaPBEdU3Vq/iC9xyaIjXtZtZyt+o5l7ki1W/GvFr8nWg4eFl2
	 VSoqrttm9kMh8Z9IVcoWVOE/YGTHjOxJtpiQh1rOhbrJe85WNI8BfaIrMiDWYfo/jQ
	 NFUKUUVZ6B9MhEPeYcxCVmzpiyhoPyJJ81P+bMu/iyGt7Qn2l/QGZElbrwvpr5R7zw
	 gDCyGOmgrHy0jM9auo2bOXEB3o4ULMkBsyUKBggelue9EnAxNi/HiWLYfrmT7ydgXy
	 ZCWSAtxjYEfj/jEAkcGN1zTo3J9jdps5WTG3Z9RMyM/f2E7eEhX85xFmTSC/8vS6x5
	 ZSjbZqwKaQKXA==
Date: Mon, 17 Jun 2024 20:57:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Adam Rizkalla <ajarizzo@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix bmp580 temp read
Message-ID: <20240617205726.7ddcd6eb@jic23-huawei>
In-Reply-To: <20240604191904.GA19711@vamoiridPC>
References: <20240602201200.30418-1-ajarizzo@gmail.com>
	<20240604200107.7f68dbf4@jic23-huawei>
	<20240604191904.GA19711@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 21:19:04 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Tue, Jun 04, 2024 at 08:01:07PM +0100, Jonathan Cameron wrote:
> > On Sun,  2 Jun 2024 15:12:01 -0500
> > Adam Rizkalla <ajarizzo@gmail.com> wrote:
> >   
> > > Fix overflow when storing bmp580 temperature reading and preserve sign.
> > > 
> > > This patch re-applies the fix in [1] after the merge conflict resolution
> > > mentioned in [2].
> > > 
> > > [1] https://lore.kernel.org/all/Zin2udkXRD0+GrML@adam-asahi.lan/
> > > [2] https://lore.kernel.org/linux-kernel/20240531140621.264f0848@canb.auug.org.au/
> > > 
> > > Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>  
> > 
> > Thanks! I was just about to email about this fix currently being lost in
> > linux-next.
> > 
> > Rather than dance around this, I'm going to pull the later part of Vasielios'
> > series off the togreg tree for now then reapply later once I have the fix
> > in my upstream.
> > 
> > It's a shame that we need to do the maths in driver to keep within range.
> > Maybe we can be cheeky and avoid doing the division?
> > I believe the IIO core formatting code should be fine with that as it
> > already casts up to 64 bits to do the maths.
> > 
> > (s64)*raw_temp * 250);
> > 
> > bmp580_temp_coeffs = {1, 18}
> > 
> > Anyhow, I've dropped (for now) the following patches from my togreg tree
> >   iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
> >   iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
> >   iio: pressure: bmp280: Add triggered buffer support
> > 
> > Jonathan
> >   
> 
> Hi Jonathan, Adam,
> 
> I had mentioned it here [1], when I applied v7 of the patches that this would 
> happen. No worries though,  I already have the new version of these 3 patches
> that include Adam's fix, so when we have it upstream I can resubmit them
> (no need to keep a note Jonathan, I have it) and I think we will be fine!

Excellent.  The fix is no in the upstream of my togreg branch.

I've only pushed it out as testing for now, but if you send a version based
on my testing branch or 20460472952 (currently char-misc-next head) that would be great.

Thanks,

Jonathan

> 
> Cheers,
> Vasilis
> 
> [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#t
> 
> > > ---
> > >  drivers/iio/pressure/bmp280-core.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > > index 95c88b0e1c49..3a003843c79c 100644
> > > --- a/drivers/iio/pressure/bmp280-core.c
> > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > @@ -1752,6 +1752,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
> > >  		dev_err(data->dev, "reading temperature skipped\n");
> > >  		return -EIO;
> > >  	}
> > > +	*raw_temp = sign_extend32(*raw_temp, 23);
> > > +	*raw_temp = ((s64)*raw_temp * 1000) / (1 << 16);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -2154,7 +2156,7 @@ static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > >  
> > >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> > >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > > -static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > > +static const int bmp580_temp_coeffs[] = { 1, 0 };
> > >  static const int bmp580_press_coeffs[] = { 1, 64000};
> > >  
> > >  const struct bmp280_chip_info bmp580_chip_info = {
> > > @@ -2184,7 +2186,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
> > >  	.iir_filter_coeff_default = 2,
> > >  
> > >  	.temp_coeffs = bmp580_temp_coeffs,
> > > -	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> > > +	.temp_coeffs_type = IIO_VAL_INT,
> > >  	.press_coeffs = bmp580_press_coeffs,
> > >  	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > >    
> >   


