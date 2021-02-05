Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA56C310588
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhBEHKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 02:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBEHJh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 02:09:37 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD1C0613D6;
        Thu,  4 Feb 2021 23:08:55 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y19so6051342iov.2;
        Thu, 04 Feb 2021 23:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNfJK75qRPvbtvaYdX9EaEkWcTvBmOLP5wSbIrjz3nM=;
        b=KULeYA7DuSaNr2aMaFqJFzEna1Wn1UbedYn7zKZZ4T38u6LzNpwJF2nuGljOfnYmoI
         cpbptTGDVZYXZSclD5CoNkRFGivsydcF6KcgnWw3WeecBtuXBJYs/GMAWSFxgLRgLx36
         P4mXTSRUZrk7cISCTllHFfdqXFhRCAmW5s1msCsUWwMgOagGEOc8ySFcQpYYei9Dd9gH
         jJIa5YoWGE6qQkLoxUo36xBluBDe3qvTxJECOzDFECFW9kdEpAsLmdhvC8ALdcdmi/C5
         IE1+18IsN5GkGGcHL/p53b+uY6qR2iQO40IVEQKoGw0aS9GxfsqVnenTPPT9UNLXOWoO
         fsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNfJK75qRPvbtvaYdX9EaEkWcTvBmOLP5wSbIrjz3nM=;
        b=ksOV7/m+1KNTcgIq9mtJvt2LhmKZ95WwrVF739+dhjqN/6IGDEwHIBpfbQSiMOInME
         JMQJpm4F1jKgw5k84NJ1QSfs0wuBvOn8x4xFkHCEookgcgMrv9I8GLtxfr322tmUh7YA
         m5lQIiTj2X3Y3sMtoaMY29zERlVGJdXpXOIRBL7IEWjos6hGL2nwdDZYzGMepOoZIO+n
         b8G36YWENdKN63ZcDwO97cMMkYRH5zXvvQsjyyWu13Nd7n5Rrv0H+UBqulW7YsjIvAO4
         VAhIuXkyUxj+C1o1drjqpWBAXOpqiOdc0LEyNe1oCQfC6AAWehUWt/njjN32RS0sNOsM
         YD6g==
X-Gm-Message-State: AOAM532LSz00ppdHaADJbRNlEnCQDOlDQRTzVP8sjWgnGOaEJ/KXhmur
        8otyF7iuGMs6C8a1D9fYkowvMM8G2cu6Ft0dgEq2DQ1A
X-Google-Smtp-Source: ABdhPJzzyjYXENhdWm3PDKCDJ+wNwbTGkmob153FKhmIV08pUaSPaTKEMbycP10MvcuVjZRKz35Dpot1BIYk6k34Aro=
X-Received: by 2002:a05:6638:d0b:: with SMTP id q11mr3516916jaj.88.1612508935509;
 Thu, 04 Feb 2021 23:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-2-alexandru.ardelean@analog.com> <20210204170655.00001b03@Huawei.com>
In-Reply-To: <20210204170655.00001b03@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 5 Feb 2021 09:08:44 +0200
Message-ID: <CA+U=DsoDuQOOJm5AM0+CJmj2yB2BeDvpMGMzpzw+66inJjfhzA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] docs: ioctl-number.rst: reserve IIO subsystem
 ioctl() space
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 4, 2021 at 7:13 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Feb 2021 16:50:55 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > Currently, only the 'i' 0x90 ioctl() actually exists and is defined in
> > 'uapi/linux/iio/events.h'.
> >
> > It's the IIO_GET_EVENT_FD_IOCTL, which is used to retrieve and FD for
> > reading events from an IIO device.
> > We will want to add more ioct() numbers, so with this change the 'i'
> > 0x90-0x9F space is reserved for IIO ioctl() calls.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Hi Alex,
>
> Thanks for tidying this up.  My bad from a long time ago to not register
> this at the time.
>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index a4c75a28c839..9ebde26b7e32 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -245,6 +245,7 @@ Code  Seq#    Include File                                           Comments
> >  'i'   00-3F  linux/i2o-dev.h                                         conflict!
> >  'i'   0B-1F  linux/ipmi.h                                            conflict!
> >  'i'   80-8F  linux/i8k.h
> > +'i'   90-9F  `uapi/linux/iio/*.h`                                    IIO
>
> I think the uapi/ bit is effectively implicit. I checked a few of them and the
> definitions are in uapi/linux/

ack

>
> >  'j'   00-3F  linux/joystick.h
> >  'k'   00-0F  linux/spi/spidev.h                                      conflict!
> >  'k'   00-05  video/kyro.h                                            conflict!
>
