Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEB435492
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJTU3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 16:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJTU3L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 16:29:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AAB361354;
        Wed, 20 Oct 2021 20:26:54 +0000 (UTC)
Date:   Wed, 20 Oct 2021 21:31:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     sesankm <sesank.mallikarjuna@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        sesankm <26676400+sesankm@users.noreply.github.com>
Subject: Re: [PATCH] Staging: iio: adc: ad7280a: fixed coding style
Message-ID: <20211020213112.6084a04c@jic23-huawei>
In-Reply-To: <20211020061027.34148-1-26676400+sesankm@users.noreply.github.com>
References: <20211020061027.34148-1-26676400+sesankm@users.noreply.github.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Oct 2021 01:10:27 -0500
sesankm <sesank.mallikarjuna@gmail.com> wrote:

> fixed issue with coding style
> 
> Signed-off-by: sesankm <26676400+sesankm@users.noreply.github.com>

Ah. Our 'favourite' false positive.  Take a look at what that macro
is doing..

There is a series waiting for review that removes this code anyway...
https://patchwork.kernel.org/project/linux-iio/list/?series=499867

> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index fef0055b8990..473f95118214 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -829,14 +829,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>   * The function argument is stringified and doesn't need a fix
>   */
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -			     in_voltage-voltage_thresh_low_value,
> +			     in_voltage - voltage_thresh_low_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,
>  			     AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -			     in_voltage-voltage_thresh_high_value,
> +			     in_voltage - voltage_thresh_high_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,

