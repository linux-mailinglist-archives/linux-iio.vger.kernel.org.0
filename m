Return-Path: <linux-iio+bounces-8475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE595222A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B3B280FB7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 18:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A41B9B4D;
	Wed, 14 Aug 2024 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2QrOO5+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF738374FA;
	Wed, 14 Aug 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661207; cv=none; b=EQb2g+cLdIIPjC3Zlhi8yW2CvS+P8OYw8/bcISc2GBV7dkGjOoCHfkQd5Z4tk1Y8T0+u92WBuBRCJHfXtt0H7CmK1Z2XfDmz849ezqKI6sllcmTwV+savcLrqiIw066MTEiP28gcSGx6/mTetLI9HulLT++N+aZfYX5jqbAYeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661207; c=relaxed/simple;
	bh=Ve6qEbUDhSkkvpyPc07VYItMJCbBhMvu6CfuLrszOk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGJ+VfLQo5o9kKWGevwvto6m5xF9sLHTWVJ6VCGz4VjZ1KV0tGnX23SjFPr9MPpqE3XLy+/dt3RgYDxrwQklHJX7ZkQnkVnsKqx+Bc5b/xfJodvwqF0K08V0y1tVC9bASQIokahhmXZ7zmq/5Xwo9zt2kTK02TJvtbQ4WufezyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2QrOO5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316E1C116B1;
	Wed, 14 Aug 2024 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661205;
	bh=Ve6qEbUDhSkkvpyPc07VYItMJCbBhMvu6CfuLrszOk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2QrOO5+s6/HTaBE3NQsT8fUAHWNGRBNK5wsfLBtjQYe5Gp6B9JNXe6T5MgcVOXtn
	 nA0QfwbQwuITNychY7ANsVokY7XOA6Fg5fPD9wgX/Hvqh2sU6P48s5oVMi2fXhVBqu
	 DAo2l3evOXPqWqzHaHcvDPZH/inxP43eq4A02kiKPFGN8TY0Ysh9nLNjfzVG2cAQxb
	 5HOJoBldUD78P5+SukNAYrTXckqi/y7mIuBSms0pA5sdMzxbdQ4Nxg36l4ztSHqZfP
	 7GbkAYnzneo5TH/wFQqg+1e1e6dpzClR+YEEEFJtKMfv2XRIOrEOE6kS00732QLaxH
	 kiE7xK6UvavzA==
Date: Wed, 14 Aug 2024 19:46:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Heiko Stuebner
 <heiko@sntech.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Francesco Dolcini
 <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZl?=
 =?UTF-8?B?cw==?= <jpaulo.silvagoncalves@gmail.com>, Haibo Chen
 <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/23] iio: make masklength __private (final round)
Message-ID: <20240814194635.439a9dd9@jic23-huawei>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jul 2024 10:22:52 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
>=20
> Here it goes the final conversion round.  On the testing branch a git
> grep:
>=20
> git grep "\->masklength"
>=20
> Gives no more users so hopefully I did it right :).
>=20
> Not entirely related with this but I'll mention it anyways :). Looking
> at the other [INTERN] fields, I see:
>=20
> * active_scan_mask: which seems to be pretty similar to masklength;
> * scan_timestamp: Has some apparently valid  users;
> * scan_bytes: Also has a few users;
> * trig: may need a bit more inspection.
>=20
> The first 3 look like valid RO fields that drivers are allowed to
> access. I mean, for scan_bytes I guess drivers could calculate that
> based on the active_scan_mask but I think that's just not worth it given
> the core already did it for us.
> =20
> So I wonder if a similar work would be valuable? scan_timestamp and
> scan_bytes would be pretty trivial but for active_scan_mask we do have
> lots of users (but also trivial I think).
>=20
> For Trig, most of the writes are drivers doing
>=20
> indio_dev->trig =3D iio_trigger_get(data->trig);
>=20
> So we either assume it's public or remove that line from drivers. Though
> that could break userland apps relying on some trigger to be
> automatically set after device probe. We can anyways have another helper
> to do that for drivers (not sure this field is accessed in some
> fastpath).
>=20
> Also need to better check if there are any readers for it.
>=20
> Anyways, it would be nice to get your inputs on the last [INTERNAL] fields
> in struct iio_dev
>=20
> Also want to mention that I deliberately removed some mailing lists
> given by get_maintainers as this is fairly simple and so I don't think
> the "spam" is worth it :).=20
I applied these about 10 days ago but for some reason didn't say that!

So these are applied if anyone was wondering.

Jonathan

>=20
> ---
> Nuno Sa (23):
>       iio: accel: adxl380: make use of iio_get_masklength()
>       iio: adc: max1118: make use of iio_for_each_active_channel()
>       iio: adc: max1118: make use of iio_for_each_active_channel()
>       iio: adc: mcp3911: make use of iio_for_each_active_channel()
>       iio: adc: mt6360-adc: make use of iio_for_each_active_channel()
>       iio: adc: rockchip_saradc: make use of iio_for_each_active_channel()
>       iio: adc: rtq6056: make use of iio_for_each_active_channel()
>       iio: adc: stm32-adc: make use of iio_get_masklength()
>       iio: adc: stm32-dfsdm-adc: make use of iio_get_masklength()
>       iio: adc: ti-adc0832: make use of iio_for_each_active_channel()
>       iio: adc: ti-adc084s021: make use of iio_for_each_active_channel()
>       iio: adc: ti-ads1015: make use of iio_get_masklength()
>       iio: adc: ti-ads1119: make use of iio_get_masklength()
>       iio: adc: ti-ads1298: make use of iio_for_each_active_channel()
>       iio: adc: ti-adc12138: make use of iio_for_each_active_channel()
>       iio: adc: ti-ads124s08: make use of iio_for_each_active_channel()
>       iio: adc: ti-ads131e08: make use of iio_for_each_active_channel()
>       iio: adc: ti-ads8688: make use of iio_for_each_active_channel()
>       iio: adc: vf610_adc: make use of iio_get_masklength()
>       iio: adc: xilinx-xadc-core: use new '.masklength' accessors
>       iio: common: cros_ec_sensors_core: use new '.masklength' accessors
>       staging: iio: impedance-analyzer: ad5933: make use of iio_get_maskl=
ength()
>       iio: core: annotate masklength as __private
>=20
>  drivers/iio/accel/adxl380.c                               | 2 +-
>  drivers/iio/adc/ina2xx-adc.c                              | 3 +--
>  drivers/iio/adc/max1118.c                                 | 3 +--
>  drivers/iio/adc/mcp3911.c                                 | 2 +-
>  drivers/iio/adc/mt6360-adc.c                              | 2 +-
>  drivers/iio/adc/rockchip_saradc.c                         | 2 +-
>  drivers/iio/adc/rtq6056.c                                 | 2 +-
>  drivers/iio/adc/stm32-adc.c                               | 4 ++--
>  drivers/iio/adc/stm32-dfsdm-adc.c                         | 2 +-
>  drivers/iio/adc/ti-adc0832.c                              | 3 +--
>  drivers/iio/adc/ti-adc084s021.c                           | 3 +--
>  drivers/iio/adc/ti-adc12138.c                             | 3 +--
>  drivers/iio/adc/ti-ads1015.c                              | 2 +-
>  drivers/iio/adc/ti-ads1119.c                              | 4 ++--
>  drivers/iio/adc/ti-ads124s08.c                            | 3 +--
>  drivers/iio/adc/ti-ads1298.c                              | 3 +--
>  drivers/iio/adc/ti-ads131e08.c                            | 2 +-
>  drivers/iio/adc/ti-ads8688.c                              | 4 +---
>  drivers/iio/adc/vf610_adc.c                               | 2 +-
>  drivers/iio/adc/xilinx-xadc-core.c                        | 5 ++---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 8 +++-----
>  drivers/iio/industrialio-buffer.c                         | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c           | 5 +++--
>  include/linux/iio/iio.h                                   | 4 ++--
>  24 files changed, 32 insertions(+), 43 deletions(-)
> ---
> base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
> change-id: 20240724-dev-iio-masklength-private3-7a2d819acc7d
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


