Return-Path: <linux-iio+bounces-18461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A508FA952A0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4DE173560
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81768187325;
	Mon, 21 Apr 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjSap1yS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78E13A418;
	Mon, 21 Apr 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245227; cv=none; b=kscNXcEvoha8VGAFaDpAeCr4ZCMA6adwqIwNrWxnxbkX/OOrhbMRXoynaI8vJmg+LB+HvAdDG3mwyR6nkv2dQoTumNBTOAU0wFR5dRtg6pHaahbxb1Tgs+OS4/oEbBEY0xFmSgoUrcboBiOIwkSbwyN3BeRWyWzse73kzoBn+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245227; c=relaxed/simple;
	bh=9BaS4/yvCP2VWZ4vW+sjMlK9au+mAQZhlwBJy+NiT+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h59/zR60gwu09RhAbkHfQewhl9lFND4+gDOMED7AZdECDCxwPQdPSAxiKXcs+aOyVOfReIzayP6h3/F+E0SRJjNzWS3WSMzUXW0EmW8tc18l9hV8H7ve8gHJvk8P2InlNMhBNU3RV+G4pSEPgF9bjCdvLBjeeubHqprC7/f1TWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjSap1yS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47ae894e9b7so65728871cf.3;
        Mon, 21 Apr 2025 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745245224; x=1745850024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI2xNSbeewY7lsc4y3gCRJvOG3cBl5hA05Vzfe6wrpg=;
        b=kjSap1ySjo4T37x47m4a2T8w6dCqzLLPXYoXXol6gGsCf5Avs4J/Tnyx1x9eISkmPU
         j77AWTcz1+Z59mzn8ZMMbUf5N02tA86F0WC7hW3v4eIrZ3zLtSJcXYWfSUdVIB2KSMjD
         ZztPYiDoNBEQPkoPoO//iL0n0mLZLX0AlQsctUsUhr2Y12MPdPGd28GL/Zzd9pITqg/N
         KLa2BnTApl2ooym4a4GpnAyF0k9zVIbu6TW+eAQKHsOWKZy1N/21NXCdiR4dPbl2R5iP
         Ojkb7QRCVndRzgnq0iYdR72xMCSf2u7tcZGZHUFsBU2T3mVyb7AuH+CYJ4I4bwvdsvgA
         e9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745245224; x=1745850024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI2xNSbeewY7lsc4y3gCRJvOG3cBl5hA05Vzfe6wrpg=;
        b=n86auOJq3vup5OuWjwT29y2QZOoGwj114WRWYE8pc29JtMopaEptvNtMeyH/Zyb8j1
         UXLP3Bv671M0pJ89g7HFr9Ve5v2Dn+tGHgQGEHyH64G38mthntvc8U8huV2eeyRlRcNv
         Iru+RYKa+DO42ZEUsjUZ0XCxZjoyW2MKtpLjQmNOnSwIekbXusSpqeVc62fkCNj8TUC5
         crYocHq80TEjapFel/RdQKS7pSMvbxA6yhxj/4cO7LUhLfANyoc18Mf8t6mRpLEmsAAa
         1ciUKvVMwKWFL+LC0hvBS7GVrSC1aBsttTZzfXbl6OpFqWlMkKeW4I22hkb3zB16YrE9
         a1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV5BmJoUvFi/IKqq6cHAplYmzGgmPu35HcjJbbW6j6kP70833CHA/VW058kwURVt9VbrOwgGCeWfU4=@vger.kernel.org, AJvYcCWXb8uxD4/5vpMkDs0G+J5Wl2tpJf1MZtWyFQS9GtMhxxxku+x8UaYrVIsxDA8NZbHy0+sUk6lPh432Ks+5@vger.kernel.org, AJvYcCX4rfMImGcqijqAgHwJX0IwxGKBegnxsLTtb5lfynu+G2Uk1XQzKynyWGN8HNIMSwKAIWxXMPxw@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrF6C9wCKarcuQBbgpJmIBuMtvCvGmzkEPXr1DSG/tb5RcleV
	NTOvFB7uO1x3aZDujM4usxsJeaTrfiVbuLEGUGNrXMlRPHF27RIQ41EzCUXKAHXaDfpXNWB79Gh
	Y5rDf9l9z7GFbd6BKMLkrKBwwI5M=
X-Gm-Gg: ASbGncuqrrSRAd7WNQZCKcxAirJKhbBv5Nth3MuBfWFY/hozAQGSmsHVk1TgDwR04Cx
	gpnXfG6vEY42G7K+UpIDDmYUrlva8mRQBXlcWHFbwz7jYGnvTPpwBC+do+PI0upAfQIJbf6n5ch
	9ZvsqDXx2bRtAy8h6iEvhoosVz9djeT2fbjocImAaSke62JW2RjA0GwQ==
X-Google-Smtp-Source: AGHT+IGiwVHdFSP3RyYjNXEtkPVmd51AlMlVK54vlvEAduXQRnI0NpLK+6bgJH5tuxlzzGRreEFkNYv6mIKVQO9CN70=
X-Received: by 2002:a05:622a:251:b0:476:ad9d:d4f0 with SMTP id
 d75a77b69052e-47aec4c56c6mr169031841cf.48.1745245223831; Mon, 21 Apr 2025
 07:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421124915.32a18d36@jic23-huawei> <20250421131539.912966-1-gshahrouzi@gmail.com>
 <20250421145931.605df588@jic23-huawei>
In-Reply-To: <20250421145931.605df588@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 10:20:13 -0400
X-Gm-Features: ATxdqUEcsfhAZuHj_DJDNyEENkD2VFIfgxR7tR6TCwWttn2zmwd8Sxn6BTIeyn0
Message-ID: <CAKUZ0z+=Vo-QUW1ph5FKej-o6Vmv_TcX=WF=3gteDs1Lg9_w3w@mail.gmail.com>
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, marcelo.schmitt1@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 9:59=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 21 Apr 2025 09:15:39 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > The inclinometer channels were previously defined with 14 realbits.
> > However, the ADIS16201 datasheet states the resolution for these output
> > channels is 12 bits (Page 14, text description; Page 15, table 7).
> >
> > Correct the realbits value to 12 to accurately reflect the hardware.
> >
> > Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> If you post a new version, always add the version number.
>
> Anyhow, I was just asking for the fixes tag, but this is fine.
Ah, that makes sense - thanks for the clarification. I was debating
whether to just send the Fixes tag or resend the full patch, and
figured the full patch might make it easier to apply.
>
> Applied to the fixes-togreg branch of iio.git
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/adis16201.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis1620=
1.c
> > index 982b33f6eccac..dcc8d9f2ee0f1 100644
> > --- a/drivers/iio/accel/adis16201.c
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_channel=
s[] =3D {
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >       ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, =
0, 12),
> >       ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
X,
> > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > +                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> >       ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
Y,
> > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > +                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> >       IIO_CHAN_SOFT_TIMESTAMP(7)
> >  };
> >
>

