Return-Path: <linux-iio+bounces-5106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C28C94E8
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446221F2185F
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1E7481A3;
	Sun, 19 May 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCQVH7hn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A3481CD;
	Sun, 19 May 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127445; cv=none; b=e5d/rVjLoOwLld8LGx9oA/M4QAr3Vv5WqA/qxgRoEoLDi+CN9vBwrZwSbUX4CDpBjVp1xmq/dbW4vPRyKlbFtn/T6WCFDWsSRzdgkllgMSsk+UzK2lBdOUt3frfKXKaLS7OmjMl/bS2JW0KuELpac8JyJVPh+9gA+Ai0+u0XYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127445; c=relaxed/simple;
	bh=kX5c/j3XbB6lfj9z5eriyWxGnhGXhpYNAAdgOsLVHyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGi1VVD1ii33h5QsDu1BvaIcbfeTwtFpBDcfql62EMvd442o+mTGmgBHHoY3cVZSm0UDqpEWa01bXq5HNthTn4qi8f/toCIOjJmxFtQdPXDXrnFsi6XFU6Lb3svIP/nI3QL1NYLdnSoU9Pyli+gaQlfXowTkGb6WHWLeRiquyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCQVH7hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F55DC32781;
	Sun, 19 May 2024 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716127444;
	bh=kX5c/j3XbB6lfj9z5eriyWxGnhGXhpYNAAdgOsLVHyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCQVH7hn3otSFLPQmanPzWBTNHre8jj/IOWcSdxgGX9ACat1VZzWqjkUD1cmKoauL
	 vGJ0VsxxFk9yZNQeuYYHijja3mreZuyqjypaq4qT8SGKIXnudmRAcO2QcQ+SNnS+Dn
	 i085mrJVmNV66K5jiw3bAQ+J25l0a7DcR6KYqa3t7Zz7nUUpLnyj5OfoeS4QOjb8z7
	 fGVfU2FQmk+dYKowfqcPRZ1kBP+crjvfHo/425I9qvSgy5/tos/4FMdsgyMDCG08VK
	 DlPDClFPkAEtWZqVulUqfFWGm0UQXOrWz0ReOl5YTZ89dc4dL41/XDxrDrxgEZc4/D
	 Zg+LPqI3POhlA==
Date: Sun, 19 May 2024 15:03:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Gustavo Silva <gustavograzs@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
Message-ID: <20240519150351.6c248b1d@jic23-huawei>
In-Reply-To: <b8775460-5519-4294-9218-d8e814e05305@wanadoo.fr>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-5-gustavograzs@gmail.com>
	<b8775460-5519-4294-9218-d8e814e05305@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 21:13:07 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 12/05/2024 =C3=A0 23:04, Gustavo Silva a =C3=A9crit=C2=A0:
> > ENS160 supports a data ready interrupt. Use it in combination with
> > triggered buffer for continuous data readings.
> >=20
> > Signed-off-by: Gustavo Silva <gustavograzs-Re5JQEeQqe8AvxtiuMwx3w@publi=
c.gmane.org>
> > --- =20
>=20
> ...
>=20
> > +static irqreturn_t ens160_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct ens160_data *data =3D iio_priv(indio_dev);
> > +	__le16 val;
> > +	int ret, i, j =3D 0;
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		ret =3D regmap_bulk_read(data->regmap,
> > +				       ENS160_REG_DATA_TVOC + 2 * i, &val, 2U);
> > +		if (ret)
> > +			goto err;
> > +
> > +		data->scan.chans[j++] =3D val; =20
>=20
> Is it safe? How can we know if it has been only *partly* updated? Does=20
> it matter to know?

You've lost me. What do you mean by partly updated?=20
This won't push anything to the kfifo etc unless all succeeded.
Or is there a race with something else in here?

>=20
> CJ
>=20
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> > +					   pf->timestamp);
> > +err:
> > +	mutex_unlock(&data->mutex);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +} =20
>=20
> ...


