Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCAD2D8953
	for <lists+linux-iio@lfdr.de>; Sat, 12 Dec 2020 19:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407729AbgLLSiT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 13:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389883AbgLLSiS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2020 13:38:18 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911BC0613CF
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 10:37:38 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n1so6868097pge.8
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2020 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5oCGl0oDs7TGVR5ywE70gM5bExxdvTKJGsKYrP9iAA=;
        b=ZzCFBPni9+B735Md0ixWxxemYvCRqQMclgJlNKeMe0yo4gI86fDDD4S80/ZARkxEJI
         aiBeuPTw94sTNXfUPfJXfiww3Bde/eW69NF4OlAdrW6v23ekOIaxmRgCX7HNfAvPIHpy
         L+MUSURCSsliJfx6WqM4XhB3tKSZPkBrkedqX1Xl2DfvTIjfv6rLq9BgYhaW4El5w39Y
         Z5QxdcljQdN8bKwQUaX492T5i0mwyr6AvU4r0dEeT4hHgGsY/xK2FdTg5qODG8LBQg3h
         f/9xd79xzLor3ShYPAIWyNDohUkc3GIMRW+utrsYtK0769iWOktohpyepELMp+0LIwCZ
         w8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5oCGl0oDs7TGVR5ywE70gM5bExxdvTKJGsKYrP9iAA=;
        b=cf//QqKEFW6tn3gKppAkUXlAdjPXUnKaMxKCgSCfg2Ih/gVUYym5tFNyXDo9g0+we5
         +lBU9YRxy+pGoeDeW2v2mNeZzK6R234rhiAwC/vwnv5VjGPXAHfp4UJFU94gDOGLsgrk
         jLJ6K2UcPySTPL9s7o/AMLnWj0tRz1vCyI1OmFitzNOYiP/ycKUdTLtFo5ZgOCHLDHwj
         Xoax0x3oYbiBqtwfkC/lNT4qKl422sIpfJ6pyHcKD1PODioM2m0rKbeb38ch9XQ3IJQg
         n80j/PWx1txm7+L/mn0f3IDQGy1XzATxbBTutoORozMctPDmBjdU6GV2q4Bd5eoD5drY
         hdJA==
X-Gm-Message-State: AOAM532PsK301WOewaAPKW84JiDb9mGj8fViSqrCFDigJDghivovOrFJ
        EdNJr+8c4WHQ18Mc7U5SYb3wHyyiqtEs3WSbK18=
X-Google-Smtp-Source: ABdhPJwcJzQJ8hjAlUmqveeNeN2NIw2o3hhh9r4neDq8pF3B6ZvZtMoxFKpjw5h4o1MUF6acmNG4U06FGqlu+zDOx+c=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr16786255pfc.7.1607798257967; Sat, 12
 Dec 2020 10:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20201210221541.1180448-1-gwendal@chromium.org> <20201210221541.1180448-3-gwendal@chromium.org>
In-Reply-To: <20201210221541.1180448-3-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Dec 2020 20:37:21 +0200
Message-ID: <CAHp75Ve9Bp7zxG36XvhowSi=KfT5-fxwAhA7e00EupEvDi73vA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: acpi_als: Add trigger support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 11, 2020 at 12:15 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> As some firmware does not notify on illuminance changes, add a
> trigger to be able to query light via software (sysfs-trigger or
> hrtrigger).
>
> BUG=b:172408337
> TEST=Check iio_info reports the sensor as buffer capable:
> iio:device0: acpi-als (buffer capable)
> Check we can get data on demand on volteer:
> echo 1 > iio_sysfs_trigger/add_trigger
> cat trigger2/name > iio\:device0/trigger/current_trigger
> for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
>   echo 1 > $i
> done
> od -x /dev/iio\:device0&

Hard to read. Also I recommend to indent a bit (couple of lead spaces,
for example)

> echo 1 > trigger2/trigger_now

...

> +       /*
> +        * when coming from own trigger via polls, set timestamp here.

Capitalize sentences.

from its own?
a timestamp

> +        * Given ACPI notifier is already in a thread and call function directly,
> +        * there is no need to set the timestamp in the notify function.
> +        */

...

> +       struct device *dev = &device->dev;

This is not related. Please, split the preparatory patch.

-- 
With Best Regards,
Andy Shevchenko
