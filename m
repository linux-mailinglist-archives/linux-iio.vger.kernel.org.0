Return-Path: <linux-iio+bounces-26259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE4C61799
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2BD4E7453
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF630C60F;
	Sun, 16 Nov 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNFrL36Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C786277;
	Sun, 16 Nov 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307505; cv=none; b=JB75FmHWWhJMLxrSLQbsmJnvjw69YZ9PDSrJqtDg7W21pjjeFRhgRco92I40IdQ2O9LMlX73kpZmXFI/s4bKNokgO2zp1CXNLwvgQP/fNzEJ7SW84I/43u/AN1ZGOetrrjrAkcodhSz4GakSO7z8vnebl90y7mHuYaK8O4td1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307505; c=relaxed/simple;
	bh=PklCDM7OUgIAW2NKSP9gwJga3TF0F7kzFD8/5tkLGbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+ZGCHyXR9RfZB4QI8VZUARkkJdFURgfg6O7JpY1nS+La4vNhkRmwhVkilC/JPB+M4C2uV9vgXYsrBD7gIWnhZxMIcWkb2aW7+7ft53DYn9/g8TooJKvmMoShrrigIvVhvORcO8VK2ExyyoXiZ07wwbTQDKWqlHNoVOkLb6DDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNFrL36Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A143C16AAE;
	Sun, 16 Nov 2025 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763307505;
	bh=PklCDM7OUgIAW2NKSP9gwJga3TF0F7kzFD8/5tkLGbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uNFrL36QHDg9RUc+GlDYjwNe/cL/U1PzeOH8bVbIc9ni0Mwo8NOLLaAeq064X5gcV
	 bJDPRLt9uk2XPsepX/gqwn7D1UU78WqJ/g003xSkU/V5uSWXP1GsqDc5U68hHbt2zM
	 T9h3k9ThLqFkOj7LJt8M/5ZjwSTTMwlwgJi+nW2beK9eBw7v0tMkBaVZi7FWdjpMSs
	 gCiRArKm6VJtV8DjiOwAqNO9JtPQpTGwHZnl7Pavj0LK9qYepSBGOGKOK0N7wi7Vdc
	 KTeOLjge8CXBvdTAyoOAYpn5CMnV5f7wowxRANTisUaWRH+wRjNV1tIob+dHTg+QBS
	 +J8sHBVbsq+Vw==
Date: Sun, 16 Nov 2025 15:38:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: amplifiers: adl8113: add driver support
Message-ID: <20251116153819.7afc9de0@jic23-huawei>
In-Reply-To: <20251114115725.5660-3-antoniu.miclaus@analog.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
	<20251114115725.5660-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 11:57:24 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

A few really minor things inline that are in the category of
things I'd just tidy up whilst applying.

However, I want to know more about real usecases.  Probably best
place to discuss those is wrt to patch 3 so I'll reply to that.


> diff --git a/drivers/iio/amplifiers/adl8113.c b/drivers/iio/amplifiers/adl8113.c
> new file mode 100644
> index 000000000000..155291f4ec89
> --- /dev/null
> +++ b/drivers/iio/amplifiers/adl8113.c
> @@ -0,0 +1,252 @@
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
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>

Is this used?

> +static const char * const adl8113_supply_names[] = {
> +	"vdd1",
> +	"vdd2",
> +	"vss2"

This one should have a trailing comma because maybe we'll have
another supply at some future point.  At very least it's not obvious
from code alone that we never will so convention is to have that comma.

> +};

> +
> +static const struct iio_chan_spec_ext_info adl8113_ext_info[] = {
> +	IIO_ENUM("signal_path", IIO_SHARED_BY_ALL, &adl8113_signal_path_enum),
> +	IIO_ENUM_AVAILABLE("signal_path", IIO_SHARED_BY_ALL,
> +			   &adl8113_signal_path_enum),
> +	{ },

Trivial but no trailing comma given nothing can come after this.

> +};



