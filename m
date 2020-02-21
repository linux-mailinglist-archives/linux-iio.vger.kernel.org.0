Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C4D167E14
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 14:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBUNLu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 08:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgBUNLu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 08:11:50 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3E42073A;
        Fri, 21 Feb 2020 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582290709;
        bh=jNY4bnNY/Z3DsEGdGY9Cp0GBQ0q0ns36gFzk+USyEOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zpJWwd/HmS2+FNKa65UCLMQSxXWKlDNXFqidEvAq9wKNBVastvhIow+a305zcRMb7
         C2NsXOfgBE+C2SMT7Dgh+a++MKM9W5avvfXSLlmV/VRWlVvq8b4mS6ax/g96cj846s
         wHd5HvrACnfzRlPJv3NHZe6+hRA/7mZ5swbMFQtE=
Date:   Fri, 21 Feb 2020 13:11:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Message-ID: <20200221131146.2213e8e1@archlinux>
In-Reply-To: <20200221114943.2056-1-alexandru.ardelean@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 13:49:41 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds a doc-string for the 'adis' struct. It details the fields
> and their roles.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  include/linux/iio/imu/adis.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index ac7cfd073804..0787a3aabd05 100644
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
> + * @tx: Cacheline aligned TX buffer for SPI transfers
> + * @rx: Cacheline aligned RX buffer for SPI transfers

This last one isn't true.. 

> + */
>  struct adis {
>  	struct spi_device	*spi;
>  	struct iio_trigger	*trig;

