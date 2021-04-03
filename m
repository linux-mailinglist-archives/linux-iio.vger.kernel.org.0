Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E59353433
	for <lists+linux-iio@lfdr.de>; Sat,  3 Apr 2021 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhDCNwz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Apr 2021 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhDCNwy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Apr 2021 09:52:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30169C0613E6;
        Sat,  3 Apr 2021 06:52:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w10so3665319pgh.5;
        Sat, 03 Apr 2021 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OitHGhp6e8IIJxCkTzKNVArz7Jaba2sg3X3U/T01B+w=;
        b=cRNEbOK0myOFj3SrAfAn60lZ2ka8YUYGHUGGF//tbd48t4aeLzJhZzu8TMCSEmgv4O
         o0tSasCptDsBBjHo5ARWXv9Kg1Aa5pv9Hs1L7rx5XtB0FDXNdcJXbhiG18Ql+WwssoLA
         Pio6P4NE0zYooGNlhPv6gLJwH5Ah0G8HFzZXaAEWHJsxNmhbyS591L0pa3VP/wk0MwUb
         226BUZXwfyPeC8v/OiPnhCfNVcCpFTCpr7G4NeTGW6UQ+m8ooI/XJPaJ8lYWk2EJr5hc
         S7/nUxbkoMra4vPvQyFmeKDUeACVPM6Ygl8By8c78lht/RTespt2bomOP3sbjcJNmfCM
         JS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OitHGhp6e8IIJxCkTzKNVArz7Jaba2sg3X3U/T01B+w=;
        b=jZphhcYYJ3HoIES7Yy2vgt7gVFB4dTFpCRAgYmYMh9Wb800LfRrvm/VI2vWUfvLOzX
         PO7QdRowVQaLfXIOtBwG/IHLC7ndw4dD7y8/QLmS6DJqrG0WAlow4c0+JSqfmMSqjFl3
         Oi/S7VEPC3W/UchI8o//KOqqob9cZp/PGjCOu2LorVMMCpXI1ae8lthz5uN6qsCYYdHB
         pGvezE0Dz9OuRewXP33vsaujKTQE/KVPpbmnE5M9ieJasPnCuXkegs1QYunoZcae1JPJ
         dNWoHmQ2bWx1gXGuJ6AeqVm8G+ydCLQa20ZEmO19k5112adBW61pTKP0jaM/aJf9xJhH
         azGA==
X-Gm-Message-State: AOAM533R8HOBFPaRV4j9GRbil5v+GYcvUjGiMyd9xVitZF3jaiQfkSOO
        8uO8pYY5VmmFnA03Kivu0ypwSekNiryYvJyt7Ic=
X-Google-Smtp-Source: ABdhPJxE8/oeGODnBvCXWPVluy4mySdg0MiV8GEZXX1WTOiNR2yH504FRQ9C2HcDW4gn6yVAabAWMf+TZMcsSyixdkw=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr16531089pff.73.1617457971115; Sat, 03
 Apr 2021 06:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210401091648.87421-1-puranjay12@gmail.com> <20210401091648.87421-3-puranjay12@gmail.com>
 <CAHp75Vcmyvi4V2D0cnmobTGHCS_ci2FC=cBF8tEoG9v51o8RmQ@mail.gmail.com> <0d2bce88-1c23-a711-6a37-118173066ab5@metafoo.de>
In-Reply-To: <0d2bce88-1c23-a711-6a37-118173066ab5@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Apr 2021 16:52:34 +0300
Message-ID: <CAHp75Vfu6B=p7XRx6Ca2tiwVzSgs8YOuyvYJ63cOrYZxDOYdSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: add driver support for ti tmp117
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 2, 2021 at 11:14 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 4/1/21 11:36 AM, Andy Shevchenko wrote:
> > [...]
> >> +       case IIO_CHAN_INFO_SCALE:
> >> +               /* Conversion from 10s of uC to mC
> >> +                * as IIO reports temperature in mC
> >> +                */
> >> +               *val = TMP117_RESOLUTION_10UC / 10000;
> >> +               *val2 = (TMP117_RESOLUTION_10UC % 10000) * 100;
> >> +               return IIO_VAL_INT_PLUS_MICRO;
> > You use 10000 many times, can you give it an appropriate name (via #define)?
> #define TENTHOUSAND 10000 ;)

Actually, besides April fool's day, this can have a value if 1000 is
defined as mC _PER_uC or so.
Oh, wait. We have it already.

#define MILLIDEGREE_PER_DEGREE 1000





--
With Best Regards,
Andy Shevchenko
