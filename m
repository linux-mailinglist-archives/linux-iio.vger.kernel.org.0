Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936D61DD626
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgEUSkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUSkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:40:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABF9206C3;
        Thu, 21 May 2020 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590086423;
        bh=WilSX/tvB1ZgGJHt9Z4h/gS/HMv0mGFmgDv17bIMFdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o99OUrvH4iYPkWT7frQqqRHqpSAXvHUYPWpLTmutilY/rrnU/eCuzE+ZEN845PEgE
         tNbEooJ7WgIYj+EUrpLRebb5Pi/hTpb1ySFBB31cJyXzOq3djpfuEv5wSF/BQUcIpd
         Gs19tOIwzIA71N6ORfOgwcc/zYWZpMpKn5Qnyp2Y=
Date:   Thu, 21 May 2020 19:40:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <ak@it-klinger.de>
Subject: Re: [PATCH v2] iio: proximity: ping: pass reference to IIO device
 as param to ping_read()
Message-ID: <20200521194020.5cb1ac16@archlinux>
In-Reply-To: <20200518133813.403903-1-alexandru.ardelean@analog.com>
References: <20200518133813.403903-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 16:38:13 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since there will be some changes to how iio_priv_to_dev() is implemented,
> it could be that the helper becomes a bit slower, as it will be hidden away
> in the IIO core.
> 
> But even without that rework, this looks like it can pass the 'indio_dev'
> object to ping_read() and obtain the state struct via iio_priv() which is a
> preferred practice than going back-n-forth (getting the state-struct, then
> using iio_priv_to_dev() to get the indio_dev object back).
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seems trivial and unlikely to have any issues so I'll take this one
without waiting any longer.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * split away from series
> * pass 'indio_dev' to ping_read() and get the info via iio_priv()
> 
>  drivers/iio/proximity/ping.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index 12b893c5b0ee..2e99eeb27f2e 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -89,14 +89,14 @@ static irqreturn_t ping_handle_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int ping_read(struct ping_data *data)
> +static int ping_read(struct iio_dev *indio_dev)
>  {
> +	struct ping_data *data = iio_priv(indio_dev);
>  	int ret;
>  	ktime_t ktime_dt;
>  	s64 dt_ns;
>  	u32 time_ns, distance_mm;
>  	struct platform_device *pdev = to_platform_device(data->dev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(data);
>  
>  	/*
>  	 * just one read-echo-cycle can take place at a time
> @@ -228,7 +228,6 @@ static int ping_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *channel, int *val,
>  			    int *val2, long info)
>  {
> -	struct ping_data *data = iio_priv(indio_dev);
>  	int ret;
>  
>  	if (channel->type != IIO_DISTANCE)
> @@ -236,7 +235,7 @@ static int ping_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = ping_read(data);
> +		ret = ping_read(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;

