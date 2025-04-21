Return-Path: <linux-iio+bounces-18425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C943CA950F8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9372B7A18A5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B88264A9D;
	Mon, 21 Apr 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSA4Mdqc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847C1885B8;
	Mon, 21 Apr 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238794; cv=none; b=Cdw6GizSmCQ3zPM8pc3iCa507crYeqtuvYUe8G3e84hz31UONqKRIWJZHwhtn/nTuYCDDIJgDFFAVr8mBhBE+89u1+J7cXyw4iRoWxuwZ3ltCL2PHbLxGwYxeWz3j2bTaqvsQ1v0p6luD632/dOxbWAEAI/UlfRMjpXCFRX+3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238794; c=relaxed/simple;
	bh=wqrJORC7kXaeaHHCXjKjEWLJCiYSLyOiCXagiUJd88k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCnR59qgG6qNL2BE7yxSzd9ZQIa38M+kBctTzPiaruS30uw5Qe4ZdHdUw78zP9tzvqnGS5Y9kUMiMxkUZ7JAU6R6DQsu6Rqvw0+Fk0/CEiRJaXS5FAZ3l76YaOmYY6cs5FyES2O39e8iHyWIy9cDm+xXChT9dyjSVmspoTYmiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSA4Mdqc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a304a8edso41494561cf.3;
        Mon, 21 Apr 2025 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238792; x=1745843592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eChZmy5qVC82sBxIFmHOSjXPUbGZooL1QoxWZm005kw=;
        b=YSA4Mdqc4LFlsk6PBmD1YXxZEefBVjVVNrY0AWfC/aeqCuRZRhJLxDcrzZAhlm6J56
         rt+ki851Puc+ubeYIu67Y0uVNUUDoKYwPqhnOMYE7VQRpJdVDCkV+hyLqyzkp2a864d0
         gFlZAslDn3pq2T5Aw5BaWqjWssEZjTAqyLs2eA/QnMqz+La8ofcIrcuFNdjMHaHzgNjU
         YVa5yocSpEekK6FzNzWRAHSX8GBCNs9tcpUgfSy9p1afL5LrODh23PjWu9FNnQ5YIRFo
         0W+lJuMMbz9deN738LTSaT7F9LZRHmYFj1TJEu98KSk0n/RGWDAZWVbYbJHiNBBxunDZ
         4xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238792; x=1745843592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eChZmy5qVC82sBxIFmHOSjXPUbGZooL1QoxWZm005kw=;
        b=KhcQacJ8OuQEV9yT+LTGNLs+J5XJbdiT72LQYgFRsJE+jmUEXF+OwKOZtBWjC/f/Y2
         XnJ05hibXWecA2WusaOphJmqlzuB6v1fHMk5R4HKskSkIS2kISlGA+m+QhRg+2JUDyyl
         764lFtC36wgd1mIx7hj5n8FHrbUZP04CVQyvHMxgcyPPTRMUCZeGBV921HBhrZCcerxO
         a/vK+i1dbpdX/vpqfw88OH3P9t8Uu7F3CS8l5Egw/x51Tl2Xx+8NiwkBmz7Sxjl6tWOz
         ua+YIpT5Q4ildihVZqenjKOaMHx0VPEWkzfRrJ2Fl0SaX5S50uNuTBHIHdQHJ0DB3Q54
         d/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVElrEGKBPMPCkpBLswO3QfIhD/7i2t4pSEpUsjGTzfhoYsyNNvFDwIK7mDjiA5gclPBJBMTldVTISBWScA@vger.kernel.org, AJvYcCVhkZ5pZt6QZvq3fFbtNL8LVtsk3K//vxJwI5VOUpWWi89gfyZYpAGR+XlkLf6rRgArxNiwsggH@vger.kernel.org, AJvYcCXBfta/xjOQi5qfAyy1f5hpaq0PmHCX6mQYlv41mPhImnNk5NKiz/tTLditg4P3JjbwKhiLzks7iPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInogeNnfo61I9PEnU70g5vxbIHCcyv3gxbeIvveUCQjsuYhfL
	n6f0r/J94ufT6mAVv+vZsxFwNTEBi8gOKlJBks0Rr8w03Mzu8uAtsz3BVyVSOQhgMLpWZO3XxwL
	MVeTDxYuTcyuoGIPCROfIGrOAS0c=
X-Gm-Gg: ASbGncvEVCBu0BMv8LL3n8YIqWYVmZyGhbE53qh3O9iLB0tlyfLdudlT1y2bmVFulrE
	IMAUj0GJYL6lS9G39nAbh7/5Oeq3AiSl3lZP2Tm4Psa+6LRrbpbdIVu8T1oPK2CmmeUOf3OZYCb
	/gS0i08DcPmfuQmuBSrd666E9NoLFLHi+nrjpjFECqGXkU7T1VpHLyhg==
X-Google-Smtp-Source: AGHT+IFaaX6+2xHkLcgslU01jFDOcbqs7hltQ40RQ8wzUyG0YQTGtEbDeKrMYngslEzC06BAytv+1r5cQAbAPsNsUq4=
X-Received: by 2002:ac8:5795:0:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-47aec4d23aamr183858731cf.52.1745238791594; Mon, 21 Apr 2025
 05:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421122819.907735-1-gshahrouzi@gmail.com>
In-Reply-To: <20250421122819.907735-1-gshahrouzi@gmail.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 08:33:00 -0400
X-Gm-Features: ATxdqUEyX9qpK523GiiHqFgOS3IQGtJNf5CuM7NiXhHEXKOmyJfQdgOJZiEIlUA
Message-ID: <CAKUZ0zKgvwhzgq8+_HG845QDze2SGN2fPwdXuN=UkATea6Nuag@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adis16201: Use IIO_VAL_INT for temperature scale
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
	Greg KH <gregkh@linuxfoundation.org>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not sure this is worth mentioning but one of the emails from using
get_maintainer.pl on the patch listed a deprecated email:
gregkh@suse.de.

On Mon, Apr 21, 2025 at 8:28=E2=80=AFAM Gabriel Shahrouzi <gshahrouzi@gmail=
.com> wrote:
>
> This is a leftover from the patch: commit cf96ffd8c2ed
> ("staging:iio:accel:adis16201 move to chan_spec based setup.").
> Initially *val =3D 0 and *val2 =3D -470000.  However, they were later
> changed to -470 and 0 respectively but their return type was not
> updated.
>
> Use correct type as -470 is an integer in the base units.
>
> Fixes: cf96ffd8c2ed ("staging:iio:accel:adis16201 move to chan_spec based=
 setup.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/iio/accel/adis16201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.=
c
> index dcc8d9f2ee0f1..1f27386edcc4e 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -125,7 +125,7 @@ static int adis16201_read_raw(struct iio_dev *indio_d=
ev,
>                 case IIO_TEMP:
>                         *val =3D -470;
>                         *val2 =3D 0;
> -                       return IIO_VAL_INT_PLUS_MICRO;
> +                       return IIO_VAL_INT;
>                 case IIO_ACCEL:
>                         /*
>                          * IIO base unit for sensitivity of accelerometer
> --
> 2.43.0
>

