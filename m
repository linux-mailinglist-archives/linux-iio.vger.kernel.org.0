Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0A1682FA
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBUQOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 11:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgBUQOc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 11:14:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3002073A;
        Fri, 21 Feb 2020 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582301671;
        bh=03mmMubZATC978zRnpoRzUK0gpBr8Z2CKI6eBfkoRsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JTd/BjDIrsSWFurv3McozyobZoT1LcEUVmlVPSByEbVlF1z2YTEiQTZgAKkTNn753
         uswo/xfAvCVaR6S3JdtTQo6tkDOqQSLiBlIjo17fkzGKMxFkwJaL5ENteMzg5N7Hir
         nc7Rh7bIqG6ctKs7d+lS2RH+6ZR4tL3JpQx7NiTk=
Date:   Fri, 21 Feb 2020 16:14:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Message-ID: <20200221161428.188e1532@archlinux>
In-Reply-To: <414d7e293b75e556ce857e0ce985a0f89fb24ffd.camel@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
        <20200221131146.2213e8e1@archlinux>
        <414d7e293b75e556ce857e0ce985a0f89fb24ffd.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 15:59:35 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-02-21 at 13:11 +0000, Jonathan Cameron wrote:
> > On Fri, 21 Feb 2020 13:49:41 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > This change adds a doc-string for the 'adis' struct. It details the fields
> > > and their roles.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  include/linux/iio/imu/adis.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> > > index ac7cfd073804..0787a3aabd05 100644
> > > --- a/include/linux/iio/imu/adis.h
> > > +++ b/include/linux/iio/imu/adis.h
> > > @@ -73,6 +73,20 @@ struct adis_data {
> > >  	bool has_paging;
> > >  };
> > >  
> > > +/**
> > > + * struct adis - ADIS device instance data
> > > + * @spi: Reference to SPI device which owns this ADIS IIO device
> > > + * @trig: IIO trigger object data
> > > + * @data: ADIS chip variant specific data
> > > + * @burst: ADIS burst transfer information
> > > + * @state_lock: Lock used by the device to protect state
> > > + * @msg: SPI message object
> > > + * @xfer: SPI transfer objects to be used for a @msg
> > > + * @current_page: Some ADIS devices have registers, this selects current
> > > page
> > > + * @buffer: Data buffer for information read from the device
> > > + * @tx: Cacheline aligned TX buffer for SPI transfers
> > > + * @rx: Cacheline aligned RX buffer for SPI transfers  
> > 
> > This last one isn't true..   
> 
> Oh right.
> I noticed this at some point, then forgot about it.
> [ The "joys" of multi-tasking; sorry about it :) ]
> I guess I should also add a patch in this series making it cacheline-aligned.
> I don't see a reason why not-to [unless I am misunderstanging something]
No.  The code is fine.  The purpose of the cacheline stuff is to ensure
no other data ends up in the same cacheline and might be changed in parallel
with the spi dma taking place.   You only need to force it for the first
element when you have 2 buffers like this.

So you need to update the comment in this patch to say something less specific.
Perhaps

@tx: DMA safe TX buffer for SPI transfers
@rx: DMA safe RX buffer for SPI transfers.

Thanks,

Jonathan

> 
> 
> >   
> > > + */
> > >  struct adis {
> > >  	struct spi_device	*spi;
> > >  	struct iio_trigger	*trig;  

