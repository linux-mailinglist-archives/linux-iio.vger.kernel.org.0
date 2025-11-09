Return-Path: <linux-iio+bounces-26109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F6C4447F
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BDB18896AD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448D3064A1;
	Sun,  9 Nov 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMg8OIHE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCE305E3A;
	Sun,  9 Nov 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708958; cv=none; b=lq8fBSR3uITXAsuCGIJGQnefgNgLiahzyGEN1y3FOUFrggY9/P0hwmHQj2AJ0zCSl44JaQzJBiWNSIrTQhYdA5Di6RKZ1j8qROZFyJkrDCBg08MEpJoH04UEg2cCKpkze4NRDDrACaPm/ZfGxsqL5YGvgXPaHqNeGNZKB8yAAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708958; c=relaxed/simple;
	bh=A5s0fFD+mU9Sqbg0aCjZQdmRQywvhDPbuhdhAqZW0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOuOrbKZWDDmlsbWSVUP9tJu4KHq1sRdFvktR8vFRCqKXf52vR17/Np95RViC2pHjoYJ43x/ryvOjalfGNxEh3pTGaiPPT1MCQ8/ll47QtRDXx11oGZ6dVhMmsQwsYDxpxHAInYueKEY6XJ2PQ4C2mRoOANybkhxAxEL/mma7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMg8OIHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE4C19422;
	Sun,  9 Nov 2025 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708958;
	bh=A5s0fFD+mU9Sqbg0aCjZQdmRQywvhDPbuhdhAqZW0M8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMg8OIHETRfRJCqRrZM7s3ady71xhe51nE75ZWQrOFvzgUH/yaUvNclveAa1wFTlc
	 iv+0A577qnkCjH9N0OVOuGK9OGGyteBUYG2VApiBQSN/2VDxek0sI5rjZ2OTWz/deA
	 U551xsJvzhm27drDNsSERlw3FhrCNtzTB2ljMZudj9Klisg956gwKYwXKiiyCcnzqn
	 Cqn4pZd1zXnAMX90h0WCTJMjGUSGzy/5xcv/Cf0BHcu00xXe0f9ZGaQM26PxwkDpQH
	 cJZm3Q5IHu4EOdZbaGg0eVOq0FhGT+NDApHNsxljG32NKLsKoAsAVMbbtXJmRBkBGU
	 1qygTj7+NcX/Q==
Date: Sun, 9 Nov 2025 17:22:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: amplifiers: adl8113: add driver support
Message-ID: <20251109172213.69d35297@jic23-huawei>
In-Reply-To: <20251108174357.3748-3-antoniu.miclaus@analog.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
	<20251108174357.3748-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 17:43:53 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

I think we need to come up with an innovative solution for the "mode".
I'm not sure what it is yet though so very much looking for some discussion.

thanks,

Jonathan

> diff --git a/drivers/iio/amplifiers/adl8113.c b/drivers/iio/amplifiers/adl8113.c
> new file mode 100644
> index 000000000000..8c234f0a1b6a
> --- /dev/null
> +++ b/drivers/iio/amplifiers/adl8113.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADL8113 Low Noise Amplifier with integrated bypass switches
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Not sure if this file is being used.  It is rare to see it needed in a modern drive.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>

> +
> +static int adl8113_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adl8113_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		switch (st->current_mode) {
> +		case ADL8113_INTERNAL_AMPLIFIER:
> +			*val = 14;
> +			*val2 = 0;
> +			ret = IIO_VAL_INT_PLUS_MICRO_DB;
return ...

> +			break;
> +		case ADL8113_INTERNAL_BYPASS:
> +			*val = 0;
> +			*val2 = 0;
gain of bypass = 1.0 rather than 0.0 which is open circuit gain.

> +			ret = IIO_VAL_INT_PLUS_MICRO_DB;
return IIO_VAL_INT...

> +			break;
> +		case ADL8113_EXTERNAL_BYPASS_A:
> +		case ADL8113_EXTERNAL_BYPASS_B:
> +		default:
> +			ret = -EINVAL;
return -EINVAL;

Early returns save a line of code here and I general think make
for much more readable code.

> +		}
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}


