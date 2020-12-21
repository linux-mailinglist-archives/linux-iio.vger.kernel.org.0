Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C92DFF1E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLUSA4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 13:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLUSAz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 13:00:55 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BBDC0613D6;
        Mon, 21 Dec 2020 09:59:40 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q205so12052424oig.13;
        Mon, 21 Dec 2020 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ui6zW1fAECFc2gEXxsQFOudLu4o+hfhu76Kgy65HxoY=;
        b=hfnfZnWeAbRa89kvAzfU4bxp+7siuL/T++w7vu3Ku0U3lQZxxT6lBcku6eVoWmxuOI
         3gx4emQJQI0k80u0iv3IeHID3WyGkuxHYuLSwNXyw0cw/lrMk3HK//v1aJqdFRX3C6P1
         4QSCvksLXiG0rWfYUblpDBOKN4no0ySG3dJtFGnT19P0Bd7YqgR2+3q+dufz8uZ4y+gL
         Uwi38udGgqYs3+I0CXPaUZSHhg4WbgPAgkUVLr/VhoMjKywCMwQ5LgB9WY//veND7PYS
         hHCX0Cc0atgkW5s7jDitfIFRBoNIonlyMClkf085d03zv5F7IuIIBdBooonNPMZTdau1
         GZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ui6zW1fAECFc2gEXxsQFOudLu4o+hfhu76Kgy65HxoY=;
        b=Hyj1osNyhr4UHME8thr6/ss2M9LHXmxTEd2wZDHkS+WU45xxEiJTVMrjGiIM4k7v6k
         kFLbKAhy8oZur1HAqZJ9gO5Q4jFOjzK0UK+EmEfKfgOla9qiQziGHK9XTBsHHg0K45yN
         4DI2aHYK0uCuN9MReFEbL4+i0Qvr3/TeUtw4SNIcH9Dy0LkfOSGlK/S7lhBMUicbxQ9Y
         jdHo2wVF79BfT/ZcXYCB+uafcxw5csbCTHxtpkZvt61JscV7geRkpeDkKajse1MAXHjy
         33dZQmHUcTfkZ//F/Eo/v96rOlxIxc6wida36u0DCvtAbGwaHs/chRvSik7JXohkOY8O
         +leQ==
X-Gm-Message-State: AOAM533YXhFUmQKwnE1kmNSnPCxW2PEfJdTJZRpdvVqWVkx0GsxNsacD
        UcUeoKvRKGhLJVyTsWv3jX8HrnJePJzHNVuyDOgU6KWXkYs=
X-Google-Smtp-Source: ABdhPJxT5ASjlLeSdcAjns1ixlfwE9Db42btuJN9lT60t5QwUpywkIS1QWUP00XT8pQBJJKOVI7SGPUuizg32BZrM+I=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr18502363pjb.129.1608572166918;
 Mon, 21 Dec 2020 09:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20201221151551.52511-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201221151551.52511-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Dec 2020 19:36:55 +0200
Message-ID: <CAHp75Ve6GHU50WO3Ygmfz8GU=22jpLi+JeDoA3TiY8bp76T09A@mail.gmail.com>
Subject: Re: [PATCH v4] iio: Handle enumerated properties with gaps
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 21, 2020 at 5:11 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Lars-Peter Clausen <lars@metafoo.de>
>
> Some enums might have gaps or reserved values in the middle of their value
> range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> meaning, but 2 is a reserved value and can not be used.
>
> Add support for such enums to the IIO enum helper functions. A reserved
> values is marked by setting its entry in the items array to NULL rather
> than the normal descriptive string value.

...

> I tried a few shots at working with 'lib/string.c', and that went
> slow. The __sysfs_match_string_with_gaps() approach has stalled.
> https://lore.kernel.org/linux-iio/20190422140251.8960-1-alexandru.ardelean@analog.com/

Hmm... If you are not going to push that forward, perhaps better is to  provide
iio_sysfs_match_string() and if we need it in the future for other
users, it would be easier to find and export. Also it will be a matter
of one line change in the caller.

-- 
With Best Regards,
Andy Shevchenko
