Return-Path: <linux-iio+bounces-12865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BCE9DF231
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A27161F8A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C383B1A4F12;
	Sat, 30 Nov 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW0/qDcy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2778468;
	Sat, 30 Nov 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986834; cv=none; b=qFVjBK5w7JuIEF6jvMy+3r1J0BF0hgILdxZ6eTX2v1R09Qnv4i5u/JNCBkcxmnWNRYXqhTd8SIxu1c2Xi5+uGtYxcSHej/YtaMyNWYyAE4zqIHOjDQGmwFLoNSDp56/8o2C+VSr4yVTxWNGhm9m8JaPiHnsvwsCP/XLhrR7FFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986834; c=relaxed/simple;
	bh=qjqrF/VB+RYPQPiOREQb687IUQL+rKoEIp8e5HzPqnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elBF/p6mm5cnEuA3SQoEFz5sdqB8N/K/IaVYwzy5s/ntS7AeqWEH8LK5xzNTLVZsL0gyYIxSPmHkdzCsDEq9v+I2xAkMLvw4vG7RoaO9mzkQ/VlbeUw/S23D8NxUBv2gL9NI/IEinchErJ+xFOS0dbG+NrZSO5Z9ieF2PrONFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW0/qDcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE234C4CECC;
	Sat, 30 Nov 2024 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732986834;
	bh=qjqrF/VB+RYPQPiOREQb687IUQL+rKoEIp8e5HzPqnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sW0/qDcyposwz7pVUbiDw/gd7YEEKBwe/zJBrwL1qxEjF2NAYQMOcoEtVlL5zp38r
	 lbbAedYKztRE3pX6zVy6j2CZJcs21+4stBPa1cxKMq5WrDs+h6MWkG29x1Kt599UbK
	 9Ny5tBDW8ReAEqTSAnVzxWHM3nflDeyCyjrKbbOzX8sju8+m4IiDeAMi2TZHmVS+gF
	 lk3ZGBMchc6+BofP9s7nkhIp0ywgNiLWIdCFpVEJddtR+3AkH6kmOqFQDF36tWqKFT
	 wTzcp7AsbUIBOoMvfcusyZeGUOd0f06UdCmyCvD3sfFMPLQ7sgH0y8kP4Af14xmmxh
	 St1TAMnJ13PFA==
Date: Sat, 30 Nov 2024 17:13:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/7] iio: imu: adis: Add custom ops struct
Message-ID: <20241130171343.007eaffd@jic23-huawei>
In-Reply-To: <20241125133520.24328-3-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
	<20241125133520.24328-3-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 15:35:09 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch introduces a custom ops struct letting users define
> custom read and write functions. Some adis devices might define
> a completely different spi protocol from the one used in the
> default implementation.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
I assume that by the end of the series, adis_default_ops will be in=20
use, but until then I think this change breaks support for all devices
currently supported by not providing a working read / write.

Thanks,

Jonathan

> @@ -488,6 +488,11 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(adis_single_conversion, IIO_ADISLIB);
> =20
> +static const struct adis_ops adis_default_ops =3D {

Not yet used.  So I'm guessing this patch breaks all existing drivers.

> +	.read =3D __adis_read_reg,
> +	.write =3D __adis_write_reg,
> +};



