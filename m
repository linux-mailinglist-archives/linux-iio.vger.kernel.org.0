Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAD425683
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbhJGPZH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 11:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhJGPZH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:25:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A0F61090;
        Thu,  7 Oct 2021 15:23:12 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:27:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Message-ID: <20211007162716.0abd5937@jic23-huawei>
In-Reply-To: <AM8PR10MB4801DB5353ADA0656510E920EDB19@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
References: <20210927134153.12739-1-broonie@kernel.org>
        <20210930173852.208f1815@jic23-huawei>
        <AM8PR10MB4801DD2B605277F3D97CAF87EDAA9@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
        <20211001121944.GA5080@sirena.org.uk>
        <AM8PR10MB4801DB5353ADA0656510E920EDB19@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Oct 2021 00:47:56 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Hello Mark,
> 
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Friday, October 1, 2021 5:20 AM
> > To: Denis CIOCCA <denis.ciocca@st.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; linux-iio@vger.kernel.org
> > Subject: Re: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
> > ID table
> > 
> > On Thu, Sep 30, 2021 at 06:35:23PM +0000, Denis CIOCCA wrote:
> >   
> > > I am not very familiar with how much the kernel would like to keep  
> > 'probing id' consistent. I perfectly understand the value of doing this
> > (maintain ID compatibility) but I also see increase confusion in maintaining
> > half in a way and half in another.
> > 
> > The goal is not to maintain compatibility, the goal is to be able to
> > load the driver as a module on DT systems.  For historical reasons SPI
> > uses the platform device IDs to load modules bound with DT, if there is
> > no platform ID for a DT ID then userspace won't be able to find and load
> > the module.  
> 
> Ok now it is clear. I wasn't aware of that.
> In this case it is good to me (I didn't do any testing).

Applied to the fixes-togreg branch of iio.git. I haven't explicitly marked
it for stable but it may make sense to backport at somepoint.

Thanks,

Jonathan

> 
> >   
> > > I personally think that we should drop the '-press' thing for all the devices  
> > since they all are single-chip (meaning that the name used identify
> > univocally that is a pressure sensor).
> > 
> > The DT bindings are an ABI, you can't really remove compatibles only
> > deprecate them.  
> 
> Yeah I guessed this was the case.
> 
> >   
> > > If you think that compatibility is more important here, I think the patch is  
> > fine but this should be done in the i2c part as well so that it's at least
> > congruent withing the driver.
> > 
> > I2C doesn't have this issue with modaliases so it's not an issue there.  
> 
> Clear.
> 
> > 
> > Please fix your mail client to word wrap within paragraphs at something
> > substantially less than 80 columns.  Doing this makes your messages much
> > easier to read and reply to.  

