Return-Path: <linux-iio+bounces-5783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36088FBC70
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0173E1C2150D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266814036E;
	Tue,  4 Jun 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFC0aPDn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A0801
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528749; cv=none; b=Jd2qdtVMerMT93o4pR8FoL8KbSr8uNClVxhKWVV0nzqRvMu62m9tdTgch0hv7FYlHB9mYrQd58qJupqRJL3PKdIi00XvKKlWRMHDrXdkN5NnVJt4gtS1bjCA+77b6JNhbIBSGr4vX7oLm98BniZVXwyNFNROJqjq5C3whzl1XsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528749; c=relaxed/simple;
	bh=cOVa+/Lh6t7HOoOUP0bzKeSoRFN5UWKmW6Wb+K44c/Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H55RFltLLvPqoOleT9u83O7uwuj1oJe5r27rxtycoZwmjFUBy0T5jz85cDAelxGHZJUOABUg0UFYEvF5QRy96z11s049tkuiSPeI1NtGZKQlB989c7tQZEetY/ex8EmwsJYND1D+iUHyoSAulFwuXHBZIixJpL3qGnGON+EG3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFC0aPDn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213870aafdso28450925e9.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Jun 2024 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717528746; x=1718133546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib27gSvh3MBZgFtR2eADPxjjpbTa05z1cQo+VvVX9G4=;
        b=UFC0aPDnYPref+hYdBcP0NNgTuhN7wUSm8WkvVO9s6YRbUYMUGSvtqTV0dKALms0oc
         1qxLAirrTMh/FqnwOCkAW9+HOCUIU6xb6eVg0N1sT25Ly5+azsUIPaRDjrvqWcJdaqhb
         445vYp7xicWIrL9AC0gTcVurs1PTAi4khPHsvEsdsrpPSLBb4hvm51502r+ESmyxWBHZ
         fklrGpWmfpxQVqjUzivaQE43eld1FOKIGtYikhxw1wAVfm1YlfDaaDr8dUx7IKqdCM7T
         b6pO+DdmQ+b1gqruaSTYRq4+483f0VzMjpZZD3e5WLl0AvrFoVIkRMCPh7TkN9AmatVE
         bPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717528746; x=1718133546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib27gSvh3MBZgFtR2eADPxjjpbTa05z1cQo+VvVX9G4=;
        b=dzR81SwNvWwLtWycDs3XnrDglh+NMU/yLjG6YQv1bPUcHqjeTgCNlyDZMYBIv7MYrr
         jsf30tkHMkLNH6TtjzFc12QmaloEA4OQ87wKhYkPhQtWldYLhO8W4dScr/qWc68Yzqb3
         0x23z3nMC1TLFRAW4YtXGQ34avVH+p1kjYEmpdqZ3pERC04zJwuGqIkwpH3Bl8uWLxx2
         Z8lpvP7+k/4nNKWf37K6iLmFIqgO4Hxy7XPIGkPKjtVTckja+qNACLENm+/usxkhmv+D
         DI1PNGs+cSCsYMLzjYUhaBn8ArqHlvINLA4zaYBQAT6zo2v624Jvj0jNacAAJDNfP20p
         YRBw==
X-Forwarded-Encrypted: i=1; AJvYcCVeYrYpcws4QR8Nm/9kZt/xUWHPJAfe/BQRZorNcfDqwgxLrHQSrkWnxIsCdAXqaO3fR9ipRsXUUvcLraNGNCSgivPyIAiCHzev
X-Gm-Message-State: AOJu0Yz+DmWfyUjd5l1Mt3AUKCfDlyNuGWjvwKL07FgZq/EvSUsvfjmY
	67/HV8I+5gb8KbKjLzHF6na4XTVaPNftv4azFDj5D/tlNBELkQX3
X-Google-Smtp-Source: AGHT+IGiphfjTCHkAFSEBxzhpla579IImnA5as/sZWH2pHHWbkdhPKfDgWSzlQY6DU25igKW6Smgbw==
X-Received: by 2002:a05:600c:3108:b0:41f:e87b:45c2 with SMTP id 5b1f17b1804b1-4215624b7fbmr3997735e9.0.1717528746180;
        Tue, 04 Jun 2024 12:19:06 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:a913:c0c9:f979:5aec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062ecd3sm12633094f8f.74.2024.06.04.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 12:19:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 4 Jun 2024 21:19:04 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Adam Rizkalla <ajarizzo@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix bmp580 temp read
Message-ID: <20240604191904.GA19711@vamoiridPC>
References: <20240602201200.30418-1-ajarizzo@gmail.com>
 <20240604200107.7f68dbf4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604200107.7f68dbf4@jic23-huawei>

On Tue, Jun 04, 2024 at 08:01:07PM +0100, Jonathan Cameron wrote:
> On Sun,  2 Jun 2024 15:12:01 -0500
> Adam Rizkalla <ajarizzo@gmail.com> wrote:
> 
> > Fix overflow when storing bmp580 temperature reading and preserve sign.
> > 
> > This patch re-applies the fix in [1] after the merge conflict resolution
> > mentioned in [2].
> > 
> > [1] https://lore.kernel.org/all/Zin2udkXRD0+GrML@adam-asahi.lan/
> > [2] https://lore.kernel.org/linux-kernel/20240531140621.264f0848@canb.auug.org.au/
> > 
> > Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>
> 
> Thanks! I was just about to email about this fix currently being lost in
> linux-next.
> 
> Rather than dance around this, I'm going to pull the later part of Vasielios'
> series off the togreg tree for now then reapply later once I have the fix
> in my upstream.
> 
> It's a shame that we need to do the maths in driver to keep within range.
> Maybe we can be cheeky and avoid doing the division?
> I believe the IIO core formatting code should be fine with that as it
> already casts up to 64 bits to do the maths.
> 
> (s64)*raw_temp * 250);
> 
> bmp580_temp_coeffs = {1, 18}
> 
> Anyhow, I've dropped (for now) the following patches from my togreg tree
>   iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
>   iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
>   iio: pressure: bmp280: Add triggered buffer support
> 
> Jonathan
> 

Hi Jonathan, Adam,

I had mentioned it here [1], when I applied v7 of the patches that this would 
happen. No worries though,  I already have the new version of these 3 patches
that include Adam's fix, so when we have it upstream I can resubmit them
(no need to keep a note Jonathan, I have it) and I think we will be fine!

Cheers,
Vasilis

[1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#t

> > ---
> >  drivers/iio/pressure/bmp280-core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 95c88b0e1c49..3a003843c79c 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -1752,6 +1752,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
> >  		dev_err(data->dev, "reading temperature skipped\n");
> >  		return -EIO;
> >  	}
> > +	*raw_temp = sign_extend32(*raw_temp, 23);
> > +	*raw_temp = ((s64)*raw_temp * 1000) / (1 << 16);
> >  
> >  	return 0;
> >  }
> > @@ -2154,7 +2156,7 @@ static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> >  
> >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > -static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > +static const int bmp580_temp_coeffs[] = { 1, 0 };
> >  static const int bmp580_press_coeffs[] = { 1, 64000};
> >  
> >  const struct bmp280_chip_info bmp580_chip_info = {
> > @@ -2184,7 +2186,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
> >  	.iir_filter_coeff_default = 2,
> >  
> >  	.temp_coeffs = bmp580_temp_coeffs,
> > -	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> > +	.temp_coeffs_type = IIO_VAL_INT,
> >  	.press_coeffs = bmp580_press_coeffs,
> >  	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> >  
> 

