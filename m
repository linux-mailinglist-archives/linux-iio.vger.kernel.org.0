Return-Path: <linux-iio+bounces-12596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0A9D7721
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC71632C9
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599AE13A409;
	Sun, 24 Nov 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATYnq+5V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213B136658;
	Sun, 24 Nov 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471660; cv=none; b=tvrA+OWAcXSdnu0KsL/uW8hj+414Md69Kdtw4y0PjqExMzheYHvv46WlTv7u8HFHoPxXAqncVcUCSY/ctb5rq/IXgkGqWR1M8A0Fn4L1oH6j1X7XBG26Yd2+S4iV/ZimBGUefeapInLcprwYr+SBOCKj4lFcbyZayetKlnfz+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471660; c=relaxed/simple;
	bh=LzngBWXfS6selD1cbz9f2MMFyXKr906AXg9ONfInK44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AouzUCzayPKBWolQa43IaKgTm5CnztaDtYxZGHV5t/FfyjJ03lZfkg7Me9gqCuGYKcsOkJBfqlDIt0Rc9SQmxXKnMPPDvErRM67heGRljwm8TIZQGtzD1/F4LVFl5SLrItlDqh5UfsdC9ag6t/K6x4c6jlvVmyPshCA/B9JyteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATYnq+5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A6C4CECC;
	Sun, 24 Nov 2024 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732471659;
	bh=LzngBWXfS6selD1cbz9f2MMFyXKr906AXg9ONfInK44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATYnq+5Vqx+O/LLklRtBawrpAjJvatiUQcKWMuoboFm6ovq8e9Ggp8AYO3na1Grir
	 Yh6YPB28Cr9jQxPaePpP1vfQjdIEW2xCQOrQgNhweMk+kRZy+G3VVdLPtaM79reYAC
	 TypTimxscnSNJcafzdMQIDjgjnqu6PPJeOD9VfmoxIWAEut622Z8Eif7yk5ZxTAA1E
	 9dbsVzV3bvu+iE+0j4acwdiAAUSC71xZEuwTifJrLTnJUms1GgprGP3gKK+SbSunEq
	 qLYXePyf3bD4M3Y8AIvOImUaKtb/IVuuUUWQr1/we5FsL/i9a2EG2gWN6mHbGz3ojl
	 H8paKGka5epfg==
Date: Sun, 24 Nov 2024 18:07:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 05/22] iio: accel: adxl345: measure right-justified
Message-ID: <20241124180733.2925eaa7@jic23-huawei>
In-Reply-To: <20241117182651.115056-6-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:34 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make measurements right-justified, since it is the default for the
> driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
> the data becomes right-judstified. This was the original setting, there
> is no reason to change it to left-justified, where right-justified
> simplifies working on the registers.

Surely this can't be changed independent of other changes as it will
change the format of the data we are processing?

Each change must stand on it's own so that I can apply up to any
point in your patch set and have everything continue to work.


Jonathan

> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 2b62e79248..926e397678 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -184,8 +184,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	struct adxl34x_state *st;
>  	struct iio_dev *indio_dev;
>  	u32 regval;
> +
> +	/* NB: ADXL345_DATA_FORMAT_JUSTIFY or 0:
	/*
	 * NB: AD...

is the multiline comment style all IIO drivers use (and most of the kernel
except for networking.

> +	 * do right-justified: 0, then adjust resolution according to 10-bit
> +	 * through 13-bit in channel - this is the default behavior, and can
> +	 * be modified here by oring ADXL345_DATA_FORMAT_JUSTIFY
> +	 */
>  	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
> -					 ADXL345_DATA_FORMAT_JUSTIFY |
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
>  	int ret;


