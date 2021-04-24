Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2536D36A18D
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhDXOPR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhDXOPR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 10:15:17 -0400
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4854C061574
        for <linux-iio@vger.kernel.org>; Sat, 24 Apr 2021 07:14:38 -0700 (PDT)
Received: from [81.101.6.87] (port=48670 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1laJ3M-0004s3-Of; Sat, 24 Apr 2021 15:14:37 +0100
Date:   Sat, 24 Apr 2021 15:15:14 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
Message-ID: <20210424151455.0de017f4@jic23-huawei>
In-Reply-To: <20210411152120.0c806bba@jic23-huawei>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <20210411152120.0c806bba@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Apr 2021 15:21:20 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 8 Apr 2021 19:38:09 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
> > Some devm variants are implemented with devres_alloc() and devres_add()
> > manually to only manage a single pointer. This can be simplified with
> > devm_add_action_or_reset() which works the same. Simplify these functions.
> > 
> > Yicong Yang (7):
> >   iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
> >   iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
> >   iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
> >   iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
> >   iio: core: simplify some devm functions
> >   iio: trigger: simplify __devm_iio_trigger_register
> >   iio: inkern: simplify some devm functions  
> 
> Nice set.  Note no rush for a v2 as IIO is effectively closed for the
> coming merge window.  Hence these won't hit linux-next now until after
> the merge window closes.

On second thoughts was just easier for me to make the minor tweaks and
apply so I did that.

All applied to the togreg branch of iio.git and pushed out as testing
for autobuilders etc to poke at.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> >  drivers/iio/adc/adi-axi-adc.c                      | 22 ++++----
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 ++++----
> >  drivers/iio/buffer/industrialio-hw-consumer.c      | 25 ++++-----
> >  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 ++-----
> >  drivers/iio/industrialio-core.c                    | 43 ++++++---------
> >  drivers/iio/industrialio-trigger.c                 | 18 ++-----
> >  drivers/iio/inkern.c                               | 61 ++++++++--------------
> >  7 files changed, 78 insertions(+), 132 deletions(-)
> >   
> 

