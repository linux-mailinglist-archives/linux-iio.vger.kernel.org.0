Return-Path: <linux-iio+bounces-13679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C49F82A6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EEB7A4AE5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732131A2554;
	Thu, 19 Dec 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKrRqQNk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3519F424;
	Thu, 19 Dec 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630725; cv=none; b=iRZgjSFwGaaIWGGbSrKD3GG5QuFisbE1LnsejGRcUOQmfBHxZ3RPq4m7GtBmwRUI8+3+L2v4kD3UgNHtlOPLKZDFBYr/nY26zNEew92AurEwk8Gss0602QJ81e33kAU7uSzEmsqS0S4bdhYRPEurwY5ka7LqEHuwWpNADahLSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630725; c=relaxed/simple;
	bh=CpcTheWsLbSV03dGmbI+n+L8rp2gA98K8DMSak0tiH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox+OJ6SrUCIiB14IDwv7EqeFf4j81JSlyLFhCwABCKSxQV95U1TxdoTr3TDqUJrNcZ89bt6CHWSyTwp0F1u0qHbXwiNSc9JShyP8jQy1T9FyZ9HUdb4uSucGzo9LMlA1eTgd2/TXpgV1G0wutlwrmDRngphzIzfKaa/cMimMYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKrRqQNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E55C4CED0;
	Thu, 19 Dec 2024 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630724;
	bh=CpcTheWsLbSV03dGmbI+n+L8rp2gA98K8DMSak0tiH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TKrRqQNkbxN9R13UiMSpZ4PqNJlXCxQH7hILM5xHlo6LvQGnbvFgPjwdF1fS9BzNr
	 Pn6gJ6UIdwXbpCU8YaoPox3qnntNe8J7MUH42ClK2OB5EG5pfMQ4pORbUvlAwZiltv
	 WgOWWPue4LwgfL7j/KSStxwT+q+jj3feGahqTW3ZDxZRAoqqmbYqQGhJIEA4kHwEp3
	 VCAvIOgzczwteJ2G+yKa5afF/8uvGsCADnRYFJZWIh15siKoK5U55cB2G6Ay1r9fQb
	 E0UHLk4R91uvl7iFltRWiIv3n86HgaRPhFBuN8nNSmAlpvL+IGpr/1P0qJxtvOCim1
	 GaA2tZovHSfyQ==
Date: Thu, 19 Dec 2024 17:51:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: constify 'struct bin_attribute'
Message-ID: <20241219175157.5036bc19@jic23-huawei>
In-Reply-To: <20241215-sysfs-const-bin_attr-iio-v1-1-a5801212482e@weissschuh.net>
References: <20241215-sysfs-const-bin_attr-iio-v1-1-a5801212482e@weissschuh.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Dec 2024 16:21:24 +0100
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Hi Thomas

Applied to the togreg branch of iio.git, but I'll push out briefly as testi=
ng
to let 0-day take a quick look at this and the other stuff I've queued up t=
oday.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bno055/bno055.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno=
055.c
> index 0728d38260a1c9dd218569ee870bd62c833e9906..59814de042c7d6d69547eb2ad=
c9e1174a7e0c324 100644
> --- a/drivers/iio/imu/bno055/bno055.c
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -1193,7 +1193,7 @@ static ssize_t serialnumber_show(struct device *dev,
>  }
> =20
>  static ssize_t calibration_data_read(struct file *filp, struct kobject *=
kobj,
> -				     struct bin_attribute *bin_attr, char *buf,
> +				     const struct bin_attribute *bin_attr, char *buf,
>  				     loff_t pos, size_t count)
>  {
>  	struct bno055_priv *priv =3D iio_priv(dev_to_iio_dev(kobj_to_dev(kobj))=
);
> @@ -1348,16 +1348,16 @@ static struct attribute *bno055_attrs[] =3D {
>  	NULL
>  };
> =20
> -static BIN_ATTR_RO(calibration_data, BNO055_CALDATA_LEN);
> +static const BIN_ATTR_RO(calibration_data, BNO055_CALDATA_LEN);
> =20
> -static struct bin_attribute *bno055_bin_attrs[] =3D {
> +static const struct bin_attribute *const bno055_bin_attrs[] =3D {
>  	&bin_attr_calibration_data,
>  	NULL
>  };
> =20
>  static const struct attribute_group bno055_attrs_group =3D {
>  	.attrs =3D bno055_attrs,
> -	.bin_attrs =3D bno055_bin_attrs,
> +	.bin_attrs_new =3D bno055_bin_attrs,
>  };
> =20
>  static const struct iio_info bno055_info =3D {
>=20
> ---
> base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
> change-id: 20241215-sysfs-const-bin_attr-iio-66be522330f3
>=20
> Best regards,


