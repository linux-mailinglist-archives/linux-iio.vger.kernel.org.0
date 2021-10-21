Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE8435C50
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 09:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJUHsT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 Oct 2021 03:48:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37425 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhJUHsT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 03:48:19 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9F7C020019;
        Thu, 21 Oct 2021 07:45:56 +0000 (UTC)
Date:   Thu, 21 Oct 2021 09:45:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/48] TI AM437X ADC1
Message-ID: <20211021094555.0557d1a4@xps13>
In-Reply-To: <YXA8fVh5Q7aWNFE2@google.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
        <20211020173611.07980c1d@xps13>
        <YXA8fVh5Q7aWNFE2@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Wed, 20 Oct 2021 16:57:49 +0100:

> On Wed, 20 Oct 2021, Miquel Raynal wrote:
> 
> > Hi Lee,
> > 
> > miquel.raynal@bootlin.com wrote on Fri, 15 Oct 2021 10:14:18 +0200:
> >   
> > > /*
> > >  * Reducing the Cc: list as this is just a rebase and all patches
> > >  * received reviews already. Only the DT patches have received no
> > >  * feedback, hence keeping the omap@ list in.
> > >  */
> > > 
> > > Hello,
> > > 
> > > This is a (fairly big) series bringing support of AM437X ADC1.
> > > On TI AM33XX SoCs family there is an ADC that can also be connected to a
> > > touchscreen. This hardware has been extended and is present on certain
> > > SoCs from the AM437X family. In particular, the touchscreen has been
> > > replaced by a magnetic card reader. In both cases, the representation is
> > > an MFD device with two children:
> > > * on AM33XX: the touchscreen controller and the ADC
> > > * on AM437X: the magnetic stripe reader and the ADC
> > > 
> > > This series really targets small and atomic changes so that the overall
> > > review is eased, even though it leads to a lot of rather small patches.
> > > Here are the steps:
> > > * Supporting the missing clock
> > > * Translating a single text file containing the description for the
> > >   MFD, the touchscreen and the ADC into three independent yaml files.
> > > * Cleaning/preparing the MFD driver.
> > > * Supporting ADC1 in the MFD driver.
> > > * Cleaning/preparing of the ADC driver.
> > > * Supporting ADC1 in the ADC driver.
> > > * Updating various device trees.
> > > 
> > > Here is the full series again, almost reviewed and acked entirely.
> > > The clock patch has been acked, the ADC patches as well, so we expect
> > > the series to go through the MFD tree if the maintainers agree with it.  
> > 
> > Sorry to ping you so early, but we already are at -rc6 and I was
> > wondering if you could take the series as it has been on the mailing
> > list for a while and received no real change since a couple of weeks
> > already, possibly avoiding the need for yet another resend of 48
> > patches :)  
> 
> Don't worry, it's email day tomorrow.  I have a bunch of high-priority
> patches/sets that I aim to handle, yours included.

Haha, ok, thanks for the quick feedback :)

Cheers,
Miquèl
