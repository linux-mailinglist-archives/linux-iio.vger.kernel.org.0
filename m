Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8DA34CEC6
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhC2LXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhC2LWz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:22:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BFC061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:22:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 11so9647892pfn.9
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dREYXMBbY63bbHkjmsbxakM5IN5DK5joe5mT+GjWy4=;
        b=aOMaPUaN6XX4THjhy0Xq23WGnIQH042SJTq9G7rNXdUbfzDwQD2szp2kSv+EQL54N+
         WIYOn58XNNtlXrPYwHpck3Z+NX9spLHAyrK+loxiPzhlYHAF/5z+OhVpFbsJjeSJkfrj
         r6HqDwZhXACyEI+TVd8gM7NeevdKWwz5+ZiAawwVGW3zsvcDrusz5UMRSLW4HmexAnID
         CH1LlOrDt8ZZ9ffaMmeORB3eks+40zK2VRahPRFe+CF5eBAQoPO8r5STf5RLl4+wk2uX
         BNsfTN656eNQOaPEn8uYIt8ex5bW5SO9SkAHAjyNN/tiVPBybwUZljFpLtrp2/SiKAx+
         jv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dREYXMBbY63bbHkjmsbxakM5IN5DK5joe5mT+GjWy4=;
        b=OaembEeIX91z+EI6NmBj2emxKhgoitmt8ABST4Aqs2vz2i2fwcay1bHtCEDPzltKOm
         pbFifxcJI3mITTWZ8j6tGEoKwXPUvthn7bOWKPbHJosve/BR+5wuzpcljGKlaeAcwTo0
         yFrpsq3GlwLo65lkCB018n0K+fP23L1SNwQFHyT/apvz4gzQ9NE5NQqh25YjS6SMYMjl
         9azutc2qGZyr3UlpdNygMULJ5y+pBcWN6x9nqJLKUHFmrJK88Vn/bBDnU6G19LpndJQO
         j/ty1Y9LUYX+hkhH0f41jbc4a4ZUMFsRbDCSYVHcxySePiHSkVJwNAhqoD4aFE34NFiX
         gtAA==
X-Gm-Message-State: AOAM532zauGm4s6UizZiEwca0jdz+q65xkXwZwefexs6UtgNAKZNPctO
        KvAcJ6Rx/VRWqf6NMMjPOtS8bna+8lXkq6myMHQ=
X-Google-Smtp-Source: ABdhPJx0bT5sbl3ASBRfdNf2k5t7tEJNN/7+nXxqBdR16biHIUj882SRTVb6X9Lzi8JAR7UNyA8Pu2ltAr8fnK/BxHI=
X-Received: by 2002:a63:cb44:: with SMTP id m4mr918744pgi.4.1617016974240;
 Mon, 29 Mar 2021 04:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210320071405.9347-1-lars@metafoo.de> <20210320071405.9347-5-lars@metafoo.de>
 <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
 <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de> <CAHp75VdV0YjL2uBWS5SQsH=PfLkWRu5_bTWbfLFUO+hEc0B2OA@mail.gmail.com>
In-Reply-To: <CAHp75VdV0YjL2uBWS5SQsH=PfLkWRu5_bTWbfLFUO+hEc0B2OA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 14:22:38 +0300
Message-ID: <CAHp75Vd_+_3rMCOvU_mo8XLwn+6LH7qKWa0L3tdh-5_qVtAVEg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to sysfs_emit()
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 29, 2021 at 2:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Mar 20, 2021 at 2:54 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 3/20/21 12:01 PM, Joe Perches wrote:
> > > On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:

...

> > >> -    return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> > >> +    return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> > > rather than cast to bool, perhaps standardize to use !!(val & test)
> > I very much prefer the cast to bool since it semantically stronger.
>
> It's a mistake here. You have no special type for bool and you do
> transition int -> bool -> int.
> Why? !! is a proper way to deal with this.

Just to generalize: casting printf() parameters is a mistake in 99% cases.

-- 
With Best Regards,
Andy Shevchenko
