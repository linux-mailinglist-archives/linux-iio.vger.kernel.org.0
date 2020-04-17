Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4A1ADBFA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgDQLNF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 07:13:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39535 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgDQLNF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 07:13:05 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8B15B24000F;
        Fri, 17 Apr 2020 11:13:02 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:13:02 +0200
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
Message-ID: <20200417111302.GZ34509@piout.net>
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
 <20200416205428.437503-2-alexandre.belloni@bootlin.com>
 <CAHp75Vddt-UKkP+b8W2CDYjt5kzggwQ+gTjrieigeYhM=e4Tig@mail.gmail.com>
 <CAHp75VeUdj4kkGMaapZu2i96faxmdnhC4a4GF1UoGfSKAVtg6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeUdj4kkGMaapZu2i96faxmdnhC4a4GF1UoGfSKAVtg6g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/04/2020 13:47:33+0300, Andy Shevchenko wrote:
> On Fri, Apr 17, 2020 at 1:44 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Apr 16, 2020 at 11:55 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > The first received byte is the MSB, followed by the LSB so the value needs
> > > to be byte swapped.
> > >
> > > Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> > > bytes to get the last bit.
> > >
> >
> > Can you show example of what is read and what is expected to be a correct value?
> > Because it seems I have been reported with similar issue on other TI
> > ADC chip [1]. Perhaps we have to fix all of them?
> >
> > [1]: https://github.com/edison-fw/meta-intel-edison/issues/108
> 
> Also, forgot to mention that TI ADC are 16 bit word, so, we need to
> read two u16 rather then bytes.
> 
> Some configuration won't allow to do byte reads.
> 

Both ADC families are not related, I don't think this is your issue. The
ADS8344 was from Burr-Brown.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
