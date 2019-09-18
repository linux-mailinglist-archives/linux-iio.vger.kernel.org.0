Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C180B5914
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 02:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfIRAr6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 20:47:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45168 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIRAr6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 20:47:58 -0400
Received: by mail-ua1-f66.google.com with SMTP id j5so1765047uak.12
        for <linux-iio@vger.kernel.org>; Tue, 17 Sep 2019 17:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FA+I3fkr+pQHrgd2SSAvzbvXD7GK3Tv3iv0Ww8Yb9aE=;
        b=fkT7EZ2R7RafpEqY2+eGVuflsBv48770F423OJ4Qk+B/qkg4JFqKPWfum0NutKaJjz
         44yF3tITeNrO8HbLbxpUArBb8tnQrz/VmRANicmRHQNM8KrCGR1srECEeP59jrK52uOr
         svkLANrLfXTfHkQ1Ea2SBKUHjjaQcn7JMs2QM8VBXUe8mYknm+FgBRlHUg1i9vPL5CzX
         BFjnO48J+/ZOK9wSstL5kGiiWbj7C6IybAIIMn+jMXR/hr6AaLXDV9qr43EgpmfzpUKz
         YFxbSHNeYb7rV3RnAVZz02jlYn+5e8x/eOLu6SvTPETblw4CvIMn1OE88NvpzPGbOell
         YFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FA+I3fkr+pQHrgd2SSAvzbvXD7GK3Tv3iv0Ww8Yb9aE=;
        b=A80E0HUdJddmF5IWRfQ2j7zdT3mlvyZAeP9Ky3OBztc2IDPSNCdUgsqtpjq99UJJnq
         DDadtlLiprTHNvwHayLE7tth5MBUKTtHbMlZxbUTVv2xLUzzPkIPw8hnjpP1GGfMORNx
         +yKpjyiz5sSojzFK/PuoTTCHgJB0iV15C9wXuR1WDFdHMCGADC9FGwE/QI7LSFPF9O/3
         BLX9KsQFZBTZEsEhWyQTkJ1vGmWEG13AMG94Mvxt5rhUdpP9gsnV2hqci1CHmTmAlD2S
         7hvCYjN2FI9yPvSZj53sZmX6MjHt4dPQsPbBWOPZ8vd6iHWvbvbX0Mkuulb8Zt9B35C4
         N2NA==
X-Gm-Message-State: APjAAAXED7P4WqR5OUzcws/ZsGwKqNPD/6uK8wpH5V/KOwttgo+Cv9rb
        A6cpq8yn1TE008/XjkUB38v/SHwuEpEV/plg5rVPzCU4
X-Google-Smtp-Source: APXvYqwwD5MBxChsgsDyaCN+jX5o/mi4ZfPVE0XLAciOfbwpeSvBPxJjCD9Yqo68Z86Nhqm0YP2RqEcSeQIurXuiCr0=
X-Received: by 2002:ab0:21d7:: with SMTP id u23mr944441uan.142.1568767677442;
 Tue, 17 Sep 2019 17:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
 <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com> <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
In-Reply-To: <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
From:   Daniel Junho <djunho@gmail.com>
Date:   Tue, 17 Sep 2019 21:47:44 -0300
Message-ID: <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com>
Subject: Re: Doubts in getting started with the Analog AD7928 driver
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 17, 2019 at 3:24 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Mon, 2019-09-16 at 20:50 -0300, Daniel Junho wrote:
> > [External]
> >
> > Hello everybody.
> >
> > I am still learning about kernel developing. I would like to try to
> > develop a device driver for the AD7928 [1], from Analog Device.
> >
> > Can someone give some words to guide me?
> >
> > I was thinking about forking the analog kernel repo [2] but I don't
> > know to which branch should I commit to when doing a pull request. Or
> > if this is the correct way for the devices from Analog.
> >
>
> Hey,
>
> Thanks for the interest in writing the driver for this.
>
> In some cases, some new parts may have an existing driver available already
> that can be re-used partially or completely.
>
> You're in luck.
> There is driver seems to be partially implemented via
> drivers/iio/adc/ad7923.c
>
> I've done only a minor/quick check but the control register bits are
> compatible for the AD7928 as well.
>
> Typically, you can extend that driver and add the new parts and test them.
>
> So, my suggestion would be:
> 1. Get an eval-board or a AD7928 part; depending on the case we could help
> with this
> 2. Try to set it up with a Raspberry Pi with the eval board
>    a. it looks to me that you need a 7V-9V power-supply
>    b. you can hook the SPI to the test-points on the eval board
> 3. Write a basic device-tree overlay ; you can adapt something from other
> examples.
> Look here:
> https://github.com/analogdevicesinc/linux/blob/rpi-4.19.y/arch/arm/boot/dts/overlays/Makefile
> Usually  rpi-adXXX.dts  are ADI parts.
> 4. Enable the driver for the kernel.
> If using the ADI kernel, there's a guide here for RPi.
> https://wiki.analog.com/resources/tools-software/linux-build/generic/raspberrypi
> Check the branch that matches your Raspbian image (rpi-4.19.y is the
> latest)
> 5. Build the kernel
> 6. Write it to the SD-card image
> 7. Test
> 8. Modify & repeat
>
> Thanks
> Alex
>
> > [1] https://www.analog.com/en/products/ad7928.html
> > [2] https://github.com/analogdevicesinc/linux
> >
> > Daniel Junho

Hi Alex.

It seems that using AD7923 will be the best choice. They are very similar.

Thank you for your reply and suggestion.
I don't have an EVB, but at work, we have a board with the AD7928
using a user driver. So I will try to use it for this development, at
least for now.

I believe that will be fun =)

Daniel Junho
