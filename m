Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB91A7A57
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 14:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgDNMIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 08:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbgDNMIi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 08:08:38 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.102.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116702075E;
        Tue, 14 Apr 2020 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586866117;
        bh=AE6abk0P8o5HO1zDl/JX0fKcg0o808yfPOCIO2osquY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJmt0e7Mc6E3lk6HAbtBuiKU6vXBUAwMK/TnzGyynf7dDDFqpcx/q06D3nF5AlTR4
         a71xgApVGPHC1WCz6w8eYqMj+xaaqUwqMwl2Dvz2xXWekAZdifB8N8i29LuXkA9Hl4
         uHzM8Zz1kMtMk3/dRdmCzVWaz6wAxu18KfZv4/Qk=
Date:   Tue, 14 Apr 2020 17:38:26 +0530
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
Subject: Re: [PATCH 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
Message-ID: <20200414120325.GA28388@Mani-XPS-13-9360>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-3-mani@kernel.org>
 <CAHp75VdCK26wXiw0c=1fc0vKsea4w=tthCBrroLOqqaDbwuMVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdCK26wXiw0c=1fc0vKsea4w=tthCBrroLOqqaDbwuMVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 11:20:42PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 13, 2020 at 8:34 AM <mani@kernel.org> wrote:
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
> ...
> 
> > +#define CCS811_SW_RESET                0xFF
> 
> 
> > +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +                                            GPIOD_OUT_LOW);
> > +       if (IS_ERR(reset_gpio)) {
> > +               dev_err(&client->dev, "Failed to acquire reset gpio\n");
> 
> > +               return -EINVAL;
> 
> Do not shadow actual error code.
> 

Okay. Will change below instance as well.

> > +       }
> > +
> > +       /* Try to reset using nRESET pin if available else do SW reset */
> > +       if (reset_gpio) {
> > +               gpiod_set_value(reset_gpio, 1);
> > +               usleep_range(20, 30);
> > +               gpiod_set_value(reset_gpio, 0);
> > +       } else {
> 
> > +               static const u8 reset_seq[] = {
> > +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> > +               };
> 
> Is 0xFF here is CCS811_SW_RESET? If so, can you put it explicitly?
> 

Nope. CCS811_SW_RESET is the register address whereas 0xFF here is the actual
value return to the register. I don't know what these values in array represent.
So will keep them as it is.

Thanks,
Mani

> > +               ret = i2c_smbus_write_i2c_block_data(client, CCS811_SW_RESET,
> > +                                            sizeof(reset_seq), reset_seq);
> > +               if (ret < 0) {
> > +                       dev_err(&client->dev, "Failed to reset sensor\n");
> > +                       return ret;
> > +               }
> > +       }
> 
> ...
> 
> > +       data->wakeup_gpio = devm_gpiod_get_optional(&client->dev, "wakeup",
> > +                                                   GPIOD_OUT_HIGH);
> > +       if (IS_ERR(data->wakeup_gpio)) {
> > +               dev_err(&client->dev, "Failed to acquire wakeup gpio\n");
> 
> > +               return -EINVAL;
> 
> Ditto.
> 
> > +       }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
