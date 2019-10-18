Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81151DCF01
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 21:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfJRTGu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 15:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRTGt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 15:06:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E912070B;
        Fri, 18 Oct 2019 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425609;
        bh=3lK0wB758Ik+tkuSgnpRHRP48j0abQLzjZeE0VJEzHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BpU18IUuHSguSYupSHi6mZ1KiegdbcVsmG2anFQFQdcZIx32mn/yjREcjBZbW9l6/
         jb43t1p/xNivIekfgPZqYajbBqXaHEp0m/7OlD8nL6fjINSyC3uodXCMxscGbDadcf
         RyOgDqtwvPBj4+zd0u8KOIr2el34boso9ZLjrBis=
Date:   Fri, 18 Oct 2019 20:06:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH] iio: adc: xilinix-xadc: use
 devm_platform_ioremap_resource
Message-ID: <20191018200645.1f77d67d@archlinux>
In-Reply-To: <CAGngYiVPbgt1YTemHuBJ_oggd8RvfcmyUE5kapfSYCwTzNJmDw@mail.gmail.com>
References: <20191013164848.2069381-1-jic23@kernel.org>
        <CAGngYiVPbgt1YTemHuBJ_oggd8RvfcmyUE5kapfSYCwTzNJmDw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Oct 2019 15:56:36 -0400
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Sun, Oct 13, 2019 at 12:50 PM <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Reduces local boilerplate.
> > Suggested by coccinelle.
> >  CHECK   drivers/iio/adc/xilinx-xadc-core.c
> > drivers/iio/adc/xilinx-xadc-core.c:1184:1-11: WARNING: Use devm_platform_ioremap_resource for xadc -> base
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Manish Narani <manish.narani@xilinx.com>
> > Cc: Sven Van Asbroeck <thesven73@gmail.com>
> > ---
> >  drivers/iio/adc/xilinx-xadc-core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)  
> 
> Looks good to me:
> 
> Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>

Applied,

Thanks,

Jonathan


