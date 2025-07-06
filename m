Return-Path: <linux-iio+bounces-21390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F84AFA481
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542A217A760
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B71FECC3;
	Sun,  6 Jul 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRNA28b1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2891A9B3D;
	Sun,  6 Jul 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751798053; cv=none; b=SfEvRr9wK7+gx+cKfOCfkJQU6RHdDWJ1Y7LP15k/kG2ozV+WuajAXdXQ527TZfGF5M07j0qORnLhp+4Q9IuL+ppRMS9HGEGRmcDkMSlsCRFTV3lBS7S/Bup6JI3QKIBNN8RXBcCAvZTcQ9FmC5PmZijGFafxdqQTnA5XH4bbQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751798053; c=relaxed/simple;
	bh=L+h4RM2hcY5a78lXjmVrgYV3HLDNxDqzN+u+0QCv0LE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/QaUyenHUUakUaXVQDmSJmw8RoGMu05GVwn5JE5ZP5BG51y30H6hbY5EvrxNKztx8xNq+lQFLg724J6WSzgO9YjCQBqsCUsdYvbl0X/wygOuco0ZUSIf2nIOkhbcxeojjPM9ZJvN4tLOod3ddEjqMEQGvMwiSPcTCjrsza0GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRNA28b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7735C4CEED;
	Sun,  6 Jul 2025 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751798052;
	bh=L+h4RM2hcY5a78lXjmVrgYV3HLDNxDqzN+u+0QCv0LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KRNA28b1PwcTBAabfQVhlOmAbc5aUVL5kMuR5guZsHGV+17PDD/yS4lg9T5Ar0I/7
	 aSN+eOUen0vT6JnqJyahLhkPD6SX9UkPxlbgR9EsUPKl07y9CiXoat/3DU79WLOrT8
	 IEznnARLFtF3YaQLqLRLDAYYQd+47aL7GhU7uVpZjzYAu7By+o0pNxO89lYRg7CUDR
	 SQxGztqrO2CZQR4DRhQC1fqwQ8gQ/tKEHc36gJIW+1HtXe5sERw4UV8ZkQJCQxSOVR
	 HU68yaEWJMe1RUOvtb75AZiTklDfj3RUZPUlDqracs3VV+WBjENEx3HEDU+RbQeRVo
	 jRcuKeFfoatOw==
Date: Sun, 6 Jul 2025 11:34:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: change to buffer predisable
Message-ID: <20250706113407.206682e7@jic23-huawei>
In-Reply-To: <1a0d8f22dc540567142e4583db6eaea0e7d06f99.camel@gmail.com>
References: <20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com>
	<1a0d8f22dc540567142e4583db6eaea0e7d06f99.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Jul 2025 13:43:59 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-07-03 at 16:07 -0500, David Lechner wrote:
> > Change the buffer disable callback from postdisable to predisable.
> > This balances the existing posteanble callback. Using postdisable
> > with posteanble can be problematic, for example, if update_scan_mode
> > fails, it would call postdisable without ever having called posteanble,
> > so the drivers using this would be in an unexpected state when
> > postdisable was called.
> >=20
> > Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devi=
ces")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.


>=20
> > =C2=A0drivers/iio/adc/ad_sigma_delta.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > b/drivers/iio/adc/ad_sigma_delta.c
> > index
> > 4c5f8d29a559fea7226b84141bcb148fb801f62c..1a2ee7c7f65afc60677af9f3138e5=
9f6476f
> > 74c7 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -520,7 +520,7 @@ static int ad_sd_buffer_postenable(struct iio_dev
> > *indio_dev)
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > -static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
> > +static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct ad_sigma_delta *sigma_delta =3D
> > iio_device_get_drvdata(indio_dev);
> > =C2=A0
> > @@ -644,7 +644,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev
> > *indio_dev, const unsigned l
> > =C2=A0
> > =C2=A0static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops =
=3D {
> > =C2=A0	.postenable =3D &ad_sd_buffer_postenable,
> > -	.postdisable =3D &ad_sd_buffer_postdisable,
> > +	.predisable =3D &ad_sd_buffer_predisable,
> > =C2=A0	.validate_scan_mask =3D &ad_sd_validate_scan_mask,
> > =C2=A0};
> > =C2=A0
> >=20
> > ---
> > base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> > change-id: 20250703-iio-adc-ad_sigma_delta-buffer-predisable-d10fc19140=
92
> >=20
> > Best regards, =20


