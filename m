Return-Path: <linux-iio+bounces-9163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A865196D0E3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 09:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B58B247CA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9236193435;
	Thu,  5 Sep 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpmPEto6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B36192D80;
	Thu,  5 Sep 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522859; cv=none; b=advmzjWcxL+yKgPZg+LCzmZeD9ppiLXnW/Gav8r+9CMO1cE24PB4l+/wkA8uVjWs5RdL+IbN0aAojEGwsKSa9XovQrMAG89zDh8tK/i7y+zRPc8rR4DD8xs2XumHHoMkeY0GDYrRxl4JO7VRkDVgp00PWQypZQ3CueLumi72+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522859; c=relaxed/simple;
	bh=zJKGpuYvH7Ai5Tm7IJT2Xi8kjgiRVE4+ZxBlzBpmjeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9Gm+SkPUskoz3vrLWlzusypiHq9VsTVtsLoJCE9xacWITCzsm1GRNZ0kwJUyt5CXpKJ+yD+kzu15Qdt1VAPBXNXkKb6R9uxn0A1un6HBXZHJHAdPjdRrFVg1IcOlTtooFLZT6GAD+kmbL0S+1LmCSIxYROnrbcUlNCGHm/hyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpmPEto6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso504324a12.3;
        Thu, 05 Sep 2024 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725522856; x=1726127656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LS46h2cUdd3xkkXL3rV8fC3ZmaplGqT/09pUBaEt2oY=;
        b=GpmPEto6kzzdLyzoGfydR4zuRmiQXxaLSwBgYi4tpA42y/L2MWgt7EwGhiBucRDlwE
         1o0znMbnVCF3dK0P9Em5gQ5J1akRvSlknelQWpCPtLHSkLnP2vu49ZKxM5k9jSA//keY
         X+fiPBq+vHUnS27nArePcP1ERO6X6bh9Vt2fRBZhOElFuLerpjnD3VEOmhmnMh3ZQZAW
         cPwyZerEqmO0ZhYoWdMxovY03wTWBick5Bm5VNWprozDxo914xkO0/5nDS5gu1QtoTKL
         WPGgekYXv40S/oj5VipjDmootI7uxj9flYwXVLSj6rFnZkd60quvyQKYV2qrksJXMrdA
         7z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522856; x=1726127656;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS46h2cUdd3xkkXL3rV8fC3ZmaplGqT/09pUBaEt2oY=;
        b=CoKMK5lV4WE4lwqI6dxMXors1lioQWE2qeginNe385SzyYlrrhTndTPTKahQ8E9o2e
         WP1deHGH03TCssTZ4ReQRUMB5c4RYGJ82Z2+TXekR41i7G+121Bi2qgRHapGP+QJewPo
         eu85aLfrIj+jwnwwRDEAgssYRy11HaGjRn0HazPjc6qgjIHdSKExGbrMP8eJphmO9+TA
         uonOgrhhxTuqCjfXB6UR4tpZ4EwsE6gAWXz2UhEapHjiiTKWtKZxXK/whZr1BwONPsNr
         FDlJKPdpczHWCg6UryCzHSxa9OX6LhqJl/dsTe6OtyAem8BJGYmmRM/wvMwQ/rzyu+33
         bqyg==
X-Forwarded-Encrypted: i=1; AJvYcCUkiyPShZANqDQXJxn3xZFjlafpGaoPBnS7L137BwuBJ9M7bKbO2C414SB+C0ilcXLpwyNMD2RNnGVw1BOr@vger.kernel.org, AJvYcCX5369W/apDM/nvnJqsv+B/byBzgzp8+sKsM4PHiwyztdz8GSJ3SVg8c3TiAa/zNiWsfz/pRgKKYNk3@vger.kernel.org, AJvYcCXSZRssQ/jouEwVuzmVinaGw8KQ0M4kIWh22SIuhYG1MtBpSBn6LP9qDPGXYf7oM6nBbjKKXPszJgZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2ZOpq3P+S08/BVD+mjvkS44BcnAM4PtBURWm1JdzK0vEAU8T
	ZwkwwCkcBWpsadOmzHknMCeOzz4VmOBS/EZ4XMwUtl/IliXSrvkH
X-Google-Smtp-Source: AGHT+IF/9gOWXiuu6urdZMDHPZjmg6DWo/zi9OQ4/ixCDu34obvSaix1X1JwszmCrUEjPO4pE0uKpA==
X-Received: by 2002:a05:6402:849:b0:5c2:6343:8ddf with SMTP id 4fb4d7f45d1cf-5c263438deemr7783558a12.33.1725522855510;
        Thu, 05 Sep 2024 00:54:15 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56a897sm877332a12.47.2024.09.05.00.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:54:14 -0700 (PDT)
Message-ID: <23c81d6735075c0b9d98833641606a661fab7194.camel@gmail.com>
Subject: Re: [PATCH v4 2/3] iio: adc: ad7625: add driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 05 Sep 2024 09:58:22 +0200
In-Reply-To: <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
	 <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 15:14 -0400, Trevor Gamblin wrote:
> Add a driver for the AD762x and AD796x family of ADCs. These are
> pin-compatible devices using an LVDS interface for data transfer,
> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
> reference options based on the configuration of the EN1/EN0 pins, which
> can be set in the devicetree.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Hi Trevor,

It LGTM, just some minor stuff from me...

With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 16 ++
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7625.c | 684
> +++++++++++++++++++++++++++++++++++++++++++++++
>=20

...

> +
> +static int ad7625_set_sampling_freq(struct ad7625_state *st, int freq)
> +{
> +	u64 target;
> +	struct pwm_waveform clk_gate_wf =3D { }, cnv_wf =3D { };
> +	int ret;
> +
> +	target =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);

Not seeing any reason why it can't be DIV_ROUND_UP()?

> +	cnv_wf.period_length_ns =3D clamp(target, 100, 10 * KILO);
> +
> +	/*
> +	 * Use the maximum conversion time t_CNVH from the datasheet as
> +	 * the duty_cycle for ref_clk, cnv, and clk_gate
> +	 */
> +	cnv_wf.duty_length_ns =3D st->info->timing_spec->conv_high_ns;
> +
> +	ret =3D pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Set up the burst signal for transferring data. period and
> +	 * offset should mirror the CNV signal
> +	 */
> +	clk_gate_wf.period_length_ns =3D cnv_wf.period_length_ns;
> +
> +	clk_gate_wf.duty_length_ns =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *
> +		st->info->chan_spec.scan_type.realbits,
> +		st->ref_clk_rate_hz);
> +
> +	/* max t_MSB from datasheet */
> +	clk_gate_wf.duty_offset_ns =3D st->info->timing_spec->conv_msb_ns;
> +
> +	ret =3D pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
> +	if (ret)
> +		return ret;
> +
> +	st->cnv_wf =3D cnv_wf;
> +	st->clk_gate_wf =3D clk_gate_wf;
> +
> +	/* TODO: Add a rounding API for PWMs that can simplify this */
> +	target =3D DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz, freq);

ditto...

> +	st->sampling_freq_hz =3D DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 target);
> +
> +	return 0;
> +}
> +
>=20

...

> +
> +static int ad7625_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7625_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D pwm_set_waveform_might_sleep(st->cnv_pwm, &st->cnv_wf, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pwm_set_waveform_might_sleep(st->clk_gate_pwm,
> +					=C2=A0=C2=A0 &st->clk_gate_wf, false);
> +	if (ret) {
> +		/* Disable cnv PWM if clk_gate setup failed */
> +		pwm_disable(st->cnv_pwm);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7625_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7625_state *st =3D iio_priv(indio_dev);
> +
> +	pwm_disable(st->cnv_pwm);
> +	pwm_disable(st->clk_gate_pwm);
> +
> +	return 0;
> +}
> +

Might not matter but it is a good practise to disable things in the reverse
order.

- Nuno S=C3=A1



