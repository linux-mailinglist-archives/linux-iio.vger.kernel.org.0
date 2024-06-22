Return-Path: <linux-iio+bounces-6723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6317391358E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149261F2368C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924F22F03;
	Sat, 22 Jun 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs/Arlq9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB717C69;
	Sat, 22 Jun 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719079787; cv=none; b=rEeTUHzY3Z/BrxnjLKt2FHe22kp4SSfW8dQynzwcT0+/2tnsYSlsQkIG649/8WpXT8FQL0Y6DhfQ9/v87KC1+h9B6khx5J8uaqxM+p1r5Rm6NUpnMVabwaDbLctYq2epgTwAOOrp5ycx351nxpjQGsSdKLTAbaZZc+h4aVJjbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719079787; c=relaxed/simple;
	bh=082FeeJIT8NcL1A4NEunFEyHbInRFrlQoDCLXe/8G6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM1lVZ73GnuT8RHOVLdeJL6jpd/0eO6g5KAXEFE/0GGDbp1wUv+XIzrfIUn6Aubcg/lIQKFOZbaawVW/c/rsq/bslcfHVWZhrVy7F3SFFxZlWxakT9+B8OR7YTd30ZhvCl/tXYfR0QQu9dW7UNqX1j1L6pc2oSaDQeRzTIsR8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs/Arlq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4117C3277B;
	Sat, 22 Jun 2024 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719079786;
	bh=082FeeJIT8NcL1A4NEunFEyHbInRFrlQoDCLXe/8G6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cs/Arlq9rIqWlmGUoGV8h4KjQpRxfteZ517I2bSJ66vYcjskBWqCz8+L3i1ZT+DJf
	 029K0l7ZyAfTXyzfSI0IvJCiya9RSVh4zJ7VssdHWJAjbEK7gAFydMRQxwqWDZPV+O
	 d2wm2wMeYV0fyhpzPy272QmgCNYcozjIDzammHV2vTLXpodamUf0zw+tdy1PNbDmJ5
	 RYVOsjoGrZIs6Yu31EPdvBWknJz+ilskQl6zr/f+qDP+jcNEYLYAWNNFSwAIy4W3SA
	 JSZRTq+h+1/k5LQdvqEcID8tx3Cd8q4FOhrzWhYpBfXjLqniZpJmuZlcbkhtHeCkOT
	 +PZezrHQuzQIw==
Date: Sat, 22 Jun 2024 19:09:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Lars-Peter Clausen  <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi-dac: improve probe() error messaging
Message-ID: <20240622190939.7ff46d62@jic23-huawei>
In-Reply-To: <8ba6d78d2cd7f58d1d24e3c32211a8ef0d6864fc.camel@gmail.com>
References: <20240617151820.3337034-1-tgamblin@baylibre.com>
	<8ba6d78d2cd7f58d1d24e3c32211a8ef0d6864fc.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 10:34:34 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-06-17 at 11:18 -0400, Trevor Gamblin wrote:
> > The current error handling for calls such as devm_clk_get_enabled() in
> > the adi-axi-dac probe() function means that, if a property such as
> > 'clocks' (for example) is not present in the devicetree when booting a
> > kernel with the driver enabled, the resulting error message will be
> > vague, e.g.:
> >  =20
> > > adi_axi_dac 44a00000.dac: probe with driver adi_axi_dac failed with e=
rror -2 =20
> >=20
> > Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
> > devm_iio_backend_register() checks to use dev_err_probe() with some
> > context for easier debugging.
> >=20
> > After the change:
> >  =20
> > > adi_axi_dac 44a00000.dac: error -ENOENT: failed to get clock
> > > adi_axi_dac 44a00000.dac: probe with driver adi_axi_dac failed with e=
rror -2 =20
> >=20
> > Suggested-by: Nuno Sa <nuno.sa@analog.com>
> > Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > ---
> > Added Angelo as Tested-by since he tested the patch on an internal
> > setup.
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied,
Thanks,


