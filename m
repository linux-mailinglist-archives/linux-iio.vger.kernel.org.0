Return-Path: <linux-iio+bounces-21042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8EAEC84A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5211BC15E4
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA01F874F;
	Sat, 28 Jun 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxSlAqLV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C513BAE3;
	Sat, 28 Jun 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124629; cv=none; b=BEkn3XO7scu4Fauj/xvXb6yZydItViY0hHumsbIBtbBeavaKhUfbxQd/lB8Ffth1w6t8BG4CE5dIn+A8cvxmN1Agx3GJKJIQj/bI6S2S0N6ki00u/r0RAt6wKFFcegMMTgnXuo2tHUhn/e5I4VkfrT9BdVMVsPEUkeEqMbGZU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124629; c=relaxed/simple;
	bh=h5ePO71syrYOncnS3vc3y/lj13pLh0VkvHVlsMRLdek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv6MsIKS1bbVneUddt7wjcsoTPwFTWz1ure5i2spG9cTlyT8h7ZiyQ/xe42BsOpHqJOMQRqTlMsULM88WR7y5IcDNJzgkQey2DyopCx6ZfC3IREoi7o3DGs68fbAQOJVk4T/Tanr1hAQ+v0XqUllwH2zZXiA1uhipcJqXrNqg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxSlAqLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942C5C4CEEA;
	Sat, 28 Jun 2025 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124629;
	bh=h5ePO71syrYOncnS3vc3y/lj13pLh0VkvHVlsMRLdek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxSlAqLVJCWRUF+rmSe2CvHGomvhuRxXrn2HiPDEfRFla/RDyqtLsr65saS7DP/Tj
	 0nfPpwlGz28w+vKGqzscB94DWDo/b8TcfCBnnI/zzDqzSon17JnIcslfWKCPojSga3
	 Z2Fl/nsGJ8io4i0OXMj8PGfY106vy2EvOY1OGZf+vSXkIBTxIjm/Yfzq/DaupayIT+
	 r9ZupiclmKE1xzIorwUbpmhcVFQzus4ueilfvMrzZQP3aaAJhSMGzFkRyzVYSx8jng
	 hg7ful0E4Y9fSHK/rgWwT2ldr3maWFps3kgA5HuptWxGyh+n/XsJ3UHRWlP84R3CpU
	 pDSvqY5p1ZpOw==
Date: Sat, 28 Jun 2025 16:30:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: remove unused oversampling_ratio
 getter
Message-ID: <20250628163020.036e92f8@jic23-huawei>
In-Reply-To: <cd0b9044ce6434e9313a4fddf73897800821aec3.camel@gmail.com>
References: <20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-getter-v1-1-26cbee356860@baylibre.com>
	<cd0b9044ce6434e9313a4fddf73897800821aec3.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025 16:56:55 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-06-24 at 22:44 +0000, David Lechner wrote:
> > Remove a call to ad7380_get_osr() in ad7380_init_offload_msg. The
> > returned value is never used.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > I wrote this a while back but it looks like it never got sent so here
> > it is now.
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.


