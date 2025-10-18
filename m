Return-Path: <linux-iio+bounces-25230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4FBED3AD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61ABF4E888B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5066243956;
	Sat, 18 Oct 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvsZE0XW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B523ABA7;
	Sat, 18 Oct 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804075; cv=none; b=eWSkd0l380ccsXZJjdHaiLSE1lo36K1KGJLHxdLblYI6q3jbUJM2zuMuKPFHgB0ZRxC1cC6tKJbAtwbmrUnNi821dx1CXlTgbgmsJ4xms1oj+yyDgnim6JsF4HsUR0HjmeohPz7Qm9roCe3d74TjzcGv7RLxhkhNsOwX/CbIM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804075; c=relaxed/simple;
	bh=+7YpSDx6wXw4POrOKMgskGVyR1NEcg7/Co/YsLmXjew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlnYfVQVEwb+XVFC810d4zWvk3duTh6wlDdGwZ1IXrza1qnJRwhdQrKSigd4jXqS5gxo22zVvGwNbLXgQx53MRZrVrCnB8J2UIpeKB0TCCLpfihWfDMwSfpHpMk0vEze8+R9E8yZsw3TyUyMYIl6KAqqGOSjG42P3BkP7KRC2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvsZE0XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9507C4CEF8;
	Sat, 18 Oct 2025 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760804075;
	bh=+7YpSDx6wXw4POrOKMgskGVyR1NEcg7/Co/YsLmXjew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SvsZE0XW/mSMUwTVjXbhIs4dh6qHdrvlmm+qhFzY1CoV9onDkyTxwg67WszUtYXeZ
	 aLxfomDm77jjbcrPi6OYXf0dpQrXyHEcTD7f0qyzQmxfaF7ENx45KeLC9SVKua4UJ9
	 iPjHIIjGrQl5Gdpu9563otFyua3/11Wif5Q+Y3Jq7rp5vsvNaEDaf5z5hSzOMMchs5
	 OFNE2cqOsATrx5PuNGZHNAM3G/YLO8WrzzpWlymm3CHCJWjBN4tZbfgpKMPrQN/Duu
	 WWJBxW6VtFK0ksoME1wWkV/Q+asiW+12MeFq3i64gvxkh+Awh9ZgFcyvnxmMcMTsAc
	 rAhvQnXhfLwWQ==
Date: Sat, 18 Oct 2025 17:14:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 5/7] iio: adc: ad4062: Add IIO Trigger support
Message-ID: <20251018171425.7515d39f@jic23-huawei>
In-Reply-To: <20251013-staging-ad4062-v1-5-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-5-0f8ce7fef50c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 09:28:03 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
> signal, if not present, fallback to an I3C IBI with the same role.
> The software trigger is allocated by the device, but must be attached by
> the user before enabling the buffer. The purpose is to not impede
> removing the driver due to the increased reference count when
> iio_trigger_set_immutable or iio_trigger_get is used.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

A few things inline.
Thanks,

> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> index e55a69c62694a71a4e29f29b9a2bfeec3b16c990..40b7c10b8ce7145b010bb11e8e4698baacb6b3d3 100644
> --- a/drivers/iio/adc/ad4062.c
> +++ b/drivers/iio/adc/ad4062.c

> +static irqreturn_t ad4062_poll_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	u8 addr = AD4062_REG_CONV_TRIGGER;
> +	int ret;
> +
> +	/* Read current and trigger next conversion */
> +	struct i3c_priv_xfer t[2] = {
> +		{
> +			.data.in = &st->raw,

If it is safe to use addr on the stack, do we need to have
a dma safe buffer for raw?  I'm not sure for i3c!

> +			.len = 4,
> +			.rnw = true,
> +		},
> +		{
> +			.data.out = &addr,
> +			.len = 1,
> +			.rnw = false,
> +		}
> +	};
> +
> +	/* Separated transfers to not infeer repeated-start */
> +	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[0], 1);
> +	if (ret)
> +		goto out;
> +	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[1], 1);

Add a comment on this. I assume it's setting things up for the next
scan?

> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->raw,
> +					   pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
>  }

> +
> +static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +
> +	pm_runtime_mark_last_busy(&st->i3cdev->dev);

Take a look at the changes across the tree recently.
Now pm_runtime_put_autosuspend() calls pm_runtime_mark_last_busy()
internally to avoid the need for this pair.

> +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> +	return 0;
> +}



