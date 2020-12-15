Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65CA2DB49D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLOTlg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 14:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgLOTl0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 14:41:26 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C7C0617A6
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 11:40:46 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lb18so172197pjb.5
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLencUfCHyyZy3vWcFLWAOq5AiBapLkwshvIBU16G+o=;
        b=kn0CjOWOc7KwJ8FdCxqwJiCvA1x9BMq7zHyOBxsD2LGVkxrfZhYJC8pcT6+ap+7dxR
         joCJrBOQM11bDaCw9JV2FkL+vQ3Qek1Er/aiOCegWsowr4yht5udL6IBkMaZEjmsQqQK
         Tv9pvZieuSl9jFMpG5xgltNioHl0lFu+fURQEsUrxzSCHG9MLsv+ER/JM7PpPg2cLiOH
         /b2D6NCDjuqfy04g6PeOf79HiQYTFIO7Yspvn7wp9kLRytPvNq4ajrNPtPorgzRMOc02
         HCuqo4V4Pc3Qru3V05O4dVHEONdQh2mOS02WwxRcT9NpctzVIySy4NMGH0ghlgoWtnaa
         q7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLencUfCHyyZy3vWcFLWAOq5AiBapLkwshvIBU16G+o=;
        b=qNEx6QdwbCzcIrVLspEU6H0tk281VG+XbcPifnrLtBHkq8y0kxNHESlpZ/CNh9TIJs
         jW2OUV1befsKdOfr4EhJGlypdoAjkw67ZHLWVK9hUs2IQh5pQbIyc4XehZ6FgRBM9WvE
         zPj33buP/PIgb5C0Sse6lP1i3IpWZT89qDaMlFi3UP9bLhGmbFmu3gZJtFusjromimQ5
         ddtZ5eSn8VC0jEispD6Gt1fIX5PXoQ8/iYa9bSrJi2lfXXbxpNZV4lUSP6s50dymhHaZ
         xd0n0A4SIY45GAQ1/xV00jzyD1q46kEHKO7cU49rZzt8dLcFFr3Zj8VhUlLTT/1Dr2t8
         G2ng==
X-Gm-Message-State: AOAM533uIS+lbOV4uu4T/AThF//Mz7OYH/McVM5a5YGbaNMFg4ILogW+
        A3ejVo40IYBT0gQvVD6AyVJCKYtfK93fRW6cNq4=
X-Google-Smtp-Source: ABdhPJzLpIaqmTtoNMpPzvaQgJkjT5EEMlRyICGKIjCsl6UM0xmIhTaPNtdac6XYCq7wSue67Z/12yUWwvgxiWjdaVk=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr425509pjt.228.1608061245966;
 Tue, 15 Dec 2020 11:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20201214220412.13224-1-sis@melexis.com> <20201214220412.13224-2-sis@melexis.com>
In-Reply-To: <20201214220412.13224-2-sis@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Dec 2020 21:41:34 +0200
Message-ID: <CAHp75VfakW9A4i=N-aq3=6+2CMX0CPaR07EWqDVTsNhBz6WCwA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drivers: iio: temperature: Add delay after the
 addressed reset command in mlx90632.c
To:     Slaveyko Slaveykov <sis@melexis.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Crt Mori <cmo@melexis.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 15, 2020 at 12:05 AM Slaveyko Slaveykov <sis@melexis.com> wrote:
>
> After an I2C reset command, the mlx90632 needs some time before
> responding to other I2C commands. Without that delay, there is a chance
> that the I2C command(s) after the reset will not be accepted

accepted -> accepted.

...

> +       /*
> +        * give the mlx90632 some time to reset properly before sending a new I2C command

give -> Give

> +        * if this is not done, the following I2C command(s) will not be accepted

accepted -> accepted.

> +        */
> +       usleep_range(150, 200);

After addressing above you can take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
