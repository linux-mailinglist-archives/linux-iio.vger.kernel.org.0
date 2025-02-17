Return-Path: <linux-iio+bounces-15620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A184CA38060
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225217A42D8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73C1A5B8C;
	Mon, 17 Feb 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKFyYyfy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A915C0
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788693; cv=none; b=V9jeQ8UTauUIgsFQkcAI68awPA7YKdDbuf7nUBB3+clH9w2kLgQH8vO90MuZ53CUtIsY5aczm7+KFKNfHeriDxZLjLBQZYI9wpKswdAwKfgqw4bCfKM428bTqahLXEGER2b0LClFJunxhKo8gCIj6BOijNkBK/LkZeSFVDj5WdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788693; c=relaxed/simple;
	bh=7DH6yLD8v9Rv2jf9HhghW/fPK3EcFxEWh12/aqKQVE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nj5FDIJRq3ejWt8PMMpdf1MEinVhSimqf5kPVbB9zGYErjfsDdl6Bq4hn7kTfI8f8lXniNX35ERJ2lPZyeAMSpjfYp2IFU0ZUIq3PpEypOSYyOh8dMaH8u8qh9h/rDHiVBszgrS8VhBu/0STUC2tRKsSuFUZSvaTwXt2eCs6LWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKFyYyfy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so3704533a12.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788689; x=1740393489; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGfWsyGJFjqOoFXF5sHD7I08LcosBOpcKQVp17PrDmI=;
        b=GKFyYyfya4CZasZJGbMND0g72ohpSlFUXSpsUZw4izFEuZ44Wsyprp7LYS+fYKTG+F
         CzXb5ErQiMyBfhndI+ZeaIA9yUgslYSzXSSYu7xvfwi3OkYGqDBd1I/pcds/2iJ+LpzA
         JaR59ej9L1ljdLuO6weL7wpxvJS2Vgy4tuy2r8bxvxIP9U5tTvDgKV+PLM5vDel6msqo
         H8113o75IPdAsz1PeS/k+jknwIkoOxia0zEKGmnBJSVSfY4l39OtXgT0YGmpU2O6t4do
         dM+UL2BclY1HfYWte9cKZEalfBCNqeemXHsuzNUCEzqKbOkoZDmaXUCvp+WIzA3t/8u8
         LbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788689; x=1740393489;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGfWsyGJFjqOoFXF5sHD7I08LcosBOpcKQVp17PrDmI=;
        b=QqZ7n7qXZO1nL14zGZImecH1p42nZxCpjO0dRuFdAbvyhp/snt9GIRrMzyvIETiJL0
         c0aD1H6CAVnhtXODQ7BeyQsSYU71J3I2UCkxAYktaBgO5vk181yi0tTt/Xnwwc6j+JEd
         4f+aI7Pu49qcPgHNM2NaOAFdRy8RovegIP+iARFvORNVp5JGE2MW1TqPnnt8IOF9GATP
         D8JGlgmJ+sRfFAHRMFLUnf3pyvPS0cSpE8EmP8fNL/faalR6ZrJatqk0bABytMFoARLF
         b3ey3bq0RIr6ahrLfYhYreW+sijLZzGK91RC9V8/WzZ0BwYc7DDkPWQUN4K0YR/aTXVg
         V3mA==
X-Forwarded-Encrypted: i=1; AJvYcCW+vQprk+G3lAJgobgt02IwwtN2NUfckyEajIbFbx0Shh5Yqz/+YYyiyjcQZaJ9f2N2slQahqzaeKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhNhKpSilcjEMmo+CmF0pRHsxk8T2qG9XZcAuDeaKwrHlu556
	wsrQmCA5SV5jAwqNn9aPIr9/ETfvjB2QTKS8dQWd3ZwqN60v/R9I
X-Gm-Gg: ASbGnct5FOJlI6xqC3cRDenJV9cllp9349eP0phVD8ckmO3ftsDFkIItcYv3IHH1nPt
	kfUf4We/zFSSbypDp+Y/YPmZKRljzVPH13qxqm/8Yyisg+wSJAi/IcsplPKfZKI04Of0zNS5BCv
	8mCVeeCQvbz7NDjshGbzK58M9esjWrqYUAVDbw/CVc8VTCp6k1sVaT+jj3znBbNDVgHdD2CMXyA
	tu8i3+c2J0/HxUVFmvr79Q+BqG/+KLS7gw/AXRfzqc2WPTRzSVe27sOZxiZePGaZv1bT42U1Mnw
	PEKeoJyv4XLi93YWk6NkjoBETii4d4hH7um+nj1SEaBrBMampWcDORhwAeyE8n8=
X-Google-Smtp-Source: AGHT+IFFr0j3ZYgaZ7qY0oE4nBaXKXJva7liIBlBI2MgpMm/r63FBFN1UxsFfHGFjxGs/eHMIO7dSA==
X-Received: by 2002:a05:6402:440d:b0:5d9:b84:a01f with SMTP id 4fb4d7f45d1cf-5e0360a6974mr8197717a12.18.1739788688692;
        Mon, 17 Feb 2025 02:38:08 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270cbcsm7369333a12.49.2025.02.17.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:38:08 -0800 (PST)
Message-ID: <c11d55efa6bb145aba7cd7141031b7aa45027a76.camel@gmail.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
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
Date: Mon, 17 Feb 2025 10:38:11 +0000
In-Reply-To: <20250209180624.701140-2-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-2-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:05 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Initial thought was to do something similar to __cond_lock()
>=20
> 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev);
> 0; })
> + Appropriate static inline iio_device_release_direct_mode()
>=20
> However with that, sparse generates false positives. E.g.
>=20
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context
> imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock
>=20
> So instead, this patch rethinks the return type and makes it more
> 'conditional lock like' (which is part of what is going on under the hood
> anyway) and return a boolean - true for successfully acquired, false for
> did not acquire.
>=20
> To allow a migration path given the rework is now non trivial, take a lea=
f
> out of the naming of the conditional guard we currently have for IIO
> device direct mode and drop the _mode postfix from the new functions givi=
ng
> iio_device_claim_direct() and iio_device_release_direct()
>=20
> Whilst the kernel supports __cond_acquires() upstream sparse does not
> yet do so.=C2=A0 Hence rely on sparse expanding a static inline wrapper
> to explicitly see whether __acquire() is called.
>=20
> Note that even with the solution here, sparse sometimes gives false
> positives. However in the few cases seen they were complex code
> structures that benefited from simplification anyway.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: include linux/compiler_types.h (David)

UhU, I'm not seeing it?

> ---

With the above,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0include/linux/iio/iio.h | 25 +++++++++++++++++++++++++
> =C2=A01 file changed, 25 insertions(+)
>=20
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 56161e02f002..fe33835b19cf 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -662,6 +662,31 @@ int iio_push_event(struct iio_dev *indio_dev, u64
> ev_code, s64 timestamp);
> =C2=A0int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> =C2=A0
> +/*
> + * Helper functions that allow claim and release of direct mode
> + * in a fashion that doesn't generate many false positives from sparse.
> + * Note this must remain static inline in the header so that sparse
> + * can see the __acquire() marking. Revisit when sparse supports
> + * __cond_acquires()
> + */
> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
> +{
> +	int ret =3D iio_device_claim_direct_mode(indio_dev);
> +
> +	if (ret)
> +		return false;
> +
> +	__acquire(iio_dev);
> +
> +	return true;
> +}
> +
> +static inline void iio_device_release_direct(struct iio_dev *indio_dev)
> +{
> +	iio_device_release_direct_mode(indio_dev);
> +	__release(indio_dev);
> +}
> +
> =C2=A0/*
> =C2=A0 * This autocleanup logic is normally used via
> =C2=A0 * iio_device_claim_direct_scoped().


