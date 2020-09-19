Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED137270FB0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgISRDD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 13:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgISRDD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16CF720771;
        Sat, 19 Sep 2020 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600534983;
        bh=TpHptMcTIyIAkkgIHsyfefI8THRPanNuzVREKFgkclU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gAko3lF2QRNuoG1AIY0/bsD4RYFAFL9Cittq2SSpKiOKZKzR10QaKEQFB7ZlR3e4G
         oiTqxcbKMejYI1VSonomXZmg7U3VoqIyL+ehN61PXM0m9akWi3e3CPPMNJrLJfBjao
         3CnK8hLK/nvK3YrReyiXFKPfiSYaKZTYuLWeJwzc=
Date:   Sat, 19 Sep 2020 18:02:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 19/27] iio:pressure:mpl3115 Force alignment of buffer
Message-ID: <20200919180258.1cfdaadc@archlinux>
In-Reply-To: <20200723133142.00001b88@Huawei.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-20-jic23@kernel.org>
        <CAHp75Ve6UAs+iryEgbcxW6FtbnmUAsV_MPJ7SiiCpkT5_O0xng@mail.gmail.com>
        <20200723133142.00001b88@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 13:31:42 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 23 Jul 2020 15:17:16 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > This one is unusual.  We have to do an explicit memset each time
> > > as we are reading 3 bytes into a potential 4 byte channel which
> > > may sometimes be a 2 byte channel depending on what is enabled.
> > > As such, moving the buffer to the heap in the iio_priv structure
> > > doesn't save us much.  We can't use a nice explicit structure
> > > on the stack either as the data channels have different storage
> > > sizes and are all separately controlled.    
> > 
> > I guess all non-standard cases (where no struct is applicable) deserve
> > for better comment in the code.
> >   
> 
> Sure can do that. I guess that will mean people actually think about
> it whilst copying examples form old into new drivers.
> 
> In many ways the no struct applicable is the 'standard' case. It's
> mere coincidence that in some drivers there are sufficiently few
> channels that the struct 'trick' works.  All the other channels
> are moving around even in those cases, it's just the timestamp
> that happens to only have one valid location.
> 
> I'll probably do a v4 at the weekend.
Well a weekend anyway :)
This one is sufficiently unusual I will bring it back for a v4 with
additional information in the comment.
> 
> Jonathan
> 
> 
> 

