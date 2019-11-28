Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5332710CB72
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1POH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 10:14:07 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46129 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1POG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 10:14:06 -0500
Received: by mail-ua1-f66.google.com with SMTP id i31so8270462uae.13
        for <linux-iio@vger.kernel.org>; Thu, 28 Nov 2019 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zy5uF93qK7TsStsu2k6NBdy7JOya0iOQZuXD1Iujcb0=;
        b=FgU8RBDillVl+/sMKUnVfTCyoZ6ovuHCJ3RYXZVdc8DkktX+sOespBa63SRYWG4dnl
         iBmxqUPDLRcgTyJ6LaY51B+vJRo4OVSxqm9KGbGhsCfAm++HvUEzqZZbf9rSFXQX8xnZ
         8a3/IAVcQmIRdQkhiZ+RIMYIfOZIVESGhwA6DAYYVFarja6wWf5D+ZcVpyyKXjkksPTS
         j9amkeksnenw65cj5BPfp1QZih0IaGNGX17IiSydMPgs08LyFBevpKzAosNnuZbtem3q
         DQPoYh0okaQLeYry/mb8rLyQ6Igx8MV3z5+e+PEDCYcnSUEl443b6vSeuaLY2FU1qKaz
         RT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy5uF93qK7TsStsu2k6NBdy7JOya0iOQZuXD1Iujcb0=;
        b=VdfttTbbqUR8CeTEF43FUrqFE5MgTY7qIF0MOlwrrRSUG9FuFsjgFKhqkcXh9m6CkF
         XNtCnooBCXGuUwDoxSljpho+H0CL98cpqK5NZdg3BjGA89ltjCx/78zLpixEkaGEWEVy
         6MiKKBh9W6F1ot7jQ7E3AcLtOYFAfg5ldAtI2ZXA6paWKgTi9Zfj+xwDKTfQhNaHlNEE
         lyPN/artrosZlhgEQsyht6AnDcpmT6gr+D9U33NHDOc31koqzMLBPPmV4L8LjoQS82Ta
         EulWpuYdVYSi6aSFMdnE4cH56iW5AsbkpDjjDa4By8O4fzLwDTwyx1dJclxqtQAQtOEZ
         Q4+A==
X-Gm-Message-State: APjAAAVfmzdJ8uFfLQ9yp3JnsuEct0uIXYuNc09kDOKMsSRbh4m6xgk/
        OqBerwyTbhVV1bMw1CzwBV8TLPbFtbqC7+7eOoc=
X-Google-Smtp-Source: APXvYqwAGy+gTV/SLPvtYrl7dXWczaEJcV2ETOiaEioT0LRv9xRcivVVU3hysirSDPYjAnOHgKIM0hhsApxY+szl1jg=
X-Received: by 2002:ab0:2551:: with SMTP id l17mr6571105uan.54.1574954044923;
 Thu, 28 Nov 2019 07:14:04 -0800 (PST)
MIME-Version: 1.0
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
 <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
 <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
 <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com> <74bff1fe1eab887d3d19f3cff3fc02afbc52a12d.camel@analog.com>
In-Reply-To: <74bff1fe1eab887d3d19f3cff3fc02afbc52a12d.camel@analog.com>
From:   Daniel Junho <djunho@gmail.com>
Date:   Thu, 28 Nov 2019 12:13:56 -0300
Message-ID: <CAKxs2cBRC1Mkx5+jtW+BNqA_53GL1K2C8Hppf7wuY6SMPiMi+Q@mail.gmail.com>
Subject: Re: Doubts in getting started with the Analog AD7928 driver
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello.

After some effort to extend the AD7923 to include the AD7928, I got
stuck because it won't work.

After several days trying to figure out, I could use an oscilloscope
to analyze and, it seems that the cs_change does not affect the
driver.

```
  struct spi_transfer t[] = {
           {
                   .tx_buf = &st->tx_buf[0],
                   .len = 2,
                   .cs_change = 1,
           }, {
                   .rx_buf = &st->rx_buf[0],
                   .len = 2,
           },
   };
   ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
```

The code above sends the first cmd and does not deselect the cs to get
the answer.

I am using kernel 4.4.107 from Toradex to deploy the driver. That is
the version used on the project of the board.

Does anyone have any idea what I am doing wrong? Should I update the
kernel, or it should work as well in this version? Or any ideas of how
to debug it?

Daniel E. M. Junho


On Wed, Sep 18, 2019 at 3:13 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Tue, 2019-09-17 at 21:47 -0300, Daniel Junho wrote:
> > On Tue, Sep 17, 2019 at 3:24 AM Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com> wrote:
> > > On Mon, 2019-09-16 at 20:50 -0300, Daniel Junho wrote:
> > > > [External]
> > > >
> > > > Hello everybody.
> > > >
> > > > I am still learning about kernel developing. I would like to try to
> > > > develop a device driver for the AD7928 [1], from Analog Device.
> > > >
> > > > Can someone give some words to guide me?
> > > >
> > > > I was thinking about forking the analog kernel repo [2] but I don't
> > > > know to which branch should I commit to when doing a pull request. Or
> > > > if this is the correct way for the devices from Analog.
> > > >
> > >
> > > Hey,
> > >
> > > Thanks for the interest in writing the driver for this.
> > >
> > > In some cases, some new parts may have an existing driver available
> > > already
> > > that can be re-used partially or completely.
> > >
> > > You're in luck.
> > > There is driver seems to be partially implemented via
> > > drivers/iio/adc/ad7923.c
> > >
> > > I've done only a minor/quick check but the control register bits are
> > > compatible for the AD7928 as well.
> > >
> > > Typically, you can extend that driver and add the new parts and test
> > > them.
> > >
> > > So, my suggestion would be:
> > > 1. Get an eval-board or a AD7928 part; depending on the case we could
> > > help
> > > with this
> > > 2. Try to set it up with a Raspberry Pi with the eval board
> > >    a. it looks to me that you need a 7V-9V power-supply
> > >    b. you can hook the SPI to the test-points on the eval board
> > > 3. Write a basic device-tree overlay ; you can adapt something from
> > > other
> > > examples.
> > > Look here:
> > > https://github.com/analogdevicesinc/linux/blob/rpi-4.19.y/arch/arm/boot/dts/overlays/Makefile
> > > Usually  rpi-adXXX.dts  are ADI parts.
> > > 4. Enable the driver for the kernel.
> > > If using the ADI kernel, there's a guide here for RPi.
> > > https://wiki.analog.com/resources/tools-software/linux-build/generic/raspberrypi
> > > Check the branch that matches your Raspbian image (rpi-4.19.y is the
> > > latest)
> > > 5. Build the kernel
> > > 6. Write it to the SD-card image
> > > 7. Test
> > > 8. Modify & repeat
> > >
> > > Thanks
> > > Alex
> > >
> > > > [1] https://www.analog.com/en/products/ad7928.html
> > > > [2] https://github.com/analogdevicesinc/linux
> > > >
> > > > Daniel Junho
> >
> > Hi Alex.
> >
> > It seems that using AD7923 will be the best choice. They are very
> > similar.
> >
> > Thank you for your reply and suggestion.
> > I don't have an EVB, but at work, we have a board with the AD7928
>
> If you have the chip already connected, then it's even better.
> You don't need to go through the trouble of interfacing it anymore.
>
> > using a user driver. So I will try to use it for this development, at
>
> And if you've already validated with a user-driver, it's again better, as
> the connections have been validated.
>
> > least for now.
> >
> > I believe that will be fun =)
>
> Should be.
> If this whole thing is new to you, it's always easier to start with a
> base/existing driver and extend than go through the process of writing it
> from scratch.
> It's mostly how I learn(ed) things: taking things apart, seeing what people
> have done, and then using the best ideas in my future processes.
>
> >
> > Daniel Junho
