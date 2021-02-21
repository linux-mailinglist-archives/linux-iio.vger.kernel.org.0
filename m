Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C099320A1D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBUL4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 06:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhBUL4S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 06:56:18 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41B264EEF;
        Sun, 21 Feb 2021 11:55:36 +0000 (UTC)
Date:   Sun, 21 Feb 2021 11:55:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH 0/2] iio: core,buffer-dma: 2 fixes for the recent IIO
 buffer series
Message-ID: <20210221115535.5f380d99@archlinux>
In-Reply-To: <20210219085826.46622-1-alexandru.ardelean@analog.com>
References: <20210219085826.46622-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Feb 2021 10:58:24 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Patchset contains 2 fixes for some patches that are present in the
> iio/testing branch.
> 
> No idea what's best now, either to re-send the series or to just send these
> fixes on their own.
> For now I chose to send the fixes on their (due to lack of time).
> 
> These could be squashed into the original.
>
That is the approach I've taken.

Tidier to do it this way as I'd not yet pushed the tree out other than as
testing.

Thanks,

Jonathan
 
> I can also re-send the series, but not from an Analog email; since I will
> not have access to it.
> 
> Alexandru Ardelean (2):
>   iio: core: use kfree_const in iio_free_chan_devattr_list() to free
>     names
>   iio: buffer-dma: fix type of 'i' in iio_dma_buffer_alloc_blocks()
> 
>  drivers/iio/buffer/industrialio-buffer-dma.c | 3 +--
>  drivers/iio/industrialio-core.c              | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 

