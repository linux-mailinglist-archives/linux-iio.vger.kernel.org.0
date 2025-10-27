Return-Path: <linux-iio+bounces-25469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917DC0E29C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E951890F4E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACB2D3750;
	Mon, 27 Oct 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKJnhYhi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD372AD11;
	Mon, 27 Oct 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572954; cv=none; b=PUW63I2yaBZ+8O+jv6tMl3x1b1QfMqxKsHWvscTpx0cBTf/vZZEliPw4E1k7rFfY8GzTB8HDNYObwMw7scM59bRu82BHTnS0dntefDfEVxCGdVyVJfrshJDCyO2C7qYS985NS96tM3Tr/yUr6oCJIC70bOgsN9MEV8LszHGh0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572954; c=relaxed/simple;
	bh=BuQRZjoRLkFIeOGFeXAe+MJwyKbmh8gpiipXAD2WStQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXlQEgCrgN3yoUr9H6GL17lLBx4n1qJUM+Xnjr82F4w8OuZgPkBwBIUuMudr9/c7QVoro40MObGH3X1P0Jrom4mHde4TufSHZolRTGTU2P9SPXWvSkx8pze5j0zzZRrzvNcklgRgQNCSQJtbvscA+hKNGb0bY4qyZUSrfFWm6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKJnhYhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68862C4CEF1;
	Mon, 27 Oct 2025 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572954;
	bh=BuQRZjoRLkFIeOGFeXAe+MJwyKbmh8gpiipXAD2WStQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YKJnhYhi7MR1rlWeQ7DklQ2nj+h4F/83VYrR90V9o5czk7DZaFlRPgwI7y2AwVwPA
	 j8PvG6WhZdZ3PmJCzvNx/OwuEOB5OZZnP/OVPDl5TzK5+90LGMN8e7rkv3UfdSuhF2
	 J8sVS0k3G8IU9oue3aWVz3wKvWDnweV4+UhcCfBrv+Rixs+ir0hqvhYCGmwgRuZxhM
	 /zloM/HdZgQ7I/kqvJxZcNLH9Fs5gIW+w+5MCtCGilGeHPI6r5tWme4KbXkYHchNR/
	 k+jStBqA2Klto/H43yjyOpPSO7/uv65SFYmX82Z1Ev2cXSQRpZuEs01+uI9MpRC7+8
	 W5GCdjOfzs6GQ==
Date: Mon, 27 Oct 2025 13:49:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: eugen.hristev@linaro.org, alexandre.belloni@bootlin.com,
 lars@metafoo.de, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nicolas.ferre@microchip.com
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: Fix potential
 use-after-free in sama5d2_adc driver
Message-ID: <20251027134908.36d63b9f@jic23-huawei>
In-Reply-To: <268cbf0a5d9b931fcf6c025c53cc698ce78e4689.1760946527.git.xiaopei01@kylinos.cn>
References: <e9d6831a-d0ef-440c-b235-fec18048deed@linaro.org>
	<268cbf0a5d9b931fcf6c025c53cc698ce78e4689.1760946527.git.xiaopei01@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 15:49:25 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> at91_adc_interrupt can call at91_adc_touch_data_handler function
> to start the work by schedule_work(&st->touch_st.workq).
> 
> If we remove the module which will call at91_adc_remove to
> make cleanup, it will free indio_dev through iio_device_unregister
> while the work mentioned above will be used. The sequence of operations
> that may lead to a UAF bug is as follows:
> 
> CPU0                                      CPU1
> 
>                                      | at91_adc_workq_handler
> at91_adc_remove                      |
> iio_device_unregister(indio_dev)     |
> //free indio_dev                     |
>                                      | iio_push_to_buffers(indio_dev)
>                                      | //use indio_dev

Hi,

I'm not completely following your description here.
The free doesn't happen in iio_device_unregister() but quite a bit later.
So either the problem you are seeing is actually devm_ tear down that
will do the free, or it's a more specific action in iio_device_unregister()
though I'm not sure what it might be. Possibly a specific buffer mask
getting torn down?  I haven't analysed it closely enough to figure out if
there is a race there but it's the only thing I can immediately spot that
would even be of interest to a work item in a driver via some core interfaces.

Other than working out exact cause for anyone looking at this later, I'm
also not sure you don't leave a potential race where a fresh request comes in
between that cancel_work_sync() and the iio_device_unregister() call as it
is only when iio_device_unregister() is complete that all interfaces are torn
down that could start a fresh capture.

So were the cancel_work_sync() one line later I would have been happy but
from your description I'm not sure that fixes the bug you are seeing!

Jonathan



> 
> Fix it by ensuring that the work is canceled before proceeding with
> the cleanup in at91_adc_remove.
> 
> Fixes: 3ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index b4c36e6a7490..1cd6ce61cf17 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2480,6 +2480,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	cancel_work_sync(&st->touch_st.workq);
>  	iio_device_unregister(indio_dev);
>  
>  	at91_adc_dma_disable(st);


