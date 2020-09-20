Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137F271704
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 20:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgITSST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 14:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgITSST (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 14:18:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD1720870;
        Sun, 20 Sep 2020 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600625899;
        bh=MtKJZ1yPd/9uRAMKem+tJp7NNd73TF2YiUld3L4sca0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gjYWpD+40zNfSAPSQ6X+mX5RGSfrsVOx+Fsb9rq8n8NsucBSTCNNFrkGtR0SFVA56
         JIql9D8ccGAGOlHIEHaZwwgHfSFpL0M1cALLoFvPUCiHPmne38PofSNiP2TrWWqK5D
         w0YVjnCdemYliIJRaYGcVE2l7KmbIfrLuVMXqqZs=
Date:   Sun, 20 Sep 2020 19:18:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio:trigger: Remove re-poll logic.
Message-ID: <20200920191814.4a7e8a25@archlinux>
In-Reply-To: <78141dee-33a2-c28d-2e80-38918c03f81d@metafoo.de>
References: <20200920132548.196452-1-jic23@kernel.org>
        <78141dee-33a2-c28d-2e80-38918c03f81d@metafoo.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Sep 2020 17:02:32 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 9/20/20 3:25 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This code isn't used by any current mainline drivers (except
> > via error handling routes that shouldn't exist).  The original
> > user is long gone.  It is causing issues, so let's drop it.
> >
> > The main bulk of this mini-series is renaming the function to account
> > for the change in what it does.
> >
> > Lars, what impact does doing this have on your patches to mark hrtimer
> > and irq_work as expiring in hardirq context? I got a bit lost in the
> > discussion of that series, beyond figuring out his corner needed cleaning up.  
> 
> I think no impact. This is an issue that is orthogonal. I think the 
> patches should still be applied as they are.
> 
> For this series:
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Great.  Hopefully resolving this one will get us acks on that series.
I've just posted a quick note in that thread to point at this one as resolving
the latter part of that discussion.

Thanks,

Jonathan


