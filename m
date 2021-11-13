Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7256144F47E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 19:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhKMSVk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 13:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhKMSVk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 13:21:40 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBDB6112F;
        Sat, 13 Nov 2021 18:18:46 +0000 (UTC)
Date:   Sat, 13 Nov 2021 18:23:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/5] iio: adc: ad_sigma_delta: Add sequencer support
Message-ID: <20211113182334.0486a4a0@jic23-huawei>
In-Reply-To: <CAHp75Vf8+HH8t-pqXtd3=FT5=9T4T2ke+ceQ-pyAyvmH2pN9zQ@mail.gmail.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
        <20211110111750.27263-4-alexandru.tachici@analog.com>
        <20211112171448.79b4e8cc@jic23-huawei>
        <CAHp75Vf8+HH8t-pqXtd3=FT5=9T4T2ke+ceQ-pyAyvmH2pN9zQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 13 Nov 2021 19:00:11 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Nov 12, 2021 at 7:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed, 10 Nov 2021 13:17:48 +0200
> > <alexandru.tachici@analog.com> wrote:  
> 
> 
> > > +     kfree(sigma_delta->samples_buf);  
> >
> > krealloc() preferred.   It might not be necessary to actually do an allocation after all
> > if we happen to have one we can already use.  
> 
> Looking at below, shouldn't it be krealloc_array()?

True

> 
> > > +     sigma_delta->samples_buf = kzalloc(slot * indio_dev->channels[0].scan_type.storagebits,
> > > +                                        GFP_KERNEL);  
> 
> 

