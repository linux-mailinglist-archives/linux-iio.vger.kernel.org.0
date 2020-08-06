Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3055E23E15D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHFSqb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFSqb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:46:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088F22224D;
        Thu,  6 Aug 2020 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596739591;
        bh=Tc6ZE7AVfMeSt+O7CH/Xtb/TQi8vFhleir113iZU9nk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mq/DXRBRWmTO9+SeQyl/OqpUPDubfhn1qdads299i1+Hnm6Uag0B3Atup3O1K/Zxd
         8epjj374a4DVN6fD+mu4yTr8JAzkiYURaYD8rX96r6QY0M9RUzRwIIPJ5bm0gyNg3F
         xPXoqm+JuuAK1BHXWNNVcCp+a1dKLPVUw3j22zCE=
Date:   Thu, 6 Aug 2020 19:46:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        development@norphonic.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
Message-ID: <20200806194626.6e7b2545@archlinux>
In-Reply-To: <86zh7ak8ub.fsf@norphonic.com>
References: <86d053d1re.fsf@norphonic.com>
        <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
        <20200712115444.49dc18c6@archlinux>
        <86zh7ak8ub.fsf@norphonic.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 04 Aug 2020 12:23:56 +0200
Eugene Zaikonnikov <ez@norphonic.com> wrote:

> Hello,
> 
> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Sat, 11 Jul 2020 18:27:09 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  
> 
> [...]
> 
> >> 4. IIO_CONST_ATTR can be one line, but hey don't we have IIO core to
> >> take care of it?  
> >
> > For that one, we could indeed use the read_avail callback here
> > for the out_current_heater_raw_available. I've not yet started insisting
> > on this because of the huge number of drivers that predate introduction of
> > that stuff to the core and as a result a lack of good examples.
> > Eugene, if you are happy to change this one over to that and hence act
> > as an example it would be great!
> >  
> Just looked into that.
> 
> We use this driver here with trees as early as 4.9.11, and it does not
> appear to have this callback in iio_info yet. Hope it's OK as it is in
> this iteration.
OK.   It is more than possible that someone will post patches tidying
that up though and I'm not going to reject them to make life easier
for your older trees.  For now, put a note in the commit log though
so I don't forget it.

Thanks,

Jonathan

> 
> --
> Regards,
> 
>   Eugene Zaikonnikov
> 
>   Norphonic AS
>   Tel: +47 98 23 97 73

