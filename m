Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AC1A73D
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfEKI7C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 04:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfEKI7B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 04:59:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8774B2173B;
        Sat, 11 May 2019 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557565141;
        bh=5s2XQhrQ5uHBzuS+eMKK8ZKQY0sdCYlC5UD1yK8Cgpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xJZzuoFd1fg6ay0cmrpoc8I09WwzLxErCcIZoWfmJr5pDq1HiCXs2DaNHYKQ65yYz
         WXyJixqbVu9jRecU74cCJhyQPd4yeEwWHYzADTAYwId6alLTAJa9M9DG435CBk5l5a
         UQnH6kwpvnTvnZf+JMn1ustDMXw4s8bjZiQ1WjvM=
Date:   Sat, 11 May 2019 09:58:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] iio: dummy_evgen: check iio_evgen in
 iio_dummy_evgen_free()
Message-ID: <20190511095855.1aaf056b@archlinux>
In-Reply-To: <20190509020447.20243-1-wangkefeng.wang@huawei.com>
References: <20190509020447.20243-1-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 May 2019 10:04:47 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> if iio_dummy_evgen_create() fails, iio_evgen should be NULL, when call
> iio_evgen_release() to cleanup, it throws some warning and could cause
> double free.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Hi Kefeng,

I'm not seeing a path to be able to trigger this.
iio_dummy_evgen_create is called only in the module_init.
If it fails, then the init fails before the device
initialization call is made.

How would we then be running the device release call
in order to end up freeing this again?

So I think this is a false positive but perhaps there is
a path that I am missing.

Jonathan

> ---
>  drivers/iio/dummy/iio_dummy_evgen.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index c6033e341963..2327b5f52086 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -58,6 +58,7 @@ static int iio_dummy_evgen_create(void)
>  	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
>  	if (ret < 0) {
>  		kfree(iio_evgen);
> +		iio_evgen = NULL;
>  		return ret;
>  	}
>  
> @@ -118,6 +119,9 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
>  
>  static void iio_dummy_evgen_free(void)
>  {
> +	if (!iio_evgen)
> +		return;
> +
>  	irq_sim_fini(&iio_evgen->irq_sim);
>  	kfree(iio_evgen);
>  }

