Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B0B2C7520
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbgK1Vt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732316AbgK1S7p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:45 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E04B24658;
        Sat, 28 Nov 2020 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606569368;
        bh=vDZDkPcxqucv9eMTo6wUdoeCVAnmA05zMl4WpXhXIcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ix8tJXCLKLE//IDtIr/mV0zIsm6VGJuG9MGg0JaovQt07qBa/XX5fnjUduBOnCLdZ
         x+mnH2JK/N52s4uXrebVQR3lirU5e0sxkGyepJAktxuNDXCkZTYqcoz2CnIKCCFP85
         /kLy25brN6OiYhH4H99c02zsLSQRzT5O8WbK0EVc=
Date:   Sat, 28 Nov 2020 13:16:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: accel: bmc150: Improve ACPI enumeration
 support
Message-ID: <20201128131604.1367126b@archlinux>
In-Reply-To: <ec8c6e1e-f914-9ee7-133f-2f55d7cc8dfb@redhat.com>
References: <20201125083618.10989-1-hdegoede@redhat.com>
        <CAHp75Vfu+PC-QzzE0_guwLHTdBXes-7RxbaS85df_p4Z=qR2=w@mail.gmail.com>
        <ec8c6e1e-f914-9ee7-133f-2f55d7cc8dfb@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Nov 2020 11:49:15 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/25/20 11:41 AM, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:  
> >>
> >> Hi All,
> >>
> >> This series improves support for ACPI enumeration of bmc150 accels
> >> described by an ACPI node with an ACPI hw-id of BOSC0200:
> >>
> >> 1. Add support for nodes which describe 2 acceleromers in a single node,  
> > 
> > accelerometers
> >   
> >> fixing: https://bugzilla.kernel.org/show_bug.cgi?id=198671
> >>
> >> 2. Add support for reading the mount-matrix from the ACPI node.
> >>
> >> This is done in patches 2 - 3, patch 1 is a trivial cleanup which I noticed
> >> could be done while working on this.
> >>
> >> Patch 2 is based on an earlier patch for this from Jeremy Cline:
> >> https://lore.kernel.org/r/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com
> >>
> >> That patch was put on hold because normally ACPI nodes which describe
> >> multiple i2c-clients in a single node are handled by:
> >> drivers/platform/x86/i2c-multi-instantiate.c
> >>
> >> Which I tried to do at first, but as explained in the commit msg
> >> of the updated patch, that is not possible in this special case
> >> (because it would cause userspace breakage due to the modalias changing).  
> > 
> > This is marked as patch 1?!  
> 
> Yes my bad, sorry.
> 
> > Usually --cover-letter produces a correct template...  
> 
> I use --compose, time to switch to --cover-letter instead I guess.
> 
> Regards,
> 
> Hans
> 

Other than the minor bits Andy mentioned I'm fine with this.

It does sort of feel like we should be gathering documentation somewhere of
where this crazy stuff has been seen in the wild.

Oh for a standard... Whilst I've been known to push the odd thing through
standards bodies, I'm not sure I can really claim this one is related to my
day job (Huawei is a UEFI forum member).  If anyone is particularly
enthusiastic and doesn't have direct access to the UEFI forum via their
job, they could try using the code first route into ACPI via tianocore.

Of course, nothing says anyone will actually use the standard anyway but
at least it would give us the moral high ground ;)

Jonathan


