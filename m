Return-Path: <linux-iio+bounces-16996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB0A65D7B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1007AFB85
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422B79E1;
	Mon, 17 Mar 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvE4JTyL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767A20328
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238038; cv=none; b=BFGr3qOr2gxSyGQo5QPKCW8iiOLa/e+MdWmgRazAIJNmujs6Ly+8w613oA0hcky55SZKJn37uNTJ2utvqo/K6aNOmm/8E53UYLxS0v2G1HLZMApAKRQsitsxx3Pw0tu4+Ag46TTzYCvFFRYcNu7mRekIphPdWC7GtSVlu3vM2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238038; c=relaxed/simple;
	bh=GQZvu+RXZVqKbcpb+bCETaxlbGMMYK7+l0GV2T+p96E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3HR5KjiLx6/NFVaTocteEZASZucr/rv89OkT747HFWLHWJA2az5sgVbtRUOtKmiPIwwax3qWpA2CIbuG24+l83BFM2xumW8xHP400O85CYy6ZgN0J2bhh3UOkL2t0N8r5bNuxNIrxFpcOJD0MioRSWrtqnj9JBcFBuxImbLHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvE4JTyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA192C4CEE3;
	Mon, 17 Mar 2025 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742238038;
	bh=GQZvu+RXZVqKbcpb+bCETaxlbGMMYK7+l0GV2T+p96E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tvE4JTyLjdw7QclloI7YspUlTEGLqvwciDtgJafNLHMrEruhyXaDz51VMuQGehkZP
	 a2vkYv+keAVtFGrSNYnjJ3YBxa21quZBc22WCPsgWfWktJ6VVWuapA1ZoYC1tPj1ic
	 R8C1HQ+Ujv3NkwRJAGyzdmyvT96paEJBwNQ6STYX5Lx/AMUTdUledlyiL97+mGzINy
	 K4m9JszFKDXMC+kVTvtFVdKPvWtHa2u+CNih5v9DU2GDocWIcEdiVz3tnhJ5/ispyx
	 cqSWKXkSx0Ap3KR5nuv8IsU5izPXyoAHijm7/ZvZrLhfmBEUwOJ8NAtoTziq3d9r4/
	 nJQdsdOxsfndQ==
Date: Mon, 17 Mar 2025 19:00:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adc: ad7124: Fix 3dB filter frequency
 reading
Message-ID: <20250317190031.22c822c4@jic23-huawei>
In-Reply-To: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Mar 2025 12:52:46 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> (implicit) v1 of this patch set is available at
> https://lore.kernel.org/linux-iio/cover.1741801853.git.u.kleine-koenig@ba=
ylibre.com
> .
>=20
> Changes since then:
>=20
>  - Reorder patches to have the cleanup ("Make register naming
>    consistent") last
>  - Drop write support for the filter_low_pass_3db_frequency property
>    which is completely broken.
>  - trivially rebase to todays iio/togreg
>=20
> I wonder if there is a way to remove the writable permission of the
> filter_low_pass_3db_frequency sysfs file instead of erroring out when a
> value is written. Hints welcome.

Unfortunately not. With a lot of hindsight that is a flaw in the way
we generate sysfs attributes. IIRC when hwmon added similar they
avoided that trap.  To retrofit it onto IIO now we'd have to have
some form of complex permissions query or duplicate all the masks
to allow r and w separately.

Jonathan


>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (3):
>   iio: adc: ad7124: Fix 3dB filter frequency reading
>   iio: adc: ad7124: Remove ability to write
>     filter_low_pass_3db_frequency
>   iio: adc: ad7124: Make register naming consistent
>=20
>  drivers/iio/adc/ad7124.c | 208 ++++++++++++++++-----------------------
>  1 file changed, 84 insertions(+), 124 deletions(-)
>=20
>=20
> base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc


