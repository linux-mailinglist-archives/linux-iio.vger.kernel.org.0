Return-Path: <linux-iio+bounces-12465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F39D4D22
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 13:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D9EB243A8
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17441D79B7;
	Thu, 21 Nov 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVXs3XSI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0C1C6F76;
	Thu, 21 Nov 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193429; cv=none; b=CfqQgNkUiHqTW7JEYDIXPswAv7DlDo2E7ER2dZnxcd0GpLawQamCNkiFIabKAQNh/UdkJrJ+gc5Fi+CuvKZeMT5ysOOQJ9pis00jY6ZdM2qQyYGulYFt/+VzGJo5sLZFqYs6S782Eb+P/SmZfwnLRXYTYRotXnXY31J0Jr/mOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193429; c=relaxed/simple;
	bh=UJTs6Iby7Teh82NJKNMq0ibvSRqmMP0ACIc+OWmnvyI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XOOYbwmA4j/QeVtDeiZP9+sqXRHlvWK8rMf36tsaIH9p5R/t/ByCdYrTl3p+oX2V5rQJXxLZUkffKnCdTnds9XLMfWoKyrhjjuFg3y3gn9M1ZFfbgCtfjOh9SqZ7V1NAHu9j95/zyu+ruJkB49BEooVC+fn6OICQdpEr0eCpGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVXs3XSI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa2099efdc3so387587466b.1;
        Thu, 21 Nov 2024 04:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732193426; x=1732798226; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00ZzQwUg353qBQWZiP9XVCQ68X3EQHzTK8nL5Lxuaus=;
        b=KVXs3XSIfpkF3d+BmCMbL4lhJ2pnrfrJgdKCiHim4JlB5GVYPQz8fHbRurfSbwa1B6
         7YsA+i7pyEGUXsXAxGHjyw0omlrQEcbmVDNi0wotVdNjcdQr1aU/SlWEfkfblc8HXZv1
         7wQfuHTplFotjGIV9PhYISWOSHMqOuCWOZBc42GT2XwnKRfs9hEgzkFKBO4T0D2C4oGb
         Er8KxqEVwURlq2ztq0cLvW4o2P1XR1/tYpHd1m39McTyvtv+qw6Tvu6qrlTMzgBB9HeZ
         u21jI9OwQCZPeb+8N3BhcxbDquzhGMjQ7o0fnNkPJtX95ItuKzS4lupy1v8zAwPF+t63
         kX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193426; x=1732798226;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00ZzQwUg353qBQWZiP9XVCQ68X3EQHzTK8nL5Lxuaus=;
        b=guzWQaTPSt1Hed6hwGoqrteDK5AUZikVc93WlYRHbuZK/RfLEcrBip6Ccb/JO7a/Md
         soWCVhiu3kL8sNco4rDPreniVVMWkiwmuSJYdxcH/+NcvwuvkLnds/kJyimiu3cf2vVz
         bz0OkZV5CoXLPW/jBvpbybDHTBXPwgzKXVJKSMi+jQZc1vG2Ecpie7hHcAsXxUn6ViX0
         KecBlFBS7/+qz4Fsw++rF+jXDUYosKgQ4TRGQkLURoy6v9QAz86vSVAt1zPgdPvxLa3O
         okLbTEtefuEHZz4spRJxODnXgxOCxMi8h0e/bpVc47viH4GYBuABNqn6cwn44CixtceS
         SrqA==
X-Forwarded-Encrypted: i=1; AJvYcCUXvM72qQFdsygXn98mgrM6s3/zREwEq4uCMZcyFwJpl29n2KaNFapyQIgAcbSvPtsgsk2u7LAaNv3Z@vger.kernel.org, AJvYcCX6wEBu9O2pYa7fcbBkYfkezQ+DWRDu58dMSQUxpmJZz76d/SK1lXmtPu/zYiviGFbO0zKvuj5tKcb+Syxz@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFcXoqS3zafBZrAjkaM9CKqG920wLwe7ZT1kFP22RiPYy5H+j
	XFSzPVkluAj1CigIGwaQqHR5Ox3PzPbdfSfv5d0mTUdogDjoT9F/KA2U+g==
X-Gm-Gg: ASbGncvQRnuzVx+wTr7hX4QgGphswiYDWjZEAbagyAdAAC6TDd/q8Uxe0nlFWwBOsPq
	BJ3ZMJJLoP6VLAkj0OUWmrdGm+dzHsqYr86ZJDy4/YsOZLLuYSmlTShNM9WO4CRon/Xi88/nanH
	dPmFu2QiSBVB0Rze5fRZF5eTphYMYGstLEmmUMbpRniBX0jeprXmK2ib0CR/R0NjNcp0rn7LdZv
	02YkFDeZ/eyq0FujrDzgXRi3z4JWaCvkc1buj1jAOPKQQA706EB1/lf4Oyct3VOetOadSlEP1xk
	Phm5UfWW+cCDsiT0DEoxDok=
X-Google-Smtp-Source: AGHT+IEWvULmFIT7y7HWMI09rdcpTv1xH1WdU4aympyXmiuuJQne2tXNNQOFkxohTZiBL9Z+PAaLjg==
X-Received: by 2002:a17:907:703:b0:a9e:85f8:2a49 with SMTP id a640c23a62f3a-aa4ef969d21mr331333466b.8.1732193425934;
        Thu, 21 Nov 2024 04:50:25 -0800 (PST)
Received: from localhost (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f431b36dsm77509366b.172.2024.11.21.04.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Nov 2024 13:50:24 +0100
Message-Id: <D5RVBLKL19B7.3JUQKEVC5T0HF@gmail.com>
To: "Per-Daniel Olsson" <perdaniel.olsson@axis.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
 <kernel@axis.com>
Subject: Re: [PATCH v6 2/2] iio: light: Add support for TI OPT4060 color
 sensor
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
 <20241120163247.2791600-3-perdaniel.olsson@axis.com>
In-Reply-To: <20241120163247.2791600-3-perdaniel.olsson@axis.com>

Hello Per-Daniel,

A few minor comments inline, LGTM in general.

On Wed Nov 20, 2024 at 5:32 PM CET, Per-Daniel Olsson wrote:
> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

...

> + * Function for calculating color components independent of light intens=
ity. The
> + * raw values are multiplied by individual factors that correspond to th=
e
> + * sensitivity of the different color filters. The returned value is nor=
malized.
> + */
> +static int opt4060_read_chan_scale(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2)
> +{
> +	struct opt4060_chip *chip =3D iio_priv(indio_dev);
> +	static const u32 color_factors[] =3D { 24, 10, 13 };
> +	u32 adc_raw[3], sum =3D 0, rem;
> +	int ret;
> +
> +	ret =3D opt4060_trigger_new_samples(indio_dev);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to trigger new samples.\n");
> +		return ret;
> +	}
> +
> +	for (int color =3D OPT4060_RED; color <=3D OPT4060_BLUE; color++) {

Nit: no need for parenthesis around adc_raw[color].

> +		ret =3D opt4060_read_raw_value(chip, indio_dev->channels[color].addres=
s,
> +					     &(adc_raw[color]));
> +		if (ret) {
> +			dev_err(chip->dev, "Reading raw channel data failed\n");
> +			return ret;
> +		}
> +		adc_raw[color] *=3D color_factors[color];
> +		sum +=3D adc_raw[color];
> +	}
> +	*val =3D div_u64_rem((u64)adc_raw[chan->scan_index], sum, &rem);
> +	*val2 =3D DIV_U64_ROUND_CLOSEST((u64)(rem * MICRO), sum);
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +

Nit: wrong alignment in the second line of the arguments.

> +static ssize_t opt4060_read_ev_period(struct opt4060_chip *chip, int *va=
l,
> +				     int *val2)
> +{
> +	int ret, pers, fault_count, int_time;
> +	u64 uval;
> +
> +	int_time =3D opt4060_int_time_reg[chip->int_time][0];
> +
> +	ret =3D regmap_read(chip->regmap, OPT4060_CTRL, &fault_count);
> +	if (ret < 0)
> +		return ret;
> +
> +	fault_count =3D fault_count & OPT4060_CTRL_FAULT_COUNT_MASK;
> +	switch (fault_count) {
> +	case OPT4060_CTRL_FAULT_COUNT_2:
> +		pers =3D 2;
> +		break;
> +	case OPT4060_CTRL_FAULT_COUNT_4:
> +		pers =3D 4;
> +		break;
> +	case OPT4060_CTRL_FAULT_COUNT_8:
> +		pers =3D 8;
> +		break;
> +
> +	default:
> +		pers =3D 1;
> +		break;
> +	}
> +
> +	uval =3D mul_u32_u32(int_time, pers);
> +	*val =3D div_u64_rem(uval, MICRO, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +

Same here.

> +static ssize_t opt4060_write_ev_period(struct opt4060_chip *chip, int va=
l,
> +				      int val2)
> +{

Note that state has become a bool, so if a new version of this driver is
required, please use a newer base (e.g. linux-next, iio/testing) to
avoid future issues.

> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	int ch_sel, ch_idx =3D chan->scan_index;
> +	struct opt4060_chip *chip =3D iio_priv(indio_dev);
> +	int ret;

Best regards,
Javier Carrasco

