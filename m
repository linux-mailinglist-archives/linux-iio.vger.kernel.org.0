Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393FC2C7483
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbgK1Vta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733023AbgK1TFA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:05:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CEED2467B;
        Sat, 28 Nov 2020 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606571168;
        bh=KEb5fWYhOGIm3OrQ7ewy2ZZYmGIlrSqmQfa9lffwEG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kz2NlIbGIPq9DiurncNCMW+hxbhe0zHEPTsmlEZDJ84yj8VMfVCkJNQRu9efec1AJ
         47n8kSptuJ8+9yCfSRkVUhuou+rhF24T6rwPJG4rLtxmyyn1JgH1l90u9pitbaY2sC
         3nF6eW08TJoaUckFdBOweKGKlNyPK6Mo/yB2Q/5g=
Date:   Sat, 28 Nov 2020 13:46:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: accel: bmc150: Improve ACPI enumeration
 support
Message-ID: <20201128134604.7703aee8@archlinux>
In-Reply-To: <17447d78-c637-ad6b-2e38-c4ce82587598@redhat.com>
References: <20201125083618.10989-1-hdegoede@redhat.com>
        <CAHp75Vfu+PC-QzzE0_guwLHTdBXes-7RxbaS85df_p4Z=qR2=w@mail.gmail.com>
        <ec8c6e1e-f914-9ee7-133f-2f55d7cc8dfb@redhat.com>
        <20201128131604.1367126b@archlinux>
        <17447d78-c637-ad6b-2e38-c4ce82587598@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 14:32:49 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/28/20 2:16 PM, Jonathan Cameron wrote:
> > On Wed, 25 Nov 2020 11:49:15 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> Hi,
> >>
> >> On 11/25/20 11:41 AM, Andy Shevchenko wrote:  
> >>> On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:    
> >>>>
> >>>> Hi All,
> >>>>
> >>>> This series improves support for ACPI enumeration of bmc150 accels
> >>>> described by an ACPI node with an ACPI hw-id of BOSC0200:
> >>>>
> >>>> 1. Add support for nodes which describe 2 acceleromers in a single node,    
> >>>
> >>> accelerometers
> >>>     
> >>>> fixing: https://bugzilla.kernel.org/show_bug.cgi?id=198671
> >>>>
> >>>> 2. Add support for reading the mount-matrix from the ACPI node.
> >>>>
> >>>> This is done in patches 2 - 3, patch 1 is a trivial cleanup which I noticed
> >>>> could be done while working on this.
> >>>>
> >>>> Patch 2 is based on an earlier patch for this from Jeremy Cline:
> >>>> https://lore.kernel.org/r/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com
> >>>>
> >>>> That patch was put on hold because normally ACPI nodes which describe
> >>>> multiple i2c-clients in a single node are handled by:
> >>>> drivers/platform/x86/i2c-multi-instantiate.c
> >>>>
> >>>> Which I tried to do at first, but as explained in the commit msg
> >>>> of the updated patch, that is not possible in this special case
> >>>> (because it would cause userspace breakage due to the modalias changing).    
> >>>
> >>> This is marked as patch 1?!    
> >>
> >> Yes my bad, sorry.
> >>  
> >>> Usually --cover-letter produces a correct template...    
> >>
> >> I use --compose, time to switch to --cover-letter instead I guess.
> >>
> >> Regards,
> >>
> >> Hans
> >>  
> > 
> > Other than the minor bits Andy mentioned I'm fine with this.
> > 
> > It does sort of feel like we should be gathering documentation somewhere of
> > where this crazy stuff has been seen in the wild.  
> 
> I can provide an (incomplete) list of devices known to use the BOSC0200 ACPI HID,
> both in single and dual accelerometer configs.
> 
> In lieu of a better place, I guess I could best just drop this info in
> a big comment block near the ACPI mount-matrix parsing stuff ?
> 
> If you agree that a comment is a reasonable place to place this info I
> can add this for v2 of the patch-set.
It is as good a place as any so go for it.

thanks,

Jonathan

p.s. Mailing list is messing around today I think as neither I nor lore.kernel.org
are getting mails from it.  It'll probably be resolved shorty but in meantime
discussion may get a bit separated and I can't use b4 for new patches which
will make it trickier to apply things until that is fixed.

> 
> Regards,
> 
> Hans
> 

