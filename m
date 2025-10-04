Return-Path: <linux-iio+bounces-24710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C7BBB8E36
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E43189F74B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5E157A6B;
	Sat,  4 Oct 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLzOLglm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300126D4DF;
	Sat,  4 Oct 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759585153; cv=none; b=ZMnpiCdev0lTlHR2R2UB1+SGe4W1kVb6TTopZXMQb0ScdsJ7yy1a3ps1d8lQ+z+a7jOGH7INbT5w/n0UyzWvjgNvESykBMF4nmYUdK/s/5Rkm3W8YED5oXKgHHWy1/KUQTv/g45ua9o8MA82BGDhBGtAUPLtGHhdDH80n4cO7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759585153; c=relaxed/simple;
	bh=QKH8jvwDOTCohnKgfPZkAXvzTAx4JhWiqc53kdURoJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1vUyMiydOD7cgXfThAZ56S0ZnN2E2gKQ8GJJvqcCc2UaWHhgVFDjkFkKqijbmju12KZ9EDcypVslt9DoX3jRcaliJGaWfvzSxuRIsRaHEK3AZZn8CtXgMBJoiGqMVjUjn32IF3DvxyYw0Mv2eDYkXHL3XTOwrkusdRquf6I4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLzOLglm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB9C4CEF1;
	Sat,  4 Oct 2025 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759585151;
	bh=QKH8jvwDOTCohnKgfPZkAXvzTAx4JhWiqc53kdURoJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bLzOLglmpEVBWVMFf+gVN+4n02n9A83GMiKTdR1ESZSgE5MtLfVy1rreNSUXb8ODQ
	 tmK1Hhxd0lJeJzWhuuLxs9XFvavXmNgkjLHmwZKbeGoZl7DUFKGEJmQ3v+yaL88cu1
	 BV1Z6LGw/STisL6vNux5tfA7mEtRTtANOmxpA7EtiJLoo8mzWEWNBkJebWRa3ZLIKe
	 1TOsgA+s210cssSW0jkJ9o07BZDwt1OKrl2/H5CJhAfrj06wB42XqTGmWbGG78PGeV
	 5sHdKnrZ3hPD+dF17Oyt6DZx7nfghPajyqipV835H0DAQ0NNxVryXe0F1NPMdwa/A1
	 0pahOwzF+BPug==
Date: Sat, 4 Oct 2025 14:39:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Message-ID: <20251004143901.505ec386@jic23-huawei>
In-Reply-To: <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  1 Oct 2025 15:23:10 +0300
Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:

> Add support for the A/D 12-Bit successive approximation converters found
> in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>=20
> Conversions can be performed in single or continuous mode. Result of the
> conversion is stored in a 16-bit data register corresponding to each
> channel.
>=20
> The conversions can be started by a software trigger, a synchronous
> trigger (from MTU or from ELC) or an asynchronous external trigger (from
> ADTRGn# pin).
>=20
> Only single mode with software trigger is supported for now.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Hi Cosmin

A few really minor comments.

I might have ignored these or tweaked whilst applying but looks
like you'll probably be doing a v4 anyway so I thought I'd mention them.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> new file mode 100644
> index 000000000000..51d1852d814d
> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc-helpers.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +
> +#define RZT2H_NAME			"rzt2h-adc"

I'm not a huge fan of defines like this as there is no inherent reason the =
two
places it is used should take the same value. If you feel it's really justi=
fied
then I don't mind too much though.

> +
> +static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return rzt2h_adc_read_single(adc, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D RZT2H_ADC_VREF_MV;
> +		*val2 =3D RZT2H_ADC_RESOLUTION;

Trivial but I'd just put the two values here and get rid of the defines.
I don't see an advantage for defines when they aren't 'magic' numbers
but are real values.

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}


