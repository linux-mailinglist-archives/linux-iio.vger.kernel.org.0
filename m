Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05B0356629
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbhDGIMS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 04:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhDGIMR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Apr 2021 04:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1630D6139E;
        Wed,  7 Apr 2021 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617783128;
        bh=6277nGItjeBVSZhHkHxCZMLCDSOSVpCZahD0bwdVTZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNZZWIr37YviGL0HABm+J/l5vac6x3p//bq8gBLVtTp7as51mDiTpRcfenu/G24WD
         rvF6wi5no7d4ISDF9cGjwyOQIc3OyXQJesdQFn4oNmuHPnFkiE+kamobETXc1Id4CT
         ZT30o/FTM0/VfbvE1zHPCAzIJgcJAezJAUU4OdYk=
Date:   Wed, 7 Apr 2021 10:09:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO features and cleanup etc for 5.13
Message-ID: <YG1oxfArId3AcSGT@kroah.com>
References: <20210406220555.0d6bc9b6@jic23-huawei>
 <YG1SvdUpcSSc2ZsK@kroah.com>
 <20210407084332.6ac35e61@jic23-huawei>
 <20210407085907.0dd1e53b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407085907.0dd1e53b@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 07, 2021 at 08:59:07AM +0100, Jonathan Cameron wrote:
> On Wed, 7 Apr 2021 08:43:32 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 7 Apr 2021 08:35:41 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Tue, Apr 06, 2021 at 10:05:55PM +0100, Jonathan Cameron wrote:  
> > > > The following changes since commit 9c15db92a8e56bcde0f58064ac1adc28c0579b51:
> > > > 
> > > >   Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-03-26 12:09:47 +0100)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.13b    
> > > 
> > > It looks like I had a minor cleanup fix to one of the files you removed
> > > from staging in my tree, but that was reasy to resolve.
> > > 
> > > However, I got the following error when trying to push these out:
> > > 
> > > Commit: b3c20190dd32 ("iio: Fix iio_read_channel_processed_scale()")
> > > 	Fixes tag: Fixes: dc98269f7c7d ("iio: Provide iio_read_channel_processed_scale() API")
> > > 	Has these problem(s):
> > > 	        - Target SHA1 does not exist
> > > 
> > > Where did that git commit id come from?  
> > 
> > There were a bunch of rebases earlier this cycle that must have crossed.
> > 
> > Oddly the fixes checking script I've been using is happy with that
> > id but it's clearly wrong.  *sigh*  I'll have to take a closer look
> > at what it is doing.  Sorry about that.
> > 
> > Anyhow, rebased with that tag fixes and I'll send a new pull in a few minutes
> > 
> > Jonathan
> 
> As a side note on this, would you mind if I asked for linux-next to include
> the iio togreg and fixes-togreg branches directly?

Not at all!

> Might be good to benefit from the extra testing coverage that will give
> before I get anywhere near sending you a pull request.
> No replacement for local scripts but might pick up on when they go wrong
> as happened here.

That would be great, it would make me feel good to have these tested in
linux-next and then if that passes I "know" all should be fine.

thanks,

greg k-h
