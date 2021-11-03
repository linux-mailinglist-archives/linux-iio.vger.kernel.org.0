Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330034448A2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKCSxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhKCSxF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:53:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43CA060E78;
        Wed,  3 Nov 2021 18:50:27 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:55:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: xilinx-xadc-core: Use local variable in
 xadc_read_raw
Message-ID: <20211103185500.4835cbc2@jic23-huawei>
In-Reply-To: <20211101071822.522178-4-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
        <20211101071822.522178-4-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Nov 2021 00:18:21 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Minor cleanup: bit is already defined as chan->scan_type.realbits,
> use bit when needed.
> 
bits

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Otherwise looks good to me.

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 83bea5ef765da..05050709e4f8a 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -943,7 +943,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  				*val = 1000;
>  				break;
>  			}
> -			*val2 = chan->scan_type.realbits;
> +			*val2 = bits;
>  			return IIO_VAL_FRACTIONAL_LOG2;
>  		case IIO_TEMP:
>  			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */

