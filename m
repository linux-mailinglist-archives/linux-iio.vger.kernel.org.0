Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4141034214A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 16:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCSPxp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCSPxR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 11:53:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B254C06174A;
        Fri, 19 Mar 2021 08:53:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e14so3150439plj.2;
        Fri, 19 Mar 2021 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkRkEyKVJ5bGUH6D89QDCO1/1FFw57umceeQiI1xt00=;
        b=j3SHyAvOQHPxVILB/KLz/3qH/EegkC6L8Bf6BDKEuTk22CAnpKLPy547XUVf8nB4N7
         maTziu99MoO57xpqYpcPgFfnszhcBreFJ0p2T5HunaLxCEzTKyLZYLD1haN3I3uMLGQT
         /BszGvWleNk7PJBt2kDUNThHpVoycpvp2ldWGFRzCJIz3SkBQpq65bWhsfd/egQcGbjL
         AJF6Djoa/2NUCeY4hxTrOftbYLICrQZ/4sMdDL3qoeao1CckjAGXG4/9xz7nd0Q1UAXJ
         2pHy/k5IUfjZ1UqwhV5dU72w/gM6WL0KHAPiOyF37vqmdTrrE0es6f6cx1TtYo9BWXg0
         6b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkRkEyKVJ5bGUH6D89QDCO1/1FFw57umceeQiI1xt00=;
        b=MUP3880/hCTgqwroO+HtJsaGI3HZkvt8Tb6T4+PhKGSXcHr9+fygjp2Km4LZM1a3WF
         RJWCITH2t7AuzwzwduH4WZaRv3vQWeDzzK0aRRyHP3PvIeBBeCfYjj1qS+mAItPrU894
         /t8R7J11ZD9XyBNH+TzDpv/0HZoL07ZHoj4qx05Wjr6sAgKw1moSVcguwwpdLCiax6F4
         9cxJ7I9izWOb4jVOtqM2yjh0tZB/BcHKl03J3f9ZV4IZer056ZCTa/YPUMdT14qNwtyR
         lxY3QywyOcMc9OmiJwqP6xLiY94dA+XPtazZm4BPWRbjGgbbZwB9OUDnZcDRKH7aHPdi
         EcgQ==
X-Gm-Message-State: AOAM531mPZ/qc/y+Cy6iuxiviO8LfWrWS7W4p6oYKM7j+HiuytJbMDbO
        /MwPvzyEUwL+OlEh+pp3yaNsUJmuM1kjcbVrdfCUoWaWOX1JRg==
X-Google-Smtp-Source: ABdhPJxFL0xfAbgHHbS1qg68GzqdBlNYPKHta7NttBmai5yqAHbDiZMrhrLWdbYWJ7+Je06zRHg+PqNte3U7S8pixsI=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr14918369plq.17.1616169197138; Fri, 19
 Mar 2021 08:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210309011715.23245-1-joe.g.sandom@gmail.com>
 <20210313191554.3e8174d3@archlinux> <20210319004223.tqaqpreo32vfnean@pop-os.localdomain>
In-Reply-To: <20210319004223.tqaqpreo32vfnean@pop-os.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 17:53:01 +0200
Message-ID: <CAHp75Vd1LPB6Sc9-QHxyvBqL3JveiA+9EX2BHnULm8pAWX0LcQ@mail.gmail.com>
Subject: Re: [PATCH v5] Added AMS tsl2591 driver implementation
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 2:45 AM Joe Sandom <joe.g.sandom@gmail.com> wrote:
> O Sat, Mar 13, 2021 at 07:15:54PM +0000, Jonathan Cameron wrote:
> > On Tue,  9 Mar 2021 01:17:15 +0000
> > Joe Sandom <joe.g.sandom@gmail.com> wrote:

> Thanks for the feedback Jonathan, glad to hear that we're nearly ready
> to merge :). The changes for V6 are complete now, will give it a couple
> more days before I send it out in case Andy or anyone else has any points to raise

To make Andy look at this don't forget to Cc all reviewers from the
previous series.

I'll look at the v5 at some point, maybe today, maybe not.

-- 
With Best Regards,
Andy Shevchenko
