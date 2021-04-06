Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF25354DA8
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhDFHRg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 03:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhDFHRg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 03:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAF8761247;
        Tue,  6 Apr 2021 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617693448;
        bh=vwBEpKRzcvCFwcfYSCxpGMlCJEBgn6BosPYa/gwJ4ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4wZgcOWPorCxTnycqRQwz+wZXk853i21LDSYPVdMwK1rxkLejIe0SRxWAkWDPXDh
         4qRv5km1THlgqiPL9kUpah+QLaK7L+p8Fk1EquThXS3jLaiyJ4KkQLdjnfiu27tXJA
         AYHuwvbByzRxHh511qefV15QnJdFHVeRcL2LiY7g=
Date:   Tue, 6 Apr 2021 09:17:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.12 cycle
Message-ID: <YGwLBO66/nAtoGTr@kroah.com>
References: <20210405152057.3157af41@jic23-huawei>
 <YGtCCHz7wIbTE/UN@kroah.com>
 <20210405220029.7c8c2ef4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405220029.7c8c2ef4@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 05, 2021 at 10:00:29PM +0100, Jonathan Cameron wrote:
> On Mon, 5 Apr 2021 18:59:52 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Apr 05, 2021 at 03:20:57PM +0100, Jonathan Cameron wrote:
> > > The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:
> > > 
> > >   Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12b  
> > 
> > It's late, it's -rc6, are these really needed for 5.12-final or can they
> > wait for 5.13-rc1?
> > 
> > thanks,
> > 
> > greg k-h
> 
> They can wait.

Ok, want me to pull it into my "next" branch then?

thanks,

greg k-h
