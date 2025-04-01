Return-Path: <linux-iio+bounces-17506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93402A776A9
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 10:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528E3168CC0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B01EB1AC;
	Tue,  1 Apr 2025 08:42:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643A1A83E4
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496976; cv=none; b=W+yYzZ3XMHZ1JxI15+a8+CDRzDGjoAc3fGZJT5mgH1O1+m6StQiA20VcI3LF1GuJORab5RTA4ajOdcyH2DKRs7cfjvfl+UbL1o2AJvhgZqxgY1gT/WE2SYKHXYalvzyqeDd3F49eC8Q3dXeQWcSfnhOb1cuvfm4Pow7hpH69Vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496976; c=relaxed/simple;
	bh=8VJP0n/RE23QDNlKEjqeR8n1Dj+FG94SvmQIlMrlp6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6qRgOoj7OtZrzWOgan6esWY9lAFfRXFwGm5qlXU4P9ycDD9+CmOOvOIPlTRvDcHj/npz0e9GDqCLou79Ou8AvPHaPCyokmMOkY2rnQSM+vrGPe+jaiEM9Cb/kDZJhU4hBxJbnrYrBV2vxkaDA38cx0U9qIgM4oI5sdNeCwsYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tzXCm-0007bS-51; Tue, 01 Apr 2025 10:42:44 +0200
Message-ID: <f1079411-0188-4b0b-9cc9-7e0c0130d69a@pengutronix.de>
Date: Tue, 1 Apr 2025 10:42:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wbg@kernel.org" <wbg@kernel.org>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
 <059003d1-d725-4439-a6d7-cb354fba161b@pengutronix.de>
 <91e5c0dd0b71e5fbf441b7a6f2a8937a7bfc366f.camel@siemens.com>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <91e5c0dd0b71e5fbf441b7a6f2a8937a7bfc366f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hello Alexander,

On 4/1/25 10:38, Sverdlin, Alexander wrote:
> On Tue, 2025-04-01 at 06:50 +0200, Ahmad Fatoum wrote:
>>> Enable/disable seems to be racy on SMP, consider the following scenario:
>>>
>>> CPU0					CPU1
>>>
>>> interrupt_cnt_enable_write(true)
>>> {
>>>  	if (priv->enabled == enable)
>>>  		return 0;
>>>
>>>  	if (enable) {
>>>  		priv->enabled = true;
>>>  					interrupt_cnt_enable_write(false)
>>>  					{
>>>  						if (priv->enabled == enable)
>>>  							return 0;
>>>
>>>  						if (enable) {
>>>  							priv->enabled = true;
>>>  							enable_irq(priv->irq);
>>>  						} else {
>>>  							disable_irq(priv->irq)
>>>  							priv->enabled = false;
>>>  						}
>>>  		enable_irq(priv->irq);
>>>  	} else {
>>>  		disable_irq(priv->irq);
>>>  		priv->enabled = false;
>>>  	}
>>>
>>> The above would result in priv->enabled == false, but IRQ left enabled.
>>> Protect both write (above race) and read (to propagate the value on SMP)
>>> callbacks with a mutex.
>>
>> Doesn't sysfs/kernfs already ensure that the ops may not be called concurrently
>> on the same open file?
> 
> as I understand the code, the operations on the same FD will be serialized, i.e.
> if you open an entry and access it concurrently within the same process.

Thanks for checking! I agree now that we indeed need synchronization here.

Cheers,
Ahmad

> 
> If you apply the following patch on top of the proposed patch:
> 
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/cleanup.h>
>  #include <linux/counter.h>
>  #include <linux/gpio/consumer.h>
> @@ -56,6 +57,9 @@ static int interrupt_cnt_enable_write(struct counter_device *counter,
>  {
>  	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
> +	WARN_ON(!mutex_trylock(&priv->lock));
> +	mutex_unlock(&priv->lock);
> +
>  	guard(mutex)(&priv->lock);
>  
>  	if (priv->enabled == enable)
> @@ -69,6 +73,8 @@ static int interrupt_cnt_enable_write(struct counter_device *counter,
>  		priv->enabled = false;
>  	}
>  
> +	msleep(1000);
> +
>  	return 0;
>  }
>  
> 
> And would run `while true; do echo 0 > /sys/.../enable; echo 1 > /sys/.../enable; done &`
> twice, you'd see the following quickly:
> 
> WARNING: CPU: 1 PID: 754 at /drivers/counter/interrupt-cnt.c:60 interrupt_cnt_enable_write+0xa0/0xb0 [interrupt_cnt]
> CPU: 1 UID: 0 PID: 754 Comm: sh
> pc : interrupt_cnt_enable_write+0xa0/0xb0 [interrupt_cnt]
> lr : interrupt_cnt_enable_write+0x34/0xb0 [interrupt_cnt]
> Call trace:
>  interrupt_cnt_enable_write+0xa0/0xb0 [interrupt_cnt] (P)
>  counter_comp_u8_store+0xcc/0x118 [counter]
>  dev_attr_store+0x20/0x40
>  sysfs_kf_write+0x84/0xa8
>  kernfs_fop_write_iter+0x128/0x1e0
>  vfs_write+0x248/0x388
>  ksys_write+0x78/0x118
>  __arm64_sys_write+0x24/0x38
>  invoke_syscall+0x50/0x120
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


