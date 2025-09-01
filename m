Return-Path: <linux-iio+bounces-23618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2856B3EEF8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFDD1A85B36
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E3338F5F;
	Mon,  1 Sep 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZHVfA25"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9126CE03
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756256; cv=none; b=r7Bnt8xyoLfWkDG32a71SMOL7YZMGev+6D3S1dwAqRaobBz4/OBpnoZPWm+5G14FJWxbdKgDiHyU6gYFEDqrgAccniT+7N9BsNMWiyvhnuEBbCUKW3+XhZR0Lum5s6n/qB4hwfqp7NZqxuOlaoRd/nwizEwO5ClrimlT483EjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756256; c=relaxed/simple;
	bh=sVXBCvbJ+5d/Tx3/IPS1Z+52AQmUroegtMT2x9MGWUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElYu17YiOc418CIrlF5rLL750sl3PzR+OF8CtXVO8j+W5s3Ap/g6sI0xzwdn6duP0REqYabf8FzTir5cjXqzoHeKPwLriVLyVAN9+zv+Efcpy7TcLnmzuVrpN7L9k7SSwsG7+rm+htKNNBL0tKJOyFOBpmCFV6VbxTLHE13ZKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZHVfA25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC81FC4CEF0;
	Mon,  1 Sep 2025 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756254;
	bh=sVXBCvbJ+5d/Tx3/IPS1Z+52AQmUroegtMT2x9MGWUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZHVfA25yIBzUYs5ExaSOLYqq9bbRaK3mwXfLVY8aa15lx6Wz8gV5hBs4pD+27T3x
	 +26qocl55egAVmtFip0+D96aGWT3StE+cq2RSrbYo6pHj8vS/wJbC1PZJvCCZ3qehj
	 HqakC0h6VOmhOe7cY1xD54L6YmIbX/uS8H0FvusGlz4qUz7f1EaKBz8oF8z7CA8Cbf
	 yr4Oj/We79DnaWig7TiKgkZMDpO/t6f7cOrFnOGzbwoV2AqwkXHV9yxOMNo0mNUKo5
	 wHjwRo8pI5A7seSl6Qcj9+/osB4MLcw55nhQZhzAvyXsv36UfR8O3psjwDDP9/aUcK
	 FUQpKXKgdbJ9Q==
Date: Mon, 1 Sep 2025 20:50:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, Liam Beguin
 <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 0/6] iio: processed channel handling fixes + Intel
 Dollar Cove TI PMIC ADC driver
Message-ID: <20250901205046.022ea9ef@jic23-huawei>
In-Reply-To: <20250831104825.15097-1-hansg@kernel.org>
References: <20250831104825.15097-1-hansg@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 12:48:19 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Hi All,
>=20
> Here is v5 of my patch-set to add an IIO driver for the Intel Dollar Cove
> TI PMIC ADC. This has turned more into a series with fixes / changes
> to iio_convert_raw_to_processed() and iio_read_channel_processed_scale(),
> with the new driver tagged on as the last patch :)

So, rather than risk the actual driver getting delayed I've picked the whole
lot up on my togreg branch. We can backport the fixes next cycle.
For now pushed out as testing to give 0-day a first look.

Jonathan

>=20
> Changes in v5:
> - Do not put case foo: val =3D x; break; statements on a single line
> - Use IIO_UNIT_TEST module-namespace for iio_multiply_value()
> - iio_read_channel_processed_scale(): Use pval + pval2 local variables for
>   better readability
> - Consistenly use s / ms / =C5=B3s for seconds in comments
> - Various other small (comment) style fixups
> - Add Andy's Reviewed-by to all patches
>=20
> Changes in v4:
> - 2 new bug-fixes for iio_convert_raw_to_processed()
> - Factor the bugfixed code multiply a s64 and an iio (type, val, val2)
>   triplet out of iio_convert_raw_to_processed() into a new
>   iio_multiply_value() helper
> - Add a KUnit test for iio_multiply_value()
> - Redo the "Improve iio_read_channel_processed_scale() precision"
>   patch using the iio_multiply_value() helper
>=20
> Changes in v3:
> - "iio: Improve iio_read_channel_processed_scale() precision"
>   - Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
>   - Directly return IIO_VAL_INT from valid cases and drop the final
>     return ret after the switch-case
> - "iio: adc: Add Intel Dollar Cove TI PMIC ADC driver"
>   - Use new more compact DC_TI_ADC_DATA_REG_CH(x) macro
>   - Use regmap_set_bits() regmap_clear_bits() where applicable
>   - Use regmap_bulk_read() + be16_to_cpu() to read ADC value
>   - Use sign_extend32() for vbat_zse and vbat_ge reading in probe()
>=20
> Changes in v2:
> - Add new "iio: Improve iio_read_channel_processed_scale() precision"
>   patch to the series
> - Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
> - Add IIO_CHAN_INFO_PROCESSED which applies calibration and
>   scaling for the VBat channel
> - Address some other small review remarks
>=20
> Regards,
>=20
> Hans
>=20
>=20
> Hans de Goede (6):
>   iio: consumers: Fix handling of negative channel scale in
>     iio_convert_raw_to_processed()
>   iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
>   iio: consumers: Add an iio_multiply_value() helper function
>   iio: Improve iio_read_channel_processed_scale() precision
>   iio: test: Add KUnit tests for iio_multiply_value()
>   iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
>=20
>  drivers/iio/adc/Kconfig              |  11 +
>  drivers/iio/adc/Makefile             |   1 +
>  drivers/iio/adc/intel_dc_ti_adc.c    | 328 +++++++++++++++++++++++++++
>  drivers/iio/inkern.c                 |  81 ++++---
>  drivers/iio/test/Kconfig             |  12 +
>  drivers/iio/test/Makefile            |   1 +
>  drivers/iio/test/iio-test-multiply.c | 212 +++++++++++++++++
>  include/linux/iio/consumer.h         |  18 ++
>  8 files changed, 629 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
>  create mode 100644 drivers/iio/test/iio-test-multiply.c
>=20


