Return-Path: <linux-iio+bounces-392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4627F939D
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4ED1C20BF6
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9CCD529;
	Sun, 26 Nov 2023 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR4IXaLO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1ACD270
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 16:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7592EC433C7;
	Sun, 26 Nov 2023 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701014601;
	bh=Q+B4Zo9g6whYMeWtEu/77DE3UqeXmkHDSf5vckYHPUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nR4IXaLOVQTz9kvT3MIaAnJpK4sVA7CdFRTqPJIFydVw4QeHWSCxemjLWbX8oJdJx
	 UBZpTEk5lGBQBz6XtlRbKFBiIpdSnIyMxPCpMIqAe5LmYA1fmZuOG1L8i8oxTrvmAI
	 9ji5SpoxGk1AzQdvWsXFrsaurtdlpI71YTD5Gxmn4qyLOyksoqsM0cpZBdM+9iSlu1
	 vubmOe7V+McZUK2/zyzLr/EPClUD8DGi/3NZPPdTE6daTVS9U8eUZAGAEL3XPsmv9o
	 7z21JB6SmHQfzB+aAYsyUhTPO4HHA4ghg92AGC27a0kPnKDlIxfx4u1OpJc05rnwDt
	 ijl3nujwtzPiQ==
Date: Sun, 26 Nov 2023 16:03:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: haibo.chen@nxp.com
Cc: lars@metafoo.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: imx93: add four channels for imx93 adc
Message-ID: <20231126160312.2ef8a307@jic23-huawei>
In-Reply-To: <20231116071026.611269-1-haibo.chen@nxp.com>
References: <20231116071026.611269-1-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 15:10:26 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> According to the spec, this ADC totally support 8 channels.
> i.MX93 contain this ADC with 4 channels connected to pins in
> the package. i.MX95 contain this ADC with 8 channels connected
> to pins in the package.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Should I treat this as a fix?

If so could you reply with a fixes tag please

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx93_adc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index 9bb1e4ba1aee..4ccf4819f1f1 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -93,6 +93,10 @@ static const struct iio_chan_spec imx93_adc_iio_channels[] = {
>  	IMX93_ADC_CHAN(1),
>  	IMX93_ADC_CHAN(2),
>  	IMX93_ADC_CHAN(3),
> +	IMX93_ADC_CHAN(4),
> +	IMX93_ADC_CHAN(5),
> +	IMX93_ADC_CHAN(6),
> +	IMX93_ADC_CHAN(7),
>  };
>  
>  static void imx93_adc_power_down(struct imx93_adc *adc)


