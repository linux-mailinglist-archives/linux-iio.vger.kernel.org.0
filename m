Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E332F3FB48A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhH3L1y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 07:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhH3L1y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 07:27:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8890A6112F;
        Mon, 30 Aug 2021 11:26:58 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:30:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Vorwerk <alec@vc-celle.de>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: cdc: remove braces from single line if
 blocks
Message-ID: <20210830123010.682d59f5@jic23-huawei>
In-Reply-To: <20210820224914.1260-1-alec@vc-celle.de>
References: <20210820224914.1260-1-alec@vc-celle.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Aug 2021 00:49:14 +0200
Alexander Vorwerk <alec@vc-celle.de> wrote:

> Remove braces from single line if blocks to clear checkpatch warnings.
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Alexander Vorwerk <alec@vc-celle.de>
Applied. Thanks
> ---
>  drivers/staging/iio/cdc/ad7746.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 78ac720266e6..71c709771676 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -241,10 +241,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		if (chip->capdac_set != chan->channel) {
> -
> +		if (chip->capdac_set != chan->channel)
>  			chip->capdac_set = chan->channel;
> -		}
>  		break;
>  	case IIO_VOLTAGE:
>  	case IIO_TEMP:

