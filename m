Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C32174E22
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgCAPyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 10:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPyp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 10:54:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0EA2468E;
        Sun,  1 Mar 2020 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583078085;
        bh=N11K61PjUnTgCSmuZ96P/U+BYtwhUgB2ShONgN2rnbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmrgeCnyQDafYc/8DnHMNgBXQj/+DnlOROo7rbv4ZEP8AP7to0+WNr8LtETWnIAh5
         sG9dXVoyufl2KHng39fMV5HIYThCELtNrYQhGpIYVJQvlnEF0gxdLhSwsldRwJNHeG
         X6YF9YAmvi3HXmOMqBP8ePe1bMxdQ3ZAwvslAHGc=
Date:   Sun, 1 Mar 2020 15:54:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: imu: adis: add doc-string for 'adis' struct
Message-ID: <20200301155440.28991de2@archlinux>
In-Reply-To: <20200225103319.20751-1-alexandru.ardelean@analog.com>
References: <20200225103319.20751-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 12:33:17 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds a doc-string for the 'adis' struct. It details the fields
> and their roles.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * changed tx/rx descriptions to
>   ```
>   @tx: DMA safe TX buffer for SPI transfers
>   @rx: DMA safe RX buffer for SPI transfers
>   ```
> 
>  include/linux/iio/imu/adis.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index ac7cfd073804..63e456aa5c8a 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -73,6 +73,20 @@ struct adis_data {
>  	bool has_paging;
>  };
>  
> +/**
> + * struct adis - ADIS device instance data
> + * @spi: Reference to SPI device which owns this ADIS IIO device
> + * @trig: IIO trigger object data
> + * @data: ADIS chip variant specific data
> + * @burst: ADIS burst transfer information
> + * @state_lock: Lock used by the device to protect state
> + * @msg: SPI message object
> + * @xfer: SPI transfer objects to be used for a @msg
> + * @current_page: Some ADIS devices have registers, this selects current page
> + * @buffer: Data buffer for information read from the device
> + * @tx: DMA safe TX buffer for SPI transfers
> + * @rx: DMA safe RX buffer for SPI transfers
> + */
>  struct adis {
>  	struct spi_device	*spi;
>  	struct iio_trigger	*trig;

