Return-Path: <linux-iio+bounces-10466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196599AAFA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6C51C22281
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581F1C8FB7;
	Fri, 11 Oct 2024 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaPuo91h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905A219FF;
	Fri, 11 Oct 2024 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671531; cv=none; b=qMaOU3Rn9gvDN2+qxZuHFWabpNJdjLBumLorl6XVIHT+xU3DBbW+TFEoWAz4uF+i8daO+CGQ5CDZdlxX3YSVV1SG31mv07Kh1EYmgc+T1qzA+9/Pc0NpxY1Il0znSH9pyWcu7uoOBCacCMgsdYVCoUA5wCf/9IGwgq4OSwfbeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671531; c=relaxed/simple;
	bh=6ABpjJ5c9laXV1Mofwkc8XFAV1AdWBcZM3Tp255Plkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VavLff9YmmJP2RNpgavr5r/3PFF2ofHthfRYHGaDEdy4R6GJZuPCC/G7YXMlmTN+R6GBsLfscurv1hq+NifKUfIB46TQx3sOanZA86dm9nZfbzqve7bFcenjTrT4ZUIVWblFT0Kmbj8MWp2RjZGqX87JepciV1fHeL4O+/KkHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaPuo91h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so845967f8f.2;
        Fri, 11 Oct 2024 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671528; x=1729276328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzGJQXEa8Jg8mFbIKKFv9fTv+IGcsaWIojSt7WKuh+A=;
        b=CaPuo91hwA4EyxbwjGKArpS6SMPsqh0z1Aaazl8r4b5TXels9ScF2tcIhLBfdM6JKA
         Jzxbpdldwb6ETYAq0xUWKCzZfnpvElu19Xe5uNPu6AInbMdSJ93/weFjaccJlARKY8dw
         wU0RwnLnkIr6tJZJKVB/vEniIUm/sLH5jUp/+CavBOj66E3ganOTfibX/yNIYb1cg2Kt
         Hz4agwQpcTWUjVxLxRhotmlQoLasrVV1n0odMz0fNWw926nyMyiCP5WLOBwGa7Ytwoih
         pnjznTgVr6gcmiGtxGPUo+eX7ao7lKn08w4LTrBb9fxVI8xmtOGHnDr+MWfweM8nFDBI
         qjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671528; x=1729276328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzGJQXEa8Jg8mFbIKKFv9fTv+IGcsaWIojSt7WKuh+A=;
        b=pnRUDyXzS8xbOoZQ29TDzFbE4NEUDuZr7jQzUVtVXcQIJUjtFyOuTD5zVPha7MWcXT
         ViElkIjAdYhSdm4gQ/jtPGaxGdEdLW6Cep+JSYcxizxP5mmNnaGqCgxcg24CkxmEHgT0
         wQySfIdQLmb1s5Cz3J927ey9gKQnKgDTgt8husTYrizkwD9wM8Zp8rnTbtdVHVECZmbf
         V1vv63stxk7MecVjF6N1sC9YIMa+OgmARO9SvNsJenfeBxB9ae8RkIGZVs+PYJ875+bu
         hCzqiuF+n3FEnMFK0NsQ9iwXZ8yp6hKZuwXqCHaYLVPnM62fBSA52VrNk5PjYuY9mFxY
         ayeg==
X-Forwarded-Encrypted: i=1; AJvYcCVC8jXCMIiZkx2Rm/QA1YcYeRuuFhclayZbh9lylNiM6OhD4cZtacH7kC7+IQPHpbkBMEm5n0Xs4vjjsJ0p@vger.kernel.org, AJvYcCVpW0/l12XB4J0kHN+Bf99vPCo22jjtZiDXdrc9s8gDRh7boRDAAN5tv35bZJ7mBGkMecqShpAIydE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytmLaZr96BR1oS0GR0BEis09OuB9b+UeI/5YEj1WEkM6AK0cB
	SKxXLoem6ZT1hE4rmLbr2N2UbyD/4/tQDeOENP7wf6/4P8bBHO7b
X-Google-Smtp-Source: AGHT+IHZfchisX4gDQW0KTvSURH8Cyp5fZ6XTR97BtsqZNdAAQv/sME0MaU1UtwkGoz/6W+YdQerPg==
X-Received: by 2002:a5d:574e:0:b0:37d:518f:995d with SMTP id ffacd0b85a97d-37d552d92c7mr2193936f8f.56.1728671527597;
        Fri, 11 Oct 2024 11:32:07 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79faa8sm4504907f8f.66.2024.10.11.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:32:07 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:32:04 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net, skhan@linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Adam Rizkalla <ajarizzo@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] iio: Fix uninitialized variable
Message-ID: <ZwlvJCxdiRqRWu6Z@vamoirid-laptop>
References: <20241011093752.30685-1-0xff07@gmail.com>
 <20241011115334.367736-1-0xff07@gmail.com>
 <26f2e35e-0a07-4b24-91a2-a48d4bc5dadc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f2e35e-0a07-4b24-91a2-a48d4bc5dadc@gmail.com>

On Fri, Oct 11, 2024 at 02:31:00PM +0200, Javier Carrasco wrote:
> On 11/10/2024 13:52, Yo-Jung (Leo) Lin wrote:
> > clang found that the "offset" in bmp580_trigger_handler doesn't get
> > initialized before access. Add proper initialization to this variable.
> > 
> > Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> > ---
> > Change in v2:
> > - Make value initialization immediate before its first use.
> > - Link to v1: https://lore.kernel.org/all/20241011093752.30685-1-0xff07@gmail.com/
> > 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index f4df222ed0c3..682329f81886 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -2222,6 +2222,8 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
> >  		goto out;
> >  	}
> >  
> > +	offset = 0;
> > +
> >  	/* Pressure calculations */
> >  	memcpy(&data->sensor_data[offset], &data->buf[3], 3);
> >  
> 
> That was a quick reply. I would recommend you to wait a little bit while
> the first version is under discussion.
> 
> I still see the offset thing a bit weird. data->sensor_data uses an
> offset to avoid hard-coded numbers, but for data->buf we do exactly
> that, in the very same lines.
> 
> Setting offset to 0 to access the first element i.e. no offset required,
> and then adding the actual offset sizeof(s32), which could even be a
> const if the first access was to sensor_data[0], looks to verbose.
> 
> These things are of course not critical, and the proposed fix is
> definitely ok, but I am missing some consistency here.

Hi everyone!

So if you check also the conversations that we had here [1] and in the
previous versions, indeed the idea behind the offset is to use it as an
self-explanatory index to a char buffer that holds in fact s32 variables.

The data->buf here holds the values that have just been read from the
sensor. If you check on the channel specification of this sensor,
you will see ".realbits = 24" in both values that the sensor returns so
hence the value 3.

I am not sure if it makes sense to use a macro here for each one of the
3's that are going to be used only one time each and in order to be more
"consistent". But I might have a wrong view on this one so feel free to
correct me!

For the initialization of the offset indeed, it was already mentioned
here [2] this morning, but on a different patch!!! I couldn't get this
error though with gcc...

Cheers,
Vasilis

[1]: https://lore.kernel.org/all/20240930202353.38203-3-vassilisamir@gmail.com/
[2]: https://lore.kernel.org/linux-iio/202410111221.YIeXHxOv-lkp@intel.com/



