Return-Path: <linux-iio+bounces-6064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A79012CC
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF5B21742
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D217B4FA;
	Sat,  8 Jun 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B69bAYcK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E885158A1F;
	Sat,  8 Jun 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864740; cv=none; b=gP/7EV8VWNVthHiyqursfN9w7UxVaZT71A0cIp/5hIgwvq4RhPYahDybLrhqMGgCEVRt2UnHg4vHrNkz7ozMSCerYgymEP8LISfYYRGt/gLIim2phFpNxg23K7LGGrYOwyWyRx3iD7fkjVAMEsC3DFebgpHEIYHSL5ouA05NDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864740; c=relaxed/simple;
	bh=NRDypsUCwfI33OUpmlEU3120t7rA9JE3Pg3U+I93Uhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM2LRBkrW0SoMXaNUje9+hHXAOprpzihg0VnMNguF0r/I2ny2qlUipPX+QPZKo7x/7UNoAs/pkIivQNC5aFvlXTWndt8pnCcB7Gl7zpLbP+dX9wEXhHYz4LxWG3tntLGuG3UcIN7fyroI1l/wXdI02aZdMvqPfXQ6pRHKxUl+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B69bAYcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84998C2BD11;
	Sat,  8 Jun 2024 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717864739;
	bh=NRDypsUCwfI33OUpmlEU3120t7rA9JE3Pg3U+I93Uhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B69bAYcKw8dym5L3MbgCzJ28mi3wHTzqDDw7asjfy/vMjDRiorhwuZqZlsdlWTuy9
	 tf+lzNAo6o7EzNfvW1mg0qkOGQi3A2W36dEdYitQ3Kn8r+JIZwPTrr1e2phcxFQG19
	 T0qlQe/Yky9RQJDHXWnb0w+5EOTr0z/k4olt3nIF4ihk4jjjPvoEsIM5lZdhvoorJA
	 HZ8pF+0E+o8FOSoEs4olfu/I+n0VMWGuI+pEzM3btJA2zPptIcoUAGoTzlERzDjWnF
	 LX8UwHfgTuydrB4E1PwDL8hCw8APreKBxHSJcFm+9NMJecwf1LlW7hkoTnVzOGVWv6
	 RHovd7RxIL57w==
Date: Sat, 8 Jun 2024 17:38:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>, <linux-mips@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240608173851.7c575f1f@jic23-huawei>
In-Reply-To: <20240607-md-drivers-iic-v1-1-9f9db6246083@quicinc.com>
References: <20240607-md-drivers-iic-v1-1-9f9db6246083@quicinc.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 09:17:52 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/ingenic-adc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Hi Jeff,

Thanks for tidying these up.

Applied to the togreg branch of iio.git and pushed out as testing
because there is other stuff I need 0-day to take a look at.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ingenic-adc.c  | 1 +
>  drivers/iio/adc/xilinx-ams.c   | 1 +
>  drivers/iio/buffer/kfifo_buf.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index a7325dbbb99a..af70ca760797 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -920,4 +920,5 @@ static struct platform_driver ingenic_adc_driver = {
>  	.probe = ingenic_adc_probe,
>  };
>  module_platform_driver(ingenic_adc_driver);
> +MODULE_DESCRIPTION("ADC driver for the Ingenic JZ47xx SoCs");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index f0b71a1220e0..ee45475c495b 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1430,5 +1430,6 @@ static struct platform_driver ams_driver = {
>  };
>  module_platform_driver(ams_driver);
>  
> +MODULE_DESCRIPTION("Xilinx AMS driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Xilinx, Inc.");
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 05b285f0eb22..38034c8bcc04 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -287,4 +287,5 @@ int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup_ext);
>  
> +MODULE_DESCRIPTION("Industrial I/O buffering based on kfifo");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240607-md-drivers-iic-cab420a99216
> 


