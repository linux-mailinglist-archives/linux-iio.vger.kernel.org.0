Return-Path: <linux-iio+bounces-15766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60BA3BC3C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097793B7C14
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573B1DE89A;
	Wed, 19 Feb 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE0pYk9q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB21DE4FA
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962645; cv=none; b=d4ezV7j36VBOLF0hf+mujavAVwIgCHsXpu19wqsTpMIMG090HhroNExsvN97gE6At+/uA1cTio1prMVQN1oUSxh3PbX1FgGgw/oHSvDM3isJLVBNZuq6YPk2tH6RQqXg278eRAUHOFwwvTNuCQRZEwfZWG7Etj0KRPhxd5hU7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962645; c=relaxed/simple;
	bh=12K7haMRfPoAvQ7NI7TpFAZvGqEGsfnOHgHH+VEcNTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1/eFxZ4Zgn6F9vsPw4VeTiwIbAB0H5YcyDFax49q5bieNvgeLIwmKr0ZGZU/1EED3de8/XhXBIpep5AY8ZRXY5p+myRiji7F++xGm62tKgnEkrk1NGi7RV1h8mkoWLeVq5RUfc5grFo2dz2QHCfw6J4qcUmHP8ubEyHn5JLHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE0pYk9q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so4128958f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962642; x=1740567442; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tW/eGXXROpRhrnB2JkOl00r853w66TAAQ+KRm8Bq7I=;
        b=BE0pYk9qMm3AVMYvW2/NQnpoOkkVG9EKenyjQvu2fPCM9bxrtBHEZVntPFMSGNeS5N
         11NZy07RBnNeQ1YWUaM8RoaTW//cOF2w14LcaOm/WsrNh3bpRDvGMev3HQIN4bQM/1E2
         u2mARbygg/6iHi5xJRw1ozkuGcBWBggdTpUZhgt5qxqdSD1u6mX2CjCEBjHVsJH4aUQ4
         Iz5u3VkZ0ShzjaRelcnvoyFvjA164Py0o9cdFF3syWrXoCm3HVH1DgDglbN7WspJS0E7
         YT6e6mXWc83gc9IZLxRg81+Fz4W9f6Olp1I6bHsOAL6+G/ME0DAGvXdRv8MevAV5aUgq
         Pf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962642; x=1740567442;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tW/eGXXROpRhrnB2JkOl00r853w66TAAQ+KRm8Bq7I=;
        b=M7GdsepPSm9BNmAE/C8NXjTerfTkoGAwoAt7aJ1J5L3b6TVKw41MWexdRSYfzrVIj7
         /6fc+SdjwBayrfY7VYazSKVPTohn1AMKMycEYFKZ59O33nexDquNUEcJMu9vtbvBGlhr
         CEiRfmgKRudldBcnDn+afDHDUucHng9a67T+jAeiD2o9KrTrj9QTYOwHW2LxcHMQXGYI
         IbfgB/yBXd8ITIT8NKsJtIF9rDy13iDRi14r4/CuH0RFwydH4unEmqmQpCesxNMV7rmh
         1OTTdNWUKJeskUOOv67JdUMk3R/d9skZUvlkdOq0WZD6iaU4ul0+oI9XSh+mwZxBEonf
         Y+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp7EgHUY8DC4SOgCLHTUccTqQvSfYBz4ZU2ZtDRu2YQ7YOPYUw1CURZSGbp0ABVgONdW0FiXirC3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34JiFU3ghGw2yVSjt7RtEI5/CdkcL0EvFmgXlGSc5jtQFQ7Yw
	PXZjik9Qg+hT5HSfWdiife0dWqlMVz1ZStRbg8z3t01XkLkXZuoz
X-Gm-Gg: ASbGnctMB5VjGh4RlPlXNYtx2aVwbz14t688YZ76MwhVqO2eYlOKYz9Nmkapi4qy5WK
	EbkgCSRu6yH6WZoSPvFx024jX5CsNVN8DpvznYeeRYhgnoPH7EAK5/mr7x/9vQfcB8y9S9NZEY8
	TfNfS1g5JEgVd+/lsDBndluMjtXahYG970rJPnFKUHIXjHCmrR6M4jeW4BPwFRld5IZ47K/N+Ez
	Q7ANPpXVslccbApxSZ9wa/pqQ3oYTr0mfsNN/xfVPqyEZALvT4+jxAv0PqXUKRuoUSDG0pvQFtr
	QiAXiZvE6L6KusJzd7r8D0q4sHZiQdKmfyJAaJiIAyccODXvAwSnrkCqI8sFWDg=
X-Google-Smtp-Source: AGHT+IHTqFom/RdSVHNrZyclPVP+LH45TzfSUucVzJ/aWArj023jA0VEbg+dsvbJ5/nqtKWi7KNKPw==
X-Received: by 2002:a05:6000:b46:b0:38f:2556:905 with SMTP id ffacd0b85a97d-38f58796072mr1997138f8f.30.1739962642347;
        Wed, 19 Feb 2025 02:57:22 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm17516583f8f.26.2025.02.19.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:57:21 -0800 (PST)
Message-ID: <10729fd8de67e7d0e6ef25e3bfcb7fe5cc9bffd5.camel@gmail.com>
Subject: Re: [PATCH 14/29] iio: adc: ad7606: Switch to sparse friendly
 iio_device_claim/release_direct()
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
Date: Wed, 19 Feb 2025 10:57:25 +0000
In-Reply-To: <20250217141630.897334-15-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-15-jic23@kernel.org>
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
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> This driver got partly converted during removal of the _scoped form.
> However some more cases got added in parallel.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7606.c | 14 ++++++--------
> =C2=A01 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 87908cc51e48..f566248db70a 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -862,11 +862,10 @@ static int ad7606_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		val =3D (val * MICRO) + val2;
> =C2=A0		i =3D find_closest(val, scale_avail_uv, cs->num_scales);
> =C2=A0
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret < 0)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D st->write_scale(indio_dev, ch, i + cs->reg_offset);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0		cs->range =3D i;
> @@ -878,11 +877,10 @@ static int ad7606_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		i =3D find_closest(val, st->oversampling_avail,
> =C2=A0				 st->num_os_ratios);
> =C2=A0
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret < 0)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D st->write_os(indio_dev, i);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0		st->oversampling =3D st->oversampling_avail[i];


