Return-Path: <linux-iio+bounces-4406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD28ABC3A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BAA1F213AE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D182CCD7;
	Sat, 20 Apr 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoopK/Mi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27E28373;
	Sat, 20 Apr 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713627576; cv=none; b=b2X66G9b3eEP+TRBgG1gH5YX0Ulo4n8Gnrq416Wy5IwNWCEMMY5tIfs65oPgWoKqYmyBKX8/PYUHr/KYaVV8NKu0Ltku+cpPdPvOJNgf9Joq0a5saYiy7mqiQFULZfO803QYpfuSWqmDCa6xB/XpcQ2YMyHI+tqNoPo60qjGjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713627576; c=relaxed/simple;
	bh=i9cY9qp6/a0mcmsh3qFB586htevc7etX3YNS7yvrCd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvtMyQfUvFVg76PLYnhxT/sIvRW/mZDCg8jQJnvzTgNK+pfgwbP/k5RQFGy0zYS+giIE8UTuxi5AqaTNhxTswxBPMQux+w7jl/6DN3JI66fJqF6qbBdzDzXcCA4ws9vcONZtP1GzY8WgCaciHUXS0uYWUNWfGMQQVRaQ7cUxmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoopK/Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765FCC072AA;
	Sat, 20 Apr 2024 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713627576;
	bh=i9cY9qp6/a0mcmsh3qFB586htevc7etX3YNS7yvrCd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RoopK/Mi4T4fahlLvKZqpmYCQDwzA/PWEl9uPvfI130RXWhFoXZ5fW0pi8VR932XB
	 aHm3f3qkPn7fUVBk65/sSNT1DS7a9QApC8t+T6roUVXvrRnBozeQ7AIJcSgtjurrvy
	 Whfahws7ERSpc/WOKGmeG/jKpAP4NW1ehpp+LOItwCmA7CoAw9ltWiMITNqMzf0meF
	 DsomxnlVOD72DrR7p2bK0j0nXvDYdfFp3nk59v4AePNJS9LkYJOsd5ccNlE22y2WF9
	 BfmY7XJPzXYprZHeI1ov7RKGfkRXM9cthduHozNygOyuM1nCRY36JGpyD6QfG9vvdw
	 YEJVBNs1CNXwQ==
Date: Sat, 20 Apr 2024 16:39:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 0/8] iio: ad9467: support interface tuning
Message-ID: <20240420163926.3ae99cb1@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Apr 2024 17:36:43 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
Hi Nuno,

Friday special :)

>=20
> Here it goes one more set of new functionality for the backend
> framework. This allows for one of the most important missing features of
> the ad9467 driver. I hope the new interfaces to be fairly straight.
> Though, there's one that's likely to catch your attention:
>=20
> iio_backend_iodelay_set()
>=20
> as you would expect (rightfully) some delay with actual units. The
> reason why it does not have any units is because the IO delay thing is
> mostly a calibration done at the backend level and the actually values
> and timings (each tap corresponds to) is very HW specific. For example
> the Xilinx/AMD zedboard has different specifications when compared to
> zc706.
>=20
> Given the above, I admit (:sweat smile:) I went the easier path and just =
added a
> parameter with no meaningful unit (with proper docs). I'm definitely open
> for ideas if this fells to hacky. One thing that I thought would be to
> have any additional API that could be called during probe and get an
> array of delays from the backend. Something like:
>=20
> iio_backend_iodelays_get(back, const unsigned int **delays_ps, unsigned i=
nt *ndelays)
>=20
> The backend should know what delays it supports. For the axi-adc IP we
> do have registers to detect the fpga grade etc so we could return the
> delays based on the HW we are running on. We would also need an addition
> refclk as the actual delay each tap introduces depends on a refclk.

=46rom a userspace point of view do we care about the real values? (in units =
we understand)
Does the front end driver algorithm ever care about what they actually mean=
 either?

Feels like all these are is a sequence of magic flags that we try, the only
thing that assigns them any absolute meaning is that you assume they
are monotonic in some sense, so picking the middle value of a set in a row =
that
works makes sense.

So I'm not really that bothered about the lack of units.
Whether this interface generalizes well to other device will be interesting
to see, but if it doesn't and we come up with something better a later stag=
e,
this is all in kernel interface, so we can change it anwyay at that point.

>=20
> The series also has some "unrelated" patches for improvements and fixes.=
=20

Hmm.  Next time pull those out as a separate set and just mention
it as a dependency.

>=20
> ---
> Nuno Sa (8):
>       iio: backend: add API for interface tuning
>       iio: adc: adi-axi-adc: only error out in major version mismatch
>       dt-bindings: adc: axi-adc: add clocks property
>       iio: adc: axi-adc: make sure AXI clock is enabled
>       iio: adc: adi-axi-adc: remove regmap max register
>       iio: adc: adi-axi-adc: support digital interface calibration
>       iio: adc: ad9467: cache the sample rate
>       iio: adc: ad9467: support digital interface calibration
>=20
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   5 +
>  drivers/iio/adc/ad9467.c                           | 340 +++++++++++++++=
+++---
>  drivers/iio/adc/adi-axi-adc.c                      | 123 +++++++-
>  drivers/iio/industrialio-backend.c                 |  86 ++++++
>  include/linux/iio/backend.h                        |  57 +++-
>  5 files changed, 561 insertions(+), 50 deletions(-)
> ---
> base-commit: 62d3fb9dcc091ccdf25eb3b716e90e07e3ed861f
> change-id: 20240419-ad9467-new-features-fbfbaa5edf06
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


