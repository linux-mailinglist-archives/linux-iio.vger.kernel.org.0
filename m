Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF593CCA39
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 20:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGRSOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhGRSOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Jul 2021 14:14:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20EC061762;
        Sun, 18 Jul 2021 11:11:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so22491047ljh.0;
        Sun, 18 Jul 2021 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Kw2GbZFRozo6bg9Vj7A8WPZ5v8TJXdXFNSIIRNCMHGk=;
        b=Qw442GzYC+mVdUFwqCsZxc326z1KHFt2n9mrgwlw82Io3zUymJ/qSFUoCrMtvW28Op
         8zvet63jetbhXFTwjmS5o1uL2W+2RAb6FuE9za/ynHKUkMrjZPTDkVtjAkdVtF2JN4rF
         yAEKY1kyVr2Ov85lylAOexwoCt7m51ZqPPUn2fHSvTb2fyIicpZKRqds/9kIiPRTbBxE
         fc1wkNhjB4sX4lJmVM0oi+EN3dav/vQMM0sgJz775LgzI+oWO2n7MOy82DAwVa6NUnO8
         45nA4oB8LwXoCUte7o+pLK5mZ5/2Jva808McJ3W6umA+CdQa7+b2HypzCNPXxKQuB9UE
         I4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Kw2GbZFRozo6bg9Vj7A8WPZ5v8TJXdXFNSIIRNCMHGk=;
        b=hGGOvz+JPaelrPc4cE1Sy625e7VbJ3bcyMWyh+QaCZtIVzVH48koeeSVrmB8W8bAwM
         Zxy6kR9r9ba4O4dq1A+0euZXI+fPxaBv/+3sz/XdiDCNtNUhl+Y3x723wkDqFo609tIa
         t3e3ZTMSMd4buS1ZM8Ut7SnIYt0UQ8LciEGqGNMNc8Cr8ot9Ovf2CxHeRHDRrUWmlVsU
         pKUzvJPkQD7P3T2OxYujQ4wz73aTvRLRk2t+larIwLD60uiRxRRektUCSwShlQthKAMV
         GS1qzf8iH8tEDmriaWxQay6qCqfcsPsPNVJ+3AfkpWZ1xaF3ZJiogKc4sVAEWAdhLWFa
         Y9aA==
X-Gm-Message-State: AOAM532lq4ISWb7rsH3Ry7jXcJenelTCWp+gfak9dDx+nOgdYecOf/ZR
        fc/2NY2gKLapkAU2Rs+AEvPL9APNV6Xo+xsmeHQ=
X-Google-Smtp-Source: ABdhPJyErEX3wHexeDi6WMRRPD4A+28XMWRCOAqEdTMt2IUqIGHrL0RO35A1BEMboXG3lbsfFMHH7FL3izv/dpyTOx4=
X-Received: by 2002:a2e:5c2:: with SMTP id 185mr19084816ljf.131.1626631862990;
 Sun, 18 Jul 2021 11:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210718175950.34728-1-puranjay12@gmail.com>
In-Reply-To: <20210718175950.34728-1-puranjay12@gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sun, 18 Jul 2021 23:40:51 +0530
Message-ID: <CANk7y0jekEwjo4W+G1n0ipPDonZ40iDb9rRne+8kvM=tWFZ-eg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: temperature: add support for ADXL355
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I wrote 'temperature' instead of 'accel' in the subject, I will change
it in the next version.
I am sorry for this silly mistake.


On Sun, Jul 18, 2021 at 11:30 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.
>
> Puranjay Mohan (2):
>   dt-bindings: iio: accel: Add ADXL355 in trivial-devices
>   iio: accel: Add driver support for ADXL355
>
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  MAINTAINERS                                   |   7 +
>  drivers/iio/accel/Kconfig                     |  29 +
>  drivers/iio/accel/Makefile                    |   3 +
>  drivers/iio/accel/adxl355.h                   |  83 +++
>  drivers/iio/accel/adxl355_core.c              | 544 ++++++++++++++++++
>  drivers/iio/accel/adxl355_i2c.c               |  63 ++
>  drivers/iio/accel/adxl355_spi.c               |  66 +++
>  8 files changed, 797 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl355.h
>  create mode 100644 drivers/iio/accel/adxl355_core.c
>  create mode 100644 drivers/iio/accel/adxl355_i2c.c
>  create mode 100644 drivers/iio/accel/adxl355_spi.c
>
> --
> 2.30.1
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
