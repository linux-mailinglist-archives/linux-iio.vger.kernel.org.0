Return-Path: <linux-iio+bounces-6448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74190BFC3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2A628219B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D11993B6;
	Mon, 17 Jun 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh8rbGJq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FE163A97
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666606; cv=none; b=bzp4LXcxcsVYuAbxkdDERPjrLRAOz125mEV4ddsH3KC3DwvB8IxAeofv5YcmX77n/IaOe6MVSF3utctmiSPApotdim7KrxphVerfqqfwm40w8pOgUUPta1aaf8TuBmAgBdCeI+3ip9Ucse3v22ON1iPAvGF42fIHuHIi0DEPXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666606; c=relaxed/simple;
	bh=/V/BUMEyoQPf1V44YETuDPE16ocFxGl95G9eCQnmBMQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfn1cHdzjWCTWwMNgDl95ncxOAt0gESi3GcYJS89WFrdaPcjrxcEVTxY785oCiKol9/V1cYM1LL3bftMN32MPXSdJy2ph8gFTrH5zwYMoK4q0PZynM+gsNL033U4uCOxob2xl99Hd7/RtSnjKrfBtPw2mXMnw6VN/XIKo7rQOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh8rbGJq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso585527466b.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718666603; x=1719271403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44hRMNyeG0NGD9gyetIkDqYK18pbhPd1hh/6hrRe514=;
        b=Bh8rbGJqfEyKQLano4hLG7sDARNb8tqvltZ3QlfKPkN+IhDXj4+wIJ6Q2Bhqg8LZND
         Jgjg9/HUoUiDgm1OuBTg81/tey2mPieLGyjtdipIPF4ioaUb5MbbjRSfmHh4gm6/ql/R
         3p9rsYwNXZzYsLH8b4m+oFuXcZdk2ZhUAlF+r+ZhJrFLjCjFzEvlXiW4ofMthTESicYh
         l1eT5aPBdWtNhwayM/iAHQSQ3BVU4u1WCPwjrPGtPmIH6EuZIc/FmzWQRzFzfDom/O0j
         ABVrNdGAsH54uNexC6XO4A6qvjxA4pZwKsr01FJVgtkMe7cVKT6ntqKxvMmMXU6epAav
         cKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718666603; x=1719271403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44hRMNyeG0NGD9gyetIkDqYK18pbhPd1hh/6hrRe514=;
        b=MZgfWQrT2z41XRmLw3LUS7ygYojlfm/nRLYTGmj/wmrG9ggvJdyxd0sGuLbhE02n1j
         kk/6wD3ZZZFdjBE1or0ZzadNHAse21C155pI09qyIf2X3EpUwISG87mQ+B5ingGQIuoI
         KmtVga9MoJf0jSgwbE5fhmrTbT0EpG/2ZsveHaxTB5TN5UIZqbd80MnlvchPntFWtFqw
         eHJL7Ut+rtkAY3srSbcrLCcyWkf8RRHVsRlqujmTl0BWxfwPInDtX1hAQG9Oj6xFhHmG
         AGD5pfQy7Sq1b8Vt41MF9XHfvrheqmP1f3Vq6Ur7lB7ajP7a+Q6VFpMrVmiZ2xgmXUFH
         F+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZmYOo3l5vtVWibmC5Twm4Y4vUiJiikRDTXE84Gxp8LONdif/axStHyVZhwUF8Qhtcyu/jouzxocYQP0ZeVF5ddWt093/zAA/Z
X-Gm-Message-State: AOJu0YxDIBPuXDch9TfPV7HihAzRuBgQ0LPoS7o3iz/lCYGWAsYHXqiu
	B9D6+hbWOKQNK+QIMnLF9rTjfrBjoGn/GZHAOqNLndum5dPu9OH0cFS5K68w+fw=
X-Google-Smtp-Source: AGHT+IE1F5w+c+kBB0JV4uKfRZc6zTSOQWiHO0NlIym1XDi48ldl2dP+rP9lEuGraQopVMMRg5iDZg==
X-Received: by 2002:a17:906:3e13:b0:a6f:da1:d077 with SMTP id a640c23a62f3a-a6f60d296f3mr663696866b.25.1718666603012;
        Mon, 17 Jun 2024 16:23:23 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:b152:a6ad:d6c8:f0e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f88f5debasm152879766b.167.2024.06.17.16.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:23:22 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 18 Jun 2024 01:23:20 +0200
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Adam Rizkalla <ajarizzo@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix bmp580 temp read
Message-ID: <20240617232320.GA34371@vamoiridPC>
References: <20240602201200.30418-1-ajarizzo@gmail.com>
 <20240604200107.7f68dbf4@jic23-huawei>
 <20240604191904.GA19711@vamoiridPC>
 <20240617205726.7ddcd6eb@jic23-huawei>
 <20240617203034.GA11985@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617203034.GA11985@vamoiridPC>

On Mon, Jun 17, 2024 at 10:30:34PM +0200, Vasileios Amoiridis wrote:
> On Mon, Jun 17, 2024 at 08:57:26PM +0100, Jonathan Cameron wrote:
> > On Tue, 4 Jun 2024 21:19:04 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > 
> > > On Tue, Jun 04, 2024 at 08:01:07PM +0100, Jonathan Cameron wrote:
> > > > On Sun,  2 Jun 2024 15:12:01 -0500
> > > > Adam Rizkalla <ajarizzo@gmail.com> wrote:
> > > >   
> > > > > Fix overflow when storing bmp580 temperature reading and preserve sign.
> > > > > 
> > > > > This patch re-applies the fix in [1] after the merge conflict resolution
> > > > > mentioned in [2].
> > > > > 
> > > > > [1] https://lore.kernel.org/all/Zin2udkXRD0+GrML@adam-asahi.lan/
> > > > > [2] https://lore.kernel.org/linux-kernel/20240531140621.264f0848@canb.auug.org.au/
> > > > > 
> > > > > Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>  
> > > > 
> > > > Thanks! I was just about to email about this fix currently being lost in
> > > > linux-next.
> > > > 
> > > > Rather than dance around this, I'm going to pull the later part of Vasielios'
> > > > series off the togreg tree for now then reapply later once I have the fix
> > > > in my upstream.
> > > > 
> > > > It's a shame that we need to do the maths in driver to keep within range.
> > > > Maybe we can be cheeky and avoid doing the division?
> > > > I believe the IIO core formatting code should be fine with that as it
> > > > already casts up to 64 bits to do the maths.
> > > > 
> > > > (s64)*raw_temp * 250);
> > > > 
> > > > bmp580_temp_coeffs = {1, 18}
> > > > 
> > > > Anyhow, I've dropped (for now) the following patches from my togreg tree
> > > >   iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
> > > >   iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
> > > >   iio: pressure: bmp280: Add triggered buffer support
> > > > 
> > > > Jonathan
> > > >   
> > > 
> > > Hi Jonathan, Adam,
> > > 
> > > I had mentioned it here [1], when I applied v7 of the patches that this would 
> > > happen. No worries though,  I already have the new version of these 3 patches
> > > that include Adam's fix, so when we have it upstream I can resubmit them
> > > (no need to keep a note Jonathan, I have it) and I think we will be fine!
> > 
> > Excellent.  The fix is no in the upstream of my togreg branch.
> > 
> > I've only pushed it out as testing for now, but if you send a version based
> > on my testing branch or 20460472952 (currently char-misc-next head) that would be great.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> 
> Hi Jonathan,
> 
> Thank for letting me know, I can send it by tomorrow.
> 
> Cheers,
> Vasilis
> 

Hi Jonathan,

Applied already, you can take the patch whenever you want,
thanks for the help and the heads up!

Cheers,
Vasilis

> > > 
> > > Cheers,
> > > Vasilis
> > > 
> > > [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#t
> > > 
> > > > > ---
> > > > >  drivers/iio/pressure/bmp280-core.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > > > > index 95c88b0e1c49..3a003843c79c 100644
> > > > > --- a/drivers/iio/pressure/bmp280-core.c
> > > > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > > > @@ -1752,6 +1752,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
> > > > >  		dev_err(data->dev, "reading temperature skipped\n");
> > > > >  		return -EIO;
> > > > >  	}
> > > > > +	*raw_temp = sign_extend32(*raw_temp, 23);
> > > > > +	*raw_temp = ((s64)*raw_temp * 1000) / (1 << 16);
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -2154,7 +2156,7 @@ static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > > > >  
> > > > >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> > > > >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > > > > -static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > > > > +static const int bmp580_temp_coeffs[] = { 1, 0 };
> > > > >  static const int bmp580_press_coeffs[] = { 1, 64000};
> > > > >  
> > > > >  const struct bmp280_chip_info bmp580_chip_info = {
> > > > > @@ -2184,7 +2186,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
> > > > >  	.iir_filter_coeff_default = 2,
> > > > >  
> > > > >  	.temp_coeffs = bmp580_temp_coeffs,
> > > > > -	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> > > > > +	.temp_coeffs_type = IIO_VAL_INT,
> > > > >  	.press_coeffs = bmp580_press_coeffs,
> > > > >  	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > > > >    
> > > >   
> > 

