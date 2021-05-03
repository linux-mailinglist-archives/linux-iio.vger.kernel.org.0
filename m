Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF137145F
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 13:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhECLhG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 07:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhECLhG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 07:37:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB85A611CB;
        Mon,  3 May 2021 11:36:12 +0000 (UTC)
Date:   Mon, 3 May 2021 12:37:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] iio: cleanup some new instances of manual parent
 setting.
Message-ID: <20210503123705.5ecc355b@jic23-huawei>
In-Reply-To: <CA+U=DsoO6tK=y4LNFNsvqDSDTJgX6DHiTxMOR0fW+YEXUoG5pA@mail.gmail.com>
References: <20210426170251.351957-1-jic23@kernel.org>
        <CA+U=DsoO6tK=y4LNFNsvqDSDTJgX6DHiTxMOR0fW+YEXUoG5pA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 10:27:44 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Apr 26, 2021 at 8:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > It seems I still haven't trained my eyes to spot these.
> >
> > I think they have all been introduced since
> > iio_device_alloc() and friends started setting this
> > 8525df47b3d1e ("iio: core: fix/re-introduce back parent assignment")
> > 78289b4a58b58 ("iio: core: pass parent device as parameter during allocation")
> >
> > Anyhow, all seem fairly obvious to me, but maybe I missed something so please
> > take a look.  
> 
> I've added 2 comments that are unrelated [directly] to this series.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Thanks for checking these.  I've added the of_node dropping bit
to the patch you pointed that out in.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it and see if we missed anything!

Thanks,

Jonathan

> 
> >
> > Jonathan Cameron (8):
> >   iio: accel: bmi088: Drop manual assignment of iio_dev.dev.parent
> >   iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent
> >   iio: adc: mp2629: Drop duplicate setting iio_dev.dev.parent
> >   iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
> >   iio: adc: ti-ads131e08: Drop duplicate setting of iio_dev.dev.parent
> >   iio: humidity: hdc2010: Drop duplicate setting of iio_dev.dev.parent
> >   iio: position: hid-sensor-custom-intel-hinge: Drop duplicate parent
> >     setting.
> >   iio: common: scmi_sensors: Drop duplicate setting of
> >     iio_dev.dev.parent
> >
> >  drivers/iio/accel/bmi088-accel-core.c                | 1 -
> >  drivers/iio/adc/mp2629_adc.c                         | 1 -
> >  drivers/iio/adc/mt6360-adc.c                         | 1 -
> >  drivers/iio/adc/ti-ads131e08.c                       | 1 -
> >  drivers/iio/common/scmi_sensors/scmi_iio.c           | 1 -
> >  drivers/iio/dac/ad5766.c                             | 1 -
> >  drivers/iio/humidity/hdc2010.c                       | 1 -
> >  drivers/iio/position/hid-sensor-custom-intel-hinge.c | 1 -
> >  8 files changed, 8 deletions(-)
> >
> > --
> > 2.31.1
> >  

