Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601CC4325A0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhJRR4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 13:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232040AbhJRR4B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 13:56:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A9160F02;
        Mon, 18 Oct 2021 17:53:48 +0000 (UTC)
Date:   Mon, 18 Oct 2021 18:58:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        "William Breathitt Gray" <vilhelm.gray@gmail.com>
Subject: Re: [PULL] 1st set of counter subsystem new features for the 5.16
 cycle.
Message-ID: <20211018185803.0b4bcdd4@jic23-huawei>
In-Reply-To: <20211018164846.0000470b@Huawei.com>
References: <20211017112717.1c1d8779@jic23-huawei>
        <YW2WjGuci2d+gK5L@kroah.com>
        <20211018164846.0000470b@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 16:48:46 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 18 Oct 2021 17:45:16 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sun, Oct 17, 2021 at 11:27:17AM +0100, Jonathan Cameron wrote:  
> > > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > > 
> > >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/counter-for-5.16a
> > > 
> > > for you to fetch changes up to c9638a65d7982b5069a500cc5c504e7a7faa2676:    
> > 
> > I get the following error when trying to push this from my scripts:
> > 
> > Commit: 50cda7cc4ab1 ("counter: fix docum. build problems after filename change")
> > 	Fixes tag: Fixes: d70e46af7531 ("counter: Internalize sysfs interface code")
> > 	Has these problem(s):
> > 	        - Target SHA1 does not exist
> > 
> > Was this caused by rebasing?
> > 
> > thanks,
> > 
> > greg k-h  
> 
> Almost certainly.  I remember checking the IIO pull but guess I forgot to run
> the test script on the Counter one.  Will tidy up and resend.
> 
False memory on the IIO tree being fine.   Gah. I hate rebases.

Anyhow, new pull requests coming up once I've unwound this.

Jonathan

> Thanks,
> 
> Jonathan

