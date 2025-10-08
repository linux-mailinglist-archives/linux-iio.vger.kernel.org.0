Return-Path: <linux-iio+bounces-24843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37078BC389B
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 09:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8667402CF3
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 07:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E02F0C6F;
	Wed,  8 Oct 2025 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="khNh2FH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48D19F137;
	Wed,  8 Oct 2025 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907231; cv=none; b=mZvqpUqNwCeKnKBbyF2rDLSuScUELUmXRHw8zuVX8U0CCt2actV/BbxRtEEjtSgBrgUSJ1H7EZClyvnsi5mPD/vPUkVEGwO+HOLPpy0sQq108HicPek/6Eb3yNrc7uKmiITzB9JyQK+WwrSsf85PXDDEdPbJMLCxnlZTliCshqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907231; c=relaxed/simple;
	bh=9s3DFkptPpbASkGIufDgeis2Emtgt5t72Kt2fxxiNIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHczZxj8ofmr7sbs3aMUlL3Mtl/FAbRxy7FRoiRnqI3FgE1eVXI9NcePJWmQ2ePKxgypnt/o1X6nrKB2qWbL8s2eTZIrHCng9vNRIUujwT2jQlWUkImloGgaFFpxes48/WC0cK+rs24yGZZTK1QrXfrSEDlh2Mi92fZgkmI58vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=khNh2FH9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2B4B84E40F7D;
	Wed,  8 Oct 2025 07:07:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDCD0606E5;
	Wed,  8 Oct 2025 07:07:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B149102F1CA4;
	Wed,  8 Oct 2025 09:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759907222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eBNgKNNk2NNtvMNclSC/XfautocVXf61NgAtMNczS/k=;
	b=khNh2FH98tNbjYfkWAKORU7PNO/K4DQaGVKeea3aWvvXF8RvK6y0qc+RxMbDVlpWvsqpIJ
	a10L3h7pAtjStGLdu4LxqiGySb38yOyELhaZR+GEd2A2y3D7cL8MU1puy8eec9IQLp6bv3
	JH+ambC9PBfy1ZZxWlelZet5R4rRYbnbVh9Zvc0jOM1KQpjq2+k00VrbKbMtUwrJG/OcMR
	YYZQC7AwFiaiwrPaBegTrXD5BelATJ2Q9dIsxk68l/nTS+N/Mx3eN90NjX1Lzt2yhJzVRj
	VcAacZ27C7P5rHh7knl8FalL92AQvqtUAusrM1jt7ulcoEKIcDCLENMeU7giuQ==
Date: Wed, 8 Oct 2025 09:06:52 +0200
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dharma Balasubiramani <dharma.b@microchip.com>, g@tpx1.home
Cc: William Breathitt Gray <wbg@kernel.org>, 
	Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Allow shared IRQ for
 multi-channel TCBs
Message-ID: <ijigaljlomxtyoy6ha2czocr7gnjqfdxs6kuhg3w4jxlwj4cr5@yum4paorabnm>
References: <20251006-microchip-tcb-v1-1-09c19181bb4a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-microchip-tcb-v1-1-09c19181bb4a@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Oct 06, 2025 at 04:21:50PM +0530, Dharma Balasubiramani wrote:

Hello Dharma,

> Mark the interrupt as IRQF_SHARED to permit multiple counter channels to
> share the same TCB IRQ line.
>
> Each Timer/Counter Block (TCB) instance shares a single IRQ line among its
> three internal channels. When multiple counter channels (e.g., counter@0
> and counter@1) within the same TCB are enabled, the second call to
> devm_request_irq() fails because the IRQ line is already requested by the
> first channel.
>
> Fixes: e5d581396821 ("counter: microchip-tcb-capture: Add IRQ handling")
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  drivers/counter/microchip-tcb-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 1a299d1f350b..19d457ae4c3b 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -451,7 +451,7 @@ static void mchp_tc_irq_remove(void *ptr)
>  static int mchp_tc_irq_enable(struct counter_device *const counter, int irq)
>  {
>  	struct mchp_tc_data *const priv = counter_priv(counter);
> -	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, 0,
> +	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, IRQF_SHARED,
>  				   dev_name(counter->parent), counter);
>
>  	if (ret < 0)
>
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251006-microchip-tcb-edd8aeae36c4
>

This change makes sense, thanks !

Reviewed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

> Best regards,
> --
> Dharma Balasubiramani <dharma.b@microchip.com>
>

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

