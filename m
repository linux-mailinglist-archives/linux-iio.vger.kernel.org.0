Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721DA1C2758
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 19:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgEBR4U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 13:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgEBR4U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 13:56:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5DB2075B;
        Sat,  2 May 2020 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588442179;
        bh=Pyti/oXfxkkEpTlk5s7TE6yHsZRFMYA9AHGC30Lb498=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MiEddyPCAtLTlxuDcubVgInzAEFFsHVAHPZPu/p+l56T1dNxwRmAHYtbBmCYfu9Gf
         3YxZRiagCdB8m1kCD/GgnuHiqWzq/RlwOFw+2bcF+cHC6EOcUGFoY5SEwq9ysTaHk3
         im/59ryejSfqE5hmVOADG140OyukQDJuCEAgKtaE=
Date:   Sat, 2 May 2020 18:56:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: cros_ec_light: Add support for RGB sensor
Message-ID: <20200502185615.74db5af1@archlinux>
In-Reply-To: <CAPUE2us=1=RvJ1aQNYQSU1rnMkwjVfM_EdS7QpO8u0NPPtgsfg@mail.gmail.com>
References: <20200423000230.82750-1-gwendal@chromium.org>
        <20200423000230.82750-3-gwendal@chromium.org>
        <20200425183101.531b49be@archlinux>
        <CAPUE2us=1=RvJ1aQNYQSU1rnMkwjVfM_EdS7QpO8u0NPPtgsfg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 14:07:03 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sat, Apr 25, 2020 at 10:31 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 22 Apr 2020 17:02:30 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >  
> > > Add support for color sensors behind EC like TCS3400.
> > > The color data can be presented in Red Green Blue color space (RGB) or
> > > the CIE 1931 XYZ color space (XYZ).
> > > In XYZ mode, the sensor is configured for auto calibrating its channels
> > > and is the "normal" mode.
> > > The driver tells the EC to switch between the 2 modes by using the
> > > calibration command.
> > > When the sensor is in calibration mode, only clear and RGB channels are
> > > available. In normal mode, only clear and XYZ are.
> > > When RGB channels are enabled, the sensor switches to calibration mode
> > > when the buffer is enabled.
> > >
> > > When reading trhough sysfs command, set calibration mode and then read
> > > the channel(s). A command will be issue for each read, so the channels
> > > may come from different sensor sample.
> > > When using the buffer, after setting the mask, when the buffer is
> > > enabled, the calibration will be set based on the channel mask.
> > >
> > > libiio tools can be used to gather sensor information:
> > > iio_readdev -s 10 cros-ec-light \
> > > illuminance_clear illuminance_x illuminance_y illuminance_z  
> > Illuminance is not defined for color channels.  It's units are LUX which
> > is only defined wrt to a model of the human eye's response to
> > 'brightness' (kind of).  
> Looking at "Calculating Color Temperature and Illuminance " from AMS
> [https://ams.com/documents/20143/80162/TCS34xx_AN000517_1-00.pdf/1efe49f7-4f92-ba88-ca7c-5121691daff7]
> page 5, equation 2, the illuminance (Y) is a derived from the vector
> (X, Y, Z) with coefficient applied. Doesn't it mean
> in_illumincance_[X,Y,Z,R,G,B,clear ...]_raw have all the same unit,
> lux?

Unfortunately not.   Lux is only defined as brightness as measured
with a very specific sensitivity profile across the bands. It has no
meaning as a unit for the various elements added up to get to it.
(somewhere good old dimensional analysis breaks down)

Fun corner case of units :)

I have seen data sheets that get this wrong btw.
It's a complex mess because RGB channels are not separable
either.  They all have overlapping frequency sensitivities.
Generally the sensors are designed to have some linear combination
of curves that is close to the curve used for illuminance as they
want to match human eye view of what bright is.

If you can provide enough info to the driver to do the calculation
that would be ideal as then we could provide a standard measure of
brightness to userspace.

Jonathan
