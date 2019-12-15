Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45C11F889
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 16:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfLOPjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 10:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfLOPjS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 10:39:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C43A206E0;
        Sun, 15 Dec 2019 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576424357;
        bh=1akoh02PQT7oTwhtBni7ybOmqLDd840J9tVkKk5vnwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x2FliTRdiMOWJjzlK0Ce8YZ91Zz4KEn+IXUZQmeG73M1YElC/6Htz3iEpn5aluJPW
         CysbZWSsHDh/OaS9JIhphAKOYXOkK/x+SbIfgyFuwng56k81L54yWLuKMT2Y6vKK+L
         holwUrdx+bTf9cPgka/NP0Ouwfo4po9OiKtLrwF0=
Date:   Sun, 15 Dec 2019 15:39:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: Fix DT channel configuration
Message-ID: <20191215153913.4086824c@archlinux>
In-Reply-To: <20191210090621.21714-1-alexandru.tachici@analog.com>
References: <20191210090621.21714-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Dec 2019 11:06:21 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch fixes device tree channel configuration.
> 
> Before this patch, the driver assumed that the DT children (adc channels)
> are parsed in the order they are written in the DT. Now the driver uses the
> reg property of each child to correctly identify to which channel the
> parsed configuration belongs to.
> 
> Fixes b3af341bbd966: ("iio: adc: Add ad7124 support")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Hi Alexandru.

Patch seems correct to me, but I'd like a little more detail in this
description.  Could you give an example of what goes wrong without this
patch?  That will be useful for people to understand if this patch is
fixing a problem they are seeing.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7124.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index edc6f1cc90b2..43a56c6f4cf3 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -489,13 +489,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  		st->channel_config[channel].buf_negative =
>  			of_property_read_bool(child, "adi,buffered-negative");
>  
> -		*chan = ad7124_channel_template;
> -		chan->address = channel;
> -		chan->scan_index = channel;
> -		chan->channel = ain[0];
> -		chan->channel2 = ain[1];
> -
> -		chan++;
> +		chan[channel] = ad7124_channel_template;
> +		chan[channel].address = channel;
> +		chan[channel].scan_index = channel;
> +		chan[channel].channel = ain[0];
> +		chan[channel].channel2 = ain[1];
>  	}
>  
>  	return 0;

