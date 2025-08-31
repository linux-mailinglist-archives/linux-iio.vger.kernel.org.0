Return-Path: <linux-iio+bounces-23544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F0B3D437
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5503B1052
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DDC1A8412;
	Sun, 31 Aug 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMC+vjQO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4046148830
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756655266; cv=none; b=KpF//9Xx7x3MTEQ88odwU0G+pbZXZ5J3dze28E7hf1amgFwyizNis3t1QdVYKrv0gISoe5qZJZjZzFu6DnPi3q2E6FJOUTGzWFHH5E3aj3HCZWa91w2uyFG95xInEuAiHAaZ26EqHrDJr3s7asRjGorvvbnSBOCBthw8kSMK4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756655266; c=relaxed/simple;
	bh=YzG+/qbsocM0904WNAYE40FeEyaZBbz3adihEW+MQ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJushinucCjnazNQ2Yt+IFonJZ6ipkujUBnVOiYXioIMcwPLS3He0HPCyhD55qfGBMbQDILtDidFUAn2aKw97sW1vC8h6rGNPpU8nwo4rxECLxvo0FEfAs+BwJfoPhflRAZKLRB82//P9LpxJS+76RAqSY5J9R0Ed7A2akY7dok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMC+vjQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3386C4CEED;
	Sun, 31 Aug 2025 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756655266;
	bh=YzG+/qbsocM0904WNAYE40FeEyaZBbz3adihEW+MQ5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMC+vjQOV6q9GtDXJ+dB6n9BYIVeH+gKZCIeWRlTM/s9hRJK6uS9sNpgXcaFaz04P
	 Rb3fxRaSBkW9BTwQAKDTS1PvJJV6vu/4cDkagIchL0kn+3YpyZfYulh8BdG1Tag4+6
	 1kAq1KxrF4ikRlS33V3xRVwf+mQc6+AxRyhASxaxNtymFWvAc5JJ3U1q5NPWkxHPKN
	 n7GSORhnuxbXEGpeGKjjF+WBmoviLK5GgDpjEc0+e/iYk0LwFDLgWBi2NKvKcOg7m3
	 8DxS4mEHXN/CfYomAriP0MN5DbtCTn0xBsOwF4+mzvEKjCxQHENQWVRgrFURbrIy2c
	 dpcEFLeuI+ezQ==
Date: Sun, 31 Aug 2025 16:47:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/2] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <20250831164738.28fad39e@jic23-huawei>
In-Reply-To: <CAHp75Vd-_iDZw70+T9uSQm96d=+-puPOihGt+9TLsamW5bkWvA@mail.gmail.com>
References: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com>
	<20250829-adf4350-fix-v2-1-0bf543ba797d@analog.com>
	<CAHp75Vd-_iDZw70+T9uSQm96d=+-puPOihGt+9TLsamW5bkWvA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 10:58:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 29, 2025 at 2:25=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or =
8/9.
> > When set to 4/5, the maximum RF frequency allowed is 3 GHz.
> > Therefore, when operating the ADF4351 above 3 GHz, this must be set to =
8/9.
> > In this context not the RF output frequency is meant
> > - it's the VCO frequency.
> >
> > Therefore move the prescaler selection after we derived the VCO frequen=
cy
> > from the desired RF output frequency.
> >
> > This BUG may have caused PLL lock instabilities when operating the VCO =
at
> > the very high range close to 4.4 GHz.
> >
> > Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF=
4350/ADF4351 Wideband Synthesizers")
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >
> > ---
> > v2:
> >  * Added fixes tag;
> >  * Added TODO (suggested by Andy). =20
>=20
> Thanks, this is a compromise I can agree with.
> Reviewed-by: Andy Shevchenko <andy@kernel,org>
>=20
Fixed up email address and series applied to the fixes-togreg branch of iio=
.git.



