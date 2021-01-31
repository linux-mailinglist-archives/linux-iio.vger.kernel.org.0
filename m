Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9163309C3C
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhAaM7L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 07:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhAaLd4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 06:33:56 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9791B64E21;
        Sun, 31 Jan 2021 11:00:25 +0000 (UTC)
Date:   Sun, 31 Jan 2021 11:00:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity
 driver
Message-ID: <20210131110021.46a700e4@archlinux>
In-Reply-To: <161161826068.76967.15170332425672601158@swboyd.mtv.corp.google.com>
References: <20210122225443.186184-1-swboyd@chromium.org>
        <20210122225443.186184-4-swboyd@chromium.org>
        <20210124173820.4528b9c9@archlinux>
        <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com>
        <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com>
        <CAPUE2uu555NT1=u=1Nb8WExT7RvK8mj5kBiDfGymHiAmoj2WCg@mail.gmail.com>
        <161161826068.76967.15170332425672601158@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...

> > > > > > +static const struct of_device_id cros_ec_proximity_of_match[] = {
> > > > > > +     { .compatible = "google,cros-ec-proximity" },
> > > > > > +     {}
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > > > > > +#endif
> > > > > > +
> > > > > > +static struct platform_driver cros_ec_proximity_driver = {
> > > > > > +     .driver = {
> > > > > > +             .name = "cros-ec-proximity",
> > > > > > +             .of_match_table = of_match_ptr(cros_ec_proximity_of_match),  
> > > > Add a ACPI match table to match.  
> > >
> > > I don't have an ACPI system in hand. What should the ACPI table look
> > > like? Can ACPI use the of_match_table logic?  
> > AFAIK, ACPI uses .acpi_match_table, see
> > drivers/iio/magnetometer/ak8975.c for a simple example.  
> 
> Ok. I'm leaning towards punting on this. I don't have an ACPI system to
> test and I don't know what the ACPI match table should have in it. If
> you can tell me what to put in the acpi_match_table then I can add it.

Unless we have a known ACPI ID don't add support.  We let a few of those
in in the past, (mostly because I didn't know better) and they are a pain
to clean up, particularly as there may be platforms that started using
them because the Linux driver supported them.

Jonathan


