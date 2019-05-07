Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C482816C7E
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEGUo7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 16:44:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33681 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGUo7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 16:44:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so1299337qkc.0;
        Tue, 07 May 2019 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UP2eq+cYSzhGvfAYCpFF2xETR/P1KUhUjm8i1vOg6uU=;
        b=NzuaRLfv+6qA0uy9JdvuLZqOsit+Wew37fdzFRTnnQ+zB/E7YTqs7Jet1FGsPEXP0r
         igACnTaJYPeoTn3mUYb+S9yO3v+GugtMpJNOas7OnmgQHh51kDiWO9y/7DXU5Tuf9IE5
         Rm9CHG3Y1GrShoahCpJojXGUnKLPBi7sPxsHF65oe3TCgqxNz5VQwmD2UOFBcxzVb0Rd
         PITRMPcGXG1hy/F7Gn7Ocgznwcss7C9dZBvYeBqgAFpFoeA8fZ2RUkl2AFYHFnCRYWgi
         kLw6ReX/kbDbuA+SWw+X5XIzAPwRL3U/hli8lCX9/iMvutfNu1JWsVQOfanUwifODEnJ
         KD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UP2eq+cYSzhGvfAYCpFF2xETR/P1KUhUjm8i1vOg6uU=;
        b=KTxQJBmXZhDlfL1NeMdZusp7nr0FHOeqDpOe/8ZGbQhc1Cvb9EGOSM9BLT1IlMd4Sw
         mrcTMFGcpikwfzbhFF/KHwBrC7FdGYJibt1d5QdGjYLzGQbtV/WSWu1k6jpdfXXEWljN
         aaom7mHEeIo5aj4yClCy7LztIcWUtzzufnxnj5C6AdgjmId7sOim09PJn2y7GYwC+Ak4
         CFwMWEa/8DbnJg/2bff/45HqcIhNO0EMHmk9I9Zba7XejLqCM4JZp47D52xk8Tt6lD/v
         Ipvp7L3Gasr84BIi30H1eJiN8Fp42VDln4p7yDKHBtNBCMrzJl+mX46mGsdHC/KMwm7D
         txRQ==
X-Gm-Message-State: APjAAAUxAUI3C4ZuZq8QbDNl+DpLAGbDoOl0VvfhCwrjUyv6Z7yhYdL2
        xchfakCaVgrj5Tb58uljLWw=
X-Google-Smtp-Source: APXvYqxX9ChVaTvY07JZGcAfgSHd8lke+t60DfiWr72RfamOOERMP4NuOxzFVgkP7ZcLGc4dzldB9g==
X-Received: by 2002:a05:620a:1015:: with SMTP id z21mr16865140qkj.229.1557261898488;
        Tue, 07 May 2019 13:44:58 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v141sm8777723qka.35.2019.05.07.13.44.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 13:44:57 -0700 (PDT)
From:   Melissa Wen <melissa.srw@gmail.com>
X-Google-Original-From: Melissa Wen <melissa.srw>
Date:   Tue, 7 May 2019 17:44:56 -0300
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "melissa.srw@gmail.com" <melissa.srw@gmail.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
Message-ID: <20190507204456.wwjjkeuzq44jy7w7@smtp.gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
 <7f7d36348bca1de25bd70350b7c665be6441250f.1556919363.git.melissa.srw@gmail.com>
 <CA+U=Dso6zSLzhhdiZcc+P4-2zcabxnoMd2539HmofTXrtYoKDQ@mail.gmail.com>
 <179d019c34cc69e50f19499a6089ac94740b59f5.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179d019c34cc69e50f19499a6089ac94740b59f5.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/06, Ardelean, Alexandru wrote:
> On Sat, 2019-05-04 at 13:43 +0300, Alexandru Ardelean wrote:
> > [External]
> > 
> > 
> > On Sat, May 4, 2019 at 1:25 AM Melissa Wen <melissa.srw@gmail.com> wrote:
> > > 
> > > Use the bitfield macro FIELD_GET, and GENMASK to do the shift and mask
> > > in
> > > one go. This makes the code more readable than explicit masking
> > > followed
> > > by a shift.
> > > 
> > 
> > This looks neat.
> > I'd have to remember to ack it from my work email.
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > 
> > One minor comment inline, which would be the object of a new patch.
> > 
> > > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > > ---
> > >  drivers/staging/iio/cdc/ad7150.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/iio/cdc/ad7150.c
> > > b/drivers/staging/iio/cdc/ad7150.c
> > > index 24601ba7db88..4ba46fb6ac02 100644
> > > --- a/drivers/staging/iio/cdc/ad7150.c
> > > +++ b/drivers/staging/iio/cdc/ad7150.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright 2010-2011 Analog Devices Inc.
> > >   */
> > > 
> > > +#include <linux/bitfield.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/device.h>
> > >  #include <linux/kernel.h>
> > > @@ -44,6 +45,9 @@
> > >  #define AD7150_SN0_REG                         0x16
> > >  #define AD7150_ID_REG                          0x17
> > > 
> > > +/* AD7150 masks */
> > > +#define AD7150_THRESHTYPE_MSK                  GENMASK(6, 5)
> > > +
> > >  /**
> > >   * struct ad7150_chip_info - instance specific chip data
> > >   * @client: i2c client for this device
> > > @@ -136,7 +140,7 @@ static int ad7150_read_event_config(struct iio_dev
> > > *indio_dev,
> > >         if (ret < 0)
> > >                 return ret;
> > > 
> > > -       threshtype = (ret >> 5) & 0x03;
> > > +       threshtype = FIELD_GET(AD7150_THRESHTYPE_MSK, ret);
> > >         adaptive = !!(ret & 0x80);
> > 
> > Why not also do something similar for the `adaptive` value ?

Hi Alexandru,

Yes, I'm working on it!  However, taking a look at the driver datasheet (Table
13, page 19), there seems to be a little mistake in choosing the variable name
and its meaning,  since when bit(7) is 1 (true) the threshold is fixed, and not
adaptive. For this reason, I removed it from this patchset to mature the
solution. I will send it as a bug fix if I prove it's necessary.
Do you have any advice or feeling about it to share?

P.s.: Sorry for having previously sent an email with HTML.

Melissa

> > 
> > > 
> > >         switch (type) {
> > > --
> > > 2.20.1
> > > 
