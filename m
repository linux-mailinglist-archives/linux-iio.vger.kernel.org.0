Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A41F88F7
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFNNf1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNNf1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:35:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7859720578;
        Sun, 14 Jun 2020 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592141727;
        bh=wHAsJEhIsHwLKWt29x7AOQN1Hi84Ntu5IixfmWZ8WAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTaXkTB4XhHHM6ldLrM1UxNd6w1bcaj+vNZzSgONzZcFMRUe9P8eA8nK2FTYVlliy
         J821MgSux8DOn5K5/xL8vLV/oiTxcK8TA6pxqPNZucNamZX0opkxiruVD+jVvSEijk
         grb1QRT2XQVkV3WovPnZ0O3PRX/IaVYlROVP1eTY=
Date:   Sun, 14 Jun 2020 14:35:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: core: add missing IIO_MOD_H2/ETHANOL string
 identifiers
Message-ID: <20200614143523.121c47a5@archlinux>
In-Reply-To: <20200609030116.23013-1-matt.ranostay@konsulko.com>
References: <20200609030116.23013-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Jun 2020 06:01:16 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add missing strings to iio_modifier_names[] for proper modification
> of channels.
> 
> Fixes: b170f7d48443d (iio: Add modifiers for ethanol and H2 gases)
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1527f01a44f1..352533342702 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -130,6 +130,8 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PM2P5] = "pm2p5",
>  	[IIO_MOD_PM4] = "pm4",
>  	[IIO_MOD_PM10] = "pm10",
> +	[IIO_MOD_ETHANOL] = "ethanol",
> +	[IIO_MOD_H2] = "h2",
>  };
>  
>  /* relies on pairs of these shared then separate */

