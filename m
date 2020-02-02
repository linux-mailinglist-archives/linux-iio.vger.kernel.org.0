Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A5E14FCC0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgBBLCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 06:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgBBLCL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 06:02:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63BC62067C;
        Sun,  2 Feb 2020 11:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580641330;
        bh=6u1cqWAlRBMJoZ/FrQ6uyLCG43c5Zdqjtczp7wHzdIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=insNWVp1qUlymq8s4QspcXAXmxa6tJm5CYz/LWS9mvrzUlPhQP5QBkNl8AI9Aawm/
         l3URLlAuRMSfWB1RW3SWyfpu7QEa5UlMsaRyGp/w4E5swg1QUsLMeMf/+z2OUzThAN
         oW3PZpWQoEQPZBMNacyb2cSZVz93ov8SW+2tW2jk=
Date:   Sun, 2 Feb 2020 11:02:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 1/3] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Message-ID: <20200202110206.7326ce4d@archlinux>
In-Reply-To: <1580216189-27418-2-git-send-email-eugen.hristev@microchip.com>
References: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
        <1580216189-27418-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jan 2020 12:57:39 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The differential channels require writing the channel offset register (COR).
> Otherwise they do not work in differential mode.
> The configuration of COR is missing in triggered mode.
> 
> Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied to the fixes-togreg branch of iio.git.  Normally I avoid rebasing that
branch but I may do so this time given it's currently mid merge window.

The other two patches will have to wait for this one to get upstream of
my togreg branch which will take a few weeks.

Please give me a poke if I seem to have forgotten about them!

Thanks,

Jonathan

> ---
> Changes in v2:
> - moved to the start of the list
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e1850f3..2a6950a 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -723,6 +723,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  
>  	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
>  		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
> +		u32 cor;
>  
>  		if (!chan)
>  			continue;
> @@ -732,6 +733,20 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  			continue;
>  
>  		if (state) {
> +			cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
> +
> +			if (chan->differential)
> +				cor |= (BIT(chan->channel) |
> +					BIT(chan->channel2)) <<
> +					AT91_SAMA5D2_COR_DIFF_OFFSET;
> +			else
> +				cor &= ~(BIT(chan->channel) <<
> +				       AT91_SAMA5D2_COR_DIFF_OFFSET);
> +
> +			at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
> +		}
> +
> +		if (state) {
>  			at91_adc_writel(st, AT91_SAMA5D2_CHER,
>  					BIT(chan->channel));
>  			/* enable irq only if not using DMA */

