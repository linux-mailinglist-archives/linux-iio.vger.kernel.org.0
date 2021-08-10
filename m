Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F3E3E59A2
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 14:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbhHJMHj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbhHJMHi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 08:07:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB7C0613D3;
        Tue, 10 Aug 2021 05:07:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b7so893124plh.7;
        Tue, 10 Aug 2021 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0RKRD6fr2UNDn7sajsm3RKAKeUrFbZHlIHwSi9SBx4=;
        b=OMXMZnlj/gmJQz3eVxlqdJeX/11ldBtNMyq3zZN8Lq5SAArpcUGW6C7VTF41Fy64Jd
         5ZJATUAHV6ziTC2lqPAn4e/z8tfki9SjlNRs9fPp3b76fGcMe6KyAXc8DURb1lYzcK+F
         IXGv8pNrxFdie2ueeVVHXYWhvaCJkTBGx0sBtS3HIu8zoT46cIyMb6HSSTqnQCMXjEjS
         YiZUl1MoVIxzU8UCBG7Q9KBpiRAPq+y8obALrcCmbhLulzqZ2AtKlQQ3OH+wKKbi9lJA
         ntj19duqW5Ey3WwZGm3jsmQsIc3whTMI5tuCLcdIawWSDoONzurnlNZi5aN5+WaeVeQB
         fURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0RKRD6fr2UNDn7sajsm3RKAKeUrFbZHlIHwSi9SBx4=;
        b=DSNfvyjU92tO/LPB8t4Bb9dZMwsFvUavxGc0FstZtYO4WYdm7FoBr0ySvj1Hy7c+z+
         UEmV2yMSFhitzYHxpjHCHKhLTKfOJrxhcehDHIMkFMXPm+9LW7HzDXhxQYJRORFzzaLM
         AIxRPUvGzTTUs8yjIAVKIqiuDQ18Ypq1nhRPAattvEZO3WEb47vbXfigZOzW65j63lx2
         XV8sJGv/WMjaErPwD0I/sifsRLbZIhHpHCO/2CHO7Vtox5/ZbLXvP+yyDV267nRJ1NDt
         APrHhak8EOkWDtw2cp7oua0+kxn6mBqqs6UPA6b0ZYwuP4B3YaN0kz4tJTbdTVEhMbA1
         By5A==
X-Gm-Message-State: AOAM532nU7zMTkxXzyaP07ixT8oxx2dZRQL1HgJFzzQwB/hJiZp3iP7E
        SRBP6eFChWXX2f0SXEoeMulUv2QAAwhHypKWrgs=
X-Google-Smtp-Source: ABdhPJwE5xLGVYfuQJx74bpLW2FbOnC03s9l5bkdA6Xx3yiDnThoFUomivfTyfZTLLdBpRNap09gTD43diWf2TwFISk=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr1180502pga.74.1628597236251;
 Tue, 10 Aug 2021 05:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210807152225.9403-1-len.baker@gmx.com> <20210808172503.5187cd24@jic23-huawei>
 <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
 <20210809102131.000021eb@Huawei.com> <20210809161422.GA2619@titan>
In-Reply-To: <20210809161422.GA2619@titan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 15:06:39 +0300
Message-ID: <CAHp75VfyJ1zSmgenn3V-2tF-X9uZJ1tByyJfJOydXZSV1as3GA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of strscpy()
To:     Len Baker <len.baker@gmx.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 9, 2021 at 7:14 PM Len Baker <len.baker@gmx.com> wrote:
> On Mon, Aug 09, 2021 at 10:21:31AM +0100, Jonathan Cameron wrote:
> > On Sun, 8 Aug 2021 22:00:34 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Aug 8, 2021 at 7:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > On Sat,  7 Aug 2021 17:22:25 +0200
> > > > Len Baker <len.baker@gmx.com> wrote:

...

> > > Isn't it too early? Or am I missing something (see below)?

> > > > >                       /* use length + 2 for adding minus sign if needed */
> > > > > -                     str = devm_kzalloc(regmap_get_device(st->map),
> > > > > -                                        strlen(orient) + 2, GFP_KERNEL);
> > > > > +                     n = strlen(orient) + 2;
> > > > > +                     str = devm_kzalloc(regmap_get_device(st->map), n,
> > > > > +                                        GFP_KERNEL);
> > > > >                       if (str == NULL)
> > > > >                               return -ENOMEM;
> > > > >                       if (strcmp(orient, "0") == 0) {
> > > > > -                             strcpy(str, orient);
> > > > > +                             strscpy(str, orient, n);
> > > > >                       } else if (orient[0] == '-') {
> > > > > -                             strcpy(str, &orient[1]);
> > > > > +                             strscpy(str, &orient[1], n);
> > > > >                       } else {
> > > > >                               str[0] = '-';
> > > > > -                             strcpy(&str[1], orient);
> > > > > +                             strscpy(&str[1], orient, n - 1);

Even if we leave the logic as is, this might be better

if (orient[0] == '-')
   str = devm_kstrdup(dev, orient + 1, GFP_KERNEL);
else if (orient[0] != '0' || orient[1] != '\0')
   str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
else
   str = devm_kstrdup(dev, orient, GFP_KERNEL);
if (!str)
   return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
