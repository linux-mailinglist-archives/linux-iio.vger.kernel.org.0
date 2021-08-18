Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34C73EFDBF
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhHRH3g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 03:29:36 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:64151 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbhHRH3e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 03:29:34 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BED61240005;
        Wed, 18 Aug 2021 07:28:56 +0000 (UTC)
Date:   Wed, 18 Aug 2021 09:29:43 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
Message-ID: <20210818072943.zgj6nibmvpnd2ffu@uno.localdomain>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-2-jacopo@jmondi.org>
 <YRvo5qCWrBT1x7V+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRvo5qCWrBT1x7V+@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Tue, Aug 17, 2021 at 07:50:46PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 17, 2021 at 05:49:50PM +0200, Jacopo Mondi wrote:
> > Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.
>
> > +  ndry-gpios:
> > +    description: Phandle to the GPIO line connected to the nDRY pin. Active low.
> > +
> > +  en-gpios:
> > +    description: Phandle to the GPIO line connected to the EN pin. Active high.
>
> Not sure you have to mention polarity. It can be changed on PCB level easily
> and this bindings won't satisfy those (valid) changes.

Well, one can indeed invert the signal on the PCB, it's weird I see most of
the bindings reporting the pin's active polarity though...

I'll drop it.

Thanks
   j
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
