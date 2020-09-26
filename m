Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52154279A8E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgIZP7b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 11:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgIZP7b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 11:59:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC42221527;
        Sat, 26 Sep 2020 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601135970;
        bh=KywDDmAD+/EjY9HWMhKoYxralCAzhcbvsQ46EOOQ/Kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AegnDm8GIRw+voOq9E82VuPxLMZSl7RXimytHMmLh4MNZo4alRvLOgMlxDSKuOt5p
         uLectIv5uBidG7Aus35fHugtnZlMyHjTKuU9LRL5eftyHZnCGD0qnI6XNrd6TznjKh
         DM7B8j74V4FRYfejNJu5/64sHD70V0k8r8Ggw9lE=
Date:   Sat, 26 Sep 2020 16:59:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH 0/3] iio: add titles to some Kconfig symbols
Message-ID: <20200926165925.1e91afe7@archlinux>
In-Reply-To: <20200924111758.196367-1-alexandru.ardelean@analog.com>
References: <20200924111758.196367-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 14:17:55 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> For some embedded systems, a workflow involving external kernel modules
> that implement IIO devices is more practical than working with in-tree
> sources. However, there are number of features in the IIO KConfig that can
> only be switched on by enabling a particular sensor.
> 
> This came as a request a few years back:
>    https://github.com/analogdevicesinc/linux/issues/140
> 
> This patch implements that request.
> 
> After a quick run-through the iio Kconfig files, 4 seem to be useful to add
> titles to.
> i.e. IIO_TRIGGERED_EVENT, IIO_TRIGGERED_BUFFER, IIO_BUFFER_DMAENGINE &
> IIO_BUFFER_DMA.
> 
> It's possible that for some out-of-tree drivers this could be useful.
I'm not particular keen on changes to support out of tree stuff, but
these are so trivial there is effectively 0 cost to doing it

Hence, series applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to find out if I'm wrong :)

Thanks,

Jonathan

> 
> Alexandru Ardelean (3):
>   iio: dma-buffer: Kconfig: Provide titles for IIO DMA Kconfig symbols
>   iio: Kconfig: Provide title for IIO_TRIGGERED_EVENT symbol
>   iio: buffer: Kconfig: add title for IIO_TRIGGERED_BUFFER symbol
> 
>  drivers/iio/Kconfig        |  2 +-
>  drivers/iio/buffer/Kconfig | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 

