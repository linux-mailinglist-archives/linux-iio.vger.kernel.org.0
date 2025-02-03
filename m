Return-Path: <linux-iio+bounces-14868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96468A251F8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 06:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB31884E79
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 05:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9B3594B;
	Mon,  3 Feb 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJwCGi10"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6F8633A;
	Mon,  3 Feb 2025 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738559693; cv=none; b=AWtpmZIjJB2Me0YVx/hx0k6Zn8YBULxPtWwDSPhzug8XIplg69tTrkI9nHjXHE5HPhPWmsPZBhY+x4drKwVhoko/UTntPUVt6fiNMBG7O+FS2dxi9Ni2owhxFFgII/JL8MNaDa7BvZiOJAk+pMGiUVR8brYisb75ZpgTMjDccWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738559693; c=relaxed/simple;
	bh=7K/KZ6Mv4XicIlnn5RnFFamx7pc5D5iDvAQua02o/7w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tluLeyWGNSHxwhsxAxKHdtGlmQbjnW2NYDtxpSvQomEd7Ugvls4AHKS0U2rTY0/eLwMHlVitFcVRN0wSRhpkJ21Y6Jwplbe6uZaGrz95vryWByQ0qUMvmG43SxID1ki9bRXTUYIdDba+89dYUtC3n9ZI8VjkXFS5FjF/4NpzLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJwCGi10; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a88ba968aso3551177f8f.3;
        Sun, 02 Feb 2025 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738559690; x=1739164490; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4SdSWDVAgbLsgCBmC0L8GxMeMI8eSrHGh6gpVTV9+w=;
        b=FJwCGi10a0LraaXYYIUSrb/aEfwLCGRFpIIQUqEeV4YrhscYFoSBo5hRRnY4C8fRGS
         N2WLnRTpkOWcjDbeExF07gy7aA64UhiRyy9nmoYoufwB/cA+dM8z97hbOVuTnMQ3kHrF
         9OUb9YZOHYsfuEmaLH+Gw6tFA50FOBL1PQTY2sqfRqFdH4GZQgKS6kmpGxjMCUbLiQtx
         CUAaGQW4vdCks4wP+dFnELRbxXl8eEUwfWt6a4W0UsVzeNVJLMDfBQxr1Zpqt0t1bzGE
         s2ltbcZcVIMRBqbKw4u6+5Z3frApSbd2zav9DSTFUaeRA7F6joQQX1QDmVhW3wun7dZ1
         DMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738559690; x=1739164490;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4SdSWDVAgbLsgCBmC0L8GxMeMI8eSrHGh6gpVTV9+w=;
        b=Ug0wB4vtRhyPtZoUrnBpt6cte58KP2QAs6/bSCSgytgp6WBniE0QawSVScK1Xs1cpw
         lTzTv0Gqe9NDez4KAB39hFJCtxjWPaGrZuPTj2sAUjqLEj3yNs0m0K2wuZ76qJRG7FJ7
         ftkZS/JNakfT2HcDG0+USRgPS+5JeKVovzg5SID+3VRtNHpjRIWkgx59P/l2aN/Ou7wg
         LYTOXZ06O7OOYxeMIsMlCHjergHxoUgFvHR8eJh9BB+VUzCDX8JIB3A3FMaCQWkkhU+n
         xjm4aqpL81C6wilvd/W5Dpe0eqP2WJ8m86jlCXxBGz+4CWZk/WTNP+UgG5Vmf4RXnZR0
         SACA==
X-Forwarded-Encrypted: i=1; AJvYcCVmEZV7007FHXCMS9E5GOYl6Vf2fgAPNL8myzxrcWAEgxzmVW/sfBEBi9EcpDvadtcw5N5VRH1IJciU+okr@vger.kernel.org, AJvYcCXIpOEoZPw0hDGiXlO5xmY3a+GU5f2ISCM4AOTgsjf3j2xucxF7g+TUF1Au/yaAOIyXBAs9W3lRBr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdmC/Za/MQQ9GPOLjwYurnb+fWLslRIvIa+DgUF1Tat2j0vlb
	8MJIM4rWnGTyJrvMdtIywQaLT3ySbiZOkLXu2YbON7I7b5/Ra2db
X-Gm-Gg: ASbGncvJR10vOdBuvUEaUp/+mor+o/pWUWzClJxcC36Ii8NBixIPjKgWB2tvLG4gISP
	baMFSAToIyLfRGjA5sb83aeiVsdlgZyXhxk8+EaI78EWPo/Xb5iQaDNNaYij1WXHTrc5+X7XIsB
	dR4lwHKnXy/NJg68xWXn3DZcF/wsbyIr+ihG8Te5PNet7RJTQ8CgNR0TcvQH+ffs2+WmS/9893l
	gNQrY7VgeFD9YxFX1WYCDOm63RXMccHCPXPZHDZztH/BuvwCJSIeFSp4kBs6RQLMSK0Pukcw+BY
	XsLi8mP9n7e9gsbSRdL7RMVrog21
X-Google-Smtp-Source: AGHT+IENPXJB0G7Tte420zKL8FGXF/oXVUQkX0RxUEym7mrwO5nT7+s/Cfmi4dGro/OBIbyO6f9v8Q==
X-Received: by 2002:a05:6000:18ac:b0:38a:88f8:aadd with SMTP id ffacd0b85a97d-38c520a64b7mr20005609f8f.53.1738559690110;
        Sun, 02 Feb 2025 21:14:50 -0800 (PST)
Received: from localhost ([185.238.219.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1e8addsm11508694f8f.101.2025.02.02.21.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 21:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Feb 2025 06:14:46 +0100
Message-Id: <D7IJZ2639BOH.3KPFSYMOLZBGM@gmail.com>
Subject: Re: [PATCH] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Karan Sanghavi"
 <karansanghvi98@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250202-outofboundsread1573409-v1-1-5e3dd97a24a6@gmail.com>
 <D7I4JY638HIU.1OH0ECMRKC7K7@gmail.com>
In-Reply-To: <D7I4JY638HIU.1OH0ECMRKC7K7@gmail.com>

On Sun Feb 2, 2025 at 6:09 PM CET, Javier Carrasco wrote:
> On Sun Feb 2, 2025 at 11:49 AM CET, Karan Sanghavi wrote:
> > The array contains only 5 elements, but the index calculated by
> > veml6075_read_int_time_index can range from 0 to 7,
> > which could lead to out-of-bounds access. The check prevents this issue=
.
> >
> > Coverity Issue
> > CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> > overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> > elements at element index 7 (byte offset 31) using
> > index int_index (which evaluates to 7)
> >
> > Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor=
 driver")
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> >  drivers/iio/light/veml6075.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.=
c
> > index 05d4c0e9015d..a892330582f4 100644
> > --- a/drivers/iio/light/veml6075.c
> > +++ b/drivers/iio/light/veml6075.c
> > @@ -210,7 +210,7 @@ static int veml6075_read_int_time_ms(struct veml607=
5_data *data, int *val)
> >
> >  	guard(mutex)(&data->lock);
> >  	int_index =3D veml6075_read_int_time_index(data);
> > -	if (int_index < 0)
> > +	if (int_index < 0 || int_index >=3D ARRAY_SIZE(veml6075_it_ms))
> >  		return int_index;
> >
> >  	*val =3D veml6075_it_ms[int_index];
> >
> > ---
> > base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
> > change-id: 20250202-outofboundsread1573409-378997439be1
> >
> > Best regards,
>
>
> Hi Karan,
>
> Thanks for your patch. That could never happen because the device does
> not support those values: it only delivers values between 0 and 4 for
> that field because it does not support more integration times.
>
> Even though the check does not do anything in reality, it does not hurt
> either, and I would like to avoid future noise from coverity.
>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Second thought: you are not returning an error code, only a value
between 5 and 7. 5 and 6 are even valid return codes.

Please complete your patch to return a sensible error code.

Best regards,
Javier Carrasco

