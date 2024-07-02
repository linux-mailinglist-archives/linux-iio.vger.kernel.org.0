Return-Path: <linux-iio+bounces-7184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB2992492B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441F02861F3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4327200134;
	Tue,  2 Jul 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak6KZbWu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7620012D;
	Tue,  2 Jul 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952023; cv=none; b=nfKxj4JPFNZfJ65efSQSEJaK4ggasAaeYWH0Cs8Dqqz9gPFfhCFiV7W8Uqs+gZf/Q6mnjU3NeiMR6xmzKDUcBHs2eXdQCVjkJzN7Awd4Ja1smhTv9aDq67ZJLN4DTv/9PDvO/TYtdqxU3gLeamP3rxbrISmTCbZpPwD/dJ6WmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952023; c=relaxed/simple;
	bh=nF/PnJ5EIPXBvRO4ymcAN7JcsPqkG/eJprinQAl55UY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfFvYm/RxcX+vCDIaDAMCQoB9SA4QAW3GZ2t7oxuMBRaU+SH61xgSM8iGy7FFfEEuwbFt7J020cywegOyV1wORpoZdH+PY3meWYDfu4V+k+1Ys/WPpKqOlDJBVbuJKt3AMC05BFmDW9Y6f/AFonJ1r56r3ZOx9y316VjlprW5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak6KZbWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9A6C116B1;
	Tue,  2 Jul 2024 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719952023;
	bh=nF/PnJ5EIPXBvRO4ymcAN7JcsPqkG/eJprinQAl55UY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ak6KZbWu5lqAkYYbcK3UEhYW7N1CXXt0z463CwO1OHkEONP+cnrzgQm1SRFtkZI9L
	 va8SrvUISnnRogDPZszkTXeYrY2fmCN/YCni+DePz3JAs7tZsX9/PJKrgg9Rx3zd5F
	 W6Ejq41Q50BfX3XAMTyKmj2g2OBS3rGVUDy4pMAAFK13E4F5zqR/ngcGS2rQVvFjDS
	 b9wLAq0L90i7rmlL/AK/JIfaVmUPWdw1pvs9FKHGE80IzfUs+gHiK2PyOydpZxz2h8
	 AD4Q5//RwrGHRIW1IQcQ/Rpp919Cpbi0scumdLYyagCLg0ND1D8PZTXZmu71VsNeKg
	 3Sf9szujvmtsw==
Date: Tue, 2 Jul 2024 21:26:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 00/20] iio: make masklength __private (round 1)
Message-ID: <20240702212652.01241fc2@jic23-huawei>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Jul 2024 18:02:32 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
>=20
> Here it goes the first round of what we discussed in [1] about
> annotating .masklength as __private. Patches should be fairly simple so
> hopefully I did not messed up much...
>=20
> Note that in core, there's one place where we're still directly writing
> into .masklength (when it's effectively set). The plan is then to
> directly use ACCESS_PRIVATE() in there in the same patch where we mark
> .masklength as __private.

Makes sense. Series looks good to me, but I'll not pick it up just yet.
I've tagged a like second 6.11 pull request, so this is probably 6.12 mater=
ial
unless things go particularly smoothly and Greg takes an additional last
minute one as there is one set waiting for a fix that is in char-misc
but not yet iio-togreg.

Jonathan

>=20
> Note this was only compile tested for arm with allyesconfig.
>=20
> [1]: https://lore.kernel.org/linux-iio/20240612-dev-iio-scan-private-v1-0=
-7c75c8e3d30b@analog.com/
>=20
> ---
> Nuno Sa (20):
>       iio: core: add accessors  'masklength'
>       iio: core: make use of iio_get_masklength()
>       iio: buffer: make use of iio_get_masklength()
>       iio: accel: adxl367: make use of iio_get_masklength()
>       iio: accel: adx1372: make use of iio_get_masklength()
>       iio: accel: bma180: make use of iio_for_each_active_channel()
>       iio: accel: bmc150-accel-core: make use of iio_for_each_active_chan=
nel()
>       iio: accel: cros_ec_accel_legacy: make use of iio_get_masklength()
>       iio: accel: fxls8962af-core: make use of iio_for_each_active_channe=
l()
>       iio: accel: msa311: make use of iio_for_each_active_channel()
>       iio: accel: sca3300: make use of iio_for_each_active_channel()
>       iio: accel: stk8312: make use of iio_for_each_active_channel()
>       iio: accel: stk8ba50: make use of iio_for_each_active_channel()
>       iio: adc: ad7266: make use of iio_get_masklength()
>       iio: adc: ad7298: make use of iio_get_masklength()
>       iio: adc: ad799x: make use of iio_get_masklength()
>       iio: adc: ad_sigma_delta: use new '.masklength' accessors
>       iio: adc: at91_adc: make use of iio_for_each_active_channel()
>       iio: imu: adis16475: make use of iio_for_each_active_channel()
>       iio: imu: adis16480: make use of iio_for_each_active_channel()
>=20
>  drivers/iio/accel/adxl367.c                   |  2 +-
>  drivers/iio/accel/adxl372.c                   |  2 +-
>  drivers/iio/accel/bma180.c                    |  3 +-
>  drivers/iio/accel/bmc150-accel-core.c         |  3 +-
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
>  drivers/iio/accel/fxls8962af-core.c           |  3 +-
>  drivers/iio/accel/msa311.c                    |  3 +-
>  drivers/iio/accel/sca3300.c                   |  3 +-
>  drivers/iio/accel/stk8312.c                   |  3 +-
>  drivers/iio/accel/stk8ba50.c                  |  3 +-
>  drivers/iio/adc/ad7266.c                      |  3 +-
>  drivers/iio/adc/ad7298.c                      |  3 +-
>  drivers/iio/adc/ad799x.c                      |  3 +-
>  drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
>  drivers/iio/adc/at91_adc.c                    |  4 +--
>  drivers/iio/buffer/industrialio-buffer-cb.c   |  2 +-
>  drivers/iio/buffer/industrialio-hw-consumer.c |  4 +--
>  drivers/iio/imu/adis16475.c                   |  3 +-
>  drivers/iio/imu/adis16480.c                   |  2 +-
>  drivers/iio/industrialio-buffer.c             | 50 ++++++++++++---------=
------
>  drivers/iio/industrialio-core.c               |  2 +-
>  include/linux/iio/iio.h                       | 18 ++++++++++
>  22 files changed, 67 insertions(+), 60 deletions(-)
> ---
> base-commit: 21ab030b8f8b4704c299435e167824ec90c8bab5
> change-id: 20240617-dev-iio-masklength-private-023cb295a786
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


