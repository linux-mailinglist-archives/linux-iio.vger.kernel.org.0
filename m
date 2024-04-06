Return-Path: <linux-iio+bounces-4103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9B89AA50
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6CDB218A1
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F922EED;
	Sat,  6 Apr 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmqaH9D9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355A2561D
	for <linux-iio@vger.kernel.org>; Sat,  6 Apr 2024 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398762; cv=none; b=GH3XVF6kBBdnO4huxqtDs7ftUia8jOQhVot4HOwrRLYOBct1m16nvB4brjX3b/BUg4jkRn0ZkKXLxAi8UbwXs2A7BMw6gTlCU/9jqpsEhOoP/WbhxJCxFObt5NytAj+5EFdslRwAv2cso+C4h4jewxXvLVxaHqb2kO9z1uR5j/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398762; c=relaxed/simple;
	bh=JRi28ltzSUInBPgwS8Er6xqHi9CJJvTWSiLywUfLjmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubOMnb6HLhIVS5d+WJ7E2+RH1YT4Fdc7SHc+HvaXKs6wiXzSfcr1tIoD97V+x4yHi3GlH1eI9YQo/yAqq4d7TbfCxKeeN0b9vtnTP5b2Ey96KdTUOQac8CowdS76RUqh3i7HmTZ/DjJzyWN1Stwwgc9QPi9PEycjFIdnhtVASzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmqaH9D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B323C433F1;
	Sat,  6 Apr 2024 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712398761;
	bh=JRi28ltzSUInBPgwS8Er6xqHi9CJJvTWSiLywUfLjmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AmqaH9D90ozrT6KIyGVTeQ4P6HtvJafRpOUEnSraE3pSOepiYycCo+iDtJL/Y1Ui6
	 viWxKcK9efbVeCWbDQDisZH3Gl6mdVVCgerJFRelbGidtMIlTMYro5qJ1O1tY1Bt2U
	 H6Dg3A4MTYbuq29nVE+xey6vtjrtdKYoFgvR4PC7U8+hf+gYrVsW4wjjNJA86jwOF+
	 jyN4iT+6YGK3rHp+4OkhA8HOInQQxf1oVLbHvBWkfpR3MfKcnfzOGhOIWciCQiVMdg
	 pZyv22IDsrM5T+8IBu3Cj0E6yirQqsJy6yjD5ClV0IEML2rm60EN/3m3mX459veY8m
	 JcPrDPn806YZw==
Date: Sat, 6 Apr 2024 11:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 8/8] iio: dac: ad5770r: Use
 device_for_each_child_node_scoped()
Message-ID: <20240406111905.5bbe983f@jic23-huawei>
In-Reply-To: <e479cbeca4b78fb5ccf901a833ba1734735b4993.camel@gmail.com>
References: <20240330185305.1319844-1-jic23@kernel.org>
	<20240330185305.1319844-9-jic23@kernel.org>
	<e479cbeca4b78fb5ccf901a833ba1734735b4993.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Apr 2024 11:11:11 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-03-30 at 18:53 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Switching to the _scoped() version removes the need for manual
> > calling of fwnode_handle_put() in the paths where the code
> > exits the loop early. In this case that's all in error paths.
> >=20
> > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied.

