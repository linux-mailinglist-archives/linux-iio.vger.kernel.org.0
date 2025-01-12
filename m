Return-Path: <linux-iio+bounces-14244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C88A0AAEC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E09C164DFD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801701BE223;
	Sun, 12 Jan 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GscXx4NM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AC20DF4;
	Sun, 12 Jan 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699655; cv=none; b=KuUhZzqQuelz5M6agQVQ+UJh/eeGn951+Kay0aHPdlp+D2prYACvx5pp7M+JmyFisOMwnir9gLf2uZVS3D/l2ahGAtUGPZnbGUo5R6AR48+o/NWfxwqz98UG2pdRhmoeH7NVOhoV7ogyKN3g6Ma0aIETc5B94AKSsgWiscVemfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699655; c=relaxed/simple;
	bh=+WCGpaAbYdfK2Km+8Mo0M/RKFR++XmCoFG2xbsM42Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyneyHfIZ/xBelrYyOhW4VR08Xm9Mm9pLGhAeTy24edcFLxY9Icb//K23kBo1hsNqN7qe5JAYHCU0ypP6xQ4+9b8DjRLWdT/EtNJTHkXwjQX4JNv95rHUtsGEtRi0spTt5dO757zTAtBUg23LMJpoSlK6+SMfKLKwUdl6HlyvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GscXx4NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2642FC4CEDF;
	Sun, 12 Jan 2025 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699654;
	bh=+WCGpaAbYdfK2Km+8Mo0M/RKFR++XmCoFG2xbsM42Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GscXx4NMGqWH+mfVGqdo8RQB8GG97eGv+tcW/ayy8kQ+VF+FSv1JIHopYPcaC2QwR
	 fC9cvoCaYW6fO2beuvO3MQNHtkiaDTYdWD1VfD+yzA9DepjT+tzbqc6JhJKJhnuEbO
	 qeOQ5cpAw1QUtvd8KsZCr9b3PLm1CguzmCAHledanbD5rwsvG232RF7dpucyChp3cg
	 W20it+cYYpLh6btDOlS46hRqGAbEaQtiwBDQe9Pi937F5Gg9xIlL1FIF7BG9ww+jzP
	 6yuddNBYMef2pxYyFe4OOTCIVf90WXT/5Kj4/ALljrD+l4oeM+/V0z6eKHcuDhWC8i
	 hXaGdTMhvYctw==
Date: Sun, 12 Jan 2025 16:34:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: accel: mc3230: add mc3510c support
Message-ID: <20250112163405.7857db5b@jic23-huawei>
In-Reply-To: <20250112-mainlining-mc3510c-v3-5-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
	<20250112-mainlining-mc3510c-v3-5-9ee6520ab69d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 15:25:39 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This commit integrates support for the mc3510c into the mc3230 driver.
> 
> Tested on Huawei MediaPad T3 10 (huawei-agassi)
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
Looks good to me.

If nothing else comes up in review you can either send a v4 with the
minor things I mentioned, or I'll just pick this up and tweak it whilst
applying.  For now it should stay on list for a few days for other people
to comment on if they wish and the trivial-devices entry to get reviewed.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mc3230.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 1b58f3ea50655b6563a78a2531b16a8088e8f8d5..92934975edc77b11ed6dc3da077a28d317314fab 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -46,6 +46,14 @@ static struct mc3230_chip_info mc3230_chip_info = {
>  	.scale = 115411765,
>  };
>  
> +static struct mc3230_chip_info mc3510c_chip_info = {
> +	.chip_id = 0x23,
> +	.name = "mc3510c",
> +	.product_code = 0x10,
> +	/* Was obtained empirically */
> +	.scale = 625000000,
> +};
> +
>  #define MC3230_CHANNEL(reg, axis) {	\
>  	.type = IIO_ACCEL,	\
>  	.address = reg,	\
> @@ -225,12 +233,14 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
>  
>  static const struct i2c_device_id mc3230_i2c_id[] = {
>  	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
> +	{ "mc3510c", (kernel_ulong_t)&mc3510c_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>  
>  static const struct of_device_id mc3230_of_match[] = {
>  	{ .compatible = "mcube,mc3230", &mc3230_chip_info },
> +	{ .compatible = "mcube,mc3510c", &mc3510c_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, mc3230_of_match);
> 


