Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C91A91A
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfEKSrn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 14:47:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45618 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKSrn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 May 2019 14:47:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so1520660qtc.12;
        Sat, 11 May 2019 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDUH+ECvLR1j+epjg5DNmKksHTWaTEUOaV6JPEZYcdA=;
        b=Xm15bRCctxqDFymgWz01KUJxzlroz8Mgt0yFTwhBRpHNNxOuNxeocQP4+G4Jn8xK0V
         /KzBgYeawBk93f4EpcaGFdCwPOeNGo/9ghk1MGIYn9eJFWBQVXT9HdhajYtLu2OSVfRI
         sv7kRjDprj5Feip9sKJ00dLi7/JbuM2113OrKEllakTg7/7++X+PeFv5cf9kfMmC1I/W
         EXvxhKMdYndKODIqRP09GAeoPW7ultpaellRZRQXjIJdfKBqqtqbOgNih8EI5xxfrvi9
         tvXyhRkQi2a5+g5ot1kSf2D/I7x1TqyEpHdTkZDI+6KehPhkVEAY6h4U4v/r7T4rU6RS
         RSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDUH+ECvLR1j+epjg5DNmKksHTWaTEUOaV6JPEZYcdA=;
        b=fwKabJBeOO4cLK9mS8Y+9edWxzOkX41XMNIMp5IbIHkQ62Vp/3UcMJZRHCT+o29lIE
         tz2oA6adF6vNeYW/wkbRIo6WAOCQEhDCxhwRR/WYHnMhVqtopm8pSEs2eU8+2D8kUhGr
         q0GP8DcWH0hX39oc8H6lMyW6kJ7JaScs75gMu3BUBTgYj1uIlt+vpWV2uIYPKa+oe/78
         Wdtru3HnCh9E5M8Jd4FgowornjIed1Fxm4w8a1hMYQiOteGVIWHieD4jCnqxAZe/LEAp
         /y/zUXjzI7y7J7TKOo6LcU2lxIoP5J+UdwKPVxOvqzcouKXqZagMmEyaDdTeaklVTrN8
         +ihQ==
X-Gm-Message-State: APjAAAU0PP1OkT126Kjb/1rOb19okSLstkx/lB3S2v+rN4VW+KVPVBQE
        teS11Sp7ZFVgYwqbOp/WrSnpfcMe+F54n9gFdD8=
X-Google-Smtp-Source: APXvYqzDhG2cRN30u5fD5CsogZpcT00fmZHCbwX9PMlnx8NRNi9ZX9DcPEBcyA2IDZ23gOYfUb5tsWFFbFDEOf7uzn8=
X-Received: by 2002:ad4:542c:: with SMTP id g12mr15084174qvt.223.1557600462077;
 Sat, 11 May 2019 11:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
 <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
 <20190414124029.1f1f6084@archlinux> <CAEc3jaCnHLA9PV5gLiBvHT5y26mwMGSUxa3YCO=c+FYmcszePQ@mail.gmail.com>
 <d9f2ee79b8690939f36377990fb6d6fb08e9f0bc.camel@hadess.net>
In-Reply-To: <d9f2ee79b8690939f36377990fb6d6fb08e9f0bc.camel@hadess.net>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Sat, 11 May 2019 11:47:30 -0700
Message-ID: <CAEc3jaBTbH=zHogxekRw5i=GtQcRc9O_d68fMwQb-7jdOcvh5w@mail.gmail.com>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input <linux-input@vger.kernel.org>,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 10, 2019 at 1:57 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Sun, 2019-04-14 at 09:26 -0700, Roderick Colenbrander wrote:
> >
> <snip>
> > We at the time were one of the first to expose acceleration and gyro
> > data through /dev/input for DualShock 4 as supported by hid-sony. We
> > report acceleration in 'g' and angular velocity in 'degree / s'. We
> > set the resolution to respectively '1 g' and '1 degree / s'. The range
> > we set to the range of the device e.g. for DS4 -4g to +4g for
> > acceleration. I need to check though what coordinate system we use,
> > but I think it is right handed (gyro counter clockwise relative to
> > acceleration axes).
>
> How do you export the gyro information through the input device?

For each DS4, there are multiple evdev devices for a DS4 for
respectively "gamepad", touchpad and motion sensors. The motion
sensors one, has INPUT_PROP_ACCELEROMETER set. ABS_X/_Y_Z provide
acceleration and ABS_RX/_RY/_RZ provide gyro. When we added this we
also updated the input documentation (event-codes.rst) to allow gyro
to use the rotational axes.

> FWIW, we needed to do extra work in iio-sensor-proxy so that the
> accelerometer in the Sixaxis/DS4 joypads (and uDraw tablet) didn't
> appear as though they were accelerometer for the system:
> https://github.com/hadess/iio-sensor-proxy/commit/401d59e54b3123860180d4401e09df8a1e1bc6c3
>
> > The two other drivers using INPUT_PROC_ACCELEROMETER are hid-wacom and
> > hid-udraw-ps3 Wacom. Both seem to report resolution in 'g'  as well.
>
> I wrote hid-udraw-ps3, and it's reporting accelerometer data through
> input because the rest of the driver is input, and it didn't make much
> sense to use another subsystem for just that small portion of the
> events the device sends out.
>
