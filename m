Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CCE2AABF9
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgKHPoY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHPoY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:44:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212F9206ED;
        Sun,  8 Nov 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604850264;
        bh=lWRwKPSiKjQ0WuQ3nEx5TJwEaexQ7sJVjLMlh+GMQUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SMgmfuQmJ0OHb/6RkKENeFK/Ml/PQLEIyiHzQWIVF4+QlRWpX82Lb5AmOyPJ0J/JC
         8zwD94xj8cDQqWmvA7+WLGIkiAvkrcgv55yXmBvUpgP1IEvt7u0WoDKE6NuWiVdI6B
         OmvHGe9dg/WATuE0gpq2FXGnW8XLCEI7mFFf+u9k=
Date:   Sun, 8 Nov 2020 15:44:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     pn@denx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu
Subject: Re: [PATCH] iio: light: fix kconfig dependency bug for VCNL4035
Message-ID: <20201108154420.4982d232@archlinux>
In-Reply-To: <20201102223523.572461-1-fazilyildiran@gmail.com>
References: <20201102223523.572461-1-fazilyildiran@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Nov 2020 01:35:24 +0300
Necip Fazil Yildiran <fazilyildiran@gmail.com> wrote:

> When VCNL4035 is enabled and IIO_BUFFER is disabled, it results in the
> following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for IIO_TRIGGERED_BUFFER
>   Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
>   Selected by [y]:
>   - VCNL4035 [=y] && IIO [=y] && I2C [=y]
> 
> The reason is that VCNL4035 selects IIO_TRIGGERED_BUFFER without depending
> on or selecting IIO_BUFFER while IIO_TRIGGERED_BUFFER depends on
> IIO_BUFFER. This can also fail building the kernel.
> 
> Honor the kconfig dependency to remove unmet direct dependency warnings
> and avoid any potential build failures.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209883
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index cade6dc0305b..33ad4dd0b5c7 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -544,6 +544,7 @@ config VCNL4000
>  
>  config VCNL4035
>  	tristate "VCNL4035 combined ALS and proximity sensor"
> +	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP_I2C
>  	depends on I2C

