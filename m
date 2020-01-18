Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD2141804
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgAROax (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 09:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROaw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 09:30:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F202469A;
        Sat, 18 Jan 2020 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357851;
        bh=jfvpugoRaJiaAZmEMxDtm22xX+OLmTaCZAns9JDGkys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i0S03MHU7UpyT/JtNyiZqYkXMqCl0L7m3VILZk0LrEsxiEP/h7/21q3ekz5GpRAsp
         VB8BP6+LV0OZh7K0oyrxYE3YrGQRduRgNd3om4/rV1Tf7KqqqUse9g/KcANpAmimS8
         FwPOLxoMebXZ11T9+4dWQ+2ctTmdGV2SJ3dD6caI=
Date:   Sat, 18 Jan 2020 14:30:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <etienne.carriere@st.com>
Subject: Re: [PATCH 1/2] iio: dac: stm32-dac: use reset controller only at
 probe time
Message-ID: <20200118143046.4e6a6b95@archlinux>
In-Reply-To: <1578921266-6025-2-git-send-email-fabrice.gasnier@st.com>
References: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
        <1578921266-6025-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 14:14:25 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> From: Etienne Carriere <etienne.carriere@st.com>
> 
> This change removes the reset controller reference from the local
> DAC instance since it is used only at probe time.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Makes sense.

Applied to the togreg branch of iio.git and pushed out as testing
to let those autobuilders poke at it for a few hours.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/stm32-dac-core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 9e6b4cd..4d93446 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -20,13 +20,11 @@
>  /**
>   * struct stm32_dac_priv - stm32 DAC core private data
>   * @pclk:		peripheral clock common for all DACs
> - * @rst:		peripheral reset control
>   * @vref:		regulator reference
>   * @common:		Common data for all DAC instances
>   */
>  struct stm32_dac_priv {
>  	struct clk *pclk;
> -	struct reset_control *rst;
>  	struct regulator *vref;
>  	struct stm32_dac_common common;
>  };
> @@ -94,6 +92,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	struct regmap *regmap;
>  	struct resource *res;
>  	void __iomem *mmio;
> +	struct reset_control *rst;
>  	int ret;
>  
>  	if (!dev->of_node)
> @@ -148,11 +147,11 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	priv->common.vref_mv = ret / 1000;
>  	dev_dbg(dev, "vref+=%dmV\n", priv->common.vref_mv);
>  
> -	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
> -	if (!IS_ERR(priv->rst)) {
> -		reset_control_assert(priv->rst);
> +	rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (!IS_ERR(rst)) {
> +		reset_control_assert(rst);
>  		udelay(2);
> -		reset_control_deassert(priv->rst);
> +		reset_control_deassert(rst);
>  	}
>  
>  	if (cfg && cfg->has_hfsel) {

