Return-Path: <linux-iio+bounces-9859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD39894AA
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5EAB20E78
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8513C90A;
	Sun, 29 Sep 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yam2JsQG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAA2B9BC;
	Sun, 29 Sep 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727604186; cv=none; b=JeL+vCe2xZWH4aoD02GxbNQaoESST+ZxEZMGwG7w19FUSDDMCfO/wCbBlSIKFVae40wvBJ8uuSvzzfZ4LwWg4PKRa7uP8tFgHIjie0XQBmD20+F/FoG9lTQuTKabOuYdvDELMXQZ6hjLtE4pxs5YpOAIvzYxlXrCL23ub1j/AgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727604186; c=relaxed/simple;
	bh=ruwm4D/yxLm8odMn01JTck3NTvNild12UusqEDFMBOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/eK6etyubCw/21MQeYmxcNnSn0iWpwuWoXVIfzkgbLSUwtIIE/b5Wslz6/ZsPmGJoXRMtA8TO05iuKCFGM7qsQGcq2lJBAT1CML9UEZjGziaQ3IOMFkTjgNUTGoeBQGghjGUYxwh6bpC1qVQrN/OvDgc6kQNSMKPIsA+4HpS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yam2JsQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AADC4CEC5;
	Sun, 29 Sep 2024 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727604185;
	bh=ruwm4D/yxLm8odMn01JTck3NTvNild12UusqEDFMBOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yam2JsQGDxqj++lmusiGi0PfxdTnlUBn2rBOqghySs7Cc5uzescqK0h4dx5pBnPmO
	 284lEKgSvMcmYTFIbcjPF1xwdgwHb63RwvjQorbh9RqsIeWitoUTUMSYPh4cMKrrxz
	 J7fnBQOyUhyQ1hbqSMGiL7HHoPPs94zaG/gX9mSGeya5VfKOtqcHCVBdTTzoTLh/X1
	 gmcovVZcF+UM46ymLewG+8NYaHE3eBC5G41mbkAmglY9WV0+drF3UWKY8M/d5EjHfB
	 yZsri+brNd9iKL6GmoAZWpEvDLDSL0DpYHJdugFjNXGkSrHW7S0fZYkf6zMFniUsa5
	 WmTCedxfeRYCQ==
Date: Sun, 29 Sep 2024 19:02:59 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2] tools/counter: Close fd when exit
Message-ID: <Zvkl02bt6TPb2G_H@ishi>
References: <20240904014253.2435-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjMTxti7lvF9h5FM"
Content-Disposition: inline
In-Reply-To: <20240904014253.2435-1-zhangjiao2@cmss.chinamobile.com>


--fjMTxti7lvF9h5FM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 09:42:53AM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>=20
> Since fd is not used in the messaging it's better to=20
> close it before printing anything. Ditto for other cases.
>=20
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Hello zhang,

I appreciate you for submitting this patch. Before I can accept it, I
need to understand the reason for it.

Previously counter_example.c did call close() before returning, but as
David Laight pointed out, we removed it for being redundant when the
kernel closes file descriptors on exit, as well as possibly changing
errno before perror() and strerror() are called.

Is this patch made to address a particular bug you have discovered? I
would like to document the rationale for this change in the commit
message so we properly understand the reason for calling close() here.

Sincerely,

William Breathitt Gray

--fjMTxti7lvF9h5FM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZvkl0wAKCRC1SFbKvhIj
K8VkAQD93xIBirFBTTbKs2f6uEQEa948Xz8xifFb4MgIXLgMZAEAn6jteODdnMMr
zKvDX3+WDfdsaZvabqBXgoy6k3hFugE=
=6EWP
-----END PGP SIGNATURE-----

--fjMTxti7lvF9h5FM--

