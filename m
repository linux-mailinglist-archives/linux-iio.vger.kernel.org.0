Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F4447E73
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 12:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbhKHLIh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbhKHLI3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 06:08:29 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26382C061714;
        Mon,  8 Nov 2021 03:05:45 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id p37so29516815uae.8;
        Mon, 08 Nov 2021 03:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=teGM/aRfgsF+v1uRkOKwMF4DSOKKVhKqEf5p4Z5SiaU=;
        b=ZFRoTUThOk+PwhJrD1Eag/Ir8bvPTzXitLWo7Qm9cG6hDuajRaS2ubnIpafa8hqelx
         WL1fNfta5V2hrroNvZl7LbQpF7RKN5VCsa+xO7FSCsfSuNMAainm2YA5tikS3fTjEUPS
         S7nUbti/rK0oZP1HtN/XSxIxymWHxiWgH+ZPUlRC52qAjrfBrS8Syo1prKFyQ6DlVzln
         5LDkWXVj5zr7B1fhibrk9qbyr+E/YxYr9pPfgdbsos4R5YM1hocn1dMvKBm3IZjjBO2b
         Yn8nOBvKre4xDiI1eLzRKslQWYixvbxMRJUOumfHVZk+aCAbdz5QT9hQoQMfG7unHNdL
         DBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=teGM/aRfgsF+v1uRkOKwMF4DSOKKVhKqEf5p4Z5SiaU=;
        b=VYf44b+g8j7e+ZzLqU77Ss/6QSnpvrsaBVhAVibDU2Z2XdEJMVoJdy/ZpN1tzNQLtw
         UpFcLQP3jvDbWO2icV9ufzoKPPeYrkvzN4ECQDFJuM0Im5O6Su0K+bQqfuVrkQ4Ps2tJ
         +TcP0ntwom7+ECHliaE/SOxTa3QlWSH1/mNjlgbV+KyOMZ5jRQVcdabQHUCrU1O7RzO7
         jHwfunHjebyesB25/oa3fWN1F5XTNVcuoqouuQkQj8q19IB0bCBgI0rEmAtzW5TtaVWT
         /Q9CWCY3MU/OFjb2DHNghAetj6a219cb/A2mMIyGLvQHxbPqHw9ALZENOnRTYR5a6IMD
         7LgQ==
X-Gm-Message-State: AOAM532ZZK+5gDqfN3JyzdK1ONH1f5+5RFnUCrSOv5dcT8SFLG48ZL19
        M4r3DYgSGP2AEJNHqUj+031Jd2AJczdJb1afi/s=
X-Google-Smtp-Source: ABdhPJzVAd63faUQ9SQu882FRAjDvxBCJF8XbXAIW/sxogjQqNvAFil9hhvBomoaLzfx7bRe0gBj4+p/TaTuRNYF97E=
X-Received: by 2002:a05:6102:3166:: with SMTP id l6mr16896002vsm.51.1636369544315;
 Mon, 08 Nov 2021 03:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-2-andrea.merello@gmail.com>
 <CAHp75VdPhNbr6Y7ethsmw_Bd7DZOi4cyFHubPpOxa1LXibkUCQ@mail.gmail.com>
In-Reply-To: <CAHp75VdPhNbr6Y7ethsmw_Bd7DZOi4cyFHubPpOxa1LXibkUCQ@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 8 Nov 2021 12:05:33 +0100
Message-ID: <CAN8YU5OAdrivQuLAaQ8FyGbmGSR_Heb2Vz44PHgeQ=rrYuQBLQ@mail.gmail.com>
Subject: Re: [v2 01/10] utils_macro: introduce find_closest_unsorted()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 28 ott 2021 alle ore 12:26 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Thu, Oct 28, 2021 at 1:18 PM Andrea Merello <andrea.merello@gmail.com> wrote:
> >
> > This is similar to find_closest() and find_closest_descending(), but, it
> > doesn't make any assumption about the array being ordered.
>
> Macros in general are not so welcoming.
> Why do you do it as a macro?

Honestly, I did that just because find_closest() and
find_closest_descending() are macros (i.e. to be consistent wrt them).
I see no drawbacks in making this a regular function indeed; just, do
you have any advice about where should it live?

> ...
>
> > +#include <linux/math.h>
>
> Wondering if the current header misses other inclusions it's a direct user of.

Looking at it, it seems that also __find_closest() actually needs
math.h because it (apparently incorrectly[*]) uses
DIV_ROUND_CLOSEST()..

[*]Indeed it seems there is another issue here about find_closest():
for example it picks the 1st element while searching for "2" in an
array like this: {1,2,..} ..This needs to be reported/fixed..



> ...
>
> > +/**
> > + * find_closest_unsorted - locate the closest element in a unsorted array
>
> an
>
> > + * @x: The reference value.
> > + * @a: The array in which to look for the closest element.
> > + * @as: Size of 'a'.
> > + *
> > + * Similar to find_closest() but 'a' has no requirement to being sorted
> > + */
>
> --
> With Best Regards,
> Andy Shevchenko
