Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7131A9A12
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896255AbgDOKKu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896249AbgDOKKp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 06:10:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C3C061A0C
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 03:10:45 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d7so7959214oif.9
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATXlOnGVgtW2lB4qANABFg41JlrWhiWA+2ZrpFtV2PE=;
        b=BrQH8ZGb7X2Pn9lyLecy3NLNj8/CHJ3WJ3iSM7IPhfpuE8L1PjXj39sR0PSbr3J+tw
         V6vfOSM/D/MvPCIEwlfp85oGHaW/lp5FT95sFe+UJK7jTzibSmj3ye8wrau5RwzEnEj3
         /4d9YzeRyWmhuMQD/Q8C9YwFZ9DoNRU0JsMNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATXlOnGVgtW2lB4qANABFg41JlrWhiWA+2ZrpFtV2PE=;
        b=MixDknxhBG8YoG6B46iiY8cSguM09zioo3Qb/YvtWWL41CzWmlcHnI8onZyLzysv3v
         XBAm4T8kpGXt8B6uSIE5ULCklNhVvVeORoXzHzhsUPDAUauLr05WAZP2B7HiSiiJ8iAQ
         YncDpArTGsNJJAnrgZGLjP8XCp26PETegKukFV9neghyF4Dzx/xdVFccfZ/4UBzgYesY
         3khMSMkdvCIIpsA444C+J2E4EgW/LuOX7gI8C7PDw8+kKM40vEhfhQWtJBpKdOPNObOK
         Rw1sFwGO9a+XMt3pkMe2JeG0o8DRpQQag6YLvJASaC2NzHWNYZnhAqB3SOCf7XLpX61p
         qyPw==
X-Gm-Message-State: AGi0PuZQkC/NWn+wBBpSTDIXyvNzqi6Hqs5wjTLJPILIu1JRGmXXNsNx
        aSygM35gHfAiv3dU96yrM6weNGJolUZnD3Q+DgOCDQ==
X-Google-Smtp-Source: APiQypI9MMDrdEz+x7wGoSq3Cjg1UnGQmPrpj3cpbpqzNpHOQtCE5VzAKCMkAxySLm3bq9hHvJoiLisHHZWz7C/237Y=
X-Received: by 2002:aca:fc57:: with SMTP id a84mr10223427oii.37.1586945444653;
 Wed, 15 Apr 2020 03:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200414184237.23018-1-lars@engebretsen.ch> <d11920433cd3c6476c1c0da18846b7d41cd1fde3.camel@analog.com>
In-Reply-To: <d11920433cd3c6476c1c0da18846b7d41cd1fde3.camel@analog.com>
From:   Lars Engebretsen <lars@engebretsen.ch>
Date:   Wed, 15 Apr 2020 12:10:33 +0200
Message-ID: <CA+XPV5O-PeDnfRDiZyDtSe+16PW5Qvmh3+eg1hMWR-+MWsvFoA@mail.gmail.com>
Subject: Re: [PATCH] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks Alexandru! I'm sending the second version of the patch now.

Den ons 15 apr. 2020 kl 07:43 skrev Ardelean, Alexandru
<alexandru.Ardelean@analog.com>:
>
> On Tue, 2020-04-14 at 20:42 +0200, Lars Engebretsen wrote:
>
> A description of the change is required to describe the change.
> I think I mentioned this in my email, but I was lazy to provide an example.
>
> Description of changes are required even for the smallest of changes; I think
> it's mostly so that people always keep their brains trained to describe all
> changes.
>
> So here, you could say something like:
> ---------------------------------------------------------------------------
> This change removes the semi-colon from the devm_iio_device_register() macro
> which seems to have been added by accident via commit 63b19547cc3d9 ("iio: Use
> macro magic to avoid manual assign of driver_module").
> ---------------------------------------------------------------------------
>
> Make sure commit comments stay within a 75 column width limit.
> And make sure you add a version tag for the next patch/re-send.
> i.e. do  git format-patch -v2  [or v3 for 3rd version,]
>
> And it's a good idea to add a changelog after the line with '---' in the patch
> file. Text after that line gets ignored for the commit description.
> Something like:
>
> Changelog v1 -> v2:
> * added commit change description
>
>
> > Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
> > ---
> >  include/linux/iio/iio.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index d63884a54939..76ba7c9fd3e0 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -597,7 +597,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
> >   * 0 on success, negative error number on failure.
> >   */
> >  #define devm_iio_device_register(dev, indio_dev) \
> > -     __devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
> > +     __devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
> >  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> >                              struct module *this_mod);
> >  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
