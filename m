Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6865174E26
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCAP46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 10:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAP46 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 10:56:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E9921775;
        Sun,  1 Mar 2020 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583078217;
        bh=qhEfjHVx8EO32+N08TyPXheahfXEzN3WpIdl8Osp8XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MK3ALxR5sxnFmHUjjV2VwAZvzvnAKhhC+LA6DQpzovSWNd/5HrAvZ1YmRElCRiMfM
         oLWRpMO0IgaR/3XWc7trsG1pvqlKmGgJvcBkh1u/dPIMYHLSU36RseMSFhR2Gylb1L
         lJyWGYj+TUS5Oj6l9WOGz5YeKowrT2nEHZI1pepU=
Date:   Sun, 1 Mar 2020 15:56:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: imu: adis: add a note better explaining
 state_lock
Message-ID: <20200301155651.1e341eb8@archlinux>
In-Reply-To: <20200225103319.20751-3-alexandru.ardelean@analog.com>
References: <20200225103319.20751-1-alexandru.ardelean@analog.com>
        <20200225103319.20751-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 12:33:19 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The 'state_lock' mutex was renamed from 'txrx_lock' in a previous patch and
> is intended to be used by ADIS drivers to protect the state of devices
> during consecutive R/W ops.
> The initial patch that introduced this change did not do a good [well, any]
> job at explaining this. This patch adds a comment to the 'state_lock'
> better explaining it's use.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  include/linux/iio/imu/adis.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 20339025c75f..dd8219138c2e 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -98,6 +98,17 @@ struct adis {
>  	const struct adis_data	*data;
>  	struct adis_burst	*burst;
>  
> +	/**
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

