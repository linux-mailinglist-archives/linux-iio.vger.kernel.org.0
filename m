Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6181ADFB3
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDQOXs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 10:23:48 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58315 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgDQOXr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 10:23:47 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 83311C001E;
        Fri, 17 Apr 2020 14:23:45 +0000 (UTC)
Date:   Fri, 17 Apr 2020 16:23:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
Message-ID: <20200417142345.GA34509@piout.net>
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
 <20200416205428.437503-2-alexandre.belloni@bootlin.com>
 <CAHp75VdQ58A39HYnW-7CYJgp4+adrzcoiQ4KmTq=0snVAokH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdQ58A39HYnW-7CYJgp4+adrzcoiQ4KmTq=0snVAokH9g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/04/2020 16:45:05+0300, Andy Shevchenko wrote:
> On Thu, Apr 16, 2020 at 11:55 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > The first received byte is the MSB, followed by the LSB so the value needs
> > to be byte swapped.
> >
> > Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> > bytes to get the last bit.
> 
> > +       return adc->rx_buf[0] << 9 | adc->rx_buf[1] << 1 | adc->rx_buf[2] >> 7;
> 
> I just realize, isn't it an open coded variant of ror() / rol()?
> 

No, this byteswaps and rotates.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
