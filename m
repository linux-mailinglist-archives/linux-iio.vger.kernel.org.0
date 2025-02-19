Return-Path: <linux-iio+bounces-15764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC3A3BC2B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6700B1782A6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307B1DE899;
	Wed, 19 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkhnxaKj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F541CD210
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962601; cv=none; b=RRMRQ3lQdeLbvl/yZzsD7i4wO42Pk73nfEWqruZoCwwIXizqwhiOvImhEpwITJn6/IgOod7ZKqSwlkJAExbq/1KNXW1pbbuARIxRV+/jNiY1ATyb8gCnLTmKFowxZD2f6IvrkDU1dWullBPJwreQI7WICHLGlCyVwl85e3H/Ru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962601; c=relaxed/simple;
	bh=lq0fvMqIkRhEdCz5q8QE+nm48iV/Nc1f0r0vH8oMBk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XkQ/dIbVTY2R0+ky7J0a8yoUKlgHxSsKles2DuVjHw9YImn12XD+1inDg5aRLl48ZKilC9mCzVETOWqvlhk7NrNj9lNoefzdabvpzxs2cU+rzDe5IH2ugFKrJm8es7d1KZ7ph0kMPrrUo5cOempt5ALdGIScq+DwQgF6vAQIEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkhnxaKj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so2968000f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962597; x=1740567397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vMqU5ZYDPchHMQm41bgBKwrBrcba4EwCabN8ei3Dv8I=;
        b=GkhnxaKjvZ0QzplSP0s/cbmKrDfA8fBXVO5aKWNeghUmDbk8e4niEY2vLhuvtYz1Fc
         EEhBJxL0rmEfR3Ucl7MePAX3+Be3YXIJbKAwxXdvgcCpqz6pFYlpn08SX3opUEi3dQlx
         xdBBIOIiuLUeUVp+y9dEzNfqjmov5d/Ark/sc20Cj9kZMBTRVXBuPQMLjOQQlLrXno1d
         swlQ47d7r2NEEnRmMMSQYEckWgJ7rBUgyybjK994PYFtg2zpmd78sccueY9h0fXImxQ2
         dYx7BfYQbp1ZLmTZcd6L8P2b+TCNWTIVmUH0LmtnoS5KVTtPF91UeqazptwhKFJE88JR
         SfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962597; x=1740567397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMqU5ZYDPchHMQm41bgBKwrBrcba4EwCabN8ei3Dv8I=;
        b=La797lpBo8uC0hrQavVnnVOW3ZSyCLasMyfge7LPJHtixoQKJ2ndeTVgEroPmUVCyF
         8oyhTM9lpP1lK0ny0bKTMA5yt6/FMLpoj0Hyhn/M0zNsgfJgl8kRXfPfC/ZGNnglmvsm
         LP0h8FELTTUE9RKGTrR8d0xJ+2x+XRX58R0xeB4j1uzHhhf8ILkNBqcN3wsL1e8gYkrB
         mDaHOVpr5hsPror+9j3ql/q0XWmF9ejLYbKh0KQW1Mp6e2B1HRQ1A71PltgWhbp1tJ+r
         ZKAJMfqWenNKcgEUpXb97NFkaMC+28FcRO+n932CZDBOZWZaScXcqGvcsKOS47YJIPt3
         RdWw==
X-Forwarded-Encrypted: i=1; AJvYcCVhlqVZ1J66GvkjBu532nD7n6lqtJqN/x7XypzHIk8rokjvN1QFc8L9b5Q6APu5BK3am68HxQdbEyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmNAtLFIAaIdG9TRW4iW0uM1rN5gG0u5WuR1V+inwy+dWPNSz
	qS3zrowkY2nONpB3//+4UyZERbGB7KjlGn0DX/I4Ej35IHxM0Na3
X-Gm-Gg: ASbGnctw6CLiVrBGfjWVvSmDn0GUlHFON7XlxiNzMhF3kqbjz1R03CmHgrgGmKN01RZ
	uICGjFG34vq6CJIMNgsScvuIhTbEDTBJNv6421zfPajPfoRaGnFkmlczR1F3qrObj67MlzEi9Rv
	9KBP0/Z49EyEn+OcdQYFulxJCt2CC8IkuBPsWBCeAfZER1cMn9INea1dFMNCc4nQ7+Uf+M8GhPq
	MVM2KxTJztc6OJ0eCEAsT/+72nnYotFoCyMQqHd79xQEyQdmnbVBDb+opSNWd3y8jIFbi5Dt8Fm
	jiTqDYY23FYbBxF1EHnt6H3Yl4fLGdQJLWVSen4uUdezXWUEiALbORwBv+HQmxg=
X-Google-Smtp-Source: AGHT+IHb3mFXAU4r2Zmhy6zhNa22k2Jg9GyOwP78Mopj8NEo0r9SCfF2oP2p6qpW/6kPfu8JXvghyg==
X-Received: by 2002:a05:6000:1568:b0:38f:3de0:d16 with SMTP id ffacd0b85a97d-38f3de00e0amr13821734f8f.52.1739962597460;
        Wed, 19 Feb 2025 02:56:37 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984924201sm86801635e9.6.2025.02.19.02.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:56:37 -0800 (PST)
Message-ID: <899e1f46af5972ff87c25d5f38f5283c1960b41f.camel@gmail.com>
Subject: Re: [PATCH 12/29] iio: adc: ad7768-1: Move setting of val a bit
 later to avoid unnecessary return value check
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
Date: Wed, 19 Feb 2025 10:56:40 +0000
In-Reply-To: <20250217141630.897334-13-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-13-jic23@kernel.org>
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
> The data used is all in local variables so there is no advantage
> in setting *val =3D ret with the direct mode claim held.
> Move it later to after error check.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7768-1.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 113703fb7245..c2ba357b82d8 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -370,12 +370,11 @@ static int ad7768_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0			return ret;
> =C2=A0
> =C2=A0		ret =3D ad7768_scan_direct(indio_dev);
> -		if (ret >=3D 0)
> -			*val =3D ret;
> =C2=A0
> =C2=A0		iio_device_release_direct_mode(indio_dev);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> +		*val =3D ret;
> =C2=A0
> =C2=A0		return IIO_VAL_INT;
> =C2=A0


