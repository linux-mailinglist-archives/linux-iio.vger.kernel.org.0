Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48BB3ECA1D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhHOP5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 11:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238473AbhHOP5K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 11:57:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A87C61157;
        Sun, 15 Aug 2021 15:56:33 +0000 (UTC)
Date:   Sun, 15 Aug 2021 16:59:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
Message-ID: <20210815165932.2e66a04d@jic23-huawei>
In-Reply-To: <20210815154555.6770bc8d@jic23-huawei>
References: <20210814135509.4500-1-len.baker@gmx.com>
        <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
        <20210815081949.GA1664@titan>
        <20210815154555.6770bc8d@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Aug 2021 15:45:55 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 15 Aug 2021 10:19:49 +0200
> Len Baker <len.baker@gmx.com> wrote:
> 
> > Hi Andy,
> > 
> > On Sat, Aug 14, 2021 at 10:36:18PM +0300, Andy Shevchenko wrote:  
> > > On Sat, Aug 14, 2021 at 4:55 PM Len Baker <len.baker@gmx.com> wrote:    
> > > >
> > > > strcpy() performs no bounds checking on the destination buffer. This
> > > > could result in linear overflows beyond the end of the buffer, leading
> > > > to all kinds of misbehaviors. So, remove all the uses and add
> > > > devm_kstrdup() or devm_kasprintf() instead.
> > > >
> > > > This patch is an effort to clean up the proliferation of str*()
> > > > functions in the kernel and a previous step in the path to remove
> > > > the strcpy function from the kernel entirely [1].
> > > >
> > > > [1] https://github.com/KSPP/linux/issues/88    
> > >
> > > Thank you very much for doing this!
> > > Now I like the result,  
> Agreed and applied to the togreg branch of iio.git, pushed out as testing
> for 0-day to poke at it and see if we missed anything.

Dropped it for now so that Joe's comment can be addressed / discussed.

Jonathan

> 
> Thanks,
> 
> Jonathan
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>   
>  
> > 
> > Thank you too Andy (and folks) for your help on this.
> > 
> > Regards,
> > Len  
> 

