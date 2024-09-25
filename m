Return-Path: <linux-iio+bounces-9771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB10985C07
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879ED28836A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37875185B61;
	Wed, 25 Sep 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSC5fFgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D912172798;
	Wed, 25 Sep 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265311; cv=none; b=mTa6rKfgtboGpnI/9YzY/EX2OdBc/DlDZzXXQZogjzXG5pRUOEs/Gx3U37E7tBPod0LcfhwLVDcLd/nbhEYR11o3nu3tw5NytK+LrJL11ACrF8aG4QWXORuwtmyHUk3GY8l+fhqvBpfgSUHaL4t0C3euzZ5uvF+65MdaQRMXej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265311; c=relaxed/simple;
	bh=06shn2lzCpIoIbV8xE2yrdhCS68w/CZnVYECorR+OY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcATW96hl1WPCHvGOlKVSz0ZyfcvG4KlD7vlZ/7/ZEJjEWCnNEzhKQ4x9g7PwfgJ21SMQG1/EX/6cP2qEITDJhWYm6xvEu9jr5LKFhwuLj77b/ricmgXU3aTJSFpANCp3AjEOU3DSrDcWrzwv7vpR6zvPteVODZry24ucshpwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSC5fFgu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc8782869so63335405e9.2;
        Wed, 25 Sep 2024 04:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727265307; x=1727870107; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RoU9Qx8kBrIgEwKXCGnJInXxTS3IuLOwTla9H1khxNM=;
        b=MSC5fFgucLpHPDfHf1v5eS5qEHi32jI84WBW0FsxoTYjBQyxBCRAKnSg0V/qjIUb1G
         Rth9HY8njyPlTQSOC2EHyjE29bSLfIi0nwIEIu/ol6pw24Om4K5+mbRY41uSFSpkb+p3
         afv0bE8evX8rsYMSYKhYiFxQq3/M5IlHmw1J9i5a4ViJIcweLHoPzPB0/dCuAMNPnKmC
         LXlC5sRx5X99aK+ZiqJYeDWxPRbwjNP1N6Nw5+zx2DB6q8aZRA9hI/o5zguepyTvF23m
         +LGziTnjqZIKV3DhTsUjcYIwKveBTshMJygbcaBpDKceRC7rfhIw3OXSnzSklXhUvCzV
         93UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265307; x=1727870107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoU9Qx8kBrIgEwKXCGnJInXxTS3IuLOwTla9H1khxNM=;
        b=XVCDvPhMwVSPnZs3Gx5bZGMutXtULQRcim6Ssx6j1CJdkmr6Ju9CUkJMP0iEOkGR86
         OL9y8S3tHVhjMZzPl0f19OfHPKTd9rOEvWbgH9dAR3dpxxuWkv/E3axJd5YHkiVEcdmS
         fIWqKMIOtNVPgtGkOTU/DI15B7gYTK0Qjm5CfalSDQN1JmfaaeD60IDr+S8akJdMnKUP
         zbM4iwBeMTQGKtr9PG74r2rwSIXy/3aTLIWjjlyWWRDQvNgQVNpvU0rct857cV8Mr4Ll
         Jtxp8P/GMftV0Z6gD15cuZtpW6Ur6FHCqqqQAJAiH2CCNjoyD65Db+DG4470cRLogAT6
         EKsw==
X-Forwarded-Encrypted: i=1; AJvYcCV+XETtFiGGuowrTIADaZRGRvs5jGV0ZDqEvGh6ITkmmud+9gu5RRgqy02drDsc2Uf5hInbUaq99YJr@vger.kernel.org, AJvYcCWSXQifxvl3lhlZL785z3Xb4N8+kH1lawzBZ1DgYb/alMTQRtAuWiTXOShZ0BH8k2g7Fe4jMWwUQ2V6i9RC@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQ6h3ndtYegJJw8WZHjj84bYW7p00PZ5oAuZYSF/xxzHF6WHc
	59mIvSyL1H1d+0t816hfFbfGn+HrcmADYWQe1JD0cKve8ga0zscv
X-Google-Smtp-Source: AGHT+IGU1CeQOnvVvHYaXd9j6bCoGgdKXtEQD/UD7GoWhx7Uc/5VWujBOYsQ6r5W7ftlUwHMWzpEDg==
X-Received: by 2002:a05:600c:3c85:b0:42c:df54:1908 with SMTP id 5b1f17b1804b1-42e96114ad3mr14732075e9.18.1727265306876;
        Wed, 25 Sep 2024 04:55:06 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36251sm16243335e9.37.2024.09.25.04.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:55:06 -0700 (PDT)
Message-ID: <fa2ab3b06dfb227de2f449c52b83ff6ffe1f79c2.camel@gmail.com>
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Date: Wed, 25 Sep 2024 13:59:18 +0200
In-Reply-To: <45f72533-ba1b-4531-890d-63d86a1f0ca4@baylibre.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
	 <60610fe3e5885033c0a1d14db6e2f576367a2e44.camel@gmail.com>
	 <45f72533-ba1b-4531-890d-63d86a1f0ca4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 16:11 +0200, Angelo Dureghello wrote:
>=20
> On 20/09/24 14:50, Nuno S=C3=A1 wrote:
> > On Thu, 2024-09-19 at 11:20 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Extend backend features with new calls needed later on this
> > > patchset from axi version of ad3552r.
> > >=20
> > > The follwoing calls are added:
> > >=20
> > > iio_backend_ext_sync_enable
> > > 	enable synchronize channels on external trigger
> > > iio_backend_ext_sync_disable
> > > 	disable synchronize channels on external trigger
> > > iio_backend_ddr_enable
> > > 	enable ddr bus transfer
> > > iio_backend_ddr_disable
> > > 	disable ddr bus transfer
> > > iio_backend_set_bus_mode
> > > 	select the type of bus, so that specific read / write
> > > 	operations are performed accordingly
> > > iio_backend_buffer_enable
> > > 	enable buffer
> > > iio_backend_buffer_disable
> > > 	disable buffer
> > > iio_backend_data_transfer_addr
> > > 	define the target register address where the DAC sample
> > > 	will be written.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > =C2=A0=C2=A0drivers/iio/industrialio-backend.c | 111
> > > +++++++++++++++++++++++++++++++++++++
> > > =C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 23 ++++++++
> > > =C2=A0=C2=A02 files changed, 134 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c
> > > b/drivers/iio/industrialio-
> > > backend.c
> > > index 20b3b5212da7..f4802c422dbf 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device
> > > *dev, struct
> > > iio_backend *back)
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +/**
> > > + * iio_backend_ext_sync_enable - Enable external synchronization
> > > + * @back: Backend device
> > > + *
> > > + * Enable synchronization by external signal.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ext_sync_enable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ext_sync_enable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ext_sync_enable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_ext_sync_disable - Disable external synchronization
> > > + * @back: Backend device
> > > + *
> > > + * Disable synchronization by external signal.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ext_sync_disable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ext_sync_disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ext_sync_disable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) =
mode
> > > + * @back: Backend device
> > > + *
> > > + * Enabling DDR, data is generated by the IP at each front
> > > + * (raising and falling) of the bus clock signal.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ddr_enable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ddr_enable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate=
)
> > > mode
> > > + * @back: Backend device
> > > + *
> > > + * Disabling DDR data is generated byt the IP at rising or falling f=
ront
> > > + * of the interface clock signal (SDR, Single Data Rate).
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ddr_disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_buffer_enable - Enable iio buffering
> > > + * @back: Backend device
> > > + *
> > > + * Enabling the buffer, buffer data is processed and sent out from t=
he
> > > + * bus interface.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_buffer_enable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, buffer_enable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_buffer_disable - Disable iio buffering
> > > + * @back: Backend device
> > > + *
> > > + * Disabling the buffer, buffer data transfer on the bus interface
> > > + * is stopped.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_buffer_disable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, buffer_disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_disable, IIO_BACKEND);
> > > +
> > IIRC, both me and Jonathan had some comments about the above 2 calls? A=
ren't
> > they
> > about buffering? I think I mentioned something about using the same buf=
fer
> > ops as
> > typical IIO devices use.
>=20
> i have now separated iio_backend_ops, keeping buffer enable/disable
> for axi-ad3352r case only,
>=20
> static const struct iio_backend_ops axi_dac_generic_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .enable =3D axi_dac_enable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .disable =3D axi_dac_disable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .request_buffer =3D axi_dac_request_buffer,
> =C2=A0=C2=A0=C2=A0=C2=A0 .free_buffer =3D axi_dac_free_buffer,
> =C2=A0=C2=A0=C2=A0=C2=A0 .extend_chan_spec =3D axi_dac_extend_chan,
> =C2=A0=C2=A0=C2=A0=C2=A0 .ext_info_set =3D axi_dac_ext_info_set,
> =C2=A0=C2=A0=C2=A0=C2=A0 .ext_info_get =3D axi_dac_ext_info_get,
> =C2=A0=C2=A0=C2=A0=C2=A0 .data_source_set =3D axi_dac_data_source_set,
> =C2=A0=C2=A0=C2=A0=C2=A0 .set_sample_rate =3D axi_dac_set_sample_rate,
> =C2=A0=C2=A0=C2=A0=C2=A0 .debugfs_reg_access =3D iio_backend_debugfs_ptr(=
axi_dac_reg_access),
> };
>=20
> static const struct iio_backend_ops axi_ad3552r_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .enable =3D axi_dac_enable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D axi_dac_read_raw,
> =C2=A0=C2=A0=C2=A0=C2=A0 .request_buffer =3D axi_dac_request_buffer,
> =C2=A0=C2=A0=C2=A0=C2=A0 .data_source_set =3D axi_dac_data_source_set,
> =C2=A0=C2=A0=C2=A0=C2=A0 .ext_sync_enable =3D axi_dac_ext_sync_enable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .ext_sync_disable =3D axi_dac_ext_sync_disable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .ddr_enable =3D axi_dac_ddr_enable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .ddr_disable =3D axi_dac_ddr_disable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .buffer_enable =3D axi_dac_buffer_enable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .buffer_disable =3D axi_dac_buffer_disable,
> =C2=A0=C2=A0=C2=A0=C2=A0 .data_format_set =3D axi_dac_data_format_set,
> =C2=A0=C2=A0=C2=A0=C2=A0 .data_transfer_addr =3D axi_dac_data_transfer_ad=
dr,
> };
>=20
>=20
> could this be good ?
>=20

I think you're replying to the wrong email :). But yeah, I made a comment a=
bout
the above and that is something I'm also expecting.

Regarding the buffer_enable/disable() stuff, please go check past discussio=
ns (I
think on the RFC). I'm fairly sure I had (and Jonathan as well) some commen=
ts
about directly using IIO buffer options or replicating them in the backend_=
ops.
Likely the second option is the best one so we can take a reference to back=
end
object directly.

- Nuno S=C3=A1


