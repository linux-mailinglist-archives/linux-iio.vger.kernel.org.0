Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B552D3A012
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFHNyz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:54:55 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:32976 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHNyz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 09:54:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 98AE39E9163;
        Sat,  8 Jun 2019 14:54:54 +0100 (BST)
Date:   Sat, 8 Jun 2019 14:54:52 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: amplifiers: update license information
Message-ID: <20190608145452.115ed56a@archlinux>
In-Reply-To: <20190530131812.3476-1-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 16:18:08 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Use the new `SPDX-License-Identifier` tag to specify the license.
> For ad8366, also update copyright years in the header part.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/Kconfig  | 1 +
>  drivers/iio/amplifiers/ad8366.c | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index e9c5f2cd9257..da5830da9bcf 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #
>  # Gain Amplifiers, etc.
>  #
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 4b76b61ba4be..82ac15914ff3 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
>   *
> - * Copyright 2012 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> + * Copyright 2012-2019 Analog Devices Inc.
>   */
>  
>  #include <linux/device.h>

