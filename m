Return-Path: <linux-iio+bounces-18128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4C4A89758
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 11:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5902744152E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AE275101;
	Tue, 15 Apr 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeLY7cr6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622C250C08;
	Tue, 15 Apr 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707767; cv=none; b=RF8frRqzR1ZVPr7qgHcqzB+CDyP+nmc/A0FZVLvk4avB3pUKNLTGE95UHzHD54QRt/N8++Q6l++uM4w1LyNZbFXmli1ZK2BHkhX+rVhv/Y5qtvOHPO5qCrANZ5QmpoDQ7asYosAszwgFYqxYKU1GVdw8zd0otThFgiwE7oS50eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707767; c=relaxed/simple;
	bh=yj/RHUQGrD0Vpi8ZhlvyunY1m7y5SFpPBaG4vllJlMA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fU81mBthMNHJFOArM0DEFyBOJySmAQyM6YF/9O4bPPcEZ4y9yIIomdPuy7CibQPospPWCQQN92X9XLAK+1ByLBs5hR6V5ONh1nDTrld6QJiwfJQP80NkOUzbeEcx8DiDAstr+4luWPwqM9qxzSL+0bLc+8w5Nd2VZ+pDw0P298U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeLY7cr6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so28422885e9.2;
        Tue, 15 Apr 2025 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744707764; x=1745312564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuOhBO9CEP87bc9yIeteLcDK+2xvcpSt8YSWodUU3cI=;
        b=BeLY7cr61dffaMg3/id5+xKWJTw8bvHtq0Zfi++0WlZnO4zmsaWBV0WcVMsnK+NkiS
         0yBMrT+HYUOnqD3FlduBj/lJlw1Pg1n0PW2WIzRUuhassfjw3zhLIm14lZPyL9F6glAd
         WnCy5Fr/NDTYFv4F8N/GTXZjA50MPS9Sb+GkK9+UQ0AMSQd5fgazOxzbGzGBJPlaablg
         L7HnL9Lzx3w+inHNW4iQx5FnJyq6e3f/m/Y+y6nOxHZ2Umr/3K1odjDcRV35SRlN5TpC
         qUPSaMI9nMo/ysKJLdwJ0pq6/5nmwYcXezFe3v5CLNA/CyxWjW7o3LGQvZbvVwYfey9t
         CxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744707764; x=1745312564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XuOhBO9CEP87bc9yIeteLcDK+2xvcpSt8YSWodUU3cI=;
        b=LjFGRY84fyi1WokZSu7wtH5GbSs1XeDo+YJzSNaILFh+yZGtPIWF1mqlsSS3NZtcCO
         Do44YlGoBpHRAXMCXW2KKxEddf5ZLsQhN10A25W1N34uRRp4sL5qm+I/CqcP1lw5Dgh2
         biSGvsd+QZ7y48NulyMtIR+Vg1UHDM658W7jOF/+8sewbzzAqioQhnzoD6a6wVj1MeAj
         iBOCN/zmpdCyYnUlFcjVz/xLuS34l8fYsXWlyU0JA5QalK4oht+XVyLtL7jBd4l2cD8E
         qJ5pr32vRnZoVd6V3Ms/YGqqdMzk3ettLoTYBl8UGatz8sCiCwEIRPGIYCJe4KDyq2eO
         jtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+zU8mxGYRrwiGXtAhbZ718GaTHt6y6onVn6hmBf1r2wOMxxNKBAfH2CJHdJcbtvucgEUNLxDxfvod@vger.kernel.org, AJvYcCXhxMcs+Za64HIx+lM9dDD3HiCWMyeil3zMjrWzgrIgWxBgmIouvIPa9nibA4ubIIh4bhCQ27d0ztzX@vger.kernel.org, AJvYcCXqenpyecod3K2lOpS/AKNIe4URUsPaBF9y2F5ImbywXzvp0TK1tVRaSUEczI5yCJ40VFDAngEUh9L/muZG@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjTAfhoLjvUE3aWa3RFh6hXnsm0nciWt1OHDCCAkiuGAzpk4p
	dgyB4K++r0tCUMqi8ZkdQX7ZCQTwAAGrQr2lbO9nz2sJHIxHSMwC
X-Gm-Gg: ASbGncug+q4sAWpLK9vzgNRlKaZbAwRwbm7SzainhEIf38RbFaqIEJVJQo5dJmb9dmw
	klBdXlscUmC+Lokt5kNP8PBriE1+VDMe4gCAlgKvGq6q9G5VW50HXdyGr3wN4O0AfAsw5HLJtSi
	KN9JGwAtw0s1BBH5GOMgoas2xk70q6rqVbDbLX45S5YU47Or8BExupkeNv1sd/XB+je8oz1ZUW5
	ynee0stOl2bv63kiwS9EIgf7dP536BJOlZ1DOpOlBxxX5bwNcrBWmj9tF6gzyZaZMqX2zHtbHqE
	oI/6TMZF/DMhq5HXuumD7+smP0Q7zgp3dUQfvPMG3X1ZmSXH7JZ4b8V9XOKJ4G5uWzgxtxbc7Ah
	U+cqMWMn+Aadh
X-Google-Smtp-Source: AGHT+IGYDL9j6sFTjksYWjwTttmrgFprBoCq+0+CwtwUeQRKTRd8YhvTbGJwWQrxoE0oK1qcKi6JJA==
X-Received: by 2002:a5d:64a9:0:b0:39c:1efb:ec8e with SMTP id ffacd0b85a97d-39ea51d3205mr11549315f8f.6.1744707763590;
        Tue, 15 Apr 2025 02:02:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c49f7sm199255635e9.17.2025.04.15.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:02:43 -0700 (PDT)
Message-ID: <85458f261a66815507170a980b17fb45135548bd.camel@gmail.com>
Subject: Re: [PATCH v2 03/13] iio: backend: add support for self sync
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Apr 2025 10:02:45 +0100
In-Reply-To: <20250411123627.6114-4-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	 <20250411123627.6114-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-11 at 15:36 +0300, Antoniu Miclaus wrote:
> Add iio backend support for self sync enable/disable.
> When disabled data capture synchronization is done
> through CNV signal, otherwise through bit-slip.
>=20

It is still not clear what API's will come out of this but you need to impr=
ove
the commit description (and the API docs). Note that the above is very focu=
sed
on your use case and you're just using the same names defined in the device=
 docs
and hdl IP. While that might be ok for the device drivers commits, it is no=
t
that nice for something that "tries" to be more generic.

This is true for all the new API's being introduced...

- Nuno S=C3=A1

> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v2.
> =C2=A0drivers/iio/industrialio-backend.c | 30 +++++++++++++++++++++++++++=
+++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++++
> =C2=A02 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 60578267643d..cb23433b22c6 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -830,6 +830,36 @@ int iio_backend_data_alignment_disable(struct iio_ba=
ckend
> *back)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_alignment_disable, "IIO_BACKE=
ND");
> =C2=A0
> +/**
> + * iio_backend_self_sync_enable - Enable the self sync data capture.
> + * @back: Backend device
> + *
> + * Data capture synchronization is done through bit-slip.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_self_sync_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, self_sync_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_self_sync_enable, "IIO_BACKEND");
> +
> +/**
> + * iio_backend_self_sync_disable - Disable the self sync data capture.
> + * @back: Backend device
> + *
> + * Data capture synchronization is done through CNV signal.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_self_sync_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, self_sync_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_self_sync_disable, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate)=
 mode
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index beff66d18151..6d006cb0da5a 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -104,6 +104,8 @@ enum iio_backend_interface_type {
> =C2=A0 * @filter_disable: Disable filter.
> =C2=A0 * @data_alignment_enable: Enable sync process.
> =C2=A0 * @data_alignment_disable: Disable sync process.
> + * @self_sync_enable: Enable the self sync data capture.
> + * @self_sync_disable: Disable the self sync data capture.
> =C2=A0 * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> =C2=A0 * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> =C2=A0 * @data_stream_enable: Enable data stream.
> @@ -158,6 +160,8 @@ struct iio_backend_ops {
> =C2=A0	int (*filter_disable)(struct iio_backend *back);
> =C2=A0	int (*data_alignment_enable)(struct iio_backend *back);
> =C2=A0	int (*data_alignment_disable)(struct iio_backend *back);
> +	int (*self_sync_enable)(struct iio_backend *back);
> +	int (*self_sync_disable)(struct iio_backend *back);
> =C2=A0	int (*ddr_enable)(struct iio_backend *back);
> =C2=A0	int (*ddr_disable)(struct iio_backend *back);
> =C2=A0	int (*data_stream_enable)(struct iio_backend *back);
> @@ -202,6 +206,8 @@ int iio_backend_filter_enable(struct iio_backend *bac=
k);
> =C2=A0int iio_backend_filter_disable(struct iio_backend *back);
> =C2=A0int iio_backend_data_alignment_enable(struct iio_backend *back);
> =C2=A0int iio_backend_data_alignment_disable(struct iio_backend *back);
> +int iio_backend_self_sync_enable(struct iio_backend *back);
> +int iio_backend_self_sync_disable(struct iio_backend *back);
> =C2=A0int iio_backend_ddr_enable(struct iio_backend *back);
> =C2=A0int iio_backend_ddr_disable(struct iio_backend *back);
> =C2=A0int iio_backend_data_stream_enable(struct iio_backend *back);

