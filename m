Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690904332BE
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhJSJpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 05:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhJSJpj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 05:45:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF156112D;
        Tue, 19 Oct 2021 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634636606;
        bh=DZwmjeCAXB03o91bj1EaBUQyyfs7UNkKFHs43AVOEmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aq++3wodW1MvRK+V0d3Eitl5GhJHvxo1n8qsxiSpf3LtmL15qUv43ozlPJCutse1b
         zZnIiWmRz8uRgoesX/52yzoR5fmcu1xJIkSz8CQgDieZECQJs9GJsDKo1gaBXCfesk
         Yzuca/Uhc+utGiHM8hkW6/eQ67d41sToQHVyA2MA=
Date:   Tue, 19 Oct 2021 11:43:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V3] 1st set of IIO new device support, features and
 cleanup for  the 5.16 cycle
Message-ID: <YW6TO7re7r9mR4Er@kroah.com>
References: <20211018192351.39245b42@jic23-huawei>
 <YW5v6OPgC84X73Qg@kroah.com>
 <20211019084227.475ecdb0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019084227.475ecdb0@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 19, 2021 at 08:42:27AM +0100, Jonathan Cameron wrote:
> On Tue, 19 Oct 2021 09:12:40 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Oct 18, 2021 at 07:23:51PM +0100, Jonathan Cameron wrote:
> > > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > > 
> > >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a-split-take3  
> > 
> > Almost :(
> > 
> > I get the following error from my scripts:
> > 
> > Commit: 4862202a0171 ("dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg")
> > 	Fixes tag: Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")
> > 	Has these problem(s):
> > 	        - empty lines surround the Fixes tag
> > 
> > Also, there was a merge conflict in drivers/iio/adc/aspeed_adc.c, but
> > that was easy for me to resolve.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sigh.
> 
> The version of your scripts I have doesn't check for that particular one.
> Anywhere I can get a newer version from?

Sure, it's here:
	https://github.com/gregkh/gregkh-linux/blob/master/work/verify_fixes.sh
and:
	https://github.com/gregkh/gregkh-linux/blob/master/work/verify_signedoff.sh

> V4 sent out. *crosses fingers*  Naturally the commit above was early
> in the series so I had to fix all the other fixes tags again.

Ick, sorry.  I'll go try that now...

greg k-h
