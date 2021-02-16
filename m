Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268831D16C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 21:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBPURa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 15:17:30 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:52286 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBPUR1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2021 15:17:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1F8789E0083;
        Tue, 16 Feb 2021 20:08:26 +0000 (GMT)
Date:   Tue, 16 Feb 2021 20:08:25 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/5] docs: iio: fix bullet list formatting
Message-ID: <20210216200825.3426bb77@archlinux>
In-Reply-To: <20210215143511.25471-5-luca@lucaceresoli.net>
References: <20210215143511.25471-1-luca@lucaceresoli.net>
        <20210215143511.25471-5-luca@lucaceresoli.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 15:35:10 +0100
Luca Ceresoli <luca@lucaceresoli.net> wrote:

> This 2nd-level bullet list is not properly ReST-formatted and thus it gets
> rendered as a unique paragraph quite unreadable.  Fix by adding spaces as
> needed.
> 
> While there also swap "shift" and "repeat" so they are in the correct
> order.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/driver-api/iio/buffers.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
> index 9dad7c94034b..5801caf216a6 100644
> --- a/Documentation/driver-api/iio/buffers.rst
> +++ b/Documentation/driver-api/iio/buffers.rst
> @@ -38,15 +38,16 @@ attributes of the following form:
>  * :file:`type`, description of the scan element data storage within the buffer
>    and hence the form in which it is read from user space.
>    Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift] .
> +
>    * *be* or *le*, specifies big or little endian.
>    * *s* or *u*, specifies if signed (2's complement) or unsigned.
>    * *bits*, is the number of valid data bits.
>    * *storagebits*, is the number of bits (after padding) that it occupies in the
> -  buffer.
> -  * *shift*, if specified, is the shift that needs to be applied prior to
> -  masking out unused bits.
> +    buffer.
>    * *repeat*, specifies the number of bits/storagebits repetitions. When the
> -  repeat element is 0 or 1, then the repeat value is omitted.
> +    repeat element is 0 or 1, then the repeat value is omitted.
> +  * *shift*, if specified, is the shift that needs to be applied prior to
> +    masking out unused bits.
>  
>  For example, a driver for a 3-axis accelerometer with 12 bit resolution where
>  data is stored in two 8-bits registers as follows::
> @@ -123,4 +124,3 @@ More details
>  .. kernel-doc:: include/linux/iio/buffer.h
>  .. kernel-doc:: drivers/iio/industrialio-buffer.c
>     :export:
> -
This shouldn't be in here really but it's so minor lets not bother fixing it.

Jonathan

