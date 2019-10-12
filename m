Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A898FD4F67
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJLLok (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfJLLmk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:42:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A3F2089C;
        Sat, 12 Oct 2019 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880559;
        bh=v57pBOuT7ianiXPyK8eblRNxhJWFvLsxxNWM4rdk4o4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=clRMAt8IMeIFnzWbQZRtZAgrDPj+V2NUBjn0cRlTdnMRpcr6/2wCcG7E7dYzNhIFe
         Eh5tlSHqBSZUVB6UunRbWCEoXIJtXpN4U4tYSSHesedACFEC3j2Ur32W3GUcWM0tgy
         DK272l2OBqUVpnze9KFyydy5shae8EbzxwhD0xSA=
Date:   Sat, 12 Oct 2019 12:42:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: adis: add doc-string for `adis` struct
Message-ID: <20191012124236.2f381154@archlinux>
In-Reply-To: <20191008080239.23239-1-alexandru.ardelean@analog.com>
References: <20191008080239.23239-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Oct 2019 11:02:37 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds a doc-string for the `adis` struct. It details the fields
> and their roles.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  include/linux/iio/imu/adis.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 48444f28b003..dbdf421d35dd 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -54,6 +54,20 @@ struct adis_data {
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
> + * @tx: Cacheline aligned TX buffer for SPI transfers
> + * @rx: Cacheline aligned RX buffer for SPI transfers
That one is ever so slightly untrue.  It's in the same cacheline as the
tx and so safe (device transfers can only cause trouble for themselves).

I'll tweak to just...
	RX buffer for SPI transfers. May share cacheline with tx.

Hope you don't mind as don't want to waste your time on a v2 for just that.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


> + */
>  struct adis {
>  	struct spi_device	*spi;
>  	struct iio_trigger	*trig;

