Return-Path: <linux-iio+bounces-23631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12DCB3FFD5
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118094E63A7
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFAA2874E1;
	Tue,  2 Sep 2025 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmJ30fQD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD656283138;
	Tue,  2 Sep 2025 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814755; cv=none; b=aNA8m1XHFaxTVtEOPFZAr3uqGkyfLA49IdbbuSkibBCLyWnYK97bD+yvpUqyRf9iKPZr8G1bnaVOW0r7+ho5u2HSAeU00siVKOOGykNSAuIe1YMIbOpm9BGmNSgKKVzxfHxf3OYxy9Xkod8v9db+OnY7k9ngXPoW+q4okh/bKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814755; c=relaxed/simple;
	bh=i0mpvbj6Ghv80vK3sVaIT97NkLXuF0QsyYOlFBF1ZIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=sQCLC0J6RA2d6IuCfAo6G2TAJwm34klK1Xsk9aKfcpzybXb53jN15acFThrpD2+OJOBP6SOtuGhhLvn7jFjH1dY1BHTFRpyBJSqaJiWfNwArnRDBk+FQRocmPh4BltmtPaDByiujmMgqRoLbygehfjhCr50LA0ARU+jqtOGsVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmJ30fQD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4326503b3a.2;
        Tue, 02 Sep 2025 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814753; x=1757419553; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OYqOdojk/NS3R2yroT3gqNVmirRcNIleOKWvh3ebD4=;
        b=FmJ30fQD+6Th9kGVqHkYZgN9+BHcHUeIG9paCLypiMJvr7dx1FqnkB/D6h7jLrIJDj
         2Ds5pqUiIAJ8Jj9OOaPgk4tdeEIi+qTPeIcfV/9XnKd+dx6XoKWIXkUSRpz64Gz7vov1
         gClpcxTibHMy/lIW3qq1kSaLTf+SSKVP17LjutUVpKvpNjz/FCB6bGP+kmy6EAspRgMi
         fS7S3Ob6aBvvTrL0gjFV4FsxvVkbkd/v/C8CxJ2DKcH81ezXjO0UiK/+owesCXqqU5nU
         0fHXX7+ay/3Vkm6AvZdPmvno+mdoJSZcpehKBZSOdRn6dyM59jQcBgU22oY9Lsyao1Pp
         1LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814753; x=1757419553;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OYqOdojk/NS3R2yroT3gqNVmirRcNIleOKWvh3ebD4=;
        b=ATDWZvSEjVrxfoKh6QlWW/9PR4U8eCDYylFiJ1pZjKdXPDhccvrlRiuKTFWJcfIX8R
         iv/HHtLCnNlRshAWGAiTfVL82/azN1/VOOWb7mjt7/jDKVUmalQ3zDqo7OIbGgUIASkJ
         JHWuDb21dteJVi8VCozKWCkhRbY3vforrdJaJ325ZkToDGrqSWaJdYn7xVL9lDQct1y3
         gcrILE35nOvMOlrIuwFREEG20pyLObfOSCXlRDoDIy60rlL02WWqJVmzs6VRqTJ+TEBb
         FM1PNozepLHtNpr4w9Tjf6TpsVYmfUH8p+7M/pQtMeYawEueDecN9y+CgoN+lrvfy4JR
         q10w==
X-Forwarded-Encrypted: i=1; AJvYcCWOL95CSPrdanil32DSg5RNxJ8gd6F3NEdawvv7ugANyEkjC+lhBqgakkV9kUDswyVJMVU2EbPYr2E=@vger.kernel.org, AJvYcCX/KoFUsIuERr6E46DNa9XJnQTFbvkKkNWbzT57/5OwKyYvmvQW102RMu74UJ5boNLz8MncZktaHOlrvSuj@vger.kernel.org
X-Gm-Message-State: AOJu0YxWt5I9J3yWI3Sx1P8BIr5kI0pg1xplSY6FkReEyRZmHynC/l/w
	XNKA0mCrRNHFg2udByVVbpMx2tMCfs0QPhMQfiTG8upUh2+BT3JWcrhv
X-Gm-Gg: ASbGncsisBr50JMP1SWSgmb5FbTdun5jOuRVwSgE4dG4Bbzb1rSjquEpPrLh0wixO6p
	FvbgD4SC9FDP7gP0tZmOyznyfx9KuwtoAlb4IXgS60AjJ3rhMZ759rbRIOKOiYRW++UkMIrhttT
	kFpC4UQXjZC3DxR8qCXTOvKiYsOk/bxp2Euyk8nvD4JdBF7/6p8DP6aOARESuBv18Ntji26sp6E
	UriPZNvr7MKu3lMNQsYs/C+v1wTuIJRhSjGuqVGSd7WpW2AO82bzlRE8AWsuPnm0e9wmB0LC5QR
	KNBbx5wTdWYcYdesDDvIIKetObK1OFIssoT2os2FqUhzW/g4r+min7qjrt3aaU3qfmiIsDOPB7p
	vRdFrTcASbTt4WVsgHxtT6rX0xv3WNA3domgu7++nZ4I=
X-Google-Smtp-Source: AGHT+IGAn+8tlmojPpU0u+pGAz8nrnQUJRaRFHChDwY00L2BAfCWpM/u1lUYvDR+BzxYX4MgkGFcFQ==
X-Received: by 2002:a05:6a21:3396:b0:243:c3c9:e1f with SMTP id adf61e73a8af0-243d6f41865mr14314758637.44.1756814752949;
        Tue, 02 Sep 2025 05:05:52 -0700 (PDT)
Received: from localhost ([123.119.72.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772447058dbsm9375374b3a.38.2025.09.02.05.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 20:05:47 +0800
Message-Id: <DCIAUP552XK1.10SMMK7H3VAVH@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: humditiy: hdc3020: fix units for
 temperature and humidity measurement
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Chris Lesiak"
 <chris.lesiak@licorbio.com>
To: <dimitri.fedrau@liebherr.com>, "Li peiyu" <579lpy@gmail.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Dimitri Fedrau" <dima.fedrau@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
 <20250901-hdc3020-units-fix-v2-1-082038a15917@liebherr.com>
In-Reply-To: <20250901-hdc3020-units-fix-v2-1-082038a15917@liebherr.com>

On Tue Sep 2, 2025 at 1:51 AM CST, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>
> According to the ABI the units after application of scale and offset are
> milli degrees for temperature measurements and milli percent for relative
> humidity measurements. Currently the resulting units are degree celsius f=
or
> temperature measurements and percent for relative humidity measurements.
> Change scale factor to fix this issue.
>
> Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity s=
ensors")
> Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
> Suggested-by: Chris Lesiak <chris.lesiak@licorbio.com>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/iio/humidity/hdc3020.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc302=
0.c
> index ffb25596d3a8bad01d1f84a9a972561266f65d76..8aa567d9aded9cab461f1f905=
b6b5ada721ba2f0 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -301,9 +301,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev=
,
>  	case IIO_CHAN_INFO_SCALE:
>  		*val2 =3D 65536;
>  		if (chan->type =3D=3D IIO_TEMP)
> -			*val =3D 175;
> +			*val =3D 175 * MILLI;
>  		else
> -			*val =3D 100;
> +			*val =3D 100 * MILLI;
>  		return IIO_VAL_FRACTIONAL;
> =20
>  	case IIO_CHAN_INFO_OFFSET:

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

