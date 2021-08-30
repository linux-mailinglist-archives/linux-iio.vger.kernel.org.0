Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F106A3FB8DD
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhH3PPR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 11:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237203AbhH3PPQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 11:15:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3DA60C3F;
        Mon, 30 Aug 2021 15:14:19 +0000 (UTC)
Date:   Mon, 30 Aug 2021 16:17:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Mihail Chindris <mihail.chindris@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v4 0/6] iio: Add output buffer support and DAC example
Message-ID: <20210830161730.554e2663@jic23-huawei>
In-Reply-To: <CA+U=DsqfxUVJ6e_09wWBqP2XMgYrsq0ggOmgFWKzrru45oWZYQ@mail.gmail.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
        <CA+U=DsqfxUVJ6e_09wWBqP2XMgYrsq0ggOmgFWKzrru45oWZYQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 10:35:53 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Aug 20, 2021 at 8:01 PM Mihail Chindris
> <mihail.chindris@analog.com> wrote:
> >  
> 
> My only note about this series [as a whole] is that I would have
> chosen an existing DAC to which to add kfifo output support.
> To make things smooth for this new mechanism.
> 
> A new driver usually takes more effort to review/introduce than a
> change to an existing one.

Agreed.  If it makes sense to send the driver without this support
first then add it in a follow up that is fine too.  That way we can
separate basic driver review from the exciting new stuff.

Jonathan

> 
> > Changelog v3 -> v4:
> >   * https://lore.kernel.org/linux-iio/20210219124012.92897-1-alexandru.ardelean@analog.com
> >   * Remove DMA related commits
> >   * Test and add fixies to the previous version
> >     - Add write function to iio_buffer_fileops in industrialiio-core
> >     - In iio_kfifo_remove_from change number of samples to 1 instead of
> >       r->bytes_per_datum otherwise n square samples are removed.
> >     - In iio_buffer_remove_sample replace move buffer->access->write
> >       check to first if an replace with remove_from. Checkpatch was
> >       complaining about returning -ENOSYS
> >   * Add ad3552r example
> >
> > Alexandru Ardelean (1):
> >   iio: triggered-buffer: extend support to configure output buffers
> >
> > Lars-Peter Clausen (2):
> >   iio: Add output buffer support
> >   iio: kfifo-buffer: Add output buffer support
> >
> > Mihail Chindris (3):
> >   Documentation:ABI:testing:add doc for AD3552R ABI
> >   dt-bindings: iio: dac: Add adi,ad3552r.yaml
> >   drivers:iio:dac: Add AD3552R driver support
> >
> >  .../ABI/testing/sysfs-bus-iio-dac-ad3552r     |   10 +
> >  .../bindings/iio/dac/adi,ad3552r.yaml         |  185 +++
> >  drivers/iio/accel/adxl372.c                   |    1 +
> >  drivers/iio/accel/bmc150-accel-core.c         |    1 +
> >  drivers/iio/adc/at91-sama5d2_adc.c            |    4 +-
> >  .../buffer/industrialio-triggered-buffer.c    |    8 +-
> >  drivers/iio/buffer/kfifo_buf.c                |   50 +
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    |    5 +-
> >  .../common/hid-sensors/hid-sensor-trigger.c   |    5 +-
> >  drivers/iio/dac/Kconfig                       |   10 +
> >  drivers/iio/dac/Makefile                      |    1 +
> >  drivers/iio/dac/ad3552r.c                     | 1419 +++++++++++++++++
> >  drivers/iio/iio_core.h                        |    4 +
> >  drivers/iio/industrialio-buffer.c             |  133 +-
> >  drivers/iio/industrialio-core.c               |    1 +
> >  include/linux/iio/buffer.h                    |    7 +
> >  include/linux/iio/buffer_impl.h               |   11 +
> >  include/linux/iio/triggered_buffer.h          |   11 +-
> >  18 files changed, 1854 insertions(+), 12 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> >  create mode 100644 drivers/iio/dac/ad3552r.c
> >
> >
> > base-commit: 94a853eca720ac9e385e59f27e859b4a01123f58
> > --
> > 2.27.0
> >  

