Return-Path: <linux-iio+bounces-20302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0DCAD0E7E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF738188FCA8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8B1D86C6;
	Sat,  7 Jun 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAr1pXmZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23842F3E;
	Sat,  7 Jun 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313198; cv=none; b=LkI9/zfjQE7d38fiJfxFIDXBH4ZV2nPmA4VrHaJBdRVPAekQ8VvYxPAj+nRC/6BfFCTmODnfbmYkgBXjCTPtNzL79ZsIDKbwD3MqTJ/dRDLo3AvR/OxW1Ld/svg22HrvAf79wqCiWeNNIcqfGGYLL7q+yrBSviIJxiIEbVjRlm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313198; c=relaxed/simple;
	bh=74NNiKZaZpH3i8kSiCdtcgfk8bjRj9cArbeqwKkfPD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCJqQj6UzD9/Ld8QDJixlw/CUDdUOULmJIR6xIE5iUNy+VUpfxW8v8v32kPHTf/dN7VDtj+wcHHkyx6QdzSqIuf1ySvKsvPvGa/NAGg6GVT3NELmRo87D0rRl4e4e14Y/z+yeKw5P6rDOhyP+pyw2xgtj+yqwK4BoIalp95fRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAr1pXmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC08C4CEE4;
	Sat,  7 Jun 2025 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749313197;
	bh=74NNiKZaZpH3i8kSiCdtcgfk8bjRj9cArbeqwKkfPD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tAr1pXmZWnxGIOoAs4kKKOcrTHPJqzOB7W1MRml/xpFJivWg17ERFFCpDe+608f7O
	 yqOKQNKcH5eZXCeO+we+gnz+CW5CwMHj58gWvCWaIQpmebMi0GiGquazB/+THY3+0A
	 Pki86t5bwC/2rglOBamCMJeHh6NWbOoJWuWGOLlBUQveEAfZ0yBSsqHcQP4r4CDbQa
	 5X8aGucPv/UL/4d0NmHP0O5xgwfY+HqCx3tY+X7a2DzGEBozcud4UnEcS6Y02xkQbO
	 dxBEC4XCJcY0dUlxOeNqJMfYSbBbWxJK06PfrWSTjZnjkA3k/DiA9Z24/sLL4On56g
	 lwZcsxOb3SHLA==
Date: Sat, 7 Jun 2025 17:19:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v5] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <20250607171950.188dc114@jic23-huawei>
In-Reply-To: <20250604053903.1376465-1-gwendal@google.com>
References: <20250604053903.1376465-1-gwendal@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Jun 2025 22:39:03 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> ChromeOS EC can report activity information derived from the
> accelerometer:
> - Reports on-body/off-body as a proximity event.
> - Reports significant motion as an activity event.
> 
> This new sensor is a virtual sensor, included only when the EC firmware
> is compiled with the appropriate module.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Passing comment inline. 



> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 64bada1e8678..a47b0cd26bf5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -485,10 +485,20 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
>  		.shared = IIO_SHARED_BY_ALL,
>  		.read = cros_ec_sensors_id
>  	},
> -	{ },
> +	{ }

Unrelated change. Should really be in a separate patch but meh it's trivial
so I don't care enough to insist.

>  };
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
>  
> +const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
> +	{
> +		.name = "id",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_id
> +	},
> +	{ }
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
> +
>  /**
>   * cros_ec_sensors_idx_to_reg - convert index into offset in shared memory
>   * @st:		pointer to state information for device

