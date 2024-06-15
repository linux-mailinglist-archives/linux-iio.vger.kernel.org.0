Return-Path: <linux-iio+bounces-6284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84CD9097B2
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8802E1F220C6
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2C37165;
	Sat, 15 Jun 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbaUoTea"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713D3A8D2;
	Sat, 15 Jun 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448057; cv=none; b=REwBjMzAroqZSD+9XmeMhOuu5VUm5EGp1O1F2msqSE6j4erVUcwj8xAhX0WpDg8GCkp1axaGnwngGmxPdcNziKu3YJnepSL1QVlnQ5JzCg1Jsv/x1+/PDNlDCx3J2qqAIkjqkzN0PswxrTbFZLhNdGOSxAxr2FAV7WG9x04FPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448057; c=relaxed/simple;
	bh=5/hYyJIIEoZXTpXMYw2yQWyZ2erfhzbU4WNhDN09KFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKDjKcSWQjIRJyifQNruQnLfbsKHbwllMAOTzWkRM7foPE3ObhQmM+HqRFCLx09gb1LuN5mdmEt4qS1xSuTY58IoLruu4MKvfZfYrBusHjr5SDf9xPx3FjPUMseKVvdfdExml3pCqUpcrj6au7iKysw+vZJiA8yu11WAwhgO4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbaUoTea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C61C116B1;
	Sat, 15 Jun 2024 10:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718448057;
	bh=5/hYyJIIEoZXTpXMYw2yQWyZ2erfhzbU4WNhDN09KFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hbaUoTeajKyPRJhHUWwdL01CrSb9aL4oZ+w7KoHSQNiqkT8FaJpvRdxLlhdLnmd52
	 jQl38J5YLPJos+vd8qTq/mrl6+pK6i7a6A13ToDdrseOiZ7s9sLddbGmtcCFjz5tqw
	 5IGF93OuZk/Y101GWwwjBukafhs3nghzcJ8DGA1OLMJEjjbpuuuODCmSybDeSzPGgm
	 Lrwsf23rQC5Qwt570mrMz+pxpe+KwDi/KRX/kMpcbqWxmMtX6I1bDqNopSyizGA1zZ
	 0m7lLg2qp+a9fHLlTiqddrozH1mRByHCHZNTB9kGPncnIeGW7JVJodnv8+u3UaXhsk
	 4Bt5d1hP1QU0Q==
Date: Sat, 15 Jun 2024 11:40:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: adi-axi-adc: improve probe() error messaging
Message-ID: <20240615114050.46d2b0a7@jic23-huawei>
In-Reply-To: <964821b3-dcbb-42b8-9062-2366a4d30a76@baylibre.com>
References: <20240613163407.2147884-1-tgamblin@baylibre.com>
	<57d4659a5abb63d7c085865059b9d71c40371edd.camel@gmail.com>
	<964821b3-dcbb-42b8-9062-2366a4d30a76@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 15:18:12 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2024-06-14 5:11 a.m., Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-13 at 12:34 -0400, Trevor Gamblin wrote: =20
> >> The current error handling for calls such as devm_clk_get_enabled() in
> >> the adi-axi-adc probe() function means that, if a property such as
> >> 'clocks' (for example) is not present in the devicetree when booting a
> >> kernel with the driver enabled, the resulting error message will be
> >> vague, e.g.:
> >> =20
> >>> adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed wi=
th error -2 =20
> >> Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
> >> devm_iio_backend_register() checks to use dev_err_probe() with some
> >> context for easier debugging.
> >>
> >> After the fix:
> >> =20
> >>> adi_axi_adc 44a00000.backend: error -ENOENT: failed to get clock
> >>> adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed wi=
th error -2 =20
> >> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> >> --- =20
> > Somehow feel that in these cases the error log should come from the fun=
ctions we're
> > calling but bah... likely not going happen/change:
> >
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >
> > (As a suggestion, you may do similar work in the axi-dac driver) =20
>=20
> Thanks. I'll send that early next week after a quick test on a board.
I tweaked the commit text to say
After the change:
as I don't want to see this picked up by a bot for stable.

As a side note, you could have taken the opportunity to add
struct device *dev =3D pdev->dev;
which I think would have reduced a few line lengths without loosing
readability.  Not important though and perhaps not even a good idea :)

Applied to the togreg branch of iio.git and pushed out as testing.
Note I plan to rebase my tree shortly to avoid some merge conflicts
that otherwise occur.  I'll probably do that before I push out
other than as testing.

Thanks,

Jonathan

>=20
> Trevor
>=20
> >
> > - Nuno S=C3=A1
> >
> > =20
>=20


