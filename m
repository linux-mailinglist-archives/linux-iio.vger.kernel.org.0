Return-Path: <linux-iio+bounces-27781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1001D1F07E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55F49300B9DB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B3395DA9;
	Wed, 14 Jan 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVayix96"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419239B4AA
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396731; cv=none; b=ivIiW3Gf2TSoJ536aMGd7yi80NGQepFhgz4Zlt4iLfWOM2MiIPCzoCq8Tdw5rSPk2rATDIwite1wuBOmcElXRzS8M5Qd3XweXyvs19IOf+rBwyo5f9qbTkkkBNOtv+TABlMeL+BC9BpKbqK+OuvBjFqYH/cZRthTQyAE4KT9wV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396731; c=relaxed/simple;
	bh=kJhQ3X7tAxH/pacww9V7iv2f7A8ohtX8o5mQVwMXlco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCdq4CeP18/k/FP1ITPUQjBqPdHV8DRpMPWkHKfs/1SFfzKLSjGKCt+nndm50PcLOe/7n58HdGbR8/CVcAy3U6qc6hFATsUcdJK3pEJzQdNrZCuoPOS2G9ArLhZKOcz9EbFnVP7zWz7emMi8HLqqNTSncOxFcl+CybVhztnYUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVayix96; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so4703905e9.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 05:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768396728; x=1769001528; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wq2iQYIcytQDZ1aLp6I4re9aFTWBbjUz0WrHFHM+oEY=;
        b=ZVayix96l4T/0bG3HQ9H/jmrN8mSEWGjwZQKY0yxXaMiqzvVExly7G6ehg34oBmIIO
         Ns1bWdfGYDTmBXoU99Ec0HY6AeiNm8eCQ5U/YRxNjdj1cUspO6Ka2/HJBVrA6VtT/vNP
         wXSg1sDPWeOFVAhYwuc6n8C1qJ5T8uf8msVaRqMbS6AeLT9su2gyHcKUlhQzhGRmvSnh
         Ss+M6kwBIevuZfhrzMGWRZjcPOnw35+WbpsQnlpEQezb45QJKpqOnkf5YaSzX/Il1dQm
         UF/jvDLJwCf+fcjYKlxGzHYvtBYBVhuY43tmffrOd08zhZMoEyasu1vUM/BreP8eunih
         OBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396728; x=1769001528;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq2iQYIcytQDZ1aLp6I4re9aFTWBbjUz0WrHFHM+oEY=;
        b=AqhixbuG5w2F5DjsUI+9gldbD6/WgEZNaDtFinZbTCwEMH83C/FG+Ia2fyOe4XP8qY
         6xZDwVHvfE/wWvsKxvZtQee7u8a9+0Xdyue7KSXmOaVw6bb1oPbRTPnbgyMEwcB4WAc3
         cG4JAlRCkHxQ2iCmZVVMuCK7yHXwTfmNLTjIWFp3V13L/ATzfRNmdSSCx6O2bHmI9xPs
         19hY5Vjec/GKQWc4e5GYJs+BZiBSqctIH3PrpZHqRxxK7rVrx7WCENygSr5aNAfbfqM8
         IhRt78uxV2Yjr+81yKUu28hfOcRN8yeHWVBnCH1d3iJxjs6P3vR6myL/ke8WfOmd/IqU
         B9kQ==
X-Gm-Message-State: AOJu0YxAncy3EA9QAqNNT+9JvQWyO6sChgNtXaufbhLRa/j0b9nmodhO
	93mjdm1KjBe9yZlKY2ca+/rQrq7TKRVnV0qkgie1wILHI+sxfDvIbt/h
X-Gm-Gg: AY/fxX4q6Bs4yVzvvHtbjBuXzWB+9X2Ric/8/Nr1yULnBX9NfEG76Wfbj0htG/kpEf5
	saDMyNvpYDhRTxrduZ2Z2PgYqSfPYFJwAYLpOMoldJpXCIMECre7bDgbvYWjqmCwNbzVwb5cvBk
	GosMt1GBM+z8HLfoBGrs8ViwjMXwV0zJ0xNQJC9Gbdqx5/x5uq38OmxInSze0TMlnHubHs5CBSp
	frLWkntuRt404n9ln7RQo/QlUh14VmPBqwj+ck5vbMTUy3YdL1ClE7aAW2cISYbI6QZ+u5HIShl
	90YLBW68Vqh0kuo6fTM+RooUy60jAHcaQagaIwFL6mrOgc5/VCwR/nhbu6WG1ORQbV2U4W1bpCe
	nn7UWvPE626NIhEjuO6faDz2TPPlYA6mK7QC/5Em9irxiuljam34ewjUZnNa5yk9M0TZd04AaTJ
	2cdUdSPnmg/D3vznHNCg/xDexMDxRvgQ==
X-Received: by 2002:a05:600c:5304:b0:47a:940a:c972 with SMTP id 5b1f17b1804b1-47ee32e5dbdmr29084295e9.4.1768396728285;
        Wed, 14 Jan 2026 05:18:48 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee117e607sm22821855e9.3.2026.01.14.05.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:18:48 -0800 (PST)
Message-ID: <728fcfbbe31a9b1a31668a2e7e879397905293a5.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2026 13:19:30 +0000
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

We could also mention this is useful for frontends that are expected to
work with different backends which can offer different functionality.

- Nuno S=C3=A1

> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports calibration. Needs at =
least
> + * iodelay_set(), test_pattern_set() data_sample_trigger(), chan_status(=
)
> + * and data_format_set() operations implemented.
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
> =C2=A0void *iio_backend_get_priv(const struct iio_backend *conv);
> =C2=A0struct iio_backend *devm_iio_backend_get(struct device *dev, const =
char *name);
> =C2=A0struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

