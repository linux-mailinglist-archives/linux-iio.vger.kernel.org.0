Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6722B3BADC5
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhGDQRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhGDQRl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:17:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330C561245;
        Sun,  4 Jul 2021 16:15:01 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:17:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <20210704171726.299ed620@jic23-huawei>
In-Reply-To: <20210703183111.2b2b9b4f@aktux>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-3-andreas@kemnade.info>
        <20210703170405.60828c57@jic23-huawei>
        <20210703183111.2b2b9b4f@aktux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 3 Jul 2021 18:31:11 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Hi,
> 
> On Sat, 3 Jul 2021 17:04:05 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat,  3 Jul 2021 10:42:22 +0200
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > This allows having devicetree nodes for the subdevices.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  drivers/mfd/rn5t618.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > > index 384acb459427..b916c7471ca3 100644
> > > --- a/drivers/mfd/rn5t618.c
> > > +++ b/drivers/mfd/rn5t618.c
> > > @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
> > >  };
> > >  
> > >  static const struct mfd_cell rc5t619_cells[] = {
> > > -	{ .name = "rn5t618-adc" },
> > > -	{ .name = "rn5t618-power" },
> > > +	{ .name = "rn5t618-adc",
> > > +	  .of_compatible = "ricoh,rc5t619-adc" },    
> > 
> > Odd to have a name of 618 and a compatible of 619.  Why?
> > Definitely deserves a comment if this is necessary for some reason!
> >   
> Background of this whole thing:
> Both RN5T618 and RC5T619 have an ADC. I would expect the driver to work
> for both but I cannot prove that. No RN5T618 here to test. Maybe it
> requires some quirks, probably not. The only hint I have is that
> a) I use register definitions added to the kernel for RN5T618 support
> b) public datasheets looks same regarding the ADC.
> c) out-of-tree code for the RN5T618 does not give a clear picture, it
> shows no differences but is not complete enough to judge.
> 
> To avoid introducing untested things, I am only adding it to the
> rc5t619_cell list. I would really hope that someone does some rn5t618
> tests... Because everything else which is both for the RN5T618 and
> RC5T619 uses rn5t618 as a name, I continued that practise.
> 
> The subdevice driver also gets the information whether it is a rn5t618
> or rc5t619 via rn5t618->variant, so it can handle things.
> 
> > > +	{ .name = "rn5t618-power",
> > > +	  .of_compatible = "ricoh,rc5t619-power" },  
> 
> Similar situation here.
> 
> > >  	{ .name = "rn5t618-regulator" },
> > >  	{ .name = "rc5t619-rtc" },  
> and this one definitively only exists in the rc5t619.

All sounds reasonable to me.
Dt binding wise we'd normally handle this with a double compatible,
with the more part specific one first.  That way we can diverge later
if we need to, but don't need to care about it until an identified need
has occurred.

compatible = "ricoh,rc5t619-adc", "ricoh,rc5t618-adc";  (or something like that) 

Anyhow, for now perhaps a comment to express briefly what you state above.

> 
> > >  	{ .name = "rn5t618-wdt" },    
> > 
> >   
> 
> Regards,
> Andreas

