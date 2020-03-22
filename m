Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1A18EC98
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 22:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCVVU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 17:20:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVVU0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 17:20:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so6469876pfj.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC/JIV5qsOwhxCouss2cmvEeqs2TDLhQ0mM661bN7ok=;
        b=JreVjbG7GWoEhyATN9gjfqr1fAfKWXoK7BHrNzRhQQs3zEsN1jESPGgXvsPUAya3i6
         AacswSAGm6xzObV7YZWJAuMvpTMmHylZbbscv1FkeNx4V73nNHIgaEvedYyaACtvurCr
         jMwBCKl3ghXFo2rDCgOcSsCi8Gp9Q3IUKE/UO6PDnsA9WI6R3rzETZ+Sfjo4BpIRjPvv
         w4sxwYIoV71C+ocsySxKVY/ZhZffqxJELqaogh2UWud++yRnljMzj8x+6cHiXpIzNmpf
         4+kc46qAF04susDv9ZTPglITqPLlaRqnDmG4kFo/8YnvAlTiwxcWAcC4MLVdRft6Qigz
         N8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC/JIV5qsOwhxCouss2cmvEeqs2TDLhQ0mM661bN7ok=;
        b=Hx7Ro0d3Rxm5tBwWOMvfE6O10A8S41WvLseTXOUKzTHaLdR0nOh1m16p85FJXn5rqW
         IKpvrjHtS/uS2YfKFAXMnP6GGWlFIvryuSrZtVSGmBl7JKBmBioWiUsXhTTJUK/TV/Gb
         Dqcw6ER8jiu75Mj1DPfHoVCgYvc2tLoEZdx8QFBMYNmoXcx9YlboX/NP1HvXZe6BSMQZ
         AdlU8i+mFbzIK0E61mZTqLoJnPRVpNkyzeutO25T73kGL97CtxfYQeNhKsymYj1wxxiM
         7Ti2S5T7AEAwXVSrcvEyIpsSdfJICddETJLjn4LmAx7dVnmkEzjssnmWJ43T+o1LP27T
         9j/A==
X-Gm-Message-State: ANhLgQ01lRVP2EyPIeTnlwZmX6XBPyMHhWLiNeLIPEfvb4Vz9MyxEroj
        B03F28Md3/KckRVY1C/LczDpdNRexUC8bDsA64U=
X-Google-Smtp-Source: ADFU+vvMqD1JFdk69IMTU5ITVy0rQwPkOKE4NmtF0eEp/1gy1dl7vSR8G/ltqrccm7pnYbAbAQ4mRIMnk6x2FhpcQwA=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr20424965pfj.130.1584912024846;
 Sun, 22 Mar 2020 14:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
 <20200317101813.30829-4-andriy.shevchenko@linux.intel.com> <20200322172156.6c6ffb3b@archlinux>
In-Reply-To: <20200322172156.6c6ffb3b@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 23:20:13 +0200
Message-ID: <CAHp75Vc9gFX0C1ae_vs40+RRmQEdPRbkWCDA15OLrBmWuu7cdA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iio: pressure: bmp280: Drop unneeded explicit castings
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 7:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 17 Mar 2020 12:18:12 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > In few places the unnecessary explicit castings are being used.
> > Drop them for good.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> A passing comment inline, but seems sensible to me.

...

> > +     ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);

(left for a context)

...

> > +     __be16 tmp;
> >       int ret;
> > -     __be16 tmp = 0;
>
> I haven't checked it but normally that sort of initialization got added
> because a compiler got 'clever' and decided that it might be used uninitialized.
>
> However, it's a bit odd in this case as there are lots of other calls
> of the same thing that don't bother initializing.  So must not be that...

When it's 3 bytes read (24 bit) it's required to get correct sign from
the value or in general to avoid garbage in one byte.
But here are two bytes to read to the 16 bit variable. No
initialization required.

-- 
With Best Regards,
Andy Shevchenko
