Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D732FD80
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 22:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCFV34 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 16:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFV3y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 16:29:54 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC7C06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Mar 2021 13:29:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 2so9629472ljr.5
        for <linux-iio@vger.kernel.org>; Sat, 06 Mar 2021 13:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqRjPwSQTP2yhNeDNx97cgEwWURSgS0yiS1hxYEJQwU=;
        b=c613E73yYq8EsIgLruob3OZwW+fD3Aup1oG8IXJqpWC3PjYjanuqGSsLJ4Pf2pcN5k
         CMyzm2q7C0M/UaDcIxT3H5DrKWt6PdsHG8BxPD5BibKY5xCPHoZNuOUPGleOuGvAQx9h
         1GyPV+RuLvMB3ygtZQq776iScniRdTLuYZxxJbMmuaCap8+dV+B7ahHlH0Z1imTfBarT
         0xpLxZKvkFKJJfl7KoJHJkTweIhD/FJz9LaHVr8jvlqGa/681Y1GimQmDRulco9YZ40J
         g/HOxn6Hvkc/ogjGY5AAF45DZsUgZzdm342zAsuRAJDQlBhXhTTGZgry/lULPsv0QuhP
         tZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqRjPwSQTP2yhNeDNx97cgEwWURSgS0yiS1hxYEJQwU=;
        b=J2ttaJwX6hhCFsGzXM8gGl6T6FTVJnR/LGkSEFLJlWo64lC8jy3gQLMEtqJHR5aGO8
         35li0obzzkyjVwZrrHyySgB1P6RAQjfEGM54Fk/HhFRDbYf8HANw862wFUzY8ZTK9Hyq
         KRYrFlIfyumzHwR2a/rhjF7nYrdOx8ipTT25fjiVSjvX/Nh4B1yU8HE2cW8g6ucjJI6O
         X+ZrxW/XuxwLDV3U8L5qQ+jGdspqWd/hbWn9j1YrdkK1O16tt9j+pkWchXIqoa21AcVn
         5ei5+3dJJ8qGEeeSoL2l6Zk5DrA662Wbw+h8T5jJBxgNPYZVnich+Po+uCXr3EfKYAtC
         T88w==
X-Gm-Message-State: AOAM533wnoRpDCez5cPzmZsTstiRKnAR7/QkhS1M0YwNvJNBXk5Y6t7x
        z3Xl+qu3762tukV7RPvab96HwRYfn4Jf3lPuRCuikA==
X-Google-Smtp-Source: ABdhPJzuUAgjVVjNPbLRmLAi6GU+gbjyA6ERjiccGyMgUaQRKs3fG6W2zD6XV53bHbgjJB9ghyj/ZD0G1bYIaINnZAc=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr9699131ljw.74.1615066192504;
 Sat, 06 Mar 2021 13:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20210304154205.1918124-1-linus.walleij@linaro.org>
 <969d00d5ea1e2d575a8464bebef4a8f16285ed98.camel@hadess.net>
 <CACRpkdZcyWPUtJbjYMS=mWZW48ZkKe=arAydJbXK6E8jyQT=hA@mail.gmail.com> <20210306153929.51b053bc@archlinux>
In-Reply-To: <20210306153929.51b053bc@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 Mar 2021 22:29:41 +0100
Message-ID: <CACRpkdaNWyQhdCDOHmRA6yWyeSXfi1WBBUauR73wdVTtFOjfUA@mail.gmail.com>
Subject: Re: [PATCH] iio: event_monitor: Enable events before monitoring
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 6, 2021 at 4:39 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Sadly this doesn't work for many devices.
> It is a common thing for hardware to only support a much smaller
> set of event monitoring registers / threshold detectors than the
> number of channels.  In many cases we handle that by working on
> a fifo basis.  So what this will do is enable a bunch of events
> which will then be replaced by later events - end result some
> random event will be enabled (or maybe 2 of them across N channels)

I understand.

What about augmenting the heuristics like this:

1. Count the available events.
2. If they are just one, then enable that event and disable after use.

This will make all proximity sensors and other things that just
provide a single event work out of the box.

Yours,
Linus Walleij
