Return-Path: <linux-iio+bounces-24044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB3B560E4
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BEF3ACDCC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F612EC0AB;
	Sat, 13 Sep 2025 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwYm6YKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626F288512
	for <linux-iio@vger.kernel.org>; Sat, 13 Sep 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767515; cv=none; b=A2DkxdbAH4jxNJ810m29Bke9DRl26/vt/UyQfMG2oDe3XQjREsFo8IlG4FrFaHah/sYKHtqdG7kr3016cCkuSEWag1wZY9LNzYZu7t52OGYv8aeS1+c2nXKaREFVxO1puMfa4erN+whZHq5MSFkz8d08YS5LcVUuf/6E7XBGOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767515; c=relaxed/simple;
	bh=xMaQibe+xIzu2wuKVnlslNWfdwPWjSm3Neinl6dyVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m21QpzyfYqqdyfn5n5RNYyRXxD6GE3AhmOny2kR2X/YJErwaffFh51eUAvIEjqk0vvW7U6reHte0KUPtN3jxt1XT5osL1nY2vTIKvrMPauRN5ydDXcVC4rCu+KHZ4f4uOwi1v41/GeuHKX8hl0h9EJYoMIyIGjEt5nBIhsR77N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwYm6YKJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47052620a6so2595078a12.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Sep 2025 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757767513; x=1758372313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBgNhLc05aeWCQ2PbldjUAPRODag2fhm6XeBdAbAa/k=;
        b=WwYm6YKJyl2g9ydjTcm01EDT+6/nr9dmSdYX123h3LiWwFbMyaKW6Wm2tE/hCCyQx5
         bk8vwgStltRjoxLscX2jBu8JxDFrreAtPCKRzAKhbVaakbSohtm04mPUTPJlOoJGOui6
         sAoMR7BrttreRJ4uGBKBiFvKShqoOMb8u7lqI6+nphgjNCLfkPX/PYzNMTp7Qo7FBv4l
         gUac+EPgODmNes0NER7sp3WsJ4DsDM6AomnaFwuDdTovON+WlxChSL9fNulCCn5ymjXQ
         BNTm9O6J6kinUc44GKUr4oyn5ddc3Zyq3J/Ov3OgVBfgZWWzr6zxIxMXbudcA/yChEiz
         Cyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757767513; x=1758372313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBgNhLc05aeWCQ2PbldjUAPRODag2fhm6XeBdAbAa/k=;
        b=DepPu+o1xKc7xrSiTp8WsBrZv4yOn4k/5bwJ6CESyc9wSwF/cI/5wAPMDJ8lxvj02T
         X4b+tkFrQaxksCdwcAyALyJvWEWIWzUyJ7+AgHmEUznG5GZxBDm6mYnhLETalr9qjUz3
         FDW/YEEpoDZRhxf6b8Y+HEXzOl1DT7lv7WAad7UeiMsnvmNuBZWJLxy31tBQ/53an6Ep
         Y+FRKA615Kjy01QjwfLQtPjMrYqtpXhvifQzU/ezy57cVN5RWBfIXI0ig0TIbUbvtNta
         JaZwJEBNqAQAC3pGOwqw4QZqn87pDmVVnXgxzuWD8WIt8zwOrFf/d6IRyiBNtmNSVxkk
         UUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe1SoJqTsHS2p+3j8sWGUcXJ4YTDL+nCw+hPtS+M64ozHRDzlyKth8X1X0LgOZvu5qGU4+2A4FDV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwDqS8RU20lbS6xPbh16im+UOmejAcTRt5UkciZeEGI7s3u3P
	yFj+TgYwZqtDz+RlEq0NyVGVPcie1mXvgpGSr6stuoiuK+d08F1GtLki
X-Gm-Gg: ASbGncv4htjAFuLsv0sR7LmaWOzzdc52o82TH3HhqDpm78vZtAcF+UKxKvME6T+jEU5
	OhXdE6tpKOM+spDhiHCvVp5bvt2GcF2mTbL7nA59wHIqETTRFbBIOepqV4KNGrDJjNL0elOHC0w
	gfNSnicluTNvEWZcWWK0bLmKID6/7Ng9hUTX78r3elBl3KTHRRC4yhY/vUsI8TSDyZle/XjGtgI
	RnoSBLuIY1tOgh+ASPu9Q1tyhLywEWdKOA3nTyc7qmLqkl60ChhiIcXDQhtULsgcn4UedYzbNaU
	SVs7ZssmFmw9YBit+GhP9SUCc+juQ1ygYrAjlLqh+wVWwd5fBmnmBqKA3VYlbjnLBAohp2tKlT0
	K9ARyGfM=
X-Google-Smtp-Source: AGHT+IG/lfy1NWrcEIj+W7etpm7WKSUoeiR3GGEPpsh74n6PAeF2X9pU1kCN9vBnwj/Y59cDM7I9Mg==
X-Received: by 2002:a17:902:e844:b0:24b:1b5f:1c0a with SMTP id d9443c01a7336-25bae12172cmr96054945ad.21.1757767512934;
        Sat, 13 Sep 2025 05:45:12 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b4f43e6sm76359485ad.148.2025.09.13.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 05:45:12 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:46:33 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
Message-ID: <lipouuxehycprgdxg4yqg4wuw7pqpeynpfbzzpukatn3wbnwak@znjzqj434atw>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
 <20250830115858.21477-2-gustavograzs@gmail.com>
 <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>

On Sat, Aug 30, 2025 at 03:44:37PM +0300, Andy Shevchenko wrote:

Hi Andy. Thank you for the review. I just have one question before
sending v6.
> 
> > +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> > +       ((val) * (scale) + ((val2) * (scale)) / MEGA)
> > +#define BMI270_RAW_TO_MICRO(raw, scale) \
> > +       ((((raw) % (scale)) * MEGA) / scale)
> 
> In the macro names "MICRO" in the implementation "MEGA", please make
> this consistent.
> 
These macros are intended to work with values of type
IIO_VAL_INT_PLUS_MICRO. The division by MEGA is what produces the
fractional part in micro, so the naming was chosen to reflect the
result.
If you prefer, I can rename them for clarity. But please note that the
same naming is already used in the BMI323 driver, and I kept it
consistent here.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

