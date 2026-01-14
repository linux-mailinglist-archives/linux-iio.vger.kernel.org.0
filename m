Return-Path: <linux-iio+bounces-27770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 720EED1EB4F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 351E23008F60
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9828396D21;
	Wed, 14 Jan 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTk3dYSS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8649356A24
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393187; cv=none; b=cWmzBrjn9l3MVfteUmioX6YYk4h8e0SfiJeilIwuIYBYEiViI0M9KQaDasymVDoByks76+M6XdyNhJG5QPaXRYb8DNGHu4AsWR2RiYKqthMOtMxQtg3M/1TeQmjvWxup2S1wtIjXxkbZaEZb0VoXipKzPXP0xIZkZNYN/NRPkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393187; c=relaxed/simple;
	bh=Ul9uRDIuNAEZD7yUfXJ+ahp5uEknivcplS5wg/nPt7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o1umcNM4AusWYpjUC6ai70g8Bx8aMEM/Orwj1P7De10P0RBYKgsm+XiSH2ztQp9eNoNi9nCLdSXnzxL9j6bruV/GNSYASiY+SKR5+0dSF6OqvS/9EziFWfG/uYj5y+LUCYLG0m0gJWyheNZ3oNlcu+UyQ298xP1t4agcB64av3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTk3dYSS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so64247235e9.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 04:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768393184; x=1768997984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76S1+zeUbIQhxKsOZuHnISrzUIHK4b1ifpotuDCkHKk=;
        b=JTk3dYSSjnezrKnrnnth3+CxtpQ0TLkVr5B41iZ5c1gB/wKJ/E7eWBjwVE3OEyIDJB
         jAm5r3j3GrPc3lqLjkWEqSCn5k8xJD7m2SEOPOlm+oeBrQjzYE1ZOZ3RKvV733sreOhC
         rQv1eMXzSIRlnLb3zst2LZ9vN4Mm+25rzZ73AIqsCWxK3VGaQVJKc7PI1D2XGTMSu57B
         /BE+PITPyegEFUKa6dusTTK7xlBMhRybn7cp9K9V5VevTjUTha1GiKCKYv+Q7OC8ImR5
         r0D29fOEBiC9Wre5qM7gDA0zVYL6GhJ/4WvR7XrpPowl4468vu/yXGUs3x2hfslGcPfW
         lX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393184; x=1768997984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76S1+zeUbIQhxKsOZuHnISrzUIHK4b1ifpotuDCkHKk=;
        b=KeVZFgrzHOzoKcajQgInmLRenGwukazvfCsj77CDe+duhK6ZYFwbn1rEhvnyNsHYR9
         EM7Zq7g8XIx3iOtUIcz4yB3cZXABcAFf3pdbYcJic0kgFZdVzN/QfnhwnvZaVMhEV1TU
         CaWDXur+fd0X6s094BQww9xe5KIe8WrmmIgMWF1od5ZFUqSURzQPVBrPeA5Ry1pFAlTS
         5aNUEpJgaGwcIE98N3baZ43UM+ScZozCH3hM8AorcSR8JVFbLT0F02x2/1gGqVVafGkD
         D98pwCre6NhMWMcj/wuEJrP/UOHVXZKss9AM9J0IH4xkvq0pQNWxn3+ub+gnYMJ/pXrQ
         qZrA==
X-Gm-Message-State: AOJu0YyoqJz7co+UD+BSOFgIaBu/efE/u3BBnNTqYhWAyIZMjRGwChJ2
	zNAOxCv6qQmwTgL6QfCGxbzKDMtR9olQAkVKelRJEthBwFVj/+lX7e+s
X-Gm-Gg: AY/fxX7VIy78AyPkqIbMoBU0TlrW9pzk2B1AlXD9ilkuxD1skXef/ptfA3iJKeYTlyl
	b22iSHZssq0T29k71jlgyHOVbyYV2KdO+FsfQcbI+dRs5VKeBD84d+8iWNTOzMGZux0LttRE8ow
	T0T4qso70l/dQFEmBhG1Dh0nQYQh5ZpjF7OfO81W3y5Jp6vpOQDSfRf7o5t/ulCxOq9VFgXVDfq
	Juyq4ALQfFNYC/FNo7zkLNQCDTjdwFq6C7Q3+/Eu/maNRsSet0S2+a6BVMhxZj/w1RvThKx+Yj/
	Lk1VnFgDAVh2ylFg5JZezTDX+QMPonT0ekvNeXjGyuBLgAFiQ+e0GSr/Pkp99cEiUB5iP1noSyY
	9WbZxYrsspznEG15cGKN+72IQYg6onsIY1tE7p0XS7oP8wrjzZ9FegXB/K+ggkwie463XsU3qzK
	z63x6Ma/dhiwhiVzWDFyA=
X-Received: by 2002:a05:600c:6287:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-47ee3391744mr35341065e9.17.1768393183972;
        Wed, 14 Jan 2026 04:19:43 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee55c5413sm28933635e9.6.2026.01.14.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:19:43 -0800 (PST)
Message-ID: <fda7d715e2cab2545c9ecdeead22d8a58ae5032d.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2026 12:20:26 +0000
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	 <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
> Not all backends support the full set of capabilities provided by the
> industrialio-backend framework. Capability bits can be used in frontends
> and backends for checking for a certain feature set, or if using
> related functions can be expected to fail.
>=20
> Capability bits should be set by a compatible backend and provided when
> registering the backend.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 +++++++++++++++++
> =C2=A02 files changed, 34 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..0a98fdd5df9db6cc233af819a=
c5243ba8cd5266f 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -56,6 +56,7 @@ struct iio_backend {
> =C2=A0	void *priv;
> =C2=A0	const char *name;
> =C2=A0	unsigned int cached_reg_addr;
> +	u32 caps;
> =C2=A0	/*
> =C2=A0	 * This index is relative to the frontend. Meaning that for
> =C2=A0	 * frontends with multiple backends, this will be the index of thi=
s
> @@ -774,6 +775,21 @@ int iio_backend_extend_chan_spec(struct iio_backend =
*back,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_has_caps - Check if backend has specific capabilities
> + * @back: Backend device
> + * @caps: Capabilities to check
> + *
> + * RETURNS:
> + * Non-zero value if backend has all the requested capabilities,
> + * 0 otherwise.
> + */
> +int iio_backend_has_caps(struct iio_backend *back, u32 caps)
> +{
> +	return back->caps & caps;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");
> +
> =C2=A0static void iio_backend_release(void *arg)
> =C2=A0{
> =C2=A0	struct iio_backend *back =3D arg;
> @@ -1114,6 +1130,7 @@ int devm_iio_backend_register(struct device *dev,
> =C2=A0
> =C2=A0	back->ops =3D info->ops;
> =C2=A0	back->name =3D info->name;
> +	back->caps =3D info->caps;

It would be nice to sanity check the registered backend here. If it adverti=
ses some capability,
then better to support the corresponding op.

> =C2=A0	back->owner =3D dev->driver->owner;
> =C2=A0	back->dev =3D dev;
> =C2=A0	back->priv =3D priv;
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..8a0df8e980e910ac2d5398275=
963dc5adf077c8a 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -84,6 +84,20 @@ enum iio_backend_filter_type {
> =C2=A0	IIO_BACKEND_FILTER_TYPE_MAX
> =C2=A0};
> =C2=A0
> +/**
> + * enum iio_backend_capabilities - Backend capabilities
> + * Backend capabilities can be used by frontends to check if a given
> + * functionality is supported by the backend. Capabilities are loosely
> + * coupled with operations, meaning that a capability requires certain
> + * operations to be implemented by the backend.
> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports calibration. Needs at =
least
> + * iodelay_set(), test_pattern_set() data_sample_trigger(), chan_status(=
)
> + * and data_format_set() operations implemented.

I would not be so explicit as the above. It is very specific to the ad9467 =
process.
There are other devices with other ways of calibrating the interface and I =
don't want
people to keep adding things into the comment. So it needs to be a bit more=
 generic
and we should also be more explicit about it being about calibrating the da=
ta interface.

> + */
> +enum iio_backend_capabilities {
> +	IIO_BACKEND_CAP_CALIBRATION =3D BIT(0),
> +};
> +
> =C2=A0/**
> =C2=A0 * struct iio_backend_ops - operations structure for an iio_backend
> =C2=A0 * @enable: Enable backend.
> @@ -179,10 +193,12 @@ struct iio_backend_ops {
> =C2=A0 * struct iio_backend_info - info structure for an iio_backend
> =C2=A0 * @name: Backend name.
> =C2=A0 * @ops: Backend operations.
> + * @caps: Backend capabilities. @see iio_backend_capabilities
> =C2=A0 */
> =C2=A0struct iio_backend_info {
> =C2=A0	const char *name;
> =C2=A0	const struct iio_backend_ops *ops;
> +	u32 caps;
> =C2=A0};
> =C2=A0
> =C2=A0int iio_backend_chan_enable(struct iio_backend *back, unsigned int =
chan);
> @@ -235,6 +251,7 @@ int iio_backend_read_raw(struct iio_backend *back,
> =C2=A0			 long mask);
> =C2=A0int iio_backend_extend_chan_spec(struct iio_backend *back,
> =C2=A0				 struct iio_chan_spec *chan);
> +int iio_backend_has_caps(struct iio_backend *back, u32 caps);

Not what David suggested and I do agree with him FWIW.

- Nuno S=C3=A1

