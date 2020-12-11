Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6852D713A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395382AbgLKIKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:10:04 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60089 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbgLKIJs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:09:48 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A0BF2240003;
        Fri, 11 Dec 2020 08:08:59 +0000 (UTC)
Date:   Fri, 11 Dec 2020 09:08:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio:pressure:ms5637: add ms5803 support
Message-ID: <20201211080859.GD1781038@piout.net>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
 <20201209234857.1521453-7-alexandre.belloni@bootlin.com>
 <20201211033413.GA3584721@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211033413.GA3584721@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/12/2020 21:34:13-0600, Rob Herring wrote:
> On Thu, Dec 10, 2020 at 12:48:57AM +0100, Alexandre Belloni wrote:
> > The ms5803 is very similar to the ms5805 but has less resolution options
> > and has the 128bit PROM layout.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  drivers/iio/pressure/ms5637.c                          | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index ab623ba930d5..84b0e44235c1 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -132,6 +132,8 @@ properties:
> >            - mcube,mc3230
> >              # MEMSIC 2-axis 8-bit digital accelerometer
> >            - memsic,mxc6225
> > +            # Measurement Specialities I2C pressure and temperature sensor
> > +          - meas,ms5803
> 
> Alphabetical order please.

Ah, this was my intention, it will conflict with the togreg branch of
iio.git anyway.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
