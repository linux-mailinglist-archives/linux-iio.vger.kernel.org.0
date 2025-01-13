Return-Path: <linux-iio+bounces-14301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C4A0BE21
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB06167FA9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33D20F073;
	Mon, 13 Jan 2025 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TgP2BeRC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191920AF73
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787520; cv=none; b=AkL9b5MgrzY/OCLVTSFpJ9VPMttpfkH53SgrYYiX0c+XQv29bmJTcJBs1oNd6eMEYUIiG5DUF08fyj0MlZvenzywtBFdKw2bWie050X5UpRkO9dUw4Fyn1tNJDSDgw4pVMpKYszxkKXpcvDFoa9ihJT0YuOBGy160Y+3CWE+uz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787520; c=relaxed/simple;
	bh=jufA5W5R+v8q7H2doVaCspNvdwUagAXhqhYVE+byM1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM0VwBQQA+FmLD+J3ND5HbCqfR997b3b+HfdJIsI5F5ylniQzWL6qtRcXokFP2tn5DikQltG2NwrLzJpwt64Z6G6o5XCr2qz1UFZvVWXESg16FOtDMMwg07jYc6kB6S8Bc3QS8Eyb+sHtTeIVfs/NHJDuxAQKwbsrlTI9FeeQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TgP2BeRC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862f32a33eso1989719f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736787516; x=1737392316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GacQKsg9AkxvAJLhtCYx9osY8VBTX0YYXTOsDVWbFU0=;
        b=TgP2BeRCPa4BvE0S/MtYCkBoVSM0ln/tF9Bwm0dblCyNjxMzxjbLsreDGAGNYsg08+
         G0Y2Lo3kBc17j8+I44eO/k4qYbrE9cG00rh85IuJIggBKayZFswZPAWbuCv6zqcVUaaH
         3jD2qDIa545+TkV6HAT+L8k1gMC2HBfZHV5eNn6I7UsFUNqAEMuHi2mk9GEMfZ8xo7XB
         MP5Xg6bdWTNFLB4F0OIy8qBbhb0fMTzYVX2PZlU8vFm+ezuHdiLXs6u8K0OjbZkU7bmZ
         cQnmR6ljkV0ByOUZI8XA/KfMAB/XXqdxg3S33HEzRmIJt2lSOJ/y+7tEB0UK0pykIlZ5
         AcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736787516; x=1737392316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GacQKsg9AkxvAJLhtCYx9osY8VBTX0YYXTOsDVWbFU0=;
        b=VSZyKDBZMUbGeh1QKr8MY3gORw2YNc3TQm4umCfecQ9HJ02XK/Mz9vxAPUBIrsgqVe
         5cMYPjKWDZ6GAajTQzAuJQJdRgeMot6AbowGpBehIp4NfRIUtfY+FoNK74hPbbsTulGh
         oSUh1+EM2HzKeOgimvoaKKvGJBalWrrB8CIuqfuNmRd2vYxthdAyIn2P3nbmStfiNIV1
         82AfQ9UNMu2v43L/UfFQPZ8g1UYBO94DCie54lie2ZWjh/G7IENYIBc8xfTAFc7PAL1q
         tORZRwH0mQJPLzpg/3P7V0zytGQBFQEnU6LTODqt/Lv57bG/CvSIdyCpaXlzFkVgJkNu
         8K+w==
X-Forwarded-Encrypted: i=1; AJvYcCUP2GXhakSyKjIKzXPSSiJFcuRYwH7YU6oMpevqv7OmJ2lajDZ4jokMIWndgBq4rSbfKx1puIHFtIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Leo0a2venF2eb3idogsOFrQUX0EQqUZ7FrQiwGeQGyopByos
	l66gDr7ISYvfSzSsrOxGGrUDW161e6HyALZbLGB40Hv+JLsly/fG1N6JSL9o3q0=
X-Gm-Gg: ASbGnctBmANgR6Qiax7gHyLUF9PmLGyC0ezgFOBr6nMOIiOjN1RPjv1bYqOiHzgDJ+0
	jOVbNuWMZrt0qXTDqvu4fLatlS1Qrx+Wv233t1jsASw1ICcjpwN0soxC1f7r2pvlZpbjijXXOXH
	8OepRaEQFEppkQwNO4ilRXYy6tn15/ODKf+ifffuJ7IGqx/rYC8IhNwfiVIGaY4AGM/dmm+zQs1
	4ur9Cn5WcBO3o8tOcDw09CD9YItOQxvgoyeS0W4uQxu9n5a
X-Google-Smtp-Source: AGHT+IG+QwByuMRdwyxK3eH9mQ2jeH1EQL3khqF/IxUKUIAExpWSOjfAj2F6KernqEJd3geyo3cPcw==
X-Received: by 2002:a05:6000:1882:b0:385:dea3:6059 with SMTP id ffacd0b85a97d-38a873558acmr18750962f8f.49.1736787515628;
        Mon, 13 Jan 2025 08:58:35 -0800 (PST)
Received: from dfj ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2df2faesm185008515e9.26.2025.01.13.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:58:34 -0800 (PST)
Date: Mon, 13 Jan 2025 17:57:13 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iio: dac: ad3552r-hs: clear reset status flag
Message-ID: <4fk4oxe2ymyqjd3ocazfdw6rias2kvn7r26vto7zp5aovv5ysm@notdy7rnal5a>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-2-ab42aef0d840@baylibre.com>
 <20250112150404.6ffb7160@jic23-huawei>
 <f7bc1af8824b99c1f82d386b71bf238928402743.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7bc1af8824b99c1f82d386b71bf238928402743.camel@gmail.com>

Hi,

On 13.01.2025 15:58, Nuno Sá wrote:
> On Sun, 2025-01-12 at 15:04 +0000, Jonathan Cameron wrote:
> > On Fri, 10 Jan 2025 11:24:14 +0100
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > 
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > 
> > > Clear reset status flag, to keep error status register
> > > clean after reset (ad3552r manual, rev B table 38).
> > > 
> > > Reset error flag was left to 1, so debugging registers, the
> > > "Error Status Register" was dirty (0x01). It is important
> > > to clear this bit, so if there is any reset event over normal
> > > working mode, it is possible to detect it.
> > > 
> > > Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
> > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > Ah. I should have checked for newer versions. Anyhow, picked up v2 of patches
> > 1 and 2.
> 
> Oh just saw this now. Anyways, just gave my tag for patch 1. If you can still
> take it, feel free to do so. Same for this one:
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 

thanks a lot.

Patch 1/9 has no changes, i'll re post it anyway with updated tags.
Patch 2/9 has a dev_err removal, should eventually be re-applied.

Will track this on the changhe log.


> > 
> > > ---
> > >  drivers/iio/dac/ad3552r-hs.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > > index 216c634f3eaf..8974df625670 100644
> > > --- a/drivers/iio/dac/ad3552r-hs.c
> > > +++ b/drivers/iio/dac/ad3552r-hs.c
> > > @@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state
> > > *st)
> > >  		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read
> > > 0x%x\n",
> > >  			 AD3552R_ID, id);
> > >  
> > > +	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> > > +	ret = st->data->bus_reg_write(st->back,
> > > AD3552R_REG_ADDR_ERR_STATUS,
> > > +				      AD3552R_MASK_RESET_STATUS, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	ret = st->data->bus_reg_write(st->back,
> > >  				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > >  				      0, 1);
> > > 
> > 
> 


Regards,
angelo

