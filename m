Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E653256D65
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgH3LKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 07:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgH3LKf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 07:10:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2FD20757;
        Sun, 30 Aug 2020 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598785835;
        bh=mu9wJFt6mGD5wvJQYVN4F/aho0AV/Y6T7Cnvd31Std8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lwgFODbPwprBd1PN4CgTfaXa7fubifZKH7xXVNpY52jIpbhScSVeJdmde9LzpU87N
         Klo/+s30c/94lYSR0ydNQRWTBKkiDmkG6BS02+id61j4Z8TK/0cmO6nA2mPoDzJXai
         uIvntISqEcqAjCITLyh3w7qMMSFLGKdrL86n5OtQ=
Date:   Sun, 30 Aug 2020 12:10:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: adjust `bytes_used` with residue
 info
Message-ID: <20200830121030.66420067@archlinux>
In-Reply-To: <f336acac-ed70-ad88-57ca-8d06ec54182e@metafoo.de>
References: <20200826052011.13348-1-lars@metafoo.de>
        <CA+U=Dsp8KXNzmVGf9N=A+h7DyC2L7Hk2A7N4ERPL4jc+-M_mFg@mail.gmail.com>
        <20200829165134.3361315a@archlinux>
        <f336acac-ed70-ad88-57ca-8d06ec54182e@metafoo.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Aug 2020 20:30:04 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 8/29/20 5:51 PM, Jonathan Cameron wrote:
> > On Wed, 26 Aug 2020 09:36:39 +0300
> > Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> >  
> >> On Wed, Aug 26, 2020 at 8:22 AM Lars-Peter Clausen <lars@metafoo.de> wrote:  
> >>> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >>>
> >>> A transfer may fall shorter than the bytes in the block.
> >>> This information is available in the residue from the DMA engine, so we can
> >>> compute actual `bytes_used` with that by subtracting the residue.
> >>>     
> >> This was in my pipeline as well [obviously].
> >> Thanks :)
> >>  
> >>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> > "smells" like a fix.  Is it?  Or are we looking at something that
> > only matters for some future hardware, or an optmization?
> >
> > If it's a fix, where is the fixes tag?  
> 
> It's a feature :)
> 
> When we first added the IIO DMA buffer support this API did not exist in 
> dmaengine. So for the longest time most DMA drivers did not have the 
> ability to report short transfers. Primarily because in many cases the 
> hardware doesn't even support it.
> 
> Now with this patch the IIO DMA buffer implementation supports systems 
> where the DMA can generate short transfers.
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> - Lars
> 

