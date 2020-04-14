Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BC1A86E4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbgDNRGC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 13:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbgDNRGA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 13:06:00 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3116120678;
        Tue, 14 Apr 2020 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586883959;
        bh=Xcd8OczNfFdGZEF3wPW0kOHvO/XmMZqNiHT1ft2gcp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAYu5Wo6SyKz8OOXUZxB0yCmcnYI/DANdYKf/LLtqG58SEPGSGt3QieOisCBupp8O
         vcJ5lrB5Tw3WUxzV7qtaa6JNmagze/ZLZ6yLqOYv5AOTziSR15RGF7sSU+Db+w0MLz
         zYf4DKe5j9ROPxXB1JQgmDIdC6VJa1d1VMeqFamY=
Date:   Tue, 14 Apr 2020 22:35:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
Message-ID: <20200414170547.GB3334@Mani-XPS-13-9360>
References: <20200414153415.957-1-mani@kernel.org>
 <20200414153415.957-3-mani@kernel.org>
 <CAHp75Vf1wzBD+r5L7XFPW=ydxFLBfBNr6Jc4b6sMWR4Rci-Acw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf1wzBD+r5L7XFPW=ydxFLBfBNr6Jc4b6sMWR4Rci-Acw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 07:42:24PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 14, 2020 at 6:34 PM <mani@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <mani@kernel.org>
> >
> > CCS811 VOC sensor exposes nRESET and nWAKE pins which can be connected
> > to GPIO pins of the host controller. These pins can be used to externally
> > release the device from reset and also to wake it up before any I2C
> > transaction. The initial driver support assumed that the nRESET pin is not
> > connected and the nWAKE pin is tied to ground.
> >
> > This commit improves it by adding support for controlling those two pins
> > externally using a host controller. For the case of reset, if the hardware
> > reset is not available, the mechanism to do software reset is also added.
> >
> > As a side effect of doing this, the IIO device allocation needs to be
> > slightly moved to top of probe to make use of priv data early.
> 
> Thank you for an update, my comments below.
> 
> ...
> 
> > +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +                                            GPIOD_OUT_LOW);
> > +       if (IS_ERR(reset_gpio)) {
> 
> > +               dev_err(&client->dev, "Failed to acquire reset gpio\n");
> 
> If it's a deferred probe, it would spam the log.
> 

Hmm. But error is an error isn't it? Would you recommend doing a debug print
or completely removing the logging?

> > +               return PTR_ERR(reset_gpio);
> > +       }
> 
> ...
> 
> > +               static const u8 reset_seq[] = {
> > +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> > +               };
> 
> I would suggest to comment above from where you got this and the
> meaning of the numbers.
> 

The datasheet doesn't specify the meaning of these values. But will add a
comment. Btw, just noticed that 0xFF is not needed and only 4 values are
sufficient for SW reset.

Thanks,
Mani

> ...
> 
> > +       data->wakeup_gpio = devm_gpiod_get_optional(&client->dev, "wakeup",
> > +                                                   GPIOD_OUT_HIGH);
> > +       if (IS_ERR(data->wakeup_gpio)) {
> 
> > +               dev_err(&client->dev, "Failed to acquire wakeup gpio\n");
> 
> Ditto.
> 
> > +               return PTR_ERR(data->wakeup_gpio);
> > +       }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
