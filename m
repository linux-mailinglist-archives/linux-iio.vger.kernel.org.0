Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF8DEDBB
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfJUNhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 09:37:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38181 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfJUNhX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 09:37:23 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so15895792iom.5;
        Mon, 21 Oct 2019 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YtUi7K3waaV8CCBvUHH0JCwm/sq5iQANn0TbVheL5U=;
        b=lqfIWVVF/KccYunqBMQKJWtWfT2Z+bSPEzxCVzgRlYJSe96/BErSlB5jSPyClRqmi1
         wpImdxlN8HDa2arRCe/hi6tsA5VCrB0J2zCPX8t2nq4pmD3m5ucUo26DAU39YrtntCMb
         reDG7jarejYbeGceenbjQqWR+jSSFC0MBq+xvLGIrKbfvciQLpjz7ujdRsB9CiWENfQg
         mFZwKO3UO1FvlNTjUB4z2miojcJ66EfgqfGgCJ2nEgbH33qsVxuZJ8a+uUiynXZiEYEa
         u4jZLpzS1+nHuV351SoOgfCTsJ3M8TuUOLkE0CDWLIwBQuDflVkLQVszOPxof7WTwFS3
         FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YtUi7K3waaV8CCBvUHH0JCwm/sq5iQANn0TbVheL5U=;
        b=K7kinMwJwwU8nZO8FBY0i2wT44Jy2Q7X3hSAwERkYjKEN1+A5ivIRTl4BHEdWmLRjr
         HivAPYAn1qIPXidj/kpJHHkuKY0cAW7tlrONFOsXjRzD4kzhp7qZJojR6dHQAsIWMiln
         5lcdCS7cYUSRR4pak/A/bWcroDW3foqvKo9g7CYYlgkula8tVva3bkBeVm2AixWSj0ge
         1ROqwx4bqj3nyL2/LL1I4U6xLvCSc9MLFCSF4e9JJW6R8g6gR2LmAWAwk8/M9kIGHGVl
         Osehihr5w3Fao5DmaTl/BAfU6WpDxtAi+v4LhI/010me+X+YHHqgU7OwoWj1UA5DIP2v
         B5dw==
X-Gm-Message-State: APjAAAVgyFiinVyiPC2JUgu5mHlOjXBWLfCd3HD2TTg5M7nOxFwXE6P6
        G8MLyYn7rlp3lCZA3Wg2F9zXb4CjKcKU1Y5Hw3Q=
X-Google-Smtp-Source: APXvYqw+jd7rZZbK1vJ/nAoQk5MT+Q5ueuQdrwrc7pBCEHmL3uTsIDYf2Vnugc9uJ0Ov+9crMCMJtM3/Dk+XLf7Yc08=
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr7117107jap.81.1571665041604;
 Mon, 21 Oct 2019 06:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569321085.git.gupt21@gmail.com> <20191005150838.542b0219@archlinux>
In-Reply-To: <20191005150838.542b0219@archlinux>
From:   rishi gupta <gupt21@gmail.com>
Date:   Mon, 21 Oct 2019 19:07:10 +0530
Message-ID: <CALUj-gsKph=5V52=aV+dsgKaELinHGEPBe+E+QGZF+8-CnCPTw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Add driver for veml6030 ambient light sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

My email server returned error so I was confused whether all patches
reached to mailing list intact or not, that is why I resent.
Regards,
Rishi

On Sat, Oct 5, 2019 at 7:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 24 Sep 2019 16:21:55 +0530
> Rishi Gupta <gupt21@gmail.com> wrote:
>
> When doing a RESEND as opposed to a new version, please say
> why.
>
> > The veml6030 is an ambient light sensor from vishay and
> > is a different hardware from an existing hardware for which
> > driver currently exist, therefore this driver submission.
> >
> > * All features; ALS, white channel & power management is
> >   supported.
> >
> > * All configurable parameters are supported through standard
> >   iio sysfs entries. User space can get valid values of any
> >   parameter (xx_available) and then can write to appropriate
> >   sysfs entry.
> >
> > * User space can get ALS & White channel readings through RAW
> >   IIO interface.
> >
> > * IIO events are used to notify application whenever threshold
> >   is crossed. This uses IRQ pin of veml6030.
> >
> > * Some registers in veml6030 are read only. For these registers
> >   read callback returns error to user space.
> >
> > There are 3 patches for this submission:
> > [PATCH 1/3] iio: light: add driver for veml6030 ambient light sensor
> > [PATCH 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
> > [PATCH 3/3] iio: documentation: light: Add veml6030 sysfs documentation
> >
> > Rishi Gupta (3):
> >   iio: light: add driver for veml6030 ambient light sensor
> >   dt-bindings: iio: light: add veml6030 ALS bindings
> >   iio: documentation: light: Add veml6030 sysfs documentation
> >
> >  .../ABI/testing/sysfs-bus-iio-light-veml6030       |  49 ++
> >  .../devicetree/bindings/iio/light/veml6030.yaml    |  62 ++
> >  drivers/iio/light/Kconfig                          |  11 +
> >  drivers/iio/light/Makefile                         |   1 +
> >  drivers/iio/light/veml6030.c                       | 633 +++++++++++++++++++++
> >  5 files changed, 756 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
> >  create mode 100644 drivers/iio/light/veml6030.c
> >
>
