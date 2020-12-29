Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917722E7157
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 15:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgL2O0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 09:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgL2O0P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 09:26:15 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC6A20825;
        Tue, 29 Dec 2020 14:25:33 +0000 (UTC)
Date:   Tue, 29 Dec 2020 14:25:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Message-ID: <20201229142531.3a4ceedc@archlinux>
In-Reply-To: <SN6PR08MB5565A63054BD03141EC56DC29ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
        <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
        <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
        <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
        <CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com>
        <SN6PR08MB55654976327EF62990D4DD919ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
        <CACRpkdYVruMggRHtOLWZ01N5yYx8GqAK3OtKC13Z=669eznurA@mail.gmail.com>
        <SN6PR08MB5565A63054BD03141EC56DC29ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Dec 2020 22:08:24 +0000
Chris Lesiak <chris.lesiak@licor.com> wrote:

> Linus Walleij <linus.walleij@linaro.org> wrote:
> > Aha you mean that iio_read_channel_processed() loses
> > precision when converting raw to scaled?  
> 
> Yes.  For example, take a 16-bit ADC with 4.096 V reference.
> The native resolution is 62.5 microVolts.
> Yet iio_read_channel_processed() can only give integer milliVolts.
> iio_read_channel_raw() followed by iio_convert_raw_to_processed()
> with a scale of 1000 will preserve more of the native resolution.
> User space can do this by using floating point numbers when
> converting to processed.
> 
> You are likely to lose precision for all ADCs greater than about 12-bit.
> 
> Chris Lesiak <chris.leisak@licor.com> wrote:
> >> I'd prefer a solution similar to the existing implementation of
> >> iio_read_channel_processed.  
> 
> > That seems like the wrong way to work around a problem in
> > the core.  
> 
> > If iio_read_channel_processed() loses precision we should
> > fix iio_read_channel_processed() and not try to work around
> > the problem in the consumers.  
> 
> > It's fine to fix all the consumers in the kernel.  
> 
> > What about changing the signature of:  
> 
> > int iio_read_channel_processed(struct iio_channel *chan, int *val)  
> 
> > to:  
> 
> > int iio_read_channel_processed(struct iio_channel *chan, int *val,
> > unsigned int scale)  
> 
> > And just augment all calls to pass 1 except the ntc driver
> > which then passes 1000 in the last argument?  
> 
> > If Jonathan agrees I can fix a patch to alter all the ~50
> > call sites like this and include the change to this NTC
> > driver.  
> 
> That would meet my needs and does address what I think is a
> shortcoming in the existing iio_read_channel_processed interface.
I'm fine with this proposal as well.  Makes a lot of sense given
there is no particular reason why another subsystem should want to
convert to IIO base units (here milivolts).

The only other way I could think of doing it would be to
have iio_read_channel_processed 'return' a pair of integers and
type etc IIO_VAL_INT_PLUS_MICRO much like read_raw etc does inside
the actual drivers.

It would be a bit clunky to implement however and potentially require
some messy maths in the consumers.

May want to think about whether we need additional sanity checks for
overflow etc.   Seems unlikely we'd hit hit them for voltage, but
we might for some other types of sensor where the base unit is much
smaller (wrt to real world values).

Jonathan

