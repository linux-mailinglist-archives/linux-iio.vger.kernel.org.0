Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245483EF08B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhHQRC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhHQRCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 13:02:25 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A3C0613CF
        for <linux-iio@vger.kernel.org>; Tue, 17 Aug 2021 10:01:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x5so10336581ill.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Aug 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TSmu7Tcx482vYatg1kVeYYagC5VeCF43KM8qW6y+Ng=;
        b=OxwMZs7YmmPYX/QkiL7SWrSfXJTR2pEdm+fzpl6lRc+BV97EQL8cy05p8rMp8toGuC
         IU9q3co4dtc5wbs8ouSzNwPhxJ71Gf4lo4CldR3Rm1aA8rnRUNM1EVWEMaQThx7hJE+4
         4xNAQDgBcMAhDqTK++bf2ygV9PpuChRhhwfZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TSmu7Tcx482vYatg1kVeYYagC5VeCF43KM8qW6y+Ng=;
        b=i36RwJwMxApNeq/MVmIoLbVtYXraf//NXWjAr3qNy0FKQvMv2fHxdGKujlidGCH3Qg
         KawSrMAjFRY0oQCWDMicOp5l7w3zss1Q9T/4/8ujL9nw/ePREfA6yvsvTX///jajy2Zv
         KB4LKQ+xm5Z65EdQ3GAF3gl0Eq20YUppi++qT72FNGepzeSDMIpzQFNBaqDUAB6rsioI
         j8v9Mh2heWrNnfQTBOLzXyir1UZ0444V8dYMlHJwsYNuX3V1AuRQdcUKSgSU9TtaQ4eL
         u0sM/dOMdR2ntHrDYqQiJFSzLA70wpwMrXUBINMrI7TZ80OlZ4SgjCY5H+aJQH59w5uo
         EpiQ==
X-Gm-Message-State: AOAM531RJ4Sq+RyOYyKuxVJutCG1uPD3CGTgCxgRlJtkRHQVSqz9TV3b
        qN+twfvUQ++qQ4FW3sg6yuxOED+z4Y87kV9t12usyg==
X-Google-Smtp-Source: ABdhPJzY0WSmHnq3bI05D1spqHiTSvNUi9htVlj3U2pk0DSthdKRBJSRhIQHZXYh9cOoEu7nEhqHkt/BmumLimtRHXg=
X-Received: by 2002:a05:6e02:214e:: with SMTP id d14mr3130259ilv.142.1629219711709;
 Tue, 17 Aug 2021 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210817154951.50208-1-jacopo@jmondi.org>
In-Reply-To: <20210817154951.50208-1-jacopo@jmondi.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 17 Aug 2021 10:01:40 -0700
Message-ID: <CAJCx=gnx=U6grCBarPOuc=v201v+Hyp8oiaYdVH-=-2JdNEQ1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: chemical: Add Senseair Sunrise CO2 sensor
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 17, 2021 at 8:49 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Hello,
>    this is a small driver for the Senseair Sunrise 006-0-0007 CO2
> sensor.
>
> The driver supports continuous reads of temperature and CO2 concentration
> through two dedicated IIO channels.
>
> While the driver is rather simple I'm not sure calibration is handled in
> the correct way. In this version, at probe time, a check on the general
> error register is made to verify if a calibration cycle is required.
> The calibration takes a time in the order of a few seconds, and currently
> can only happen at probe time.
>
> Is there a mechanism available in the IIO framework to expose a trigger to have
> userspace decide when the calibration has to happen ? In my understanding IIO
> triggers are meant to trigger read events, using them for calibration purpose
> seems not the right thing to do, or am I mistaken ?

For sure you shouldn't use the trigger framework for that.

You should use an attribute group, e.g.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/proximity/as3935.c?h=v5.14-rc6#n168

- Matt

>
> Thanks
>   j
>
> Jacopo Mondi (2):
>   dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
>   iio: chemical: Add Senseair Sunrise 006-0-007 driver
>
>  .../iio/chemical/senseair,sunrise.yaml        |  51 +++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   6 +
>  drivers/iio/chemical/Kconfig                  |  10 +
>  drivers/iio/chemical/Makefile                 |   1 +
>  drivers/iio/chemical/sunrise.c                | 310 ++++++++++++++++++
>  6 files changed, 380 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
>  create mode 100644 drivers/iio/chemical/sunrise.c
>
> --
> 2.32.0
>
