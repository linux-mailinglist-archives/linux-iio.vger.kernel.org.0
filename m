Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F786273268
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIUTFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 15:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUTFh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 15:05:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D559F2054F;
        Mon, 21 Sep 2020 19:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600715137;
        bh=65I2+Uypw52sBROUYjUm5KBOwLLpwCWUWUURDKNaaBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V68b9funpXNoXmWJR0b7sKS0qDmCsyC2Odz3eW7KyUhlw9qhUJk1kBIA4J16kXplT
         VvmN1GQkwRROnbqS1nIefih965LNZ9BUhiswrJBgBZB9/3HyX2d0LL9G9NIoBD3XbM
         1GwTuwpCuTa4ipsAFbAJbQHVs6WLb4VTW0+DlFfA=
Date:   Mon, 21 Sep 2020 20:05:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of features and cleanup for IIO in the 5.10
 cycle.
Message-ID: <20200921200534.0e2b32fb@archlinux>
In-Reply-To: <20200921185230.GA1429057@kroah.com>
References: <20200921190808.2f0af905@archlinux>
        <20200921185230.GA1429057@kroah.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 20:52:30 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Sep 21, 2020 at 07:08:08PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 2f0472a1f80e6230f126aa0af76e89f85abc37bd:
> > 
> >   drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon (2020-09-06 16:05:56 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10b
> > 
> > for you to fetch changes up to eda7a4890f5825f1a01d635ab25235f4dacb8715:
> > 
> >   dt-bindings: iio: vishay,vcnl4000: add interrupts property (2020-09-21 18:54:26 +0100)  
> 
> So close:
> 
> Commit: 7bf38af6540e ("iio:accel:bma180: Fix use of true when should be iio_shared_by enum")
> 	Fixes tag: Fixes: fdadbce0da4 ("iio: add Bosch BMA180 acceleration sensor driver")
> 	Has these problem(s):
> 	        - SHA1 should be at least 12 digits long
> 	          Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> 	          or later) just making sure it is not set (or set to "auto").
> 
> One more digit!  :)
> 
> can you fix that up and resend?
> 
> Remember, if I don't catch these, linux-next will...

Gah. I really need to take the time to get scripts in place for this rather
than always thinking I'll sort it next time and just eyeball them this
time.

False laziness gets me again.  Sorry about that!

Thanks,

Jonathan

> 
> thanks,
> 
> greg k-h

