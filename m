Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9D174E1A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 16:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCAPxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 10:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPxI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 10:53:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7989A24677;
        Sun,  1 Mar 2020 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583077987;
        bh=BNvU48AhqE7w6xnebVJSrHAuwWtfIWoXRKT9bbM+zBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=svmTW3XUdfP8EzFJ/2J+PBd2QK8uMJ+ojASvGwB3my7C3COrMRRb5fNAuxIFDXzF7
         GlVAaRbmL7V+MZKdnW09O/oc+XG9yEz79kax+Q3n7E5YIhXiHntz82eSDnCyFNgx25
         kpsB5fJ3L9/rcHpYu+RwZZ8wt/IMMaRhc8YMrt6c=
Date:   Sun, 1 Mar 2020 15:53:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: imu: adis_buffer: Use new structure for SPI
 transfer delays
Message-ID: <20200301155300.455551fa@archlinux>
In-Reply-To: <20200227123859.21757-1-sergiu.cuciurean@analog.com>
References: <20200227123859.21757-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 14:38:59 +0200
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 3f4dd5c00b03..04e5e2a0fd6b 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -97,7 +97,8 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  		if (j != scan_count)
>  			adis->xfer[j].cs_change = 1;
>  		adis->xfer[j].len = 2;
> -		adis->xfer[j].delay_usecs = adis->data->read_delay;
> +		adis->xfer[j].delay.value = adis->data->read_delay;
> +		adis->xfer[j].delay.unit = SPI_DELAY_UNIT_USECS;
>  		if (j < scan_count)
>  			adis->xfer[j].tx_buf = &tx[j];
>  		if (j >= 1)

