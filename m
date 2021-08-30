Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450F03FB42F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhH3LCu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 30 Aug 2021 07:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235818AbhH3LCs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 07:02:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBA2610E6;
        Mon, 30 Aug 2021 11:01:52 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:05:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: ltc2983: fail probe if no channels are
 given
Message-ID: <20210830120504.7363f953@jic23-huawei>
In-Reply-To: <20210825084149.11587-2-nuno.sa@analog.com>
References: <20210825084149.11587-1-nuno.sa@analog.com>
        <20210825084149.11587-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 10:41:49 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> If there are no channels defined in the devicetree, there's no point in
> probing the device. We were actually requesting a zero sized 'kmalloc'
> array but since we were not touching the ZERO_SIZE_PTR afterwards,
> nothing bad was actually happening. Hence this is not really a fix but
> rather an improvement.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Both applied.

Thanks,

J
> ---
> Nothing changed in v2.
> 
>  drivers/iio/temperature/ltc2983.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 22e6a26ce6b1..301c3f13fb26 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1275,6 +1275,11 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  			     &st->filter_notch_freq);
>  
>  	st->num_channels = of_get_available_child_count(dev->of_node);
> +	if (!st->num_channels) {
> +		dev_err(&st->spi->dev, "At least one channel must be given!");
> +		return -EINVAL;
> +	}
> +
>  	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
>  				   GFP_KERNEL);
>  	if (!st->sensors)

