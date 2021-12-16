Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A942B477666
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 16:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhLPP4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhLPP4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 10:56:46 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACACC061574;
        Thu, 16 Dec 2021 07:56:46 -0800 (PST)
Received: from [81.101.6.87] (port=52578 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxt7Y-0006WU-2V; Thu, 16 Dec 2021 15:56:40 +0000
Date:   Thu, 16 Dec 2021 16:02:04 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Expand Semtech SAR Sensors support
Message-ID: <20211216160153.2a523f46@jic23-huawei>
In-Reply-To: <20211216155015.7013eff9@jic23-huawei>
References: <20211210192328.2844060-1-gwendal@chromium.org>
        <20211216155015.7013eff9@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 15:50:29 +0000
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Fri, 10 Dec 2021 11:23:23 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
> > Add a new Semtech SAR sensor SX9324.
> > Instead of recopying 1/3 of the sx9310 driver, move common code in a new
> > file. It will be used again for the next sensor, SX9360.  
> 
> Series applied to the togreg branch of iio.git and pushed out as testing
> to let 0-day have a poke at it and see what it can find that we missed.
> 
And pulled out again.  Just noticed an issue with docs not matching
the actual ABI.

> Thanks,
> 
> Jonathan
> 
> > 
> > Major changes in v7:
> >   Fix one remaining syntax error in device tree binding documentation.
> > 
> > Major changes in v6:
> >   Fix syntax errors in device tree binding documentation.
> >   Drop of_match_ptr and ACPI_PTR protections.
> >   Fix unused variable warning.
> > 
> > Major changes in v5:
> >   Use iwyu to cleanup include files.
> >   Use dev_err_probe() in probe routine
> >   Add attribute to shift irq status register, not common among all
> >     sensors.
> >   Fix long line.
> > 
> > Major changes in v4:
> >   Use chip_info instead of info in common data.
> >   Returns an error when setting negative sysfs entries
> >   Fix cut and paste errors, credit.
> > 
> > Major changes in v3:
> >   Fix some error in binding descriptions and setting
> >   Fix invalid register constant name.
> > 
> > Major changes in v2:
> >   Better interface between common code and drivers
> >   Document SX9324 phase configuration
> > 
> > Gwendal Grignou (5):
> >   iio: sx9310: Add frequency in read_avail
> >   iio: sx9310: Extract common Semtech sensor logic
> >   iio: proximity: Add SX9324 support
> >   dt-bindings: iio: Add sx9324 binding
> >   iio: sx9324: Add dt_binding support
> > 
> >  .../ABI/testing/sysfs-bus-iio-sx9324          |   28 +
> >  .../iio/proximity/semtech,sx9324.yaml         |  161 +++
> >  drivers/iio/proximity/Kconfig                 |   18 +
> >  drivers/iio/proximity/Makefile                |    2 +
> >  drivers/iio/proximity/sx9310.c                |  714 ++---------
> >  drivers/iio/proximity/sx9324.c                | 1076 +++++++++++++++++
> >  drivers/iio/proximity/sx_common.c             |  576 +++++++++
> >  drivers/iio/proximity/sx_common.h             |  163 +++
> >  8 files changed, 2127 insertions(+), 611 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> >  create mode 100644 drivers/iio/proximity/sx9324.c
> >  create mode 100644 drivers/iio/proximity/sx_common.c
> >  create mode 100644 drivers/iio/proximity/sx_common.h
> >   
> 

