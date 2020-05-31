Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16A1E972A
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgEaLBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEaLBr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:01:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E750420671;
        Sun, 31 May 2020 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922907;
        bh=2cQ09FIuOIOn6lN8+8xqrm/XLzIVr6TSpW1peH0A3qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g3Gi5520bxYGzzbhGlpw9h9SN/w81PQ+0j5st4KFQ4zcPNsilcCZbg1Ls/NY7a37w
         NCiw0Ep9/gbTWA2Om3/VdUaMbz+F7T/JevyGOvlEwJ33BwTKsuGxuzFihAXZ6OY0QV
         c/4nxju2488usMJAtjm7yFsniMS+efxFn8UGbGUg=
Date:   Sun, 31 May 2020 12:01:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [PATCH v7 4/5] iio: magnetometer: ak8975: Fix typo, uniform
 measurement unit style
Message-ID: <20200531120143.4cea5799@archlinux>
In-Reply-To: <20200528150018.11953-1-jonathan.albrieux@gmail.com>
References: <20200528150018.11953-1-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 17:00:17 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Minor comment style edits.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied
> ---
>  drivers/iio/magnetometer/ak8975.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 3c881541ae72..fd368455cd7b 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -385,9 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  		return ret;
>  	}
>  	/*
> -	 * According to the datasheet the power supply rise time i 200us
> +	 * According to the datasheet the power supply rise time is 200us
>  	 * and the minimum wait time before mode setting is 100us, in
> -	 * total 300 us. Add some margin and say minimum 500us here.
> +	 * total 300us. Add some margin and say minimum 500us here.
>  	 */
>  	usleep_range(500, 1000);
>  	return 0;

