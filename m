Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0830D2576B0
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgHaJjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgHaJj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 05:39:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA65C061573
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 02:39:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x18so1535975pll.6
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhIxCN7C5TTT1RKbnemiv1afYhmV0WLyWoA2e+4E1vk=;
        b=vgUdgwfEaAhNZ0W049EuUbCnfuC4lq/H+izO4LgyL9ntFio4OvJ6F0HGq9fTHjV1Nh
         p77CtHQHmvGV3zwfidtlBiiZOn7zkHPB7bPZd/ofaEmRjYaI3IIzWJf8YwueEhrNERI/
         U4AUY7mJM11JoakImt2p6vFBCCyjpPuLfv4sd1pZ2hAIPwOcAGaVfOPOCSRE0iNP34Xh
         6+kOiTF/Nh0PCFo1hu7P7xVMIdJ3HDHQP5niXjIdc/7df48AmXI3I7p24IcjMHZXdudD
         P3yWaKgeNqSAAQySFhTQb3bJOi+CHbHvCJ9LQgd73SAEIHw18D4xa+OdvN7wPu2lNIWM
         lH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhIxCN7C5TTT1RKbnemiv1afYhmV0WLyWoA2e+4E1vk=;
        b=lYBLCofMcTZPRk3BW+F8yQDUZ5ebT/JzVoJOz9Gjb7fsa5jxEXkQuAxsUE+fPJfl7F
         b/BHo3zgjLwEd4CWGdT8tIwGFlwafIeV/VfhpUYw9T8W0UubkX0CYhFYvr7UBdL3diaw
         HC7C5mHUJZmAr8LfECTGpXggBnR6ZwnzS1c/jHX75uAYOpCWN7zWrWO0ggVxhvQPi/Qv
         2UBp3WNtHEOtq2uAGvQi2btr0ebHwh7tP/QvixmAPiN2YKD31xyvA9htwtyeH2WJVybv
         JLmZsEbT64f1uLm/8afYxB34SzGVTbAwTJ/eA4vpw4uGmGQeOy7syq8XfQql3mOL3rkh
         wiWA==
X-Gm-Message-State: AOAM530CQXX3KYOlAsRWrLtPnx6lMAKCfLTXTdDm2Jywz86AHEmVkeW4
        wxXZZ7NDmfnk8+u0L4CFNm769exjKzWVxWzpr6N4Y9ZM7PfSYg==
X-Google-Smtp-Source: ABdhPJx5OhDZRcEcrkh5SAzZG+XKOZwuYGDoaKyTC2e4FydcGRkirbl+W5iPoosCl1z/Wda/NugMgmeEbyUrmhd+p1U=
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr412702plr.321.1598866767659;
 Mon, 31 Aug 2020 02:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
 <20200831090813.78841-5-andriy.shevchenko@linux.intel.com> <20200831101908.52cb216e@archlinux>
In-Reply-To: <20200831101908.52cb216e@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Aug 2020 12:39:10 +0300
Message-ID: <CAHp75Ve=p2fNWWAJ5SpQNfA0rH9vDg27YZhFh4vJgzXVhHxL8w@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iio: accel: bma220: Drop ACPI_PTR() and
 accompanying ifdeffery
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

On Mon, Aug 31, 2020 at 12:19 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 31 Aug 2020 12:08:10 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > The driver is quite likely used only on ACPI based platforms and
> > rarely build with CONFIG_ACPI=n. Even though, the few dozens of bytes
> > is better than ugly ifdeffery and inclusion of heavy header.
>
> Given this part is readily available on maker type break out boards
> I doubt it is mostly ACPI.  Rest of the comment is fine though.

In-kernel use seems only ACPI (I grepped for pure SPI driver by name
and didn't find anything).
I hope we will have DT support for that as well (basically means
adding OF ID table).

-- 
With Best Regards,
Andy Shevchenko
