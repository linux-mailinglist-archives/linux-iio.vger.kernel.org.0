Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C711138D439
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhEVHfv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 03:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhEVHfv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 03:35:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2090611AD;
        Sat, 22 May 2021 07:34:25 +0000 (UTC)
Date:   Sat, 22 May 2021 08:35:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.13 cycle.
Message-ID: <20210522083547.2570d4b6@jic23-huawei>
In-Reply-To: <YKf5S+avRha12kAW@kroah.com>
References: <20210521181509.419b9db0@jic23-huawei>
        <YKf4IOiTV5cyd++3@kroah.com>
        <YKf5S+avRha12kAW@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 May 2021 20:17:47 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, May 21, 2021 at 08:12:48PM +0200, Greg KH wrote:
> > On Fri, May 21, 2021 at 06:15:09PM +0100, Jonathan Cameron wrote:  
> > > The following changes since commit ba9c25d94dea1a57492a606a1f5dde70d2432583:
> > > 
> > >   Merge tag 'iio-fixes-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-05-11 15:17:55 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13b  
> > 
> > Pulled and pushed out, thanks.  
> 
> Oops, nope, didn't work:
> 
>  Commit 488abb0f5c83 ("iio: gyro: fxas21002c: balance runtime power in error path")
> 	committer Signed-off-by missing
> 	author email:    rui.silva@linaro.org
> 	committer email: Jonathan.Cameron@huawei.com
> 	Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> 
> 
> I've rolled it back in my local tree and never pushed it out to the
> public.
> 
> Can you fix this up?  linux-next didn't catch this already?
> 

I'll check, but didn't see anything.  Perhaps an email filtering issue my end.

Anyhow, thanks for catching and will send fixed up version in a few mins.

Jonathan

> thanks,
> 
> greg k-h

