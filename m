Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BFE363743
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 21:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhDRTKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRTKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 15:10:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93CC06174A;
        Sun, 18 Apr 2021 12:09:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso343865pjn.0;
        Sun, 18 Apr 2021 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2tYufll/NX6d87pvgl+s9xxBkdd0xug4aHJ/ZVKLa0=;
        b=q4Ct89cbWRxw1j2BaB8janLyLEtrqBHPvpHX0bkKxrQu4QbTYbMESLo4pC9NlDQUbL
         mdTDiVdVrTA9/EEHCoUR9HpCIFspQEZXTA8331JXDQKiuGQWjTj8rbB2OWXVD+2q5+l+
         baGdGW3TBWfsMekERyoVBRvie94mCrYXx5t354jd2+2ftSQ6OFZMP23t7mnKiE72Jq4n
         x0c0B75dCymAFxCLWDwHBlkCCLlQiZI+fHw10xlpWD7Hz9eMJdq2N3eezPTsu5bvLc5C
         rkkI51JECMxGNyXOUeGzeP/waDx7+8sk3SEp/nopERSqXLKg4qDh1plu2v2Z2bwFjlfL
         hfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2tYufll/NX6d87pvgl+s9xxBkdd0xug4aHJ/ZVKLa0=;
        b=mwXPAfdk5XuqY2mZjaP/YxAiNC1O4XrayiPCBNBPA6DTH3cj3rNo82SWAtsI/6eqiI
         Gq2PgnRuGB6spiPB2xxVYbj78qEclmQ8+j7tPQRth2m2vVOa9gjUsgT6E5Q0jl0Z5NWx
         CrJu36IFG8z4NZPpjfKQbbjKHFNYg6vZAgM3k/wYCvHPCUuubWLIz4xZ+nr6AGs5NiLz
         Azozhk1d3Ui15PvlDxsWP9xzsUuxvds9CyVrYjwThbBPFwOlR/Qao6QdaqJXdp70wJE2
         RxzWjddyRAzEreuFcaeVqxXU5XKQpgMRbfpilhd2d7BHNe8B01sgpD5KaNzDraV20olu
         rp2w==
X-Gm-Message-State: AOAM533vskDX3QiEYqfxeaH4uZmeITYYd/oIFPfI3WDgxCmusp6HSSot
        h4h4ZreO4pQEAm0k2aEusBcxxQmv6lMvprwiGkw=
X-Google-Smtp-Source: ABdhPJx9TuThlLPUyP7gKC2hKyMVVZVabcKn8CWJZzF5F5pl08wclqvs0NsmBk8ioIV5CzollKsye7UejcmMsWJiE7I=
X-Received: by 2002:a17:90b:1184:: with SMTP id gk4mr15448275pjb.129.1618772974826;
 Sun, 18 Apr 2021 12:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
 <20210414195454.84183-4-andriy.shevchenko@linux.intel.com> <20210418115403.059f94cd@jic23-huawei>
In-Reply-To: <20210418115403.059f94cd@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Apr 2021 22:09:18 +0300
Message-ID: <CAHp75Ve+_XurtoyOKizocyO0RkFaLvhR3mKp_pSvznmmGrQEXA@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] iio: st_sensors: Call st_sensors_power_enable()
 from bus drivers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 18, 2021 at 1:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 14 Apr 2021 22:54:51 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > In case we would initialize two IIO devices from one physical device,
> > we shouldn't have a clash on regulators. That's why move
> > st_sensors_power_enable() call from core to bus drivers.
>
> Why is this a problem?  The two instances would double up and both get +
> enable + disable the regulators.  However, that shouldn't matter as
> they are reference counted anyway.

> Perhaps an example?  Even in patch 6 I can only see that it is wasteful
> to do it twice, rather than wrong as such.

Yep, now I also understand that I do it twice after this patch. But
lemme check next week this all

P.S. I have real hardware to test on. But my tests I guess are limited
to iio_info or so.

-- 
With Best Regards,
Andy Shevchenko
