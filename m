Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC88458322
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 12:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhKULaz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 06:30:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238136AbhKULaw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 06:30:52 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CDA160462;
        Sun, 21 Nov 2021 11:27:46 +0000 (UTC)
Date:   Sun, 21 Nov 2021 11:32:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Evgeny Boger <boger@wirenboard.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2] iio: adc: axp20x_adc: fix charging current reporting
 on AXP22x
Message-ID: <20211121113240.67f49851@jic23-huawei>
In-Reply-To: <CAGb2v66_+HWrJM7i3HmaeOE7oh6h+MUxOsp7J=GObZPovnfS3g@mail.gmail.com>
References: <20211116213746.264378-1-boger@wirenboard.com>
        <20211120174930.1ec11e77@jic23-huawei>
        <CAGb2v66_+HWrJM7i3HmaeOE7oh6h+MUxOsp7J=GObZPovnfS3g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Nov 2021 01:58:08 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Hi,
> 
> On Sun, Nov 21, 2021 at 1:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 17 Nov 2021 00:37:46 +0300
> > Evgeny Boger <boger@wirenboard.com> wrote:
> >  
> > > Both the charging and discharging currents on AXP22x are stored as
> > > 12-bit integers, in accordance with the datasheet.
> > > It's also confirmed by vendor BSP (axp20x_adc.c:axp22_icharge_to_mA).
> > >
> > > The scale factor of 0.5 is never mentioned in datasheet, nor in the
> > > vendor source code. I think it was here to compensate for
> > > erroneous addition bit in register width.
> > >
> > > Tested on custom A40i+AXP221s board with external ammeter as
> > > a reference.
> > >
> > > Signed-off-by: Evgeny Boger <boger@wirenboard.com>  
> >
> > I know Quentin has moved on from Bootlin, so looking for input from Chen-Yu Tsai
> > for these as I have no idea :)  
> 
> The datasheet only lists the registers for reading the value, but nothing
> is said about how to interpret the data read. And the datasheet lists 13
> bits split between two registers.
> 
> Evgeny mentioned that the original code is wrong, and the BSP code is
> likely right, and has test results that match. That's good enough for
> me. Unfortunately I don't have any way to double check it right now. So
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied to the fixes-togreg branch of iio.git with a fixes tag for the original
driver introduction (as it seems this dates back that far) and marked for stable.

Thanks,

Jonathan
