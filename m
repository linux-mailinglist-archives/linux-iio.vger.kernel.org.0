Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8718E3A2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCUSXQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 14:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCUSXQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 14:23:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562EA20753;
        Sat, 21 Mar 2020 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584814996;
        bh=M090htPaj/DOtMSYrda8MnL613ues5ssiUlI6AZOQDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Uq0HFfbmiy/xmg5BWBTejz8rq8Kv3CRkPhEOE/gkhfsOjIpJWVNSM/2vKZvqUH5m
         O6SCCR69KEghSwKtr8KZHAXzW+HDpFxFLCdSC0wpb7oswiYb3nv0FQUkZnPX0O2lp6
         /ha9v18xXbN39N8V1BLwTc3rPsCFfZ4C8NpW20qA=
Date:   Sat, 21 Mar 2020 18:23:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MAINTAINERS: Add Syed Nayyar Waris to ACCES
 104-QUAD-8 driver
Message-ID: <20200321182312.57a93f88@archlinux>
In-Reply-To: <20200320133522.GA3223@icarus>
References: <20200320081257.GA5818@syed.domain.name>
        <20200320133522.GA3223@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Mar 2020 09:36:00 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Fri, Mar 20, 2020 at 01:42:58PM +0530, Syed Nayyar Waris wrote:
> > Add Syed Nayyar Waris as a co-maintainer for the ACCES 104-QUAD-8
> > counter driver.
> > 
> > Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8fa40c3..55c7794 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -276,6 +276,7 @@ F:	drivers/gpio/gpio-104-idio-16.c
> >  
> >  ACCES 104-QUAD-8 DRIVER
> >  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> > +M:	Syed Nayyar Waris <syednwaris@gmail.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > -- 
> > 2.7.4  
> 
> The 104-QUAD-8 driver is getting large so having another set of eyes on
> it is much appreciated. Thanks!
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Applied.

Thanks,

Jonathan


