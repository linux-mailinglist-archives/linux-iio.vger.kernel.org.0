Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3E224BD9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGROfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROfa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:35:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDB2076A;
        Sat, 18 Jul 2020 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595082929;
        bh=B3NvPtqwN2+3k+yupeNBxRXoUdbSS71z1vEVfZCahuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EoFemmf2MiA5ycOpsGr9Cs4LSR+3tf3HBT3JsJ9+YpQxkmr3MF0axmeS7pam8FgW0
         HO4dptQBhZl7LbHjqDODIHAjAt3F6bVW0XJ7Q4NolSlHHR0HN/T7vwAhospdPqcHqO
         voK9kCdlAnxEFLmAk1HeZwBjvvs1oN8ZVJsdcCaM=
Date:   Sat, 18 Jul 2020 15:35:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>
Subject: Re: [PATCH 06/30] iio: adc: ad7923: Demote obvious misuse of
 kerneldoc to standard comment blocks
Message-ID: <20200718153525.24e68167@archlinux>
In-Reply-To: <20200716135928.1456727-7-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-7-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:04 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to document either of the demoted functions here
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/ad7923.c:159: warning: Function parameter or member 'indio_dev' not described in 'ad7923_update_scan_mode'
>  drivers/iio/adc/ad7923.c:159: warning: Function parameter or member 'active_scan_mask' not described in 'ad7923_update_scan_mode'
>  drivers/iio/adc/ad7923.c:202: warning: Function parameter or member 'irq' not described in 'ad7923_trigger_handler'
>  drivers/iio/adc/ad7923.c:202: warning: Function parameter or member 'p' not described in 'ad7923_trigger_handler'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Patrick Vasseur <patrick.vasseur@c-s.fr>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Both functions are static and hence don't need to be kernel-doc based,
hence agree this is the best 'fix'.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7923.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 1d124c87c6ace..2a11bc7fdb567 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -151,9 +151,9 @@ static const struct ad7923_chip_info ad7923_chip_info[] = {
>  	},
>  };
>  
> -/**
> +/*
>   * ad7923_update_scan_mode() setup the spi transfer buffer for the new scan mask
> - **/
> + */
>  static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *active_scan_mask)
>  {
> @@ -192,12 +192,12 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * ad7923_trigger_handler() bh of trigger launched polling to ring buffer
>   *
>   * Currently there is no option in this driver to disable the saving of
>   * timestamps within the ring.
> - **/
> + */
>  static irqreturn_t ad7923_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;

