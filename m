Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13113E3AE6
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhHHOtY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 10:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231932AbhHHOtV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 10:49:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217B360560;
        Sun,  8 Aug 2021 14:48:59 +0000 (UTC)
Date:   Sun, 8 Aug 2021 15:51:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Dragos.Bogdan@analog.com" <Dragos.Bogdan@analog.com>,
        "Darius.Berghe@analog.com" <Darius.Berghe@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver support for ADXL313
Message-ID: <20210808155149.1c435b88@jic23-huawei>
In-Reply-To: <CACKVXZB5Fo02ZT58swZKoz9DxNUR9Mmx717nf1OiB+g6+T7hJw@mail.gmail.com>
References: <cover.1628143857.git.lucas.p.stankus@gmail.com>
        <22ad63af54e6cfc9486d44d05ba3d2f7482c7b1e.1628143857.git.lucas.p.stankus@gmail.com>
        <CAHp75Ve7avWpdnCioW6qdT21NqjK1TTW-nwFsz6x+0JLXsQH3Q@mail.gmail.com>
        <CACKVXZB5Fo02ZT58swZKoz9DxNUR9Mmx717nf1OiB+g6+T7hJw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Aug 2021 21:22:46 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> On Fri, Aug 6, 2021 at 9:35 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> >
> >
> > On Thursday, August 5, 2021, Lucas Stankus <lucas.p.stankus@gmail.com> wrote:  
> >>
> >> ADXL313 is a small, thin, low power, 3-axis accelerometer with high
> >> resolution measurement up to +/-4g. It includes an integrated 32-level
> >> FIFO and has activity and inactivity sensing capabilities.
> >>
> >> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> >> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> >> ---
> >>  MAINTAINERS                      |   9 +
> >>  drivers/iio/accel/Kconfig        |  29 +++
> >>  drivers/iio/accel/Makefile       |   3 +
> >>  drivers/iio/accel/adxl313.h      |  63 ++++++
> >>  drivers/iio/accel/adxl313_core.c | 321 +++++++++++++++++++++++++++++++
> >>  drivers/iio/accel/adxl313_i2c.c  |  65 +++++++
> >>  drivers/iio/accel/adxl313_spi.c  |  85 ++++++++
> >>  7 files changed, 575 insertions(+)
> >>  create mode 100644 drivers/iio/accel/adxl313.h
> >>  create mode 100644 drivers/iio/accel/adxl313_core.c
> >>  create mode 100644 drivers/iio/accel/adxl313_i2c.c
> >>  create mode 100644 drivers/iio/accel/adxl313_spi.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index a61f4f3b78a9..566055450b6b 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -585,6 +585,15 @@ L: platform-driver-x86@vger.kernel.org
> >>  S:     Maintained
> >>  F:     drivers/platform/x86/adv_swbutton.c
> >>
> >> +ADXL313 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> >> +M:     Lucas Stankus <lucas.p.stankus@gmail.com>
> >> +S:     Supported
> >> +F:     Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> >> +F:     drivers/iio/accel/adxl313.h
> >> +F:     drivers/iio/accel/adxl313_core.c
> >> +F:     drivers/iio/accel/adxl313_i2c.c
> >> +F:     drivers/iio/accel/adxl313_spi.c  
> >
> >
> >
> > adxl313*?
> >  
> 
> Didn't know this would work, but I think I prefer the way it is now.
> Are you proposing this as a suggestion or more of a change request?

It's a bit neater and very unlikely we'll get a clash on that wild card
in the long run, so I'd 'slightly' prefer this as well.


...

>> +/*
> >> + * Scale for any g range is given in datasheet as
> >> + * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
> >> + */
> >> +#define ADXL313_NSCALE 9576806  
> >
> >
> >
> > Is it in nanonewtons? Perhaps add a suffix _nN?
> >  
> 
> It's actually in meters per second squared, so I couldn't come up with
> a good suffix. Do you have any suggestions?

Easy. Don't have a #define :)

In all seriousness it isn't a 'magic' number, it's an actual real world
value, so move the comment down to where it's used and put the number
directly were it is needed.


Jonathan

