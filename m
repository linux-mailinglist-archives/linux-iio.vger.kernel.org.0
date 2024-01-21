Return-Path: <linux-iio+bounces-1795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F165F8356A3
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D06282177
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7D37711;
	Sun, 21 Jan 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo6lJIjD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856A12E4C
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854189; cv=none; b=i3owVzl5U1RPhYcLCqNFvU0bQP90OxXRb6C/dqnR0UBuCfsA7VbSB9SipxqoRViJ5R/qG4nzK9Gsu2XXgnfDdSmlb7FZH1F9O+CuA0BTdOV56J80QhBkbzrL1Hexe7kZ5vhDWAZaQm/eExin/qfQRj5X9mnBFLQa8nOcHSGTLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854189; c=relaxed/simple;
	bh=u7+xpIP3uwpXOANCDUsg0lNAnHeLKCF4WaMJnKq+KY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REDvGrpztnhjMZqZM7PIjrRJ59ITwKt38NSVG5kx4L8w6rfmvgITcYS1fAuW8M+MB0k9QlDWLF1hsx+KItUKryWr46AT5+3oUbJWshahZwVQwH1kn0FumcCTz1+aMnEmseUp0BzRFRrEg04oC1c3j1yX/hEvaxnz8hK3yxbZIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo6lJIjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67394C433F1;
	Sun, 21 Jan 2024 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705854189;
	bh=u7+xpIP3uwpXOANCDUsg0lNAnHeLKCF4WaMJnKq+KY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eo6lJIjDA2U2kYnAXYwz2K1ljNFyATdNehzeH+P7WoSKcVbqxZsumOWPybbDyWfun
	 CK+sCLbgvMInmj8JHEs0RclBCq+qOkrAIC0SyOet4u+Ev3U/O7RchDncgtj/fv163W
	 hczFHRgpzwdRIE02CeD47+sReISsK/Ps9l79lOQevygmqto5HeqQhiH5WK2+VkFHHK
	 AXg0Y6YEqxEUEa5vr7mw92O8zQvrVfU+GRiC1WSl950VWh4jFogBKe+3KezlnzLZTH
	 8JVsUaaajdQ/O7EfyPTa9OtHYkyv55dXBizR+4VRWABea3vLcmMBhSl3klBH8J4E5+
	 +FHWITf74UxgQ==
Date: Sun, 21 Jan 2024 16:22:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Renato Lui Geh
 <renatogeh@gmail.com>, Fabrizio Lamarque <fl.scratchpad@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad_sigma_delta: allow overwriting the IRQ
 flags
Message-ID: <20240121162256.08918bb4@jic23-huawei>
In-Reply-To: <20240117-dev_sigma_delta_no_irq_flags-v1-2-db39261592cf@analog.com>
References: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
	<20240117-dev_sigma_delta_no_irq_flags-v1-2-db39261592cf@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 13:41:04 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Make sure we can specify the IRQ trigger type from firmware and drivers
> won't ignore it. In fact, this how it should be done but since someone
> might be already depending on the driver to hardcode the trigger type
> (and not specifying it in firmware), let's do it like this so there's
> no possible breakage.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I'm going to treat this as adding increased flexibility rather than a fix. Hence
Applied to the togreg branch of iio.git and pushed out as testing.
Will be rebased on rc1 once available.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 7e2192870743..fbba3f4a1189 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -568,6 +568,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
>  static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->spi->irq);
>  	int ret;
>  
>  	if (dev != &sigma_delta->spi->dev) {
> @@ -588,9 +589,13 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
>  	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
>  	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
>  
> +	/* Allow overwriting the flags from firmware */
> +	if (!irq_flags)
> +		irq_flags = sigma_delta->info->irq_flags;
> +
>  	ret = devm_request_irq(dev, sigma_delta->spi->irq,
>  			       ad_sd_data_rdy_trig_poll,
> -			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
> +			       irq_flags | IRQF_NO_AUTOEN,
>  			       indio_dev->name,
>  			       sigma_delta);
>  	if (ret)
> 


