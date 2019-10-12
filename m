Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E474D4F6E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJLLwU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfJLLuU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:50:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92B32089C;
        Sat, 12 Oct 2019 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570881019;
        bh=jn7+wUSc3pFrRgbowSAIqkFHZuGihMdTdiJL8TqegZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Npvd1DN0LlBTR547Sweljy6+4IlMv1mfNbtdiC8rcwNzSm1M5kou0H1Auk5tMc9b8
         pMFhUg8f6dLmM8k3kWNp4U8/hyR/jDxiuP/xoq71op0LrlzcjapfDwjImEqCppg7tg
         Dea9ixUqZZEzBgJ8A1CQJk7wlLuNhIu9pVuW+F2E=
Date:   Sat, 12 Oct 2019 12:50:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: imu: adis: add a note better explaining
 state_lock
Message-ID: <20191012125015.6cd3f714@archlinux>
In-Reply-To: <20191008080239.23239-3-alexandru.ardelean@analog.com>
References: <20191008080239.23239-1-alexandru.ardelean@analog.com>
        <20191008080239.23239-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Oct 2019 11:02:39 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The `state_lock` mutex was renamed from `txrx_lock` in a previous patch and
> is intended to be used by ADIS drivers to protect the state of devices
> during consecutive R/W ops.
> The initial patch that introduced this change did not do a good [well, any]
> job at explaining this. This patch adds a comment to the `state_lock`
> better explaining it's use.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Tiny tweak. See below.

Applied to the togreg branch of iio.git and pushed out as testing.

One thing to note though.  I don't normally run kernel-doc on random
headers, and my eyes missed it, but there are errors in the docs
for read and write functions that could do with fixing.

[jic23@archlinux iio]$ ./scripts/kernel-doc  include/linux/iio/imu/adis.h > temp.html
include/linux/iio/imu/adis.h:138: warning: Function parameter or member 'val' not described in '__adis_write_reg_8'
include/linux/iio/imu/adis.h:138: warning: Excess function parameter 'value' description in '__adis_write_reg_8'
include/linux/iio/imu/adis.h:150: warning: Function parameter or member 'val' not described in '__adis_write_reg_16'
include/linux/iio/imu/adis.h:150: warning: Excess function parameter 'value' description in '__adis_write_reg_16'
include/linux/iio/imu/adis.h:162: warning: Function parameter or member 'val' not described in '__adis_write_reg_32'
include/linux/iio/imu/adis.h:162: warning: Excess function parameter 'value' description in '__adis_write_reg_32'
include/linux/iio/imu/adis.h:217: warning: Function parameter or member 'val' not described in 'adis_write_reg'
include/linux/iio/imu/adis.h:217: warning: Excess function parameter 'value' description in 'adis_write_reg'
include/linux/iio/imu/adis.h:254: warning: Function parameter or member 'val' not described in 'adis_write_reg_8'
include/linux/iio/imu/adis.h:254: warning: Excess function parameter 'value' description in 'adis_write_reg_8'
include/linux/iio/imu/adis.h:266: warning: Function parameter or member 'val' not described in 'adis_write_reg_16'
include/linux/iio/imu/adis.h:266: warning: Excess function parameter 'value' description in 'adis_write_reg_16'
include/linux/iio/imu/adis.h:278: warning: Function parameter or member 'val' not described in 'adis_write_reg_32'
include/linux/iio/imu/adis.h:278: warning: Excess function parameter 'value' description in 'adis_write_reg_32'

If you could role a patch for those, that would be great.  Thanks!

Thanks,

Jonathan

> ---
>  include/linux/iio/imu/adis.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 27ebd740f626..abd4bd07e960 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -80,6 +80,17 @@ struct adis {
>  	const struct adis_data	*data;
>  	struct adis_burst	*burst;
>  
> +	/**
This isn't kernel doc so
 /* 

I'll fix.

> +	 * The state_lock is meant to be used during operations that require
> +	 * a sequence of SPI R/W in order to protect the SPI transfer
> +	 * information (fields 'xfer', 'msg' & 'current_page') between
> +	 * potential concurrent accesses.
> +	 * This lock is used by all "adis_{functions}" that have to read/write
> +	 * registers. These functions also have unlocked variants
> +	 * (see "__adis_{functions}"), which don't hold this lock.
> +	 * This allows users of the ADIS library to group SPI R/W into
> +	 * the drivers, but they also must manage this lock themselves.
> +	 */
>  	struct mutex		state_lock;
>  	struct spi_message	msg;
>  	struct spi_transfer	*xfer;

