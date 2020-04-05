Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3019EB24
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDEMNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgDEMNw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:13:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7511206B8;
        Sun,  5 Apr 2020 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586088832;
        bh=hqxypv1/soNwaZHOaGwg17k+2Dmj89e4t/m2X6dJ+Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dfzbippEDy7Y+TEloAoQrly5ARmQ3D3WompcfDU9hKiQo2fSaigZUIuTIYkDEM6IH
         Iz571enQ2Mzf93OTX+JPncuKEheeK/l1iU9K4khJaIbIc7lPz/UModDQVLNxJKZQhg
         XczUqRLoI1kOvc8Qwo14foqqaZ8sef+LZhFD8FTs=
Date:   Sun, 5 Apr 2020 13:13:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: xilinx-xadc: Fix sequencer configuration for
 aux channels in simultaneous mode
Message-ID: <20200405131348.6eb332af@archlinux>
In-Reply-To: <20200403132717.24682-3-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
        <20200403132717.24682-3-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:27:15 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The XADC has two internal ADCs. Depending on the mode it is operating in
> either one or both of them are used. The device manual calls this
> continuous (one ADC) and simultaneous (both ADCs) mode.
> 
> The meaning of the sequencing register for the aux channels changes
> depending on the mode.
> 
> In continuous mode each bit corresponds to one of the 16 aux channels. And
> the single ADC will convert them one by one in order.
> 
> In simultaneous mode the aux channels are split into two groups the first 8
> channels are assigned to the first ADC and the other 8 channels to the
> second ADC. The upper 8 bits of the sequencing register are unused and the
> lower 8 bits control both ADCs. This means a bit needs to be set if either
> the corresponding channel from the first group or the second group (or
> both) are set.
> 
> Currently the driver does not have the special handling required for
> simultaneous mode. Add it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Looks fine, but sounds like a fix, so when was the problem introduced?

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 04a2a609ced4..4acababda4d5 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -798,6 +798,16 @@ static int xadc_preenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		goto err;
>  
> +	/*
> +	 * In simultaneous mode the upper and lower aux channels are samples at
> +	 * the same time. In this mode the upper 8 bits in the sequencer
> +	 * register are don't care and the lower 8 bits control two channels
> +	 * each. As such we must set the bit if either the channel in the lower
> +	 * group or the upper group is enabled.
> +	 */
> +	if (seq_mode == XADC_CONF1_SEQ_SIMULTANEOUS)
> +		scan_mask = ((scan_mask >> 8) | scan_mask) & 0xff0000;
> +
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(1), scan_mask >> 16);
>  	if (ret)
>  		goto err;

