Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C3577007
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiGPQHI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPQHH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 12:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1559B19C3B
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 09:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A422F6102E
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 16:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEFFC34115;
        Sat, 16 Jul 2022 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657987626;
        bh=7cLoJuzFEYlnIdg3tZsiAFJ7xupXcfmrLoDUzkZ9Pgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mdvUriZ1Am+tVFfRqoTBPqmf12S1AZvnXJ+IIiyd/nlANzcVohuiwyQA3hjd0wQOk
         9kbJPBh4KBfUaxPLAIFT4NNZEFhY/f7gNXTr8H5+uE97dESWja6fy5tYnJ4pRxpStO
         zjgaQsKpa8vOY9zInWY3sdP9TA8NkOrYLOx2ZVhW9gYT5d2faNter3j+3ZICNrDp2s
         xBVTQNVmKfiN1DgSJ6QfhkmvLQNRuI7zq6+9ieq6lRqDFAaWfCBnZJgWmZ0ikCFcwj
         lWxJ+CGQDJWUC2aXnYIbLbqMeZCO6fSemb2QLAY0F95newg75oxpnCjRU8qSz9wwIa
         pvHxi9Bq3XtDw==
Date:   Sat, 16 Jul 2022 17:16:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Giedrius =?UTF-8?B?VHJhaW5hdmnEjWl1cw==?= <giedrius@blokas.io>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Dynamically configured channels, overlap with GPIO, encoder
 support
Message-ID: <20220716171659.0d47e08f@jic23-huawei>
In-Reply-To: <CAHp75Vd28B5HFcmOPoT4HS0MHyCs8-WXUxSzgVgpg1nXj5sR7g@mail.gmail.com>
References: <CAMONXLtN9-t=SuNzDWk22ufYXQHh7ZkXD2FhrRmR_uRgJFmZng@mail.gmail.com>
        <CAHp75Vd28B5HFcmOPoT4HS0MHyCs8-WXUxSzgVgpg1nXj5sR7g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jun 2022 14:35:20 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 28, 2022 at 12:06 PM Giedrius Trainavi=C4=8Dius
> <giedrius@blokas.io> wrote:
> >
> > Hello,
> >
> > I am developing an extension board for Raspberry Pi, it has a
> > microcontroller on it and I'm trying to expose its pins as a I/O
> > expander via I=C2=B2C bus. I've recently successfully implemented gpioc=
hip
> > interface as well as irq_chip in a kernel module, and now I'm looking
> > at adding ADC support, Industrial IO seems like a good candidate for
> > exposing it, but I have a couple of questions:
> >
> > 1. Can the IIO channels be configured dynamically?

Nope. You'd need to remove and probe the device again.

> On the
> > microcontroller, the same pins can be used for GPIO, ADC, etc... - can
> > things like the channel direction, the function (simple high or low
> > GPIO pin, ADC, PWM output) be configured by userspace programs? Can it
> > be configured within a kernel module, if I provide my own sysfs
> > interface for function setup?

As a general rule, a pin is wired to one thing on a given board, so it very
rarely makes sense to actually configure these at runtime.  Normally you
push that complexity to device tree.  Sure there are cases with dev boards
etc where this isn't a perfect fit but having to unbind a driver and rebind
it with a new DT overlay isn't too bad and makes things a lot simpler
for the common case of not wanting to do anything dynamic.

> >
> > 2. Can IIO channels be appended and removed to/from the list during run=
time?

Not with a bound driver.

> >
> > 3. Are encoders supported by IIO? I'd like to decode encoders within
> > the firmware of the microcontroller, and provide only
> > increments/decrements to the kernel module via I=C2=B2C, can encoders b=
uilt
> > in such a way be exposed via IIO? I've seen some patches on the
> > internet adding 'counter' interface to IIO, but it seems it never made
> > it to be within IIO, and instead the 'counter' in its own subsystem.

Other way around.  Counters were supported in IIO, but the fit was not good
so in the end the counter subsystem was written to handle them better and
we've since moved all the drivers over.

> >
> > 4. How does IIO interact with gpiochip? As I'm implementing gpiochip
> > interface, I could simply return -EBUSY for pins already used by the
> > other subsystem.
It doesn't.  You need to control the usecases before binding drivers (calli=
ng
probe etc) so that each driver is told only about the 'channels / pins'
that it has access.

Wrapping such a device up as an MFD with appropriate registration functions
to handle management is one way to handle this.

>=20
> We have a DLN2 adapter that provides 4 interfaces with overlapped GPIO
> pins, I don't remember how they solved this. Perhaps the
> microcontroller itself refuses GPIO line acquisition when it's in use
> for other functions.
>=20
> Hence, I recommend looking into the drivers for Diolan DLN2.
>=20
Good suggestion.

Jonathan
=20

