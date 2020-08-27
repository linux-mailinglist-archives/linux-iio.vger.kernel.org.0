Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47780254138
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgH0Ix6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgH0Ix5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 04:53:57 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A5C061264;
        Thu, 27 Aug 2020 01:53:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so3766650otp.12;
        Thu, 27 Aug 2020 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJqkqfKDzNHfiL/tMPJGSfWZ8ecLoIaK4a3CdN76f08=;
        b=rNirvoBEcyW1jBwdIu+fwpbS49hBLs1+mFh7z2yzTaggVxkQ28bv9uNU8qZRAXpKPt
         zN1oCIRrfarUUbUfKdtOiAIRRxXNZ0KvTIVr+j6KeUsj2V+gBe1OI7vp39yUFNeB71x1
         18yO6MEZ0+FR/mO/Z3r1VQTllsPVysn1DQoK2knEe2IKBgdSxf50ssWjNKfSwQdJhvUx
         RmYwz7YgihE9tdlXP3OulXvrF3pcPTKQxI7SKP9RzLy1SkKIr5rx07eugRW8LfPquP7k
         GLD4MCvEVFBDZK5bertBsAyHV669YvZvNmQiZeRFAHztbZJCNCecI3skBmn59hVfeasr
         GnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJqkqfKDzNHfiL/tMPJGSfWZ8ecLoIaK4a3CdN76f08=;
        b=QzsE7fWVUSMxtQe9cXUwVsknWxzhFSESYU+mmCTC7yxuqPQPJ0DyOIBTViZLXNvo0p
         ZQfOUlY7KkLkAxUrPhOaJau8m9tA9bLE5ewaeS2e3rSJTdywKzpn79qAaJu1utF2dkeh
         ZE61u8XvdepEj7QKQQ2Tr0Tet5RGQZiCkpcLyHRtTJ329GsHdJuQCiC0BI63ixfnwGEm
         ZEvdCfmQ8sV6f8I38ltjIxoJXSv/GiPX7+WhJGM9beRzOcBwXCKuCxAl+pNLfPgb+SDn
         hiLcUWd3lWOCcG/h9ho/7jTLnm9eNHSfks574WDhx7uBaHeV5JZiXZkGu09r7wmQ8Xsr
         /p6g==
X-Gm-Message-State: AOAM531NacZwQi+2kyJZKjx4SCVdH7Utv9rb/2Ltz+7tsJe0zZEoQPCP
        dwMJMo64/gXfzuMvdT1d7pzl/Np7WTFpWlyykC3ToMFZyFdywUpa
X-Google-Smtp-Source: ABdhPJyNg9E+EYqZ3jMKYxrnDs3Fs/guWQT2WPErhXYuDxBwtvuuHvN5YzBTQvexOOWAYySUThg+sI7u84kGPM4z7eE=
X-Received: by 2002:a9d:2ac5:: with SMTP id e63mr12914667otb.119.1598518435737;
 Thu, 27 Aug 2020 01:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826132203.236748-1-alexandru.ardelean@analog.com> <20200827065625.GB17964@kozik-lap>
In-Reply-To: <20200827065625.GB17964@kozik-lap>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 27 Aug 2020 11:53:44 +0300
Message-ID: <CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: exynos_adc: Replace indio_dev->mlock with own
 device lock
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, kgene@kernel.org,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 9:57 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Aug 26, 2020 at 04:22:03PM +0300, Alexandru Ardelean wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >
> > As part of the general cleanup of indio_dev->mlock, this change replaces
> > it with a local lock, to protect potential concurrent access to the
> > completion callback during a conversion.
>
> I don't know the bigger picture (and no links here for general cleanup)
> but I assume it is part of wider work and that mlock is unwanted. In
> such case:
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> If it is part of some bigger work, please put a link to lore.kernel.org
> under separators ---, so everyone can get the context.

Will keep that in mind.
I am not sure if there is a lore.kernel.org link that's easy to find
for a discussion on this topic, maybe I can describe it here and use
the link [from this later].

This was something that popped up during reviews we got from Jonathan
[or others], saying "please don't use indio_dev->mlock, that is an IIO
framework lock, and an IIO driver should not use it".
Reasons include [and some may be repeated a bit]:
- this could cause a deadlock if the IIO framework holds this lock and
an IIO driver also tries to get a hold of this lock
- similar to the previous point, this mlock is taken by
iio_device_claim_direct_mode() and released by
iio_device_release_direct_mode() ; which means that mlock aims to
become more of an IIO framework lock, than a general usage lock;
- this wasn't policed/reviewed intensely in the older driver [a few
years ago], but has become a point in recent reviews;
- if we want to develop/enhance the IIO framework, some elements like
this need to be taken care of, as more drivers get added and more
complexity gets added;
- there is an element of fairness [obviously], where someone writing a
new IIO driver, takes an older one as example, and gets hit on the
review; the person feels they did a good job in mimicking the old
driver; their feeling is correct; the IIO framework should provide
good references and/or cleanup existing drivers;
- same as the previous point, we don't want to keep telling people
writing new IIO drivers [and starting out with IIO] to "not use mlock
[because it was copied from an old driver]"; it's more/needless review
work


>
>
> Best regards,
> Krzysztof
>
> >
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/adc/exynos_adc.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
