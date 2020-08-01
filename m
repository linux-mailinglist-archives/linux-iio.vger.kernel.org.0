Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CA2352FD
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHAPiT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 11:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAPiS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 11:38:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90FFE2071E;
        Sat,  1 Aug 2020 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596296298;
        bh=R9Rinnbiavbu4gLpa/mmI6LL+DEK5QDx/kYCTyiidc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMPxyJJDjNSGBv0D/zupPMuJGNEvHiF/uosVwn+FNrKfKWa7teOSIjKbNPpc7TKJl
         Io5c/genfnkgnGyZCIvDnPh2sC8XfytS4yaYUEklUE+Q/4ECB+IvPRi1SvUb6S5Vei
         EVey38G27iPNAEPoMGUH2NMi0suxqvRX2dKhuork=
Date:   Sat, 1 Aug 2020 16:38:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ankit Baluni <b18007@students.iitmandi.ac.in>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] Staging: iio: Fixed a punctuation and a spelling
 mistake.
Message-ID: <20200801163813.12bc746b@archlinux>
In-Reply-To: <CAHp75VdCBWLLMT7jm0CO+oK8eZf7cSMOM5sb9xZ1Po1_YFAMxw@mail.gmail.com>
References: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
        <20200729081155.3228-1-b18007@students.iitmandi.ac.in>
        <CAHp75VdCBWLLMT7jm0CO+oK8eZf7cSMOM5sb9xZ1Po1_YFAMxw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Jul 2020 13:38:28 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jul 29, 2020 at 11:12 AM Ankit Baluni
> <b18007@students.iitmandi.ac.in> wrote:
> >
> > Added a missing comma and changed 'it it useful' to 'it is useful'.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Gah. I had kind of forgotten these docs existed and they have
rotted pretty badly from a quick glance.   Sometime soon I'll take
a look and see if there is anything worth moving over to the main docs.

In meantime, nothing wrong with cleaning them up a little as you Ankit
has done here.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore them.

Thanks,

Jonathan

> 
> > Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
> > ---
> > Changes in -v2:
> >         -Remove space before ':' in subject line.
> >
> >  drivers/staging/iio/Documentation/overview.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
> > index ebdc64f451d7..00409d5dab4e 100644
> > --- a/drivers/staging/iio/Documentation/overview.txt
> > +++ b/drivers/staging/iio/Documentation/overview.txt
> > @@ -9,7 +9,7 @@ The aim is to fill the gap between the somewhat similar hwmon and
> >  input subsystems.  Hwmon is very much directed at low sample rate
> >  sensors used in applications such as fan speed control and temperature
> >  measurement.  Input is, as its name suggests focused on input
> > -devices. In some cases there is considerable overlap between these and
> > +devices. In some cases, there is considerable overlap between these and
> >  IIO.
> >
> >  A typical device falling into this category would be connected via SPI
> > @@ -38,7 +38,7 @@ series and Analog Devices ADXL345 accelerometers.  Each buffer supports
> >  polling to establish when data is available.
> >
> >  * Trigger and software buffer support. In many data analysis
> > -applications it it useful to be able to capture data based on some
> > +applications it is useful to be able to capture data based on some
> >  external signal (trigger).  These triggers might be a data ready
> >  signal, a gpio line connected to some external system or an on
> >  processor periodic interrupt.  A single trigger may initialize data
> > --
> > 2.25.1
> >  
> 
> 

