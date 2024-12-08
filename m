Return-Path: <linux-iio+bounces-13218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C749E8571
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5DD1884421
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56914AD2B;
	Sun,  8 Dec 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qos+Dgts"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947871E495;
	Sun,  8 Dec 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733664417; cv=none; b=iNZus8P6UF4aO2+WouVCVx0Wa24aBP/a+x+1mY9JsJ+CWywZMLmHnOqttXYOZVND1mqyWzkh7Jqp/RTfwO197FCLDdMColAhB97VMmpL9ppmGAANOG10+y05sF0f3abLPouec06y2RY7iwkoPqQyjrI0vumBNswN0Z5Hr6Et9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733664417; c=relaxed/simple;
	bh=8CUMUqlrRXqg8/ABdyM/00xP9Z0/1FZ8gOtTK68asyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5IM/S5eiohZY/fjgyj+k7N/WXAkaIWT9DPdQhf57o0Cbp6jNMxpwnqQr8nB72eqkxlV240Qx/PGjn6FDem+fYGHipKLhJljaD9FkiJy3Q9LwB1A9uNSWg3/LPWA9XKo2UVFs1xsajFCqgvOm8kOHsFY5p4Q1bDOvM0tUHWy3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qos+Dgts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDD0C4CED2;
	Sun,  8 Dec 2024 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733664417;
	bh=8CUMUqlrRXqg8/ABdyM/00xP9Z0/1FZ8gOtTK68asyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qos+DgtsZkuSuEKnpOC+UDmov4K5qDYuxFbMqnP85F/89dRSwtvJ0gOSGLo6dLeUb
	 d3V2m2MRJg6da85sP5sbBSoM/zZ9L69PvbqCEnsiVlyICZIuwySu7TSpuwXMT0RcOj
	 2w6iaFWS2yjGcmSunrKxa4I0fXSK7utXvLwfRoGbYpNapIgq19Nvqc9uEkmyL0bH92
	 cV9yx5KCjhj8/J2ydK7zXl5PftS2f5TkNSCtgf0yKoWfkPBaECtFD1Ki2TpteqWoKt
	 v7KiOlcp//SIN/MtJ3DXASqcwrH6F/hMR0mLtEwwPSOIaxBtwuMiJxkjtQfZcxiXui
	 ORaXsFt0DsL9w==
Date: Sun, 8 Dec 2024 13:26:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 01/10] iio: accel: adxl345: refrase comment on probe
Message-ID: <20241208132647.608cc10b@jic23-huawei>
In-Reply-To: <20241205171343.308963-2-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:34 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Refrase comment on the probe function, avoid naming different hardware.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
I'll pick up the ones that are ready to apply so as to shorten v6 etc.

Applied this one.

> ---
>  drivers/iio/accel/adxl345_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 006ce66c0aa..eb3ce4434a5 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -169,8 +169,7 @@ static void adxl345_powerdown(void *regmap)
>  }
>  
>  /**
> - * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
> - *                        also covers the adlx375 accelerometer
> + * adxl345_core_probe() - Probe and setup for the accelerometer.
>   * @dev:	Driver model representation of the device
>   * @regmap:	Regmap instance for the device
>   * @setup:	Setup routine to be executed right before the standard device


