Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEB23FE08
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHILum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgHILum (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:50:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D26206B5;
        Sun,  9 Aug 2020 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596973841;
        bh=xirVYyDePN9qqDQ3YHBrlv/ETjNfR0VH1Kp8z1K5KJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AhiwD2jg0yi1IU8ZLSwk7v8+/HfZpWnPt51+LkDzjZUHjsAYNgNPXR9p/8+3D5GIc
         46uBeAbfC0yLdwHrQntdVM1YWIT6uhQ83gKvcUkKrnYSDFqZo1k+Ltl8ysi6f15TY3
         tT2AZ+pD3DoiaZo424LPaMvbkQ2AcmH7WhdDew7c=
Date:   Sun, 9 Aug 2020 12:50:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, bigunclemax@gmail.com
Subject: Re: [PATCH v4] iio: adc: ti-ads1015: fix conversion when CONFIG_PM
 is not set
Message-ID: <20200809125035.5c24a5b5@archlinux>
In-Reply-To: <20200803050405.6008-1-fido_max@inbox.ru>
References: <20200803050405.6008-1-fido_max@inbox.ru>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Aug 2020 08:04:05 +0300
Maxim Kochetkov <fido_max@inbox.ru> wrote:

> To stop conversion ads1015_set_power_state() function call unimplemented
> function __pm_runtime_suspend() from pm_runtime_put_autosuspend()
> if CONFIG_PM is not set.
> In case of CONFIG_PM is not set: __pm_runtime_suspend() returns -ENOSYS,
> so ads1015_read_raw() failed because ads1015_set_power_state() returns an
> error.
> 
> If CONFIG_PM is disabled, there is no need to start/stop conversion.
> Fix it by adding return 0 function variant if CONFIG_PM is not set.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Fixes: ecc24e72f437 ("iio: adc: Add TI ADS1015 ADC driver support")
> Tested-by: Maxim Kiselev <bigunclemax@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Note that I didn't actually give this tag.  It must be formally
given by someone rather than saying a patch looks fine.

Personally I don't give reviewed-by tags for IIO patches as they will
have my sign off anyway and that also reflects having reviewed them.

Applied to the fixes-togreg branch of iio.git (which will be rebased shortly
after rc1 is out) and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1015.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 5ea4f45d6bad..64fe3b2a6ec6 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -316,6 +316,7 @@ static const struct iio_chan_spec ads1115_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
>  };
>  
> +#ifdef CONFIG_PM
>  static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  {
>  	int ret;
> @@ -333,6 +334,15 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  	return ret < 0 ? ret : 0;
>  }
>  
> +#else /* !CONFIG_PM */
> +
> +static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_PM */
> +
>  static
>  int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  {

