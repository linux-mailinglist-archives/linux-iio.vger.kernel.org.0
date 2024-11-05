Return-Path: <linux-iio+bounces-11912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488049BC724
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 08:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C80828331B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803781FDF99;
	Tue,  5 Nov 2024 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1gmpNg3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A55EEBA;
	Tue,  5 Nov 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730792423; cv=none; b=b0PwFiTHRuMhpdQrTgRTdnYXZdzsZI7U2HT0NcEIMaCyFrVTV7NLWl4wbrcMzw6peOkXrHKVO+f4XOCGNazFp2GpiYZZRFISIzM3ZrJ0Zh+bih65l1EdNWGsYEWmD4YHZI49RmzBhnsF+XW+saT9vxN9TbGIfV8iQWgJyRqYVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730792423; c=relaxed/simple;
	bh=7JYi0gA+D5ifWf/FH5BVdazYgaUP3auRzKD6OC/Vt4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/DUOUvd5n/AypRDDkogdKAo1SYDo4LGm2ZUFIFNRNEWGcgE6JcBycvZmxcdvTQQFAW0AbaeTmJCXHgLo8pRkAwX2RUpl3Zqkr3o7yE/UhOqFfhiqDJmoX5ZDjXHXLbd7bIFPyuvV++IE25QBQtn4xatJjSbtE9PfzVgFTdJGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1gmpNg3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d47eff9acso3318952f8f.3;
        Mon, 04 Nov 2024 23:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730792420; x=1731397220; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ocBWIeJyQeYQc+gJdO1SeCnJ/mpbgVz8TuewMujTg4A=;
        b=B1gmpNg3nVF3sixVXJJji8qXEZhl7+biRel4O7bgeJ2MB/L8PcOdS2J2j4ohdziMpv
         b8ADB4mbdiszEJ103hzpW8eF5E7L0Tuqpeh0J6bKPSs2tUmDXfDBozkooJSV/XjakTJi
         ckKDsEj1VSusOtCeBPPCDwgEwHZnXbQDTmjZ7P5DDLL/MMc3MK+56iVloJcdt5oTRAAx
         e/JRnsJVg+MIEfFRvXZwsY2ZIfgtT/tFeJlQqRj7Lqcodn0DL6tbB00DmOQsPsiUgJn7
         Uy717WGdZDpGlB/OdEhhc3D+ph0tJMhNqvydb4p5bCI9Gnks/1BvDN4WZ3/+MuPfvpnR
         dwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730792420; x=1731397220;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocBWIeJyQeYQc+gJdO1SeCnJ/mpbgVz8TuewMujTg4A=;
        b=q0kcslHbZFRQjhgbL6oUGTxkIQe5SiSUVg6PuJQOyKcsMWMG4fabPnC/X7ApNzZQTV
         s00hg8m6VT1a4dnz5zwV6aNXwXC0VoMJWiBWN3teIgk0ijzpCMiF3zF0qybtVhmXS7k7
         n/URsccBMRKLhRJEYs8npU5q4OtwfIH0sL2EIRqD0DvILDuvr9WbKmdPOI/1LJKTW+kY
         Eiqbkg4X1RkSQZ6OPgZJ/rvHMEBLs99+75i877/a5ucuUVGGAFW9PyCiVOWXnRRDGuWD
         bE0SjS4TM2OVcb5n23BmCd5e68Ca6rJ3qLZTicL1pu1p1k3fJc5Dx8t8OOTRGRCTS2zN
         N+mg==
X-Forwarded-Encrypted: i=1; AJvYcCV3VfqzcwOCwfj+T3QV4rALygmfTsfGrQORyWpeVctcXoIFfD7i/dOxJMuO8Acbr9acXPFBZt74J9A=@vger.kernel.org, AJvYcCXIgZp1wmkFmboyW8eROXzvWFnsRbfhBBSu+SQPjhGSGzBEm74qdrNP8Hstp3h32Dmo2Z1vuMIb5+nu1Zqv@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGqcwXYXcMwvbAYAgjibL1sYBaliqjJ3/dsxgg0BweHBFaRAe
	rqana6cJcvknPBu640F4JP3ASH1MuEG7JMFGBctK3f4AYTIBBglz
X-Google-Smtp-Source: AGHT+IGEdqChJi95E9f7lKq6z6VcnxyyANHegEKVyE8BVGIRMGCLPosT9rIRUsZjHC9h3NIiF9y3vg==
X-Received: by 2002:a05:6000:4409:b0:381:d890:b503 with SMTP id ffacd0b85a97d-381d890b575mr3486481f8f.57.1730792419597;
        Mon, 04 Nov 2024 23:40:19 -0800 (PST)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca8eesm206041765e9.43.2024.11.04.23.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 23:40:19 -0800 (PST)
Message-ID: <f1aff5adfb369c3926e43b7ecaa95d23e0126343.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7173: remove unused field
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Nov 2024 08:44:40 +0100
In-Reply-To: <20241104-iio-adc-ad7173-remove-unused-field-v1-1-da9500a48750@baylibre.com>
References: 
	<20241104-iio-adc-ad7173-remove-unused-field-v1-1-da9500a48750@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 13:42 -0600, David Lechner wrote:
> Remove the unused chan_reg field from struct ad7173_channel. This was
> set but never read.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> Noticed this while looking over the code.
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index a0fca16c3be0..29ff9c7036c0 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -193,7 +193,6 @@ struct ad7173_channel_config {
> =C2=A0};
> =C2=A0
> =C2=A0struct ad7173_channel {
> -	unsigned int chan_reg;
> =C2=A0	unsigned int ain;
> =C2=A0	struct ad7173_channel_config cfg;
> =C2=A0};
> @@ -1316,7 +1315,6 @@ static int ad7173_fw_parse_channel_config(struct ii=
o_dev
> *indio_dev)
> =C2=A0		chan->address =3D chan_index;
> =C2=A0		chan->scan_index =3D chan_index;
> =C2=A0		chan->channel =3D ain[0];
> -		chan_st_priv->chan_reg =3D chan_index;
> =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> =C2=A0		chan_st_priv->cfg.odr =3D 0;
> =C2=A0
>=20
> ---
> base-commit: 56686ac80b859c2049cc372f7837470aa71c98cf
> change-id: 20241104-iio-adc-ad7173-remove-unused-field-e3d2ca362501
>=20
> Best regards,


