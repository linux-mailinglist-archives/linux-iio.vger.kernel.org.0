Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F946141809
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 15:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgAROcl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 09:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROcl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 09:32:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046A72469A;
        Sat, 18 Jan 2020 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357961;
        bh=2gpBuuvhYqy8RvrcBZ6bAFOgb2g6EP4XMMQ95aGZvKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0GL8Sn03Xa52kpQ5+KYaDSu2O5damtoCfh914pmIzR1RJ0uoqJTGmjBL+smWd3DhC
         eofUbsfz99ZMPKpe1VakxqNVaBnlJwftR+9Mi5ZBF17402M3timem9g35dIx+p+klp
         tIEQP2CwbuYIrNghF2HSrfDv+U2VJ72qZUaMGB2U=
Date:   Sat, 18 Jan 2020 14:32:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <etienne.carriere@st.com>
Subject: Re: [PATCH 2/2] iio: dac: stm32-dac: better handle reset controller
 failures
Message-ID: <20200118143235.71a67b76@archlinux>
In-Reply-To: <1578921266-6025-3-git-send-email-fabrice.gasnier@st.com>
References: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
        <1578921266-6025-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 14:14:26 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Use devm_reset_control_get_optional_exclusive() instead of
> devm_reset_control_get_exclusive() as reset controller is optional.
> 
> Nevertheless if reset controller is expected but reports an
> error, propagate the error code to the caller. In such case
> a nice error trace is emitted unless we're deferring the probe
> operation.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/stm32-dac-core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 4d93446..7e5809b 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -147,8 +147,16 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	priv->common.vref_mv = ret / 1000;
>  	dev_dbg(dev, "vref+=%dmV\n", priv->common.vref_mv);
>  
> -	rst = devm_reset_control_get_exclusive(dev, NULL);
> -	if (!IS_ERR(rst)) {
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (rst) {
> +		if (IS_ERR(rst)) {
> +			ret = PTR_ERR(rst);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "reset get failed, %d\n", ret);
> +
> +			goto err_hw_stop;
> +		}
> +
>  		reset_control_assert(rst);
>  		udelay(2);
>  		reset_control_deassert(rst);

