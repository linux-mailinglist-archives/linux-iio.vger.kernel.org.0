Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD12456B3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 10:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgHPId6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 04:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgHPId4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 04:33:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073D12067C;
        Sun, 16 Aug 2020 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597566836;
        bh=Q8Pb6+zs3v50yIUByPCAhExQt4x+U4nxItyURgwiSUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnHWgq+eVaurDk+wXO4y1e8x3XGkyu6s4Ne7rfIXwaT3zDAVZ9/Zq16+2+b4kSxBg
         QNUCKaAk7TE3ideXolrVmolVIsFCJcnSbid1Ghr+Z0U5XYme0UoAAQ3XNEqHpqZLOL
         hg/RmYlOequd8oc4Szq0wBUNCaPrBo7sbCNDLsDs=
Date:   Sun, 16 Aug 2020 09:33:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30102: update author's email
Message-ID: <20200816093352.47276fe9@archlinux>
In-Reply-To: <20200814134941.10576-1-matt.ranostay@konsulko.com>
References: <20200814134941.10576-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Aug 2020 06:49:41 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Update email to author's current employer
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/health/max30102.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 9b47d9472a4f..bb504e993f19 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -2,7 +2,7 @@
>  /*
>   * max30102.c - Support for MAX30102 heart rate and pulse oximeter sensor
>   *
> - * Copyright (C) 2017 Matt Ranostay <matt@ranostay.consulting>
> + * Copyright (C) 2017 Matt Ranostay <matt.ranostay@konsulko.com>
>   *
>   * Support for MAX30105 optical particle sensor
>   * Copyright (C) 2017 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> @@ -632,6 +632,6 @@ static struct i2c_driver max30102_driver = {
>  };
>  module_i2c_driver(max30102_driver);
>  
> -MODULE_AUTHOR("Matt Ranostay <matt@ranostay.consulting>");
> +MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
>  MODULE_DESCRIPTION("MAX30102 heart rate/pulse oximeter and MAX30105 particle sensor driver");
>  MODULE_LICENSE("GPL");

