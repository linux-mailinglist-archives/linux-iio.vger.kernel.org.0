Return-Path: <linux-iio+bounces-24712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E687BB8E64
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94011346C96
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37F3AC15;
	Sat,  4 Oct 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv5PJwgS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8756FC3
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586453; cv=none; b=oultaoEFOMn6EbYIpilcfg5Uz2Z1V0GLfGRHDpWfDngIE4MhnVAQqCSCdhQkd9oAu/u7i6wUpGV06rJeah4azi4GPwl/Lfomhi2FdD73HKCcYmFotlxxVOEJ8Izp6BD6FPBLAfz7P7hJ+DfDgLCH3KZ9V5vPzLkAM4jtwnDvxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586453; c=relaxed/simple;
	bh=ex7OemofVmN3ix5NKoIWxXa+7aS2QwrKKGiBdsWvKr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/+LAujXTcO2qfpIBcvaa2Diybwx6gIFrA1ukSP57P/HqPmcCoKOoOHgqT4wRwcXDQeDvyFknq86AeQuBKloLseS++OiNttB5uut4YiGGSoq3mK8UpUJcEWaO1GwJ551Q6y5KmI/bOrmtyWwzTLkz8ul6p4x92emhLFISjH65go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv5PJwgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C233C4CEF1;
	Sat,  4 Oct 2025 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759586452;
	bh=ex7OemofVmN3ix5NKoIWxXa+7aS2QwrKKGiBdsWvKr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rv5PJwgSy59hrMo4PU8M2ZdMt3xJsINuDiO8Lnks8oTNO52XOD62sIxFmuAz5lg0M
	 3jYzH9lgIUiYuUoQr5CemfDd1vrO/qoBpQ1Bh6hietXZ1OdgtswdtMQpCnUMpbIiH2
	 l7JDKi9iXvxvT46QyWyfiKLmg97UMbmhUXCD0yG5jhXnvrmfhAe7rs9S3AXKbqENFb
	 CbsQkCCumCJfhZrmm6VGC5/HLMtdYBFLvgI57aYxEZ5oauJSOuGbzb/499Tcx0qATS
	 cvDPZOoJzjM3nCysn5s9T093S4HJIDuWUBUILH9m/U0NutG4l7mEQeLONCRmwA2gXd
	 YQBzHi/J5qmkw==
Date: Sat, 4 Oct 2025 15:00:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Esteban Blanc <eblanc@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Marius
 Cristea <marius.cristea@microchip.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sal@analog.com>
Subject: Re: [PATCH 0/9] iio: replace sprintf() with sysfs_emit() in
 .read_label() op
Message-ID: <20251004150041.671ad44e@jic23-huawei>
In-Reply-To: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
References: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sep 2025 16:33:09 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> When looking at some drivers implementing the .read_label() callback it
> came to my attention that there were some outliers using sprintf() (or
> even snprintf() with PAGE_SIZE) instead of sysfs_emit(). This series
> cleans that up.=20

I hope this doesn't come back to bite us by a future in kernel consumer not
directly spitting the result of this into a sysfs read buffer.  Anyhow
today it's fine and we have existing cases doing sysfs_emit() so arguably
any future problems aren't made worse by this patch set + for common usage
it's an improvement.

So applied.

Thanks,

Jonathan

>=20
> ---
> Nuno S=C3=A1 (9):
>       iio: adc: ad4030: replace sprintf() with sysfs_emit()
>       iio: adc: ad7768-1: replace sprintf() with sysfs_emit()
>       iio: adc: mcp3564: replace sprintf() with sysfs_emit()
>       iio: adc: meson_saradc: replace sprintf() with sysfs_emit()
>       iio: adc: mt6360-adc: replace snprintf() with sysfs_emit()
>       iio: adc: pac1921: replace sprintf() with sysfs_emit()
>       iio: adc: qcom-spmi-rradc: replace snprintf() with sysfs_emit()
>       iio: position: hid-sensor-custom-intel-hinge: replace sprintf() wit=
h sysfs_emit()
>       iio: resolver: ad2s1210: replace sprintf() with sysfs_emit()
>=20
>  drivers/iio/adc/ad4030.c                           |  4 +--
>  drivers/iio/adc/ad7768-1.c                         |  2 +-
>  drivers/iio/adc/mcp3564.c                          |  2 +-
>  drivers/iio/adc/meson_saradc.c                     |  6 ++---
>  drivers/iio/adc/mt6360-adc.c                       |  2 +-
>  drivers/iio/adc/pac1921.c                          |  8 +++---
>  drivers/iio/adc/qcom-spmi-rradc.c                  |  2 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |  2 +-
>  drivers/iio/resolver/ad2s1210.c                    | 30 +++++++++++-----=
------
>  9 files changed, 29 insertions(+), 29 deletions(-)
> ---
> base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
> change-id: 20250930-dev-sprintf-cleanup-baf2c89b3460
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


