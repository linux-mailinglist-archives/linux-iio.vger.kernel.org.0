Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE74F354E81
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhDFIZs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 04:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232791AbhDFIZq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 04:25:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98D5613C0;
        Tue,  6 Apr 2021 08:25:38 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:25:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.12 cycle
Message-ID: <20210406092554.7de6842b@jic23-huawei>
In-Reply-To: <YGwLBO66/nAtoGTr@kroah.com>
References: <20210405152057.3157af41@jic23-huawei>
        <YGtCCHz7wIbTE/UN@kroah.com>
        <20210405220029.7c8c2ef4@jic23-huawei>
        <YGwLBO66/nAtoGTr@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Apr 2021 09:17:24 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 05, 2021 at 10:00:29PM +0100, Jonathan Cameron wrote:
> > On Mon, 5 Apr 2021 18:59:52 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Mon, Apr 05, 2021 at 03:20:57PM +0100, Jonathan Cameron wrote:  
> > > > The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:
> > > > 
> > > >   Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12b    
> > > 
> > > It's late, it's -rc6, are these really needed for 5.12-final or can they
> > > wait for 5.13-rc1?
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > They can wait.  
> 
> Ok, want me to pull it into my "next" branch then?

I'll add them to a pull request I should be sending out later today or
tomorrow.

A couple of them will want stable tags (which didn't make sense
when the fixes were for things in the 5.12 cycle).

Jonathan

> 
> thanks,
> 
> greg k-h

