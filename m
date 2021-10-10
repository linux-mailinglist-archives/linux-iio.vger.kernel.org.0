Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C186E42827A
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhJJQTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 12:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJJQTG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Oct 2021 12:19:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2B96008E;
        Sun, 10 Oct 2021 16:17:05 +0000 (UTC)
Date:   Sun, 10 Oct 2021 17:21:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v6 3/6] iio: triggered-buffer: extend support to
 configure output buffers
Message-ID: <20211010172113.239591a3@jic23-huawei>
In-Reply-To: <20211007080035.2531-4-mihail.chindris@analog.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-4-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Oct 2021 08:00:32 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> Now that output (kfifo) buffers are supported, we need to extend the
> {devm_}iio_triggered_buffer_setup_ext() parameter list to take a direction
> parameter.
> 
> This allows us to attach an output triggered buffer to a DAC device.
> Unfortunately it's a bit difficult to add another macro to avoid changing 5
> drivers where {devm_}iio_triggered_buffer_setup_ext() is used.
> Well, it's doable, but may not be worth the trouble vs just updating all
> these 5 drivers.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
This doesn't build... See inline and fixed whilst applying.
 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 28bde13003b7..e9f64da06f89 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -360,8 +360,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			 * The only way to get samples in buffer is to set a
>  			 * software trigger (systrig, hrtimer).
>  			 */
> -			ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					NULL, trigger_capture, NULL);

This isn't the _ext form...
so dropped this change.
> +			ret = devm_iio_triggered_buffer_setup_ext(dev,
> +					indio_dev, NULL, trigger_capture,
> +					IIO_BUFFER_DIRECTION_IN, NULL);
>  			if (ret)
>  				return ret;
>  		}
