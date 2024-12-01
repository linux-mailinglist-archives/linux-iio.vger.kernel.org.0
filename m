Return-Path: <linux-iio+bounces-12920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793799DF5C5
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 14:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A2728182D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2521CCECA;
	Sun,  1 Dec 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhHDM0CJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D711CCB50
	for <linux-iio@vger.kernel.org>; Sun,  1 Dec 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733059429; cv=none; b=fYPTK19jaVO+L+NNxrdlwLZ6QDgKR5nu/gynvPAMRn9AFdI2Rh7H7XuVoaVgF4g+ut/dAu8TG+bh1GENRp/xfS4Z/66+NamlF/YsMBkds+aPtGQydU2vYzb5/3mRrEudfrYxHdQjkZJ1hNi1wT4gDT3ZwQXI+1Wk0hkJ3Y+v5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733059429; c=relaxed/simple;
	bh=N7xpxe8JWFhTEMu3h34iytTZs/wCIkRHPfZZhmZOMGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhWPeSg3DQnqEUP5m7OwL2ALnRPTIOMK4oR3BOvHr4D4hg0PiORpW0vOP8K4UEtpV8g9hlMfuncSz3L0/umP9Kk6OKoJ9L53vjVRVuzAivXNhYKViSpkxSi8TVXyWgOO/rzPNlHgXC6ZUHVWjUzAHaLkJdfbOIYFdbe6h6oG4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhHDM0CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5D1C4CECF;
	Sun,  1 Dec 2024 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733059429;
	bh=N7xpxe8JWFhTEMu3h34iytTZs/wCIkRHPfZZhmZOMGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhHDM0CJV7S4qFcketBmq93xD2qgxZG8oOzZ+YA6x5Ah3Zoc6WwYdAB4U84gODTJM
	 8WMWOCHidU6nZH3SBbFeiL+XEJ0Cj66PAqKtAl2RuUSK6RWehoh9VQD92EfqxE91g2
	 Mwr2CVfCWA+ysi1EqJ7sgg0Vk60RCEi+ff1CMndn8psPNwXeateSOrNBXRlODj5yCx
	 jlGjWyCWeg0jMJrLcOnZ0hAg05tt8E+IxJxTCWtzjw8P+Hy6dXQ8hkPfCgqBKv6kym
	 O1vDz37hG3JKloto3oK3SGHJ13Wew98oDZQdy0OzU7LmTP+MtZ7ANqhgh29I0YBLO3
	 HzFQABz8FposQ==
Date: Sun, 1 Dec 2024 13:23:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <aardelean@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad_sigma_delta: Handle CS assertion as intended in
 ad_sd_read_reg_raw()
Message-ID: <20241201132343.3878d7a5@jic23-huawei>
In-Reply-To: <f4cb05ec-6b94-4c63-bf42-2fbd40dfd532@baylibre.com>
References: <20241119183611.56820-2-u.kleine-koenig@baylibre.com>
	<f4cb05ec-6b94-4c63-bf42-2fbd40dfd532@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Nov 2024 14:09:45 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2024-11-19 13:36, Uwe Kleine-K=C3=B6nig wrote:
> > When struct ad_sigma_delta::keep_cs_asserted was introduced only
> > register writing was adapted to honor this new flag. Also respect it
> > when reading a register.
> >
> > Fixes: df1d80aee963 ("iio: ad_sigma_delta: Properly handle SPI bus lock=
ing vs CS assertion")
> > Signed-off-by: Uwe Kleine-K=C3=B6nig<u.kleine-koenig@baylibre.com> =20
> Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

Hi Uwe,

Thanks for all these cleanups.  Trivial request for future though.
If like this time the maintainer is being slow / busy and take a while
to come back so you roll up multiple fixes into a new series that's fine.
However, please just drop a quick reply on the original threads to make
it easier to notice that! Only needed if all the feedback like here has
been positive and the patch might get picked up directly from the wrong
version.

Thanks,

Jonathan

