Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4F2D4530
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgLIPQq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLIPQq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:16:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E13C0613D6
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 07:16:05 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so1087061plk.5
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvT2wIiuxsnLXhonSyiaHjeoM7uisT3Aa0IguNeIk1M=;
        b=otI/b43dB7WQIoPJgjPN2CGniOHoicPyRO5P3N9DMkzwlewYjnl3hy/yxNhSQToAUh
         0bRvWKaWsv6pBPqPbirVjBsTnSspv2sJBQF0OjNa6/VaKTfB2KFOys19LMbfbZov/cm0
         hoNndu4dLLcqe05vuzmrv8u3wdR7kajitwN1djm/f6gsHXCuZ9IqvmR8wQsbpXJJNVMy
         Hl7SQb0KYHtqMK6HqkP2J6wd8imVBCW3d3vcffMV6IJ3oD+Ko2gGHrIqM4k760pWkq48
         7CD9Fn7vvgHvz96OnNHufH9bIKnYKu0Y2YxBpRdGQ4cGeOZ2nNvdIZlltenE+MBWWipt
         0HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvT2wIiuxsnLXhonSyiaHjeoM7uisT3Aa0IguNeIk1M=;
        b=QMuBWXvAzIsjW5u8P76jPGZnc1ItPKOyLQ1eJxu5+ocvUEs6KxUdYKvDTaEGal/XwA
         YuxrP7mlh0beIPvaokP6KDMnbr2GZ5GQDItbuG+FamxvJEI2nmr0Ze0TULlGaeMWh2Au
         DBJmx19qe/CtWPCJUEL4TKIkZEvEVkcVevdimm0yuSJl1UMmxTkpTgRc9R9qLHh9IykO
         fDT3sYrEfDX+GOK1v9Kb+T5Pr+cU/eDjTxj2VkvwNH6vpufmIwvOYkLl6pORkerxkufO
         le/8+nHlVmjTngy0jEq7S8GzOCuukicb+TS5X3hawMS79U1MVv+LfWlJQOgkuz1TBG+m
         xX0w==
X-Gm-Message-State: AOAM530SMDlNLZGdduNNkk1bVvlyuLaGFCNe1A0qLyo7M8ChnmbUpi9d
        3CMzXOUvMopfMb/kXIkDFm/WgGpgJOUmWtaW5Og=
X-Google-Smtp-Source: ABdhPJywyP9hR0cWJs1SQ1S7LC7KV9kDklYCQd2JQ2zNpDh7wzKB4qrcFxs6FvGgi8qQJTWboIuMALQ4ye3a7y0CbPg=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr2679455pjf.181.1607526965350;
 Wed, 09 Dec 2020 07:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20201204203755.818932-1-gwendal@chromium.org>
In-Reply-To: <20201204203755.818932-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 17:16:52 +0200
Message-ID: <CAHp75Ve+oXJoYqRFV_FeMrS_Kh9d_3VhVQSgqtn3BxNx9k0ZtQ@mail.gmail.com>
Subject: Re: [PATCH] iio: acpi_als: Add trigger support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 4, 2020 at 10:40 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Add timestamp channel: use standard procedure to collect timestamp.
> As some firmware do not notify on illuminance changes, add a

do -> does

> trigger to periodically query light.

Sounds like two things in one change, you have to split.

> We can either use the device trigger, or a software trigger like sysfs
> or hrtimer.
>
> This change is not backward compatible.

You mean you are breaking ABI? It won't go like this.

> To get samples from bios that

bios -> BIOS

> supports notification, we need to register the hardware trigger first:

-- 
With Best Regards,
Andy Shevchenko
