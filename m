Return-Path: <linux-iio+bounces-26734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8DDCA4001
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F57330255AE
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051B24A06A;
	Thu,  4 Dec 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZdN0/6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A92226CF6
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858163; cv=none; b=o19CjTA3PbJU1vByYqpsalkGE3MVcsIRFTWvHT47tjosw9WyfY5PwvMaQSQLPVFexZlgrjWNmmOfEeFQrkZjRp5kG7PTSvAgZAHkdEQ3p4OFsuuVQJzW9vzLgF6w/cBh4EfcZL4qBEz6bdegh5aDKV1MmDySTgrR5LYCoBUC3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858163; c=relaxed/simple;
	bh=FNBg/aXlkpeZs8DBArvFxRgWWANEdgPP75jkUWYJflw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACahmS3lTc2A692n7q4Q7TtVqbiETpL6JbXKSM5dKz0uC0A0j+gXbzDVqLl14xiZZJqUWBDNaaBTNXoMYDfaLSmygtJeY6urQMfxRpPJ8e07Y5Re/atIiisfi9W1dm8ToSkIKiOeTl59/Ydc4S2171GhUY7mMNaut/oqkRsDKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZdN0/6Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so8040605e9.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764858159; x=1765462959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lNDG6GuMsZDqikeQhQzdv2px+61VwRvh7/YTpl3X4ic=;
        b=TZdN0/6Ye6mgyu0eix3uVdLr7jVom89SwClt5yS8/MoWUOSZ7Eb+yFq2P7+8KxJfyo
         MrEEsrrHTMaxppDSTow702MxCp47Gl3z4RA4L1GUyHqopkXJWTPVQupxtvcx8yPcTg3M
         OGQ5o02fU4QeRnpWcyA7DF5N6UczNcSjlc1qKqmlE/wslZ44zjpKKirWbByvZyGo1eIE
         c4YZqaZsUdN2LgQch8UW8j9AmiapfYPqjW2tbSdtfQ5QRls7FfLkj3We4NwwrhFv1UYv
         eZBxvn0blENpr13vFQk00aBlAqD1zJpegfv0atjku2RmEYUEedSG4pX04IgXoc3MF6TX
         GdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858159; x=1765462959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNDG6GuMsZDqikeQhQzdv2px+61VwRvh7/YTpl3X4ic=;
        b=XFhn/RhekU8EL9Qew9Mx9Ww/6v5zUfYlHbUFBJJ5458mh7cz8BdtNO3rDDDpRxGCV7
         5Fy9zbZg9ncVip+bKOm9+ganjDDkyfJr0rkKlutO39sXwQIYwNGIYZ4Dw6c2KvP/mL47
         e6ooEYvTypwLHQ/Tv1DzgOOfuZqAptv113XbEE2kprFq6yUZqnp6zSsiP30MykCVUz8L
         SMdorkK9jqq+nhu7tpOC6+kaNoBHGwyHNmr2Unxb5k9sjJEvi/I4nizQps8eOW4HLV1b
         LO3msn3VLyhc6IW/TfzYJ3d7Hnv7R7F847LcJ/oF7GuwtQZ4hR2kvdb647inPRu7Ne06
         +anQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlfmBK6pr3HM3E4yETh5ilZtMVIG11J7tMd6V5O4c0vKIYw4REZ3+bPHfVAMPFV4GT3clB9C7mV8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGwlEZ81vYYEabThpsUVxYNo+Kcblf33oxQtZVf5P01hLQCa1
	BDuatjpZuBqdct/k3a7UD5MWNyXjdf49AT3AUQLtKYyIXCpqlv/PJedb
X-Gm-Gg: ASbGncs2ijd+Ui5BbV5lIiwY5W7IcjC+Id80BZYlsNoDvSVeAVgx5fArrDmN/bNssSo
	dA/ev/VQeeUABmrhSmTBdVRRHVY2MD54qUWDft1vIVvk6dF5jeJzOrgKZ5+uLpd/iJBKUinSbJC
	5Umq8ouoRn+V7RLUCPyqk1lNV1/U+rB2nAKIzfHA5+y5nGpCPzSLvdCeEdi8igm0L5UtUWt/Vq3
	X2qYvmY58vSt8zBGOeHTs8ZaUYTy1MpshQO35UVnpzNntFasO0dlK8KiJhgCwtrCCyXjB1Ikqrq
	Ltk1ent9diR0NbIlWsoacFWsf15OhokWmKlVh7oYPe438sqGw95vGobq/gu6V74I1WUmkl1bI7u
	kM9IIFqr9hCSMV7DbdFBEVjQl63pous8jF9lY+r4blwej0m0k8ltAIUXUMGVGDa0krokXQ6GRob
	qY6L90UIazphIpw3yzRyo=
X-Google-Smtp-Source: AGHT+IE8ryaq+bro+W0C+oPynjAr8yRyWAwkzp4GpExnDcsobnvZZMTRh3TBX5P0XKrrpanLsjAClA==
X-Received: by 2002:a05:600c:1f90:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-4792eb12478mr38164195e9.2.1764858159131;
        Thu, 04 Dec 2025 06:22:39 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310c802bsm32350095e9.6.2025.12.04.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:22:38 -0800 (PST)
Message-ID: <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
Subject: Re: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return
 semantics
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
	 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Date: Thu, 04 Dec 2025 14:23:19 +0000
In-Reply-To: <20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	 <20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
> In order to improve API consistency with conditional locks, use
> true/false return semantics in iio_device_claim_buffer_mode().
>=20
> This also matches iio_device_claim_direct() return semantics.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---

Even if the rest gets a NACK, I think at least this patch makes sense. In f=
act I
would even extend it so that we have the same inline API with proper annota=
tions:

https://elixir.bootlin.com/linux/v6.18/source/include/linux/iio/iio.h#L679

So it really has the same semantics as iio_device_claim_direct()

- Nuno S=C3=A1

> =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 2 +-
> =C2=A0drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 +----
> =C2=A0drivers/iio/health/max30100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/health/max30102.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
> =C2=A0drivers/iio/light/opt4060.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> =C2=A07 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 2de8a718d62a..b345c4d1ef24 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -964,7 +964,7 @@ static irqreturn_t ade9000_dready_thread(int irq, voi=
d *data)
> =C2=A0	struct iio_dev *indio_dev =3D data;
> =C2=A0
> =C2=A0	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
> -	if (!iio_device_claim_buffer_mode(indio_dev)) {
> +	if (iio_device_claim_buffer_mode(indio_dev)) {
> =C2=A0		ade9000_iio_push_buffer(indio_dev);
> =C2=A0		iio_device_release_buffer_mode(indio_dev);
> =C2=A0	}
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 9ac80e4b7d75..8ed4b2e410c8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -188,11 +188,8 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_=
dev,
> =C2=A0	/*
> =C2=A0	 * Ignore samples if the buffer is not set: it is needed if the OD=
R is
> =C2=A0	 * set but the buffer is not enabled yet.
> -	 *
> -	 * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buffer
> -	 * is not enabled.
> =C2=A0	 */
> -	if (iio_device_claim_buffer_mode(indio_dev) < 0)
> +	if (!iio_device_claim_buffer_mode(indio_dev))
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	out =3D (s16 *)st->samples;
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.=
c
> index 3d441013893c..3f3680c4b42f 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -417,7 +417,7 @@ static int max30100_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0		 * Temperature reading can only be acquired while engine
> =C2=A0		 * is running
> =C2=A0		 */
> -		if (iio_device_claim_buffer_mode(indio_dev)) {
> +		if (!iio_device_claim_buffer_mode(indio_dev)) {
> =C2=A0			/*
> =C2=A0			 * Replacing -EBUSY or other error code
> =C2=A0			 * returned by iio_device_claim_buffer_mode()
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.=
c
> index a48c0881a4c7..288c2f37a4a2 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -476,7 +476,7 @@ static int max30102_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0		 * shutdown; leave shutdown briefly when buffer not running
> =C2=A0		 */
> =C2=A0any_mode_retry:
> -		if (iio_device_claim_buffer_mode(indio_dev)) {
> +		if (!iio_device_claim_buffer_mode(indio_dev)) {
> =C2=A0			/*
> =C2=A0			 * This one is a *bit* hacky. If we cannot claim buffer
> =C2=A0			 * mode, then try direct mode so that we make sure
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index f69deefcfb6f..a10590ac4e17 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2224,19 +2224,19 @@ EXPORT_SYMBOL_GPL(__iio_device_release_direct);
> =C2=A0 *
> =C2=A0 * Use with iio_device_release_buffer_mode().
> =C2=A0 *
> - * Returns: 0 on success, -EBUSY on failure.
> + * Returns: true on success, false on failure.
> =C2=A0 */
> -int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> +bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_=
dev);
> =C2=A0
> =C2=A0	mutex_lock(&iio_dev_opaque->mlock);
> =C2=A0
> =C2=A0	if (iio_buffer_enabled(indio_dev))
> -		return 0;
> +		return true;
> =C2=A0
> =C2=A0	mutex_unlock(&iio_dev_opaque->mlock);
> -	return -EBUSY;
> +	return false;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
> =C2=A0
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> index 981c704e7df5..8cb3fa38077e 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -304,7 +304,7 @@ static int opt4060_set_driver_state(struct iio_dev *i=
ndio_dev,
> =C2=A0	struct opt4060_chip *chip =3D iio_priv(indio_dev);
> =C2=A0	int ret =3D 0;
> =C2=A0any_mode_retry:
> -	if (iio_device_claim_buffer_mode(indio_dev)) {
> +	if (!iio_device_claim_buffer_mode(indio_dev)) {
> =C2=A0		/*
> =C2=A0		 * This one is a *bit* hacky. If we cannot claim buffer mode,
> =C2=A0		 * then try direct mode so that we make sure things cannot
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 872ebdf0dd77..bf7b7337ff1b 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -687,7 +687,7 @@ static inline void iio_device_release_direct(struct i=
io_dev *indio_dev)
> =C2=A0	__release(indio_dev);
> =C2=A0}
> =C2=A0
> -int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> +bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> =C2=A0
> =C2=A0extern const struct bus_type iio_bus_type;

