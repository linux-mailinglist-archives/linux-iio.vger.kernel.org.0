Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40C1912D4
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2019 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHQUi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Aug 2019 16:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfHQUi7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Aug 2019 16:38:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98C52077C;
        Sat, 17 Aug 2019 20:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566074338;
        bh=jYMSW4j9FButHPMG1+AVhutZbXtih28Os5lcUfsLxkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kH7GOLQDX9nLh4VBevLy7JPGXePNo9sDWOxmA0wU6L3PF2VmtwhdPIwcHjcSG0NYO
         eCR799JtrMqI++0oK55TNIYxFGMMySkbxGGPW3Rv92uUk5zIk3EdM+YA4RcO5EOT7f
         IegJrmLZp6OZO741f7Zmc/EpPc+4R1DnHe1W6jpI=
Date:   Sat, 17 Aug 2019 22:38:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     J Lovejoy <opensource@jilayne.com>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH 13/14] iio: trig-loop: SPDX headers GPL-v2
Message-ID: <20190817203855.GA8340@kroah.com>
References: <20190622145516.3231-1-jic23@kernel.org>
 <20190622145516.3231-14-jic23@kernel.org>
 <20190717175837.GA31268@himanshu-Vostro-3559>
 <20190717211246.GA13989@kroah.com>
 <EB9A92CE-36F5-4A27-8984-655538DEF40B@jilayne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB9A92CE-36F5-4A27-8984-655538DEF40B@jilayne.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 17, 2019 at 01:08:44PM -0600, J Lovejoy wrote:
> 
> 
> > On Jul 17, 2019, at 3:12 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Wed, Jul 17, 2019 at 11:28:37PM +0530, Himanshu Jha wrote:
> >> On Sat, Jun 22, 2019 at 03:55:15PM +0100, jic23@kernel.org wrote:
> >>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> 
> >>> Not exactly standard license text, but clear in intent and it's
> >>> my copyright anyway.
> >>> 
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> ---
> >>> drivers/iio/trigger/iio-trig-loop.c | 3 +--
> >>> 1 file changed, 1 insertion(+), 2 deletions(-)
> >>> 
> >>> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> >>> index 9258d3cf149b..f0205a9e47d0 100644
> >>> --- a/drivers/iio/trigger/iio-trig-loop.c
> >>> +++ b/drivers/iio/trigger/iio-trig-loop.c
> >>> @@ -1,8 +1,7 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >> 
> >> I think it should be:
> >> 
> >> 	// SPDX-License-Identifier: GPL-2.0-only
> >> 
> >> https://spdx.org/licenses/
> >> https://spdx.org/licenses/GPL-2.0-only.html
> >> 
> >> I don't know if `spdxcheck.py` points out about
> >> such a mismatch.
> >> 
> >> Yes, documentation and sanity checkers needs to be updated.
> >> https://lore.kernel.org/lkml/CAHk-=wipjStEwJj2_iWxBdVC4oV8rY5NjrRb1tmWLUa0VrS_Eg@mail.gmail.com/
> > 
> > Please read the in-kernel documentation about this.  We support both
> > types of tags now and have done so since the beginning.
> > 
> > 
> While I understand that the previous SPDX License List and current
> version identifiers are supported here, it would be really helpful
> more generally if we could use the current ones now and going forward.

That is fine, but for now, both are acceptable, it's up to the submitter
to pick which they want to use, we have much bigger things to worry
about here :)

thanks,

greg k-h
