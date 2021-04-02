Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8A352EAE
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhDBRqO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhDBRqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 13:46:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E6C0613E6;
        Fri,  2 Apr 2021 10:46:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m11so1378838pfc.11;
        Fri, 02 Apr 2021 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hev9CLh/h74S7Fbo3xndcdWaR2hML7wLaPxLi/omfis=;
        b=ID4Wf7ALZIiPVEmhVFZkbP2aFSYwsk7edMPOKf+WVKbVueJ7ShhGwfQY/m5sGHiD+W
         SVF6N/45Udmsxp6LRuFArvMKtgjPCeN0JxgXH1ak7Z1rxvP7aKAQBqw1O8jwpKIzXk7S
         Sg0kMHnlqDfIlmvN272xPvVKEEvj4VOJX0bgV5tQP/6x3Yazyh/+4hUhEzjqLAO3eTUP
         mThMJXkaG6ZgqLLqtrH+H4KoC2Hf1m0Hv2n/6ISraf/i6KKv0ygMGfaMxACsIrI06y0f
         Z0mUoTAeoA90lm4xqKHXSsgb8sJw1uuzH3LndPhfv29ecjwjCn/qpvKAcFAJW7Fg3vaU
         0YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hev9CLh/h74S7Fbo3xndcdWaR2hML7wLaPxLi/omfis=;
        b=ddy16/vNNLwXIf1pOu+x3p178v+CLcK5hip034bMm47Z3BJIHeIrojjO2QOHlHRMaN
         vnxEqFJuEK0VrMGJ7N4EUwcuKI2MFZTevH3S7QXS8o/kdBe7C98+8Sz+BvEkPqC4LAbN
         dONlmoM5jmplMry3yXdO08bD1qMJ7hpXKj/Qg9VEf1znP9357Q+/9VSdrs2elgrsMkZL
         giEgY+typWiPN3ZF68HJBV9UfdnpVyCXilHPT2PRR0j2bDVsHuLN7rCoINVU0cbkVst2
         xdqLjkuVN5WofRGWNHIGyvTx6IPJY+aKZCSKbugxee432bid2NUGQTyqz8iHyGd/mt9y
         Q3BQ==
X-Gm-Message-State: AOAM531cYi0FmO0VfqCLmxC9OMXq2Aw/F5aC029QAHz43Hf2qWqhyXeC
        mWfi/sEHNAlH5SoiAgZ9s0mUNmcb8lPJ87Wsx+k=
X-Google-Smtp-Source: ABdhPJwsw5JiGiZOCvBiTM3UrNGME8MWrLlebBOuOQFyvmtcGZt+9sqvgUnSV375xATeTO1q9XluJk5ZowfkRq2EtVk=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr13250559pfc.40.1617385571413; Fri, 02
 Apr 2021 10:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210401145457.12255-1-andriy.shevchenko@linux.intel.com>
 <20210402103927.6758416d@jic23-huawei> <CAHp75VfijXvPEqCnJh2RDuhi0Ets_L034LYz-bp1zNuKA-x6AQ@mail.gmail.com>
In-Reply-To: <CAHp75VfijXvPEqCnJh2RDuhi0Ets_L034LYz-bp1zNuKA-x6AQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Apr 2021 20:45:55 +0300
Message-ID: <CAHp75VcriL=Hei-UBJ2TT0ZDBq=n=cqd=z3Svob+LRauhFWhOg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: trigger: Replace explicit casting and wrong
 specifier with proper one
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 2, 2021 at 4:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Friday, April 2, 2021, Jonathan Cameron <jic23@kernel.org> wrote:
>> On Thu,  1 Apr 2021 17:54:56 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>
>> > By unknown reason device name is set with an index casted from int
>> > to unsigned long while at the same time with "%ld" specifier. Both par=
ts
>> > seems wrong to me, thus replace replace explicit casting and wrong spe=
cifier
>> > with proper one, i.e. "%u".
>> I'm not going to pretend to know what planet I was on when I wrote this =
:)
>
>
> Actually =E2=80=9C%d=E2=80=9D is even more correct (aligned with the type=
), but either will work.

I have noticed a typo in the commit message of the other patch.
I'll send a v2 altogether.

>> Series applied to the togreg branch of iio.git and pushed out as testing
>> for the autobuilders to poke at.


--=20
With Best Regards,
Andy Shevchenko
