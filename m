Return-Path: <linux-iio+bounces-15767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56640A3BC44
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C33AF6B4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131C31DE8A0;
	Wed, 19 Feb 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJQqxJYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6C1DE891
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962776; cv=none; b=ouNHjGPUhjlPKNHx0ECkaqV/cQ8jcmWZsj4QANLaByWDWowzwQPegZJ4F/ruA2Ur7o8Iu/zBiwVDJE9aDWKriEv0bwdrpZYn7CO78ba9BXc/d325XQmP8orCJ8uBDgKgZYK2EPZ2AdbeTihdX03pDzoSQxVaZB5RBcr4I6ulhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962776; c=relaxed/simple;
	bh=0VraTRCxskt0YxKv2MLAPiH316MVx4C82ZEryw7yHvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TklgPIumpylUaxfAwpaMx+kJxTxPhnfOSlHNfi9Ltt9YXyVY81fcjgUdz3UK2Amsm8f1I5c5o0sqB0U/RfaL4D6BWIMn/qiK27UsWpFJwGuiIgwl6SxgOc0/q3H5RGDdw6MGDb8L8ue/9k8JC9FixvYgqsuFkIziFfGH7qcewEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJQqxJYV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1125451266b.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962772; x=1740567572; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vtiw/73PaH3/wIZiufkmVPzbfUPsN0w+crP5dh3jNDA=;
        b=HJQqxJYVKYhMZpLvMaIHHXEYs0btt5XqbuvGGIlfG6EvV6KNOpIgFMEA5NFPz/y3AT
         1qyJ5mKtvnxa/J2LB1IoZ3SkdJK7gcw8wHuNtEld1CKk/AjLmo/OqBdsoh3f019/Czxe
         KX2/XdDiYjn33/pxXRm/03jw1QzKGR4F9S47xLGz1G0idH5dyGVWDJCQaJm9iarP/v38
         t4qQQsIbF4SOMcypqzf8o+zO1wU0HwXtVZ9Q9azK7e8baxjtELyKoRt/TuiTTNGA6e2w
         aOFW3UWFtJOvUPeF6LxOdF5JeCt6//2WfeW4OatBFqIzNC2/s8FnO/5g0SiaDwxSNi82
         7bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962772; x=1740567572;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vtiw/73PaH3/wIZiufkmVPzbfUPsN0w+crP5dh3jNDA=;
        b=JXVPfbJEfOmi7OGOnjGaxnnWxuM2v2p5VZt5o940yBfVJad7b6qJQAqD+9A72oDaz7
         1ruaLpHJ3m5K+QfAqEY27LlF1BC7PjU3ULcYmrDoFwI22409CpOeKQedKzyZLpa7P3vE
         oMWu1W3bq9cgyhSPA0XQUpDLztkUKvIfucKsJptrfCrPPIBNYcrOUNJSD2rTc8aCuiRE
         mgrZ+zEXgwCTW7ynFboFzso/d1hZOUn5M8HlmoJCgK8YMJOhJyX8d3QefSU48eXwOgyA
         V6CVTRdPGurXJlGOuMNQPYk6dgxukZWAaU4iJsDd2wGTe8d6Dn4lS6pSWicu19Fbs13e
         Pavw==
X-Forwarded-Encrypted: i=1; AJvYcCW4p1981PwTaJnA2OvH7WPO4wYNDXMwAnX48oLFFjrhwBoojiUAy4WDcvyEvTWhyVgUBtudgc3VkB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZfTQRFnI5gsIWPiMQru+dd8XURktTsADI4W+sB/TpULYb1Xb
	xMvMPPxXW+VwsX0CQvpZqKBS8yHc7y0pGTa6/NnDz229RR8b6/U1
X-Gm-Gg: ASbGncsmOT3OZ+UEuIwGl6ZW01u9GIktwdkzbZqEPQ55nWMBtBM4F3XHfFHne6baICk
	ZbFMVu/IlEIA5/SAZ3e+LYzj9PMOryV1zdh5m1nIGFfNNsA86fKgS5c/C0NLKAPab66+qCbQUr+
	hW+JMrM3PoM9I0yMpHflFmISaoY4JfIxtDn1L6e6Qeb8HA54Gv4bSGp1p9mkYzqk3t2HIA8tAhJ
	zKw0dQJ+MrIqkkLCI1ovnlW3c5DHYZrz4fb9HLjf/Gfu7G2pNAhL9BZAow3h0Q/lf9XK95tHUn6
	a9XLP2jRwo62HXnghXUrkFheA3R+JsifN9RA2zDQ1KzE17/4NtGxVbqLjVI3rpM=
X-Google-Smtp-Source: AGHT+IGvBFRY/L+oZys0PbxKQae3A28GdiR7QqAOV6gB8VyYV4VXSg9RnDsi8bc0I6CRQmxFs6KDlg==
X-Received: by 2002:a17:906:4fd5:b0:ab7:fc9a:28e1 with SMTP id a640c23a62f3a-abb70db75f4mr1771056866b.52.1739962772205;
        Wed, 19 Feb 2025 02:59:32 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbde327701sm66777766b.164.2025.02.19.02.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:59:31 -0800 (PST)
Message-ID: <2e3746c0885a4f975c16eeb0ce54fe40342fe484.camel@gmail.com>
Subject: Re: [PATCH 15/29] iio: adc: ad7791: Factor out core of
 ad7791_write_raw() to simplify error handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 10:59:35 +0000
In-Reply-To: <20250217141630.897334-16-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-16-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Factor out everything under the direct mode claim allowing direct returns
> in error paths.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7791.c | 30 ++++++++++++++++++------------
> =C2=A01 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index 76118fe22db8..e49d4843f304 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -310,15 +310,11 @@ static int ad7791_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> -static int ad7791_write_raw(struct iio_dev *indio_dev,
> +static int __ad7791_write_raw(struct iio_dev *indio_dev,
> =C2=A0	struct iio_chan_spec const *chan, int val, int val2, long mask)
> =C2=A0{
> =C2=A0	struct ad7791_state *st =3D iio_priv(indio_dev);
> -	int ret, i;
> -
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	int i;
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -328,20 +324,30 @@ static int ad7791_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0				break;
> =C2=A0		}
> =C2=A0
> -		if (i =3D=3D ARRAY_SIZE(ad7791_sample_freq_avail)) {
> -			ret =3D -EINVAL;
> -			break;
> -		}
> +		if (i =3D=3D ARRAY_SIZE(ad7791_sample_freq_avail))
> +			return -EINVAL;
> =C2=A0
> =C2=A0		st->filter &=3D ~AD7791_FILTER_RATE_MASK;
> =C2=A0		st->filter |=3D i;
> =C2=A0		ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
> =C2=A0				sizeof(st->filter),
> =C2=A0				st->filter);
> -		break;
> +		return 0;
> =C2=A0	default:
> -		ret =3D -EINVAL;
> +		return -EINVAL;
> =C2=A0	}
> +}
> +
> +static int ad7791_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __ad7791_write_raw(indio_dev, chan, val, val2, mask);
> =C2=A0
> =C2=A0	iio_device_release_direct_mode(indio_dev);
> =C2=A0	return ret;


