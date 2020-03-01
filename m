Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6140E174DB0
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCAOgx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 09:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAOgx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 09:36:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C9E20880;
        Sun,  1 Mar 2020 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583073412;
        bh=P3kRgNLrPIcuygByvuToDezRGMERH1T6XYDrQ+yfock=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LVOUvLT67BXI+TQk+SPc3GGtHBWHVer0K5P0LK/yp9wpryWOeruK6VYztkQq7hVRw
         n/45q7kr6dFCf6DRdMPiTCwJd6D0BDawk0QvzvRMzvLd6bcQGlV2jAwV6UMzOZRiD6
         gbNNaK6Ygw4Yhr9KKoQ2VFXRGj5gw5GnkvpfjdG8=
Date:   Sun, 1 Mar 2020 14:36:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH] iio: adc: ad9292: Use new structure for SPI transfer
 delays
Message-ID: <20200301143647.7e611d6b@archlinux>
In-Reply-To: <20200227121814.14442-1-sergiu.cuciurean@analog.com>
References: <20200227121814.14442-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 14:18:14 +0200
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
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7292.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index a6798f7dfdb8..6595fd196288 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -122,7 +122,10 @@ static int ad7292_single_conversion(struct ad7292_state *st,
>  		{
>  			.tx_buf = &st->d8,
>  			.len = 4,
> -			.delay_usecs = 6,
> +			.delay = {
> +				.value = 6,
> +				.unit = SPI_DELAY_UNIT_USECS
> +			},
>  		}, {
>  			.rx_buf = &st->d16,
>  			.len = 2,

