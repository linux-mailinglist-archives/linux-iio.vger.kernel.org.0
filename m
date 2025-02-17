Return-Path: <linux-iio+bounces-15622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FBA38081
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B8516A42E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BE21771B;
	Mon, 17 Feb 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmWwuNl+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23A212FBA
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789110; cv=none; b=ItqygaQnHHRvVA+pPa2dTy6GdeW0mbL+goWBsUUJyfLvgafjRMx1xm8HI2PEzXG7V2ENb/KKVRWb4NMsN0q/Trlj3ih0GtD5145S9UDeMh83Tbq+hWqW8s6S8QWcSlc+DRZpw6GVbTTNuYrDaek41rX1S24gMNtHcdDJZ1A1lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789110; c=relaxed/simple;
	bh=FgiX/onHYFvn8FkqsORQCrHLg8JJz9QSYGbdJrwUznA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QrB+1W2xcHUMbDXPx+h/5Qk7hRfCBXDOBbIl3+BZJl4ZMFLyx0Dkeok/7t4fJ8SGkktaWH9Za3bG/Oo222UfxyxTHilqLfbKaLMVTCMW/cYU4FO5M4WF07ot0A2L4JDMWV/iJDnyyKy4l1PXaGuch0ukC9DusNVeOC9/pbN8/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmWwuNl+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so2459543f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789107; x=1740393907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=byjwumVHgIZtS/iLAJSkpCf/r4C7NvnUyURUHVLhKtU=;
        b=bmWwuNl+Nid2Z5oRUIWZ5Oahpmq94MAgerWoZGKCorMlwIXIICocRTqpIqHg4lmZH1
         hyVU+MMFTi7F8wfpM3fJ+k1QvgiSvjLXJMGHSgh26T1HV1GEFQ039ZFbUiQ859l2wOIG
         U6AVoJcTY1KdzKr870Y9blVF25Hs1dWTBYLKOplNfor/fInShKuRSBbH8yPxCAz0x26w
         +KgnYjtxyPQOG/hA7j0kDSQ65NfShm+t71Wnb80T1A2VPwhfIvzUiHdpLvehQmm9ik8j
         DDY72d8gUJJh92HInvv9ZEccx3z/aXxfasWmcoLPK9i6GDd03tqehaLZP0vrObA1ZGq3
         BRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789107; x=1740393907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byjwumVHgIZtS/iLAJSkpCf/r4C7NvnUyURUHVLhKtU=;
        b=vsGsOalX5NxQSDAthnOARAeFniailZiqPIBl7lpV/3lNRmRQhg1D0pZe252u31wS0x
         uljh/bS3NVtFf2YR+lWIgy4QlL2isInY8NrKTAHfHxBBWMCU8rB/YreRhgW4o7I9VMni
         kVurqlD5yOHxNE1WUxAORzyICr3H8FzBH61XRXJhzIng19stvV9dDJPS3m6esanDFLeE
         o8Xw3em35/qX2HV+p/LeNQDD0bqxU8v1QhFnJeBSHU3/sOE3snqWvbZkW8p7nruu5WYh
         2AAZT+nzg+Mh43eB05+AtlIKlEW+K/XFpRHqCrgQO+UCps8FnVyggk+wF3lfPdElCn6W
         cC8g==
X-Forwarded-Encrypted: i=1; AJvYcCUhPOHk9EeVMlM6Y9yXNj+3RV3LQB4qf6LMxG8xIqPYQMfrzohs4qo5v/a+e+dt/UM9YbdkOyH/wxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8mgH6VMoirMgVARb8ZPiZDHt6U645dfy3uqy7d3t9VU3SiB7
	v1HOGwgj4hmAFvooPIySryOg47L7MWO59j36Vtg9RAxsKE90/YJS
X-Gm-Gg: ASbGnctDjEClpYomZjzECNcc95Wvm5vpKF4p7R0Uo4WsJ+cVEVlgSP/j2qry8f3xaHJ
	vFoAmUkdMgOOjczYWadnwrU/0bpTMqJliF8XlHT3RlA53e8L04SYJE6+0F9Vq1/RqgioUB0Xcm4
	1iTJ8D/H2F4PgP6JI1jqpweoTmeqRCmbOmhV+/eHNDpcmimbXgedJnnMXahyYZr2V+tVza4XOX+
	z1+QtjS+Ds5hJKw9VUC2sOGu44pDQnGGntWNVT25GWZu8twEXXlHuuF1GZ+ColK6Mo74+H2en3t
	25WkYFjt4FA6+bp/oa3l7Bzj/kv0skN+VS/0hVTiwLqY3A7dxFPMr2jm6i8fHdg=
X-Google-Smtp-Source: AGHT+IFLpJWyqhnDHKcdnq+EFx5Z1elCSPwswJaHPk+YT34RwvA/DeISvtohl1eSbULjFJMPwN6nBQ==
X-Received: by 2002:adf:f3cb:0:b0:38f:2a7f:b6cd with SMTP id ffacd0b85a97d-38f33f3dba5mr5801864f8f.20.1739789106708;
        Mon, 17 Feb 2025 02:45:06 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5d8bsm11903180f8f.70.2025.02.17.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:45:06 -0800 (PST)
Message-ID: <213e73b197e7d5430248d3f9bdc776c7a9ae313f.camel@gmail.com>
Subject: Re: [PATCH v2 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:45:08 +0000
In-Reply-To: <20250209180624.701140-10-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-10-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
>=20
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Tested-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4000.c | 60 +++++++++++++++++++++++++------------=
---
> =C2=A01 file changed, 37 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 1d556a842a68..4fe8dee48da9 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -535,12 +535,16 @@ static int ad4000_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0			=C2=A0=C2=A0 int *val2, long info)
> =C2=A0{
> =C2=A0	struct ad4000_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -			return ad4000_single_conversion(indio_dev, chan,
> val);
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D ad4000_single_conversion(indio_dev, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		*val =3D st->scale_tbl[st->span_comp][0];
> =C2=A0		*val2 =3D st->scale_tbl[st->span_comp][1];
> @@ -585,36 +589,46 @@ static int ad4000_write_raw_get_fmt(struct iio_dev
> *indio_dev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static int ad4000_write_raw(struct iio_dev *indio_dev,
> -			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val, int
> val2,
> -			=C2=A0=C2=A0=C2=A0 long mask)
> +static int __ad4000_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val2)
> =C2=A0{
> =C2=A0	struct ad4000_state *st =3D iio_priv(indio_dev);
> =C2=A0	unsigned int reg_val;
> =C2=A0	bool span_comp_en;
> =C2=A0	int ret;
> =C2=A0
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SCALE:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			guard(mutex)(&st->lock);
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D ad4000_read_reg(st, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	span_comp_en =3D val2 =3D=3D st->scale_tbl[1][1];
> +	reg_val &=3D ~AD4000_CFG_SPAN_COMP;
> +	reg_val |=3D FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> =C2=A0
> -			ret =3D ad4000_read_reg(st, &reg_val);
> -			if (ret < 0)
> -				return ret;
> +	ret =3D ad4000_write_reg(st, reg_val);
> +	if (ret < 0)
> +		return ret;
> =C2=A0
> -			span_comp_en =3D val2 =3D=3D st->scale_tbl[1][1];
> -			reg_val &=3D ~AD4000_CFG_SPAN_COMP;
> -			reg_val |=3D FIELD_PREP(AD4000_CFG_SPAN_COMP,
> span_comp_en);
> +	st->span_comp =3D span_comp_en;
> +	return 0;
> +}
> =C2=A0
> -			ret =3D ad4000_write_reg(st, reg_val);
> -			if (ret < 0)
> -				return ret;
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	int ret;
> =C2=A0
> -			st->span_comp =3D span_comp_en;
> -			return 0;
> -		}
> -		unreachable();
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D __ad4000_write_raw(indio_dev, chan, val2);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}


