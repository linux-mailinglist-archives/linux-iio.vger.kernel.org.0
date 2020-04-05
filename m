Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A046519EB1E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDEMLp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDEMLp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:11:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C41206B8;
        Sun,  5 Apr 2020 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586088704;
        bh=CxUjJC87Lz9zq6Ug75Bx4fgUYcNrZGsu7maVdiWhrHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAsL3DHfh9GTnEiNPEHcq6u+4T5n85hbSdeveXBTAzn6hUvRxPIlOQg+LKXVaf4gb
         wukcadg4OjCvyiMseyz59FGsfdmqhSXmZqX1loQQ/jndttATHZtE7vy1VnU/KUUNWe
         Ti4pF8/F/QK1elLXhCF4zgKnf5mEm7itYEMmT1Ic=
Date:   Sun, 5 Apr 2020 13:11:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: xilinx-xadc: Fix clearing interrupt when
 enabling trigger
Message-ID: <20200405131140.0df06963@archlinux>
In-Reply-To: <20200403132717.24682-2-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
        <20200403132717.24682-2-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:27:14 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> When enabling the trigger and unmasking the end-of-sequence (EOS) interrupt
> the EOS interrupt should be cleared from the status register. Otherwise it
> is possible that it was still set from a previous capture. If that is the
> case the interrupt would fire immediately even though no conversion has
> been done yet and stale data is being read from the device.
> 
> The old code only clears the interrupt if the interrupt was previously
> unmasked. Which does not make much sense since the interrupt is always
> masked at this point and in addition masking the interrupt does not clear
> the interrupt from the status register. So the clearing needs to be done
> unconditionally.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Looks good but were is my fixes tag?  :) I fear we have a theme
here!

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 4fcf1729341f..04a2a609ced4 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -674,7 +674,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>  
>  	spin_lock_irqsave(&xadc->lock, flags);
>  	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> -	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, val & XADC_AXI_INT_EOS);
> +	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
>  	if (state)
>  		val |= XADC_AXI_INT_EOS;
>  	else

