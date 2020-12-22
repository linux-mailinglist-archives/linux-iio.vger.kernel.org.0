Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D222D2E0A3A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 14:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgLVNAy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 08:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgLVNAy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 08:00:54 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23438C0613D3;
        Tue, 22 Dec 2020 05:00:14 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w18so11940719iot.0;
        Tue, 22 Dec 2020 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJyVygM9usbbscAGY5ErpD/5E8JGRMWrDOuSU55v38c=;
        b=mEsUgJpnnDf8lfTbqdSw+tbF4/6uf3qIGMxJIbSYNVQU7eE2AGUdL0/hms56wKhP5Y
         n/6kbkRfxz+9G47gxsl2A0GTMgM+Fm9+KzGpBdjvImmhOi9Di35PhjodY7BtWdSSCQpJ
         UzoA30DBVJppftRz3mIUrbkN+ibHJ5x7PyLk8rt6bINL+00cz9D9iRdVeL92IGsLRbKA
         gPVwSRalT44FTBr4oUWTk/eRgZoEVOUKNaV798Ij7i4PW0dqDwLwRBmBbvTE1QXAWpIQ
         pV7HeXV28uasXmHoCpz18BuMOD4I0Bc/AUZsL1Fx6wNnXwvavHKEUkw2qZlBW98p7uz3
         Poow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJyVygM9usbbscAGY5ErpD/5E8JGRMWrDOuSU55v38c=;
        b=WbzqYcBR9F+NTfQA0VhFFONPCBhGa4rnagdslrJ+4+tErLVzP0y6wy36xO9BxF64dB
         tlM8FiMGTjJX+yKJa53NRtkOGEJZfiVFdzYQY6Fzt1+p0+iRMVPKcbC9CQxQfoiK0teg
         mIZimCoxztZQbrVR3WfRvI3EB54IX3Tt/WtAt6yUccaDHiwZnS8nU7RF9PkwN5/Z9xwT
         kAkyPwDWzNd+Uf+Mqwm+GkFQ+282sDPlzUU9l6rQTs6Z2/SmVSNh1XapNAF24GC0Ob1D
         tqHhgA4ssnohFAf9iVxOitx2PZPo+l+KsCfWxT6SXx135cuj3pyr7u2/AhYYxw9xSKAr
         t0Zw==
X-Gm-Message-State: AOAM532BDF+m1qaOk83Iak8yz+eJCD6C/1F2pLSq6h5rzy4+DDd1awP6
        FPpDYz4gnCbkA6qKOaVg8fGDXDiIWx0bxggkNdaGqCSq9TU=
X-Google-Smtp-Source: ABdhPJwHX4kjEIJFx7o5zVOJayaWTausYX44iZoYMuceCM9RLJ1s7KFyfKc0yQBvL/WBFwcWVw7qNOj+3tMpgsMbhdE=
X-Received: by 2002:a02:3f62:: with SMTP id c34mr19087118jaf.16.1608642013470;
 Tue, 22 Dec 2020 05:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20201222095210.61897-1-alexandru.ardelean@analog.com> <X+HUmERYPLyM+oz5@kroah.com>
In-Reply-To: <X+HUmERYPLyM+oz5@kroah.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 22 Dec 2020 15:00:02 +0200
Message-ID: <CA+U=Dsr3agzr1jMPex7xxyPcyBGdw3tZNOqUQoeMJVkG+WutOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib/string.c: add __sysfs_match_string_with_gaps() helper
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        akpm@linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 22, 2020 at 1:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 22, 2020 at 11:52:09AM +0200, Alexandru Ardelean wrote:
> > The original docstring of the __sysfs_match_string() and match_string()
> > helper, implied that -1 could be used to search through NULL terminated
> > arrays, and positive 'n' can be used to go through arrays that may have
> > NULL elements in the middle of the array.
> >
> > This isn't true. Regardless of the value of 'n', the first NULL element in
> > the array.
>
> I can not parse this last sentence, is it missing something?

oh, my bad;
will fix this and send a new version

>
> thanks,
>
> greg k-h
