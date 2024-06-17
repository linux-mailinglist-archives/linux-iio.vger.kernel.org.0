Return-Path: <linux-iio+bounces-6426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B8890BC31
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10707B239E8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259A198A38;
	Mon, 17 Jun 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTtYLqXY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E29198A3E
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656241; cv=none; b=IvWM7jaKL/N6MdAYylDacGverPq248YWZZnsqEAHXb4AK5STnzOB7r/oVWNiSX4D6CsIf6CK/LAMtzyfs9GgdTgqz2KCaGn8blvFzo3nTfhDUkGkl1GQ4E8n3DwvvyZRCCayuoLhM+NI32uhH46NsqJrZsi9xxi7F06qs/nqxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656241; c=relaxed/simple;
	bh=KiFjhI9yXpzsfMw5rdnJmO9lBAbpypjYlQi4CIn3FFY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7W5+MoA7zR7QUWkZWjBtHKEzVDTMIDRY6k3sZeL5bfF5ZXKdgAqZcX5RL6KeupgNFLKmqjV92ns1e2WRjgI5QJolS4+0GrFTTHnOshkpPd+1PsyEsWOtsBxio7lwHF1RvrPJCltf1vTT1nL1mKSs5Fi5w+BrGqC1JnzBGTGjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTtYLqXY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so1466325a12.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718656237; x=1719261037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=92Pp25wxEMbOSvfsk3ayfLtn3nMWsq/PboWgAnWP8fU=;
        b=JTtYLqXYIxFGComADfTitP5p/54ZOqYjgMq+hxW0XIvRc1PeTtDodDEQVBLoByD8Dw
         zf4zMKecEC+s++fcN289pkrtHDe3i81NsjViN8YD18yzOI/5rF0Olh2JhYDxml6RpzG7
         BrcACrH1HJAFdh/jWfAFU1/Klxk3Tb0hCCuw9pe/7k8IAO2LiIMTRejpLQHiL0jucm13
         MURuuw4xenBNRHCmGk0q2/X6t3yd8IE15gM0d9rHsQvA2Yl5WnCavUNQYWWi/x1rGBXR
         UPUoHjOnl2pDyljRBnQH2bwjOO7naElkj8ADQ5GDn8gyHX/1sqmIUDUC0u2f7nfgpqdG
         06Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656237; x=1719261037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92Pp25wxEMbOSvfsk3ayfLtn3nMWsq/PboWgAnWP8fU=;
        b=uC+lM8PJZa74kAo68NVxIERIURXxuTJXsc2iVxmhWI6omer1rmSqLu8yssI7j/QL9R
         nEWQjj5cSoAvAZhkOy4NLUuWR0AkxBc/yjlpRezhbxcOA3VKWwnOni/tTUuyFhsGNeXS
         djlGaUh6eTWpHWqLZWzK0O5arrEogwSbYunHzB96aGFmSyC+NJ13SXHFXZJd9hM9N3Xj
         rnRovo0DlsV9GhEiQSx6FsuckuCH3vGQ7RuZvirGFuLq/REq3347J6O1CLEP3Lpgt5EA
         vD1kIiDg/NLJiQA93Xc/wC/+hdKtT0s9pchABbRR9BrtMuEyyHsVuJPo2xH0tYpE5Hyx
         rdMg==
X-Forwarded-Encrypted: i=1; AJvYcCVM2EYPpcw3HIuEJQtwo97QNeY4zpTkZXifAuHefFf7JKlwitjZRzZwfLVj0/tQKJ+j1rWtbMYb+o1fY9rFTU+Lvhdy0kG4MwMC
X-Gm-Message-State: AOJu0YwNQ6g/UkVXQcYP8VsLCg0KsUVQJnDF89qIcW9tvr6c5fjUWe5M
	XfmTaVwmj3SJGNH00wkrenYZdih5W6Ezi470uvR147f8udZq/u6F
X-Google-Smtp-Source: AGHT+IGCI2T+QgYFah8v9Tnayn4UwwUggNSfg4VrvgEVLaQrXtwL8b/aooK2jLjf1n+WZ2C8VKJLyQ==
X-Received: by 2002:a50:d514:0:b0:57c:5f88:7c69 with SMTP id 4fb4d7f45d1cf-57cbd8b9c4amr8839890a12.38.1718656237223;
        Mon, 17 Jun 2024 13:30:37 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:b152:a6ad:d6c8:f0e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb9b7c1d8sm6620704a12.53.2024.06.17.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:30:36 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 17 Jun 2024 22:30:34 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	Adam Rizkalla <ajarizzo@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix bmp580 temp read
Message-ID: <20240617203034.GA11985@vamoiridPC>
References: <20240602201200.30418-1-ajarizzo@gmail.com>
 <20240604200107.7f68dbf4@jic23-huawei>
 <20240604191904.GA19711@vamoiridPC>
 <20240617205726.7ddcd6eb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617205726.7ddcd6eb@jic23-huawei>

On Mon, Jun 17, 2024 at 08:57:26PM +0100, Jonathan Cameron wrote:
> On Tue, 4 Jun 2024 21:19:04 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Tue, Jun 04, 2024 at 08:01:07PM +0100, Jonathan Cameron wrote:
> > > On Sun,  2 Jun 2024 15:12:01 -0500
> > > Adam Rizkalla <ajarizzo@gmail.com> wrote:
> > >   
> > > > Fix overflow when storing bmp580 temperature reading and preserve sign.
> > > > 
> > > > This patch re-applies the fix in [1] after the merge conflict resolution
> > > > mentioned in [2].
> > > > 
> > > > [1] https://lore.kernel.org/all/Zin2udkXRD0+GrML@adam-asahi.lan/
> > > > [2] https://lore.kernel.org/linux-kernel/20240531140621.264f0848@canb.auug.org.au/
> > > > 
> > > > Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>  
> > > 
> > > Thanks! I was just about to email about this fix currently being lost in
> > > linux-next.
> > > 
> > > Rather than dance around this, I'm going to pull the later part of Vasielios'
> > > series off the togreg tree for now then reapply later once I have the fix
> > > in my upstream.
> > > 
> > > It's a shame that we need to do the maths in driver to keep within range.
> > > Maybe we can be cheeky and avoid doing the division?
> > > I believe the IIO core formatting code should be fine with that as it
> > > already casts up to 64 bits to do the maths.
> > > 
> > > (s64)*raw_temp * 250);
> > > 
> > > bmp580_temp_coeffs = {1, 18}
> > > 
> > > Anyhow, I've dropped (for now) the following patches from my togreg tree
> > >   iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
> > >   iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
> > >   iio: pressure: bmp280: Add triggered buffer support
> > > 
> > > Jonathan
> > >   
> > 
> > Hi Jonathan, Adam,
> > 
> > I had mentioned it here [1], when I applied v7 of the patches that this would 
> > happen. No worries though,  I already have the new version of these 3 patches
> > that include Adam's fix, so when we have it upstream I can resubmit them
> > (no need to keep a note Jonathan, I have it) and I think we will be fine!
> 
> Excellent.  The fix is no in the upstream of my togreg branch.
> 
> I've only pushed it out as testing for now, but if you send a version based
> on my testing branch or 20460472952 (currently char-misc-next head) that would be great.
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Thank for letting me know, I can send it by tomorrow.

Cheers,
Vasilis

> > 
> > Cheers,
> > Vasilis
> > 
> > [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#t
> > 
> > > > ---
> > > >  drivers/iio/pressure/bmp280-core.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > > > index 95c88b0e1c49..3a003843c79c 100644
> > > > --- a/drivers/iio/pressure/bmp280-core.c
> > > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > > @@ -1752,6 +1752,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
> > > >  		dev_err(data->dev, "reading temperature skipped\n");
> > > >  		return -EIO;
> > > >  	}
> > > > +	*raw_temp = sign_extend32(*raw_temp, 23);
> > > > +	*raw_temp = ((s64)*raw_temp * 1000) / (1 << 16);
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -2154,7 +2156,7 @@ static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > > >  
> > > >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> > > >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > > > -static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > > > +static const int bmp580_temp_coeffs[] = { 1, 0 };
> > > >  static const int bmp580_press_coeffs[] = { 1, 64000};
> > > >  
> > > >  const struct bmp280_chip_info bmp580_chip_info = {
> > > > @@ -2184,7 +2186,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
> > > >  	.iir_filter_coeff_default = 2,
> > > >  
> > > >  	.temp_coeffs = bmp580_temp_coeffs,
> > > > -	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> > > > +	.temp_coeffs_type = IIO_VAL_INT,
> > > >  	.press_coeffs = bmp580_press_coeffs,
> > > >  	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > > >    
> > >   
> 

