Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B97436B7D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 21:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhJUTwB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 15:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhJUTv5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 15:51:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DDC610CB;
        Thu, 21 Oct 2021 19:49:39 +0000 (UTC)
Date:   Thu, 21 Oct 2021 20:53:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@protonic.nl, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: chemical: scd4x: Add a scale for the co2
 concentration reading
Message-ID: <20211021205357.688947c5@jic23-huawei>
In-Reply-To: <20211021140018.3051213-1-roan@protonic.nl>
References: <20211021140018.3051213-1-roan@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Oct 2021 16:00:18 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> This patch adds a scale for the co2 concentration reading. The reading is
> expressed in percent after applying the scale to the raw value.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
Thanks,

Applied to the togreg branch of iio.git and for once pushed out directly
as I want to get this into linux-next tomorrow and a pull request out if
no problems show up.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/scd4x.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index 09b34201c42b..b063b378c7d5 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -352,7 +352,11 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type == IIO_TEMP) {
> +		if (chan->type == IIO_CONCENTRATION) {
> +			*val = 0;
> +			*val2 = 100;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		} else if (chan->type == IIO_TEMP) {
>  			*val = 175000;
>  			*val2 = 65536;
>  			return IIO_VAL_FRACTIONAL;
> @@ -501,7 +505,8 @@ static const struct iio_chan_spec scd4x_channels[] = {
>  		.type = IIO_CONCENTRATION,
>  		.channel2 = IIO_MOD_CO2,
>  		.modified = 1,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE),
>  		.address = SCD4X_CO2,
>  		.scan_index = SCD4X_CO2,
>  		.scan_type = {

