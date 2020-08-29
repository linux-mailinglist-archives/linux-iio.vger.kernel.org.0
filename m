Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6025686C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgH2OyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 10:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2OyP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 10:54:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B8420791;
        Sat, 29 Aug 2020 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598712854;
        bh=/hnmU7dblu1+2kI6nEfoP/ybPzuli9dDyPaZtgTBZ6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YOukvGup/7Sfzgq47oDLVVJg54NhKluYs4yypmDPWXuPy+hlAMsHx5kGk+llAeWcy
         k7hg15JFmmw1iGRG+tILChL6uYQkgjAWBKK3xpSDKhAwWbCwiy68cTxr84aol4duwK
         YbELuXhGAeDvsnrTnDIfOv9WfDLbPCQJzcg16L10=
Date:   Sat, 29 Aug 2020 15:54:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
Message-ID: <20200829155410.6d34a8b9@archlinux>
In-Reply-To: <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
References: <20200827201707.27075-1-krzk@kernel.org>
        <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Aug 2020 11:19:21 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 27, 2020 at 11:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Emails to Beniamin Bia bounce with no such address so remove him from
> > maintainers.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> 
> I guess Reported-by suits better... But okay.

As mentioned below, I'm not keen on marking a driver as orphan
when it is covered by a catch all.

drivers/iio/*/ad*

Let's find out what the Analog team want to do about these.

Jonathan


> 
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio <linux-iio@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  MAINTAINERS | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8107b3d5d6df..523ac1602b62 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -967,9 +967,8 @@ F:  Documentation/devicetree/bindings/iio/dac/ad5758.txt
> >  F:     drivers/iio/dac/ad5758.c
> >
> >  ANALOG DEVICES INC AD7091R5 DRIVER
> > -M:     Beniamin Bia <beniamin.bia@analog.com>
> >  L:     linux-iio@vger.kernel.org
> > -S:     Supported
> > +S:     Orphan

Given it should be covered by the catch all for Analog devices IIO drivers,
either we should confirm if it should move to someone else at Analog, or
if we should just drop specifically listing this one.
Listing it as Orphan when they are good at supporting their drivers
may give the wrong impression.

+CC Alex to make sure people at Analog notice :)

Jonathan

> >  W:     http://ez.analog.com/community/linux-device-drivers
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> >  F:     drivers/iio/adc/ad7091r5.c
> > @@ -1000,7 +999,6 @@ F: drivers/iio/adc/ad7292.c
> >
> >  ANALOG DEVICES INC AD7606 DRIVER
> >  M:     Michael Hennerich <Michael.Hennerich@analog.com>
> > -M:     Beniamin Bia <beniamin.bia@analog.com>
> >  L:     linux-iio@vger.kernel.org
> >  S:     Supported
> >  W:     http://ez.analog.com/community/linux-device-drivers
> > @@ -1068,7 +1066,6 @@ F:        drivers/iio/imu/adis16475.c
> >  F:     Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> >
> >  ANALOG DEVICES INC ADM1177 DRIVER
> > -M:     Beniamin Bia <beniamin.bia@analog.com>
> >  M:     Michael Hennerich <Michael.Hennerich@analog.com>
> >  L:     linux-hwmon@vger.kernel.org
> >  S:     Supported
> > @@ -1136,7 +1133,6 @@ W:        http://ez.analog.com/community/linux-device-drivers
> >  F:     drivers/dma/dma-axi-dmac.c
> >
> >  ANALOG DEVICES INC HMC425A DRIVER
> > -M:     Beniamin Bia <beniamin.bia@analog.com>
> >  M:     Michael Hennerich <michael.hennerich@analog.com>
> >  L:     linux-iio@vger.kernel.org
> >  S:     Supported
> > @@ -16537,7 +16533,6 @@ F:      drivers/staging/rtl8712/
> >
> >  STAGING - SEPS525 LCD CONTROLLER DRIVERS
> >  M:     Michael Hennerich <michael.hennerich@analog.com>
> > -M:     Beniamin Bia <beniamin.bia@analog.com>
> >  L:     linux-fbdev@vger.kernel.org
> >  S:     Supported
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > --
> > 2.17.1
> >  
> 
> 

