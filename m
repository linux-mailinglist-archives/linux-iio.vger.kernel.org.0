Return-Path: <linux-iio+bounces-17497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7FA773A4
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD19C18877A9
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 04:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E618FDBD;
	Tue,  1 Apr 2025 04:50:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F272114
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743483041; cv=none; b=GvzKMK3TEXaYVY41DGekE54VNzjzAUVGfebE6WMskpet+OeC8vXG2zRvQIoaULGjvyYBbbVAu84kLwADxqznX6vt0q7XdZ3CHRjgcrgN4jdXtQ5S/JIoeLAI5QDrd1QmeoKejb/AJES3yQ4ymUVuJcxbh0r9pIw704Zx5nbxZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743483041; c=relaxed/simple;
	bh=YMqeGFEfZuafwnrB5kJbEH3IDII0/ZT08GZH7KupvlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQjwj7BappWR/dOBIsar79mTHnavtwfLD2NXktV6d2bGnUNn6KrPe/Lxb5byAasAB5C9A98EeoNMt1qwbZNEDyEvLiJ+bXMaxXhbT4++YjhyNETEJEubiaXco1kkHRyUN//lVd6ZHN77vODK0CCz9Yon2tZLNr7fnonHgwWyB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tzTa7-0006yV-IQ; Tue, 01 Apr 2025 06:50:35 +0200
Message-ID: <059003d1-d725-4439-a6d7-cb354fba161b@pengutronix.de>
Date: Tue, 1 Apr 2025 06:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, linux-iio@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 William Breathitt Gray <wbg@kernel.org>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hello Alexander,

On 31.03.25 18:36, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Enable/disable seems to be racy on SMP, consider the following scenario:
> 
> CPU0					CPU1
> 
> interrupt_cnt_enable_write(true)
> {
> 	if (priv->enabled == enable)
> 		return 0;
> 
> 	if (enable) {
> 		priv->enabled = true;
> 					interrupt_cnt_enable_write(false)
> 					{
> 						if (priv->enabled == enable)
> 							return 0;
> 
> 						if (enable) {
> 							priv->enabled = true;
> 							enable_irq(priv->irq);
> 						} else {
> 							disable_irq(priv->irq)
> 							priv->enabled = false;
> 						}
> 		enable_irq(priv->irq);
> 	} else {
> 		disable_irq(priv->irq);
> 		priv->enabled = false;
> 	}
> 
> The above would result in priv->enabled == false, but IRQ left enabled.
> Protect both write (above race) and read (to propagate the value on SMP)
> callbacks with a mutex.

Doesn't sysfs/kernfs already ensure that the ops may not be called concurrently
on the same open file?

Thanks,
Ahmad

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/counter/interrupt-cnt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 949598d51575a..d83848d0fe2af 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -3,12 +3,14 @@
>   * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/counter.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> @@ -19,6 +21,7 @@ struct interrupt_cnt_priv {
>  	struct gpio_desc *gpio;
>  	int irq;
>  	bool enabled;
> +	struct mutex lock;
>  	struct counter_signal signals;
>  	struct counter_synapse synapses;
>  	struct counter_count cnts;
> @@ -41,6 +44,8 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
>  {
>  	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
> +	guard(mutex)(&priv->lock);
> +
>  	*enable = priv->enabled;
>  
>  	return 0;
> @@ -51,6 +56,8 @@ static int interrupt_cnt_enable_write(struct counter_device *counter,
>  {
>  	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
> +	guard(mutex)(&priv->lock);
> +
>  	if (priv->enabled == enable)
>  		return 0;
>  
> @@ -227,6 +234,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	mutex_init(&priv->lock);
> +
>  	ret = devm_counter_add(dev, counter);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add counter\n");


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

