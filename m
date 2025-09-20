Return-Path: <linux-iio+bounces-24315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F24B8C679
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219F358231A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80902F90E0;
	Sat, 20 Sep 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7WNCgAG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF12E0B5F;
	Sat, 20 Sep 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366305; cv=none; b=uQd6thAJ36UVDG0LkxgbTL4hNdXOVTkwFkD9VVm0KiaJGnXsf7Np+IdwLcDcNy8/aWd9R0FxQGck4acoQgPQvNm6Q8Kr3kvznH6rbtzLvatN/Axqric8/Nh+x6gJUKyXfwHG7tk2bKQNoYkHgNo/oIvz7jX34qWG+vN5YXQpZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366305; c=relaxed/simple;
	bh=v7Urrw2ChHfOXNdRWXlMWV8mOAUl4ug1LvTNOQ0/cOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTgLq0iKHsNwbMBECIDwOEYqFryBCkTWA1TFSyUwC1RUd4FT9ZmkoZXdGYnOKdSh3Z2jv5GtJQE4nUWJRyx7c0KUEdCj8X5Hs77RcwobcCSQLY0VGMcokptCJFjcUm6hzp4rgieiHeaZrM7f093QTEptBNoeiU1vjbuedk0xrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7WNCgAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58207C4CEEB;
	Sat, 20 Sep 2025 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366304;
	bh=v7Urrw2ChHfOXNdRWXlMWV8mOAUl4ug1LvTNOQ0/cOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H7WNCgAGO25/hLEfdOOGJBaMmC3eKYbx168ykMERAYjYbf2BcbgGOzzB81A9fj51U
	 VKW2gezi5Bb7iNZxuc51ac0ZtaGq0Q6yW01st0zJt+9+H3Ll76/A8TAQtdWd8GRtkO
	 9fo1Bhi5womLse0jzcyxyHOYMG1CbhjTVwqEDTGkX6M0ihVhH+lN14V1uxFtYCbVFO
	 uadSnyV+MkgdKM2AMBV4ml5PVcEUZZ01c+U0H/yrI6Df2HLivey934M5mwtrWQGy/6
	 7IglFKopcWSGjCYKunZBgVPMuV3kHMnWGzVAmfF0EJMRU7xhrbtoZ3M4/AMeeVmHpz
	 gluisoAmsTHBg==
Date: Sat, 20 Sep 2025 12:04:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: use AD7124_MAX_CHANNELS
Message-ID: <20250920120457.0022d1f2@jic23-huawei>
In-Reply-To: <add0b8de5452d9cb293c175c60cbb71b5ccac2d0.camel@gmail.com>
References: <20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
	<add0b8de5452d9cb293c175c60cbb71b5ccac2d0.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 16:17:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-09-17 at 09:17 -0500, David Lechner wrote:
> > Use AD7124_MAX_CHANNELS macro instead of hardcoding 16 in
> > ad7124_disable_all(). We already have the macro, so we should use it.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to iio.git/testing

Thanks,

Jonathan

