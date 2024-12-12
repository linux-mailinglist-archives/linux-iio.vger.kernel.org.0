Return-Path: <linux-iio+bounces-13406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3706F9EFB6E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 19:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B5916D353
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F61891A8;
	Thu, 12 Dec 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZL7wUKv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA517AE1C;
	Thu, 12 Dec 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029302; cv=none; b=TSqDobX9OQq5tsSeckfiIPgMgzh53uy/LzmKyGeDm6SVPRp4HUzA2tqhvEO+6hruQ08O6991ZQOME/PBJy7rB990dFH4QkJL7cthQh9FRsvtFfqqJ+rnqfS4HHOw0YcG2rMT8e4uO5V5zwHvWRT2BQaosBE6PY5PPczrLr9JIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029302; c=relaxed/simple;
	bh=y66TGhyZiI/xinMoA3+ax5j9EcsCL7iZ6TSGDRE7gfk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=VRjWu5VcUvoE5JS+Gcmn0xQBEOEq4wM5hiXL6hbjr/Rwfq3juiG7bLZ+2WT+cv0NT3X37wQAtzmxT7i9xIRvk3BxShPbQjBQgaKtjLGhZNxcHIbd5+7wiFAwEgnlR0IuWOw835xVURtJOs3FZnXCzywkDKYqcKdPs8b3WRC938I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZL7wUKv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434ab114753so6940255e9.0;
        Thu, 12 Dec 2024 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734029298; x=1734634098; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz4mZSKGSv4NGXMgMua0s9XSOiQMez0e8RgXR62d89Y=;
        b=PZL7wUKv+zzpSmAsK3E9/IKOooCTz1oxzPvdauMxSDYx2tu80Ti2HTUBReb7/6NdSB
         hCL1L9wzi870xDwok4e75aKPkpaijuHzP8DrrAEun/M8sFF5A2o2dvym0D0ylnwbD9x4
         cT+JyEBC+my2iNkQQoJNxtRePtvNplg0dC8IGgzLLSHWYQBjwruksSX8JGb58bZ9v49G
         LkG2jKzct236RxGoAa9vnAV9oVXpxyEu0SNZhGRc3KeZYjjmhtfJ6gRS/Udhqu4LwPNd
         dEZzyd1CSjw1MhHNqM2c+GECLKw20m04qEhV4THvgi4v9AG4PebM6OoYJ5vRcMIYg81S
         EoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029298; x=1734634098;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lz4mZSKGSv4NGXMgMua0s9XSOiQMez0e8RgXR62d89Y=;
        b=T4RzXaSrpxfmAvXScGtdW2iUB+4lent4uc7EhwBQufNQsGnlb6IRCeJyA5PPgGL9hV
         c2HZkqH4xhC7pe7sGOXn7yomIVPVojB7a1+pfDH14kPDD12Ig86CHwGQipVQ3+VBYxvl
         UMthpDzt+3y9uIqZdRqiVrL1EOxYOsUF/M56H6VnOZu/zc1QmCMVvbrbkVvO0wpeNg00
         3zN0SGqEx/AsX+tPCrdw+9NicQ3370psdcKlAHmh3L2Ue2FrKt/t15Yz2n9Gf9VASrKi
         KdE28FRP9Iyj89yYa6QsGEwfFIoy+BRHaQ0DqqnNPpebLYQ3iOASg9aJej+GN/Gmq+j7
         bdeA==
X-Forwarded-Encrypted: i=1; AJvYcCUiyIVypuitXvfAaKKVSUoN7JV3c60h7nHb491cAus2ctTSE6RQtSF4kfhu2yq09dvYIIAY5ZgVwqI=@vger.kernel.org, AJvYcCV904O2H1aNvQ4AUankuynA3dm+xIqSbeswKnps0s+gYpPl6ozmbSQdFpHk/QhRpa74X63ToEIc@vger.kernel.org, AJvYcCXRuihCX58rpyOnzDODFzIkSiAnXbHa0wDiAHGWZ/Lg1uTaWuy9xVXgpGrWAf+k8ANOS5/Wew47EJjoefyx@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTJogNLmSn1MBH7ixw2KUmd2RbAwihrhPFfCef+BCilPb+vi2
	k4ei6gFCDn9HjsJB8NfpiR6+Z+50vqTd3v6k797KtMPlVaIIYD9C
X-Gm-Gg: ASbGnctWIhGPgYeK2xOto7C3YaAe/5CuK5BtBFbRrt3SYeFNqNPNYjMhkREPLjs4Yl6
	ZmFSsubkefJv2TrBSPrERbFqX08zBfn7jMZ7aqTGT7DgtJYFqaXVjp4HR58c+aP7TBjf+09sfnb
	CihyEA1J+z9xUG8qSGbyHVyVjrEm560sz4FtUbhVpqKhnb8vl0/Qn4qexzChlFQYJOQgRZGwiCa
	X9v7+f9LLVkWM0vheQY+kgTOljXSH1HwAb2j8sN9VFJ8zDoXQswzl9hZPzPdJKeCcjLyZQCg4A7
	BUO4Ugl10Kvr2jZso8IxYnvUMZaA6n9bnMcXLdgpQbjWqhJeqeIf99LWF1cDgRjZLXfCuN8oi48
	=
X-Google-Smtp-Source: AGHT+IGLQfw3PglHjn4c1aX0F+hS2e5+eUY7Ebf3WsYFfXXZO6+bX5uqUhARMqBrHL+VaVAKR5++dw==
X-Received: by 2002:a05:6000:21c8:b0:386:366d:5d0b with SMTP id ffacd0b85a97d-3864cea0510mr4866505f8f.55.1734029298380;
        Thu, 12 Dec 2024 10:48:18 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-2ad7-4f83-0683-35cd.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2ad7:4f83:683:35cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dd5bsm4734433f8f.99.2024.12.12.10.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Dec 2024 19:48:16 +0100
Message-Id: <D69Y31IERSV2.1R9057MJA27NS@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Christian
 Eggers" <ceggers@arri.de>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3] iio: light: as73211: fix channel handling in
 only-color triggered buffer
X-Mailer: aerc 0.18.2
References: <20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com>
 <e8564c63-0c2b-4327-8e39-767530b29b11@wanadoo.fr>
In-Reply-To: <e8564c63-0c2b-4327-8e39-767530b29b11@wanadoo.fr>

Hi Christophe, thank you for your prompt feedback.

On Thu Dec 12, 2024 at 7:15 PM CET, Christophe JAILLET wrote:
> Le 12/12/2024 =C3=A0 18:56, Javier Carrasco a =C3=A9crit=C2=A0:
> > The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
> > set (optimized path for color channel readings), and it must be shifted
> > instead of leaving an empty channel for the temperature when it is off.
> >
> > Once the channel index is fixed, the uninitialized channel must be set
> > to zero to avoid pushing uninitialized data.
> >
> > Add available_scan_masks for all channels and only-color channels to le=
t
> > the IIO core demux and repack the enabled channels.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> > Tested-by: Christian Eggers <ceggers@arri.de>
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> ...
>
> > diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> > index be0068081ebb..4be2e349a068 100644
> > --- a/drivers/iio/light/as73211.c
> > +++ b/drivers/iio/light/as73211.c
> > @@ -177,6 +177,12 @@ struct as73211_data {
> >   	BIT(AS73211_SCAN_INDEX_TEMP) | \
> >   	AS73211_SCAN_MASK_COLOR)
> >
> > +static const unsigned long as73211_scan_masks[] =3D {
> > +	AS73211_SCAN_MASK_ALL,
> > +	AS73211_SCAN_MASK_COLOR,
> > +	0,
> > +};
> > +
> >   static const struct iio_chan_spec as73211_channels[] =3D {
> >   	{
> >   		.type =3D IIO_TEMP,
> > @@ -672,9 +678,12 @@ static irqreturn_t as73211_trigger_handler(int irq=
 __always_unused, void *p)
> >
> >   		/* AS73211 starts reading at address 2 */
>
> Should this comment be updated?
>
> Or maybe moved close to "if (*indio_dev->active_scan_mask =3D=3D
> AS73211_SCAN_MASK_ALL)" below?
>

The comment is still true, as address =3D 1 stores the temperature, and
the first color value can be found at address =3D 2. I think it used to
be more relevant (even if it was not the correct approach) when the
first received element was stored in chan[1]. Nevertheless, as it might
not be obvious without knowing the address map, it could stay where it
is.

> >   		ret =3D i2c_master_recv(data->client,
> > -				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
> > +				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
> >   		if (ret < 0)
> >   			goto done;
> > +
> > +		/* Avoid pushing uninitialized data */
> > +		scan.chan[3] =3D 0;
> >   	}
> >
> >   	if (data_result) {
> > @@ -682,9 +691,15 @@ static irqreturn_t as73211_trigger_handler(int irq=
 __always_unused, void *p)
> >   		 * Saturate all channels (in case of overflows). Temperature channe=
l
> >   		 * is not affected by overflows.
> >   		 */
> > -		scan.chan[1] =3D cpu_to_le16(U16_MAX);
> > -		scan.chan[2] =3D cpu_to_le16(U16_MAX);
> > -		scan.chan[3] =3D cpu_to_le16(U16_MAX);
> > +		if (*indio_dev->active_scan_mask =3D=3D AS73211_SCAN_MASK_ALL) {
>
> Should [0]...
>
> > +			scan.chan[1] =3D cpu_to_le16(U16_MAX);
> > +			scan.chan[2] =3D cpu_to_le16(U16_MAX);
> > +			scan.chan[3] =3D cpu_to_le16(U16_MAX);
> > +		} else {
> > +			scan.chan[0] =3D cpu_to_le16(U16_MAX);
> > +			scan.chan[1] =3D cpu_to_le16(U16_MAX);
> > +			scan.chan[2] =3D cpu_to_le16(U16_MAX);
>
> ... and [3] be forced as-well?
> (just a blind guess)
>
> CJ
>

in the first case (all channels are read), the temperature (scan[0])
only has 12 bits, and there are no overflows. In the second case,
scan.chan[3] is set to zero as it is not used, and there is no need to
force the U16_MAX value.

Best regards,
Javier Carrasco

