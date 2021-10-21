Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1A4361F7
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUMoK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 Oct 2021 08:44:10 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:53787 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJUMoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 08:44:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4CDAA24000C;
        Thu, 21 Oct 2021 12:41:52 +0000 (UTC)
Date:   Thu, 21 Oct 2021 14:41:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, IIO, Input
 (Touchscreen) and Clk due for the v5.16 merge window
Message-ID: <20211021144151.59f776bc@xps13>
In-Reply-To: <YXFdlMLeWEuJwhdD@google.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
        <YXFW5R8zK/g9Rqei@google.com>
        <20211021141357.2f08898c@xps13>
        <YXFdlMLeWEuJwhdD@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Thu, 21 Oct 2021 13:31:16 +0100:

> On Thu, 21 Oct 2021, Miquel Raynal wrote:
> 
> > Hi Lee,
> > 
> > lee.jones@linaro.org wrote on Thu, 21 Oct 2021 13:02:45 +0100:
> >   
> > > Enjoy!
> > > 
> > > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > > 
> > >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-touchscreen-clk-v5.16
> > > 
> > > for you to fetch changes up to e7c8a5fe82ff8ee100c65598187674eef4748bf2:
> > > 
> > >   iio: adc: ti_am335x_adc: Add the am437x compatible (2021-10-21 10:02:48 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD, IIO, Input (Touchscreen) and Clk due for the v5.16 merge window  
> > 
> > Thanks! Just to be sure, you will send a merge request to Linus
> > including this branch, right? Or do you expect someone else to do it?  
> 
> I will do it *as well as* anyone else who wishes to.

Ok perfect!

Thanks,
Miquèl
