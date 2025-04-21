Return-Path: <linux-iio+bounces-18410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E3A95005
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E13A7AD7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F32638B6;
	Mon, 21 Apr 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6iQy0ik"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8F262D0C;
	Mon, 21 Apr 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234033; cv=none; b=hPkSFwosbUfiWXJ70JeW4wiaWMrrFoM+AQ8ugfQ6h7Sq9pyhUzb3MxSN04cZ/rwR7aLbxwKueGzrVXKC0E/iOFuhzEmUsqae/Afh+JK5itXNyrgQWxGX7bq+ZZmysX1y4CpakJ+XYTKDHjYPCoRLgISa/FIUMk5jRyCzpYfISJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234033; c=relaxed/simple;
	bh=EUhH7aYFac9sc/wyQBo7qu9EZp51eX8uWaVTZ7t44SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXxFoAs/vk145X1e7cSqVf/omE3Ty1ZZiq4oneiSNL75R1LdzWRZjVKS2XJh7Z65oAMm3IHYsb0oV4h9eckRtXm5/wEuxcW5jrFgW1FVKMTfMg2abLgOznfx4Bpx6r7dH5RkA+s7X1ke1gOHZNa5oAEWqySGlxydjxtroV00UHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6iQy0ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B71C4CEE4;
	Mon, 21 Apr 2025 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745234033;
	bh=EUhH7aYFac9sc/wyQBo7qu9EZp51eX8uWaVTZ7t44SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6iQy0ik2BTl7s407AP+AfzItY2uswsoguchw3FTINiQsSrBLAuEZYES6USY//DtU
	 dbGQXhuT7sZQDUDlNVmOXdb6gqoYTT9zz6aAOyUN+D8qdUwlQV8NSJtS+aqZ8wuzWs
	 LirPseKUdVmMDj9uMZ8GPSw4gcnRaHhmJXfPzvDzGHJPYtkQQgta9fvLZehOmlHbBJ
	 dM/xZ01zxcy7IIso4vPq3WgwbhE8gxiGE6YuQme/B3pC4F1nS+3gpqS9Alq7++1UO4
	 b3pY8j/0zwZGNuG1g2mvbKB1ZezgdUgi6mzX+PToeB5c0LmCJyr41X1GXyTDF0JXJc
	 VAU4B6xPAE1Vg==
Date: Mon, 21 Apr 2025 12:13:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 04/10] iio: adc: mxs-lradc-adc: use struct with
 aligned_s64 timestamp
Message-ID: <20250421121341.49e28ddf@jic23-huawei>
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-4-4c6080710516@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
	<20250418-iio-prefer-aligned_s64-timestamp-v1-4-4c6080710516@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 14:58:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a struct with aligned s64_timestamp instead of a padded array for
> the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
> to see the correctness of the size and alignment of the buffer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index 92baf3f5f5601b863c694eb03b6d8f287e4fe6ab..73e42f0ebcaeaaa437ba5c64ecdd7759a1191e6c 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -116,7 +116,10 @@ struct mxs_lradc_adc {
>  
>  	void __iomem		*base;
>  	/* Maximum of 8 channels + 8 byte ts */

If we were keeping this (I think the buffer solution is better)
then we could drop that coment as to me this just became self describing code.
That's why I like these structures where we can use them with out confusion!

> -	u32			buffer[10] __aligned(8);
> +	struct {
> +		u32 data[8];
> +		aligned_u64 ts;
aligned_s64 

I've not idea why timestamps are signed, but they always have been!

> +	} buffer;
>  	struct iio_trigger	*trig;
>  	struct completion	completion;
>  	spinlock_t		lock;
> @@ -418,14 +421,14 @@ static irqreturn_t mxs_lradc_adc_trigger_handler(int irq, void *p)
>  	unsigned int i, j = 0;
>  
>  	for_each_set_bit(i, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
> -		adc->buffer[j] = readl(adc->base + LRADC_CH(j));
> +		adc->buffer.data[j] = readl(adc->base + LRADC_CH(j));
>  		writel(chan_value, adc->base + LRADC_CH(j));
> -		adc->buffer[j] &= LRADC_CH_VALUE_MASK;
> -		adc->buffer[j] /= LRADC_DELAY_TIMER_LOOP;
> +		adc->buffer.data[j] &= LRADC_CH_VALUE_MASK;
> +		adc->buffer.data[j] /= LRADC_DELAY_TIMER_LOOP;
>  		j++;
>  	}
>  
> -	iio_push_to_buffers_with_ts(iio, adc->buffer, sizeof(adc->buffer),
> +	iio_push_to_buffers_with_ts(iio, &adc->buffer, sizeof(adc->buffer),
>  				    pf->timestamp);
>  
>  	iio_trigger_notify_done(iio->trig);
> 


