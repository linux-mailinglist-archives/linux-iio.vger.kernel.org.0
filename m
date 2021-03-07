Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED83300B9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCGMOs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:14:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhCGMO1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 07:14:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E27600CD;
        Sun,  7 Mar 2021 12:14:26 +0000 (UTC)
Date:   Sun, 7 Mar 2021 12:14:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] staging: iio: remove mention of defunct list
Message-ID: <20210307121422.6f5475a1@archlinux>
In-Reply-To: <69b3e45e7666a1dd74a83df0b84ef8a63bf090ea.1614082343.git.baruch@tkos.co.il>
References: <69b3e45e7666a1dd74a83df0b84ef8a63bf090ea.1614082343.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Feb 2021 14:12:23 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> The ADI device-drivers-devel list no longer exists.
> 
> Cc: Mike Frysinger <vapier@gentoo.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Applied.  Thanks
> ---
>  drivers/staging/iio/TODO | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> index 4d469016a13a..0fa6a5500bdb 100644
> --- a/drivers/staging/iio/TODO
> +++ b/drivers/staging/iio/TODO
> @@ -1,9 +1,5 @@
>  2020-02-25
>  
>  
> -ADI Drivers:
> -CC the device-drivers-devel@blackfin.uclinux.org mailing list when
> -e-mailing the normal IIO list (see below).
> -
>  Contact: Jonathan Cameron <jic23@kernel.org>.
>  Mailing list: linux-iio@vger.kernel.org

