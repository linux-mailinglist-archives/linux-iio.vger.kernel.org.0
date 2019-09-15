Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75978B2FDA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfIOM1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfIOM1h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:27:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B271A2077C;
        Sun, 15 Sep 2019 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568550457;
        bh=cGEprIDaDRypp/jvKRA6/oNrR9SzlRSEXe1ZTC5S/aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qy/LRa9ZusG+ehud1eGItbsZJED0f2AFn4PVSHi/nl1h/XhkaRu5Hb/4poyRAl8oG
         q31YvArJsIV2g3Jo3rxukQEY/ybHWVGv2cmHh3hsWGp7/JgXJzYx9qQhHlyfFB0nSb
         8aX52n/AUsb/oH67QQe+FlAWNdWfZSMqTf/Pi+xY=
Date:   Sun, 15 Sep 2019 13:27:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     paresh.chaudhary@rockwellcollins.com,
        patrick.havelange@essensium.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: max31856: add missing of_node and parent
 references to iio_dev
Message-ID: <20190915132732.776423d7@archlinux>
In-Reply-To: <20190909125817.17882-1-andrea.merello@gmail.com>
References: <20190909125817.17882-1-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Sep 2019 14:58:17 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Adding missing indio_dev->dev.of_node references so that, in case multiple
> max31856 are present, users can get some clues to being able to distinguish
> each of them. While at it, add also the missing parent reference.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index f184ba5601d9..73ed550e3fc9 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -284,6 +284,8 @@ static int max31856_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->info = &max31856_info;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
>  	indio_dev->name = id->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = max31856_channels;

