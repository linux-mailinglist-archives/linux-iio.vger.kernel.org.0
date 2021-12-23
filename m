Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A647E412
	for <lists+linux-iio@lfdr.de>; Thu, 23 Dec 2021 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbhLWNZY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Dec 2021 08:25:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51800 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348338AbhLWNZW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Dec 2021 08:25:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C955861E51
        for <linux-iio@vger.kernel.org>; Thu, 23 Dec 2021 13:25:20 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 5B644C36AE9;
        Thu, 23 Dec 2021 13:25:16 +0000 (UTC)
Date:   Thu, 23 Dec 2021 13:30:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: ad7192: Use sysfs_emit()
Message-ID: <20211223133051.5b2213e1@jic23-huawei>
In-Reply-To: <20211216185217.1054495-4-lars@metafoo.de>
References: <20211216185217.1054495-1-lars@metafoo.de>
        <20211216185217.1054495-4-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 19:52:07 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> knows about the sysfs buffer specifics and has some built-in checks for
> size and alignment.
> 
> Use sysfs_emit() to format the custom `ac_excication` and `bridge_swtich`
excitation

I'll fix up whilst applying if this doesn't need a respin for other reasons.

> attributes of the ad7192 driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/ad7192.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index cc990205f306..47d3f56edcbc 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -433,7 +433,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
> +	return sysfs_emit(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
>  }
>  
>  static ssize_t ad7192_show_bridge_switch(struct device *dev,
> @@ -443,7 +443,7 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
> +	return sysfs_emit(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
>  }
>  
>  static ssize_t ad7192_set(struct device *dev,

