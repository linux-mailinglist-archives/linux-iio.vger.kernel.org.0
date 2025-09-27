Return-Path: <linux-iio+bounces-24507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CFEBA6270
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62461160C67
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E691B2343C0;
	Sat, 27 Sep 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPIXO7B0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953171D7E4A;
	Sat, 27 Sep 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758996990; cv=none; b=fd/gtLfgJ/kibrNXCr9bsmpQo2DnUnEoP2yDCvM/Zs78CTkuLO3iOLU60P4hfOULd1uojrB4QcbDp2RS8FVsTeD3Nlb2jw4XJuCxxmvQwWFqTv/RqIgjrko99xzT6MeEU2OaUQBO5bO2gO+RpYL+PpTK/oUNw9P1Q3cNf/DaTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758996990; c=relaxed/simple;
	bh=6ax9kTlMFO2D72OjE4vrddfWkgd97Ayv6KP+fEd1l2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+ozct/7f+yd/aXaOuRXt2eK+78MgHexm0oEuc6pOuUnbVHrUBt0O/Wu/dx93nUCvDajKm8HtxIp85nKXSK1xyYsh5/vZNT1OpXGywt8qno93/qKDxoyhNdkRe0NPSOURPiOJ+gnOi03d24HCKPTwrKMbi1JWTGCD/gCfYjlB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPIXO7B0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54242C4CEE7;
	Sat, 27 Sep 2025 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758996990;
	bh=6ax9kTlMFO2D72OjE4vrddfWkgd97Ayv6KP+fEd1l2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RPIXO7B0INnCZhYQMMKbpVz/keVUQ6wYnAgHtPv7+rIpSbogpifiy9M1ju9Yx33kp
	 r3xfliH/sHXkGUtNE5L/sz8ZIVE+nj/gca4fnqbu/LY+4ZHmXQK3GZStJ9pmOhKosx
	 Ga/2En8RwxkMRiJxeOPu+ojoPj6s7TxcEHHGubhBvPzGXDQ+6hXqFgQy3k8x892PgO
	 TKKBPqphB1zbn8j6WBG1IrA2ZBC0U+JAJhWNktKjAoMSwtQGpHh7pZmuCmZaBwoqfS
	 WU2DZGqlS39x7Tt1fTS4yScRPgMgNz4ErknQNxe8qbCF4IBD3k7YiPKPxwgfo3Ebt0
	 gdPVyPEJL90Bg==
Date: Sat, 27 Sep 2025 19:16:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Message-ID: <20250927191620.2babbe79@jic23-huawei>
In-Reply-To: <20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 01:40:05 +0300
Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:

> Add support for the A/D 12-Bit successive approximation converters found
> in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> 
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
> 
> Conversions can be performed in single or continuous mode. Result of the
> conversion is stored in a 16-bit data register corresponding to each
> channel.
> 
> The conversions can be started by a software trigger, a synchronous
> trigger (from MTU or from ELC) or an asynchronous external trigger (from
> ADTRGn# pin).
> 
> Only single mode with software trigger is supported for now.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Hi Cosmin

A few minor comments inline.  Nice little driver.

Jonathan

> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> new file mode 100644
> index 000000000000..6a49788a5c67
> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,306 @@
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

> +
> +static void rzt2h_adc_start_stop(struct rzt2h_adc *adc, bool start,
> +				 unsigned int conversion_type)
> +{
> +	u16 mask;
> +	u16 reg;

Might as well use one line for those.

> +
> +	reg = readw(adc->base + RZT2H_ADCSR_REG);
> +
> +	if (start) {

To me having a shared function for start and stop isn't adding much here. I'd
just spit it and avoid the conditionals and passing a conversion type into stop
which makes no sense.

> +		/* Set conversion type */
> +		reg &= ~RZT2H_ADCSR_ADCS_MASK;
> +		reg |= FIELD_PREP(RZT2H_ADCSR_ADCS_MASK, conversion_type);
FIELD_MODIFY()

> +	}
> +
> +	/* Toggle end of conversion interrupt and start bit. */
> +	mask = RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK;
> +	if (start)
> +		reg |= mask;
> +	else
> +		reg &= ~mask;
> +
> +	writew(reg, adc->base + RZT2H_ADCSR_REG);
> +}
> +
> +static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *val)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(adc->dev);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&adc->lock);

See other branch of thread and guidance in cleanup.h wrt to gotos.

> +
> +	reinit_completion(&adc->completion);
> +
> +	/* Enable a single channel */
> +	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
> +
> +	rzt2h_adc_start_stop(adc, true, RZT2H_ADCSR_ADCS_SINGLE);
> +
> +	/*
> +	 * Datasheet Page 2770, Table 41.1:
> +	 * 0.32us per channel when sample-and-hold circuits are not in use.
> +	 */
> +	ret = wait_for_completion_timeout(&adc->completion, usecs_to_jiffies(1));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +		goto disable;
> +	}
> +
> +	*val = readw(adc->base + RZT2H_ADDR_REG(ch));
> +	ret = IIO_VAL_INT;
> +
> +disable:
> +	rzt2h_adc_start_stop(adc, false, 0);
> +
> +	pm_runtime_put_autosuspend(adc->dev);
> +
> +	return ret;
> +}

> +static int rzt2h_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct rzt2h_adc *adc;
> +	int ret;
> +	int irq;

Might as well save a line.

	int ret, irq;

> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>

