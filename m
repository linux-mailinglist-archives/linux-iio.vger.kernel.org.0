Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE81F071E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgFFOqH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 10:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgFFOqH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 10:46:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F1320723;
        Sat,  6 Jun 2020 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591454767;
        bh=PBym/DGHE9NjcaE0h+p9wR4vb3R6jof0PH+usemivzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F4YXPTm3dniH8D5Dv2Qb5R9QGBzWomEEaJ3psaxgtE9IhLaxVfC2iw77xoV3AvGFf
         Cvg7XeMUPZzHdnNgLSSMVrs6GKKopZewjdFXJPKeI6iI+xX4Qj2xrNFrUefovlugQr
         eCMiGwes5PeWq5iTcCUuNtztPSbQXePD4io/2DPk=
Date:   Sat, 6 Jun 2020 15:46:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH] iio: improve IIO_CONCENTRATION channel type description
Message-ID: <20200606154603.0fd52019@archlinux>
In-Reply-To: <CAJCx=gkXrNV1pHHBYFcKUttkN=Vc9i_1fOh4stCG3f_GWVJfYA@mail.gmail.com>
References: <20200601161552.34579-1-tomasz.duszynski@octakon.com>
        <CAJCx=gkXrNV1pHHBYFcKUttkN=Vc9i_1fOh4stCG3f_GWVJfYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Jun 2020 14:19:43 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Mon, Jun 1, 2020 at 9:18 AM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > IIO_CONCENTRATION together with INFO_RAW specifier is used for reporting
> > raw concentrations of pollutants. Raw value should be meaningless
> > before being properly scaled. Because of that description shouldn't
> > mention raw value unit whatsoever.
> >
> > Fix this by rephrasing existing description so it follows conventions
> > used throughout IIO ABI docs.  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Thanks for tidying that up.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore.

Thanks,

Jonathan

> 
> >
> > Fixes: 8ff6b3bc94930 ("iio: chemical: Add IIO_CONCENTRATION channel type")
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d3e53a6d8331..5c62bfb0f3f5 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1569,7 +1569,8 @@ What:             /sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
> >  KernelVersion: 4.3
> >  Contact:       linux-iio@vger.kernel.org
> >  Description:
> > -               Raw (unscaled no offset etc.) percentage reading of a substance.
> > +               Raw (unscaled no offset etc.) reading of a substance. Units
> > +               after application of scale and offset are percents.
> >
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
> > --
> > 2.26.2
> >  

