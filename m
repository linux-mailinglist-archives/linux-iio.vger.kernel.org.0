Return-Path: <linux-iio+bounces-19027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 039ECAA858A
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 11:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83DB1895E79
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC519D892;
	Sun,  4 May 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfhAfZSW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A14B5AE;
	Sun,  4 May 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351306; cv=none; b=AMPZLBmHG5maIKD13Rl5f72J69ovWmsbXs2aSyxHTleSqXEoltIXa6aawzscc3+N9o/EF3yn4oRmLtNHR/iz1pvH9NVopldMuHAqqFMp1y8FIwaiSCxNw+xdLs22oBXM2vICezBob+Yew+Sv7pF01/MBRNRRyeas+wK2edRWYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351306; c=relaxed/simple;
	bh=XCTKtKkIKmros0a1Wk0UpmbPbWa+7CYmvSnJDrLfPLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSjCMpstDqsy6IM18/qCZenC/S3SmAHvJh9Uh0XVOvyPzTFw1SMzfJ0x6c5ChCk2Xy8gkj3mH5qQxX3yFGYNuiqR3eYg8/4+cIWnG46h0uMzVwFkUhIJQveXcG9EdaJAwvuWtOKml2BPRWvQF74tjb/Xs2N/IfYOrp9PjNAuD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfhAfZSW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso20508455e9.1;
        Sun, 04 May 2025 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746351302; x=1746956102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QqPi23+4+OnvTTGUtBrVHohYmjUjYqTZF35t15keo+E=;
        b=LfhAfZSWfmJ5d5nAPDM99UheOnDlhwdcT5CU2YJfxOjNn+KmkSWgQUm9sYEdWfru63
         9bmrzysO62Qw9NkkHkQl6ntezF0NXhHiUc+J0Z4QdSS/rHL2j/TGUVAXSLj2gyDyu/CM
         AtZa6rsO/z3MWnM31971yYrTk+zJ1q/2lsdW1VIRxQp2Ufyc7F+FhQX41ywhrYi2tSnI
         8T1rOtr1TUR7mTxr8SjyKNjcQVUHwvIW2KBdc+kU7q+puH7PxyJJT3OapQ2VFDkL0lgi
         wopc601CvJh/IdEBAPgn6dw6atmtZ11nsrGUmabfYj8oyMQOkZYV58IbV3WU5LqOv5Vt
         sY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746351302; x=1746956102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqPi23+4+OnvTTGUtBrVHohYmjUjYqTZF35t15keo+E=;
        b=NMPwxX0iwZxggLktYnLalR8M9grgNgE7i7a5fibohzco2iiPXm2sHIwg3OTJPVwRBs
         MPTheQix66e3dMBpNvHBODwWzvs+Qs1GmMs/4bQR5McqkEwImq4aqINnqB0R4k3IvcOn
         wD/R1dUtMb2J+2ezuekCI6huxwvcXQcUsC/hqRU5uRlKB7IZoIQ85kkLz1lz00lMwDjo
         7GiIt/eMzEwn//tEvwrYkDoF3JOIU0Fhcb8/LwZ/IKR/zWQDlmAVNKshwFaj47g9Zm6l
         A2dWx93RqopEQMlDelbgMinUyKrBENyZBG7m9cVZJrMhpyV7sAYggq1h4/TgffWdbc4K
         nY3A==
X-Forwarded-Encrypted: i=1; AJvYcCWio0s3cLT9+rsL8ZKZXPKUckAGrXdjeyDPWvlKd8KpEqOdXcSFSEV+4MiZaTbm3aco2vpB/gKpYuMX@vger.kernel.org, AJvYcCXzNvrcxAnDZXLXXmhc3u+2jIlLbUSk6FFiurfjm+yvMFTZuj8YMgctsd3Ai5y8PxhLEq+WjACpFH0bl73/@vger.kernel.org
X-Gm-Message-State: AOJu0YzNak0FNo8LadV62carj+hCzUZZbP0WpyoPDtT0uhb7L97p0Ndh
	JMBe7b54CXh6zergOic+dQwthZAbuAq8dkgdmcvOP3AoAdrhuww8
X-Gm-Gg: ASbGnctEewH2gQrTWDH27KHZYBq7xTRFFBux6EXl+Ss/rndkM91gUeI1ufIoBWWF+Vv
	YMz69zldIUCh5grDxez1HLXU8mKKZe3yk4lScmFva13pdxt9N5wbG0n5dbkrViDY9GEkeo3ksUi
	IDBEQqx0d0Yf+/EOZr/BPWeuC0wlMPwFdeWN4aOY5DeqQN10Y+Gqn/iCPoFGVeXmEuOaXClg3w6
	0dVmXRzEFUv/7KzI6c1aZhd+ia96DS8NYh2IjGxeYrmoyqZpUb2uHmZ74eq/s3bK1EfDhwTNsYn
	ONEb986CnYrFCKrrt6Eua1sw182Fi7kXIIWpfm4H40NYCbk0csiS8VxpMqQOdqadoEs9DMUrxke
	f0voq2xbxIlzWTDA=
X-Google-Smtp-Source: AGHT+IExmZD4jJZkcJD6n7NUstcJ4oeBGB7xpXdxOpZ0tGNn+3qhO3e++3reKLmjA70gPLDg5yYQ0A==
X-Received: by 2002:a05:600c:a401:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-441c525facbmr20551465e9.21.1746351302115;
        Sun, 04 May 2025 02:35:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441bc23bc06sm76185455e9.24.2025.05.04.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 02:35:01 -0700 (PDT)
Message-ID: <dd70cba1817c421ae05b4d7dfb00bc39895b9978.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7606: add gain calibration support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Sun, 04 May 2025 09:35:25 +0100
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
References: 
	<20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
	 <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 15:27 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
>=20
> Usage example in the fdt yaml documentation.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Here!

With the the proper type for the DT properties:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7606.c | 57 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A0drivers/iio/adc/ad7606.h |=C2=A0 4 ++++
> =C2=A02 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index
> 139d8b3f9bb39dd631a71c70539005d719fb5b7b..a167f080e89c8a8d8accaff5904cce3=
1d860edf9
> 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -33,6 +33,10 @@
> =C2=A0
> =C2=A0#include "ad7606.h"
> =C2=A0
> +#define AD7606_CALIB_GAIN_MIN	0
> +#define AD7606_CALIB_GAIN_STEP	1024
> +#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
> +
> =C2=A0/*
> =C2=A0 * Scales are computed as 5000/32768 and 10000/32768 respectively,
> =C2=A0 * so that when applied to the raw values they provide mV values.
> @@ -125,6 +129,8 @@ static int ad7609_chan_scale_setup(struct iio_dev *in=
dio_dev,
> =C2=A0				=C2=A0=C2=A0 struct iio_chan_spec *chan);
> =C2=A0static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
> =C2=A0static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> +					struct iio_chan_spec *chan);
> =C2=A0
> =C2=A0const struct ad7606_chip_info ad7605_4_info =3D {
> =C2=A0	.max_samplerate =3D 300 * KILO,
> @@ -180,6 +186,7 @@ const struct ad7606_chip_info ad7606b_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_gain_setup_cb =3D ad7606_chan_calib_gain_setup,
> =C2=A0	.calib_offset_avail =3D ad7606_calib_offset_avail,
> =C2=A0	.calib_phase_avail =3D ad7606b_calib_phase_avail,
> =C2=A0};
> @@ -195,6 +202,7 @@ const struct ad7606_chip_info ad7606c_16_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606c_16bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_gain_setup_cb =3D ad7606_chan_calib_gain_setup,
> =C2=A0	.calib_offset_avail =3D ad7606_calib_offset_avail,
> =C2=A0	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> =C2=A0};
> @@ -246,6 +254,7 @@ const struct ad7606_chip_info ad7606c_18_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606c_18bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_gain_setup_cb =3D ad7606_chan_calib_gain_setup,
> =C2=A0	.calib_offset_avail =3D ad7606c_18bit_calib_offset_avail,
> =C2=A0	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> =C2=A0};
> @@ -357,6 +366,50 @@ static int ad7606_get_chan_config(struct iio_dev *in=
dio_dev,
> int ch,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
> +					struct iio_chan_spec *chan)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned int num_channels =3D st->chip_info->num_adc_channels;
> +	struct device *dev =3D st->dev;
> +	int ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		int reg, r_gain;
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return ret;
> +
> +		/* channel number (here) is from 1 to num_channels */
> +		if (reg < 1 || reg > num_channels) {
> +			dev_warn(dev, "invalid ch number (ignoring): %d\n", reg);
> +			continue;
> +		}
> +
> +		ret =3D fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &r_gain);
> +		if (ret =3D=3D -EINVAL)
> +			/* Keep the default register value. */
> +			continue;
> +		if (ret)
> +			return ret;
> +
> +		if (r_gain < AD7606_CALIB_GAIN_MIN ||
> +		=C2=A0=C2=A0=C2=A0 r_gain > AD7606_CALIB_GAIN_MAX)
> +			return dev_err_probe(st->dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "wrong gain calibration value.");
> +
> +		/* Chan reg is 1-based index. */
> +		ret =3D st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +					=C2=A0 r_gain / AD7606_CALIB_GAIN_STEP);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev=
,
> =C2=A0					=C2=A0 struct iio_chan_spec *chan)
> =C2=A0{
> @@ -1410,6 +1463,10 @@ static int ad7606_probe_channels(struct iio_dev *i=
ndio_dev)
> =C2=A0				chan->info_mask_separate_available |=3D
> =C2=A0					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> =C2=A0					BIT(IIO_CHAN_INFO_CALIBCONV_DELAY);
> +				ret =3D st->chip_info->calib_gain_setup_cb(
> +					indio_dev, chan);
> +				if (ret)
> +					return ret;
> =C2=A0			}
> =C2=A0
> =C2=A0			/*
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index
> 4c39de36154ffb80dfbb01bb4f812826bdc55967..e9a59d2afafd43e66137599dbd8220c=
d6b641e61
> 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -50,6 +50,8 @@ struct ad7606_state;
> =C2=A0typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan=
);
> =C2=A0typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
> +typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan);
> =C2=A0
> =C2=A0/**
> =C2=A0 * struct ad7606_chip_info - chip specific information
> @@ -66,6 +68,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *ind=
io_dev);
> =C2=A0 * @init_delay_ms:	required delay in milliseconds for initializatio=
n
> =C2=A0 *			after a restart
> =C2=A0 * @offload_storagebits: storage bits used by the offload hw implem=
entation
> + * @calib_gain_setup_cb: callback to setup of gain calibration for each =
channel
> =C2=A0 * @calib_offset_avail: pointer to offset calibration range/limits =
array
> =C2=A0 * @calib_phase_avail:=C2=A0 pointer to phase calibration range/lim=
its array
> =C2=A0 */
> @@ -81,6 +84,7 @@ struct ad7606_chip_info {
> =C2=A0	bool				os_req_reset;
> =C2=A0	unsigned long			init_delay_ms;
> =C2=A0	u8				offload_storagebits;
> +	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
> =C2=A0	const int			*calib_offset_avail;
> =C2=A0	const int			(*calib_phase_avail)[2];
> =C2=A0};
>=20


