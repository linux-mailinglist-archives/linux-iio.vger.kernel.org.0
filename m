Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61A476A57
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 07:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhLPGZD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 01:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhLPGZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 01:25:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BDDC061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:25:02 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m24so18610928pls.10
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQPjXKQSXu2LvyD7s+gkBn/8M6TFkGGwRB59oSCDPwA=;
        b=G5oLw5rAubJixi65/UXsCMsBN8rX3HNmvIbgteqMG1co0nbQWjYkTyWzrutVrQfxBV
         lwuqdMUvIEsbKZ3ddgkxrJoMqKhYWqg7lfNzG704OxbRqzCVjaYQwQUShbOFuVyTJI2s
         tQEh6rw1uYJBzi4GNJqrpgaLSCvLrO9+JPCfvEnco6OQdlLeKtf1TCHDEQ6hx6ZAw7KM
         MrDhrUeri9RvEDaNq8JOj2e+t8SZ1RszsMYPVLfHGhLb1xP2IK8B8NJV2kIteaAd7+IB
         ltaNqvY1Vg+ByGgdnvSmA5hwCvKXB6MlaiYt12W5bdUhngmZ924V0+c9aEmlRLIdjk5I
         n8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQPjXKQSXu2LvyD7s+gkBn/8M6TFkGGwRB59oSCDPwA=;
        b=lJL4m/dn5iqAikSxVWPo1+IQiUkbA4KOnIiRKYIRImv3fnsfHZ4FsefzV7mWbLUkUh
         7YY5X4F7Vag0i429Xkc3co1BF2S724YHSNOXgbInvU+RF2OHMOOkUDgp+3C988wM5Pi4
         z1uswlVsCjiQoYuSVHPK+3jTP4wRoIKsgtRdE1o6PsbrT0be+8De/w7UJAmlupjauqky
         e8hopjISG8HcLomPqIN/rPjCezmfC4lp1K7fhF14A5icAZfEl8wWvM+RjxdXUDFvoSRl
         tqobNibnosLhU1xBZ563WAix1K2C61/yHKUn5kwprp4KIjUxsW1qFOSX/gAfWUUnkpM2
         ujjQ==
X-Gm-Message-State: AOAM531Xw3g0Z5wtdUBghPmAlL+0wAeOa9HFtZmpbe15i9C4y8Di+Tw1
        Lb1aMx2hju5UiUdTEHgjpRL4LbMQ99nqTvliHD4=
X-Google-Smtp-Source: ABdhPJxmFfzXOJlN+xVoQdiDzOLU5cqqGDM0dNT8Whxb+6ARNmAQDFHB3SVc491Slbtw2cKwco9nx70Rngva8LSlKQ8=
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr4217442pjb.81.1639635902414;
 Wed, 15 Dec 2021 22:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-3-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-3-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 08:24:51 +0200
Message-ID: <CA+U=Dsq_HewmCchxauGe6YKpWaNBAb5rP3xvzNQ6K7n7KpbpvA@mail.gmail.com>
Subject: Re: [PATCH 02/10] iio: core: Enhance the kernel doc of modes and
 currentmodes iio_dev entries
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Let's provide more details about these two variables because their
> understanding may not be straightforward for someone not used to the IIO
> subsystem internal logic. The different modes will soon be also be more
> documented for the same reason.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/iio/iio.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 06433c2c2968..0312da2e83f8 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -487,8 +487,14 @@ struct iio_buffer_setup_ops {
>
>  /**
>   * struct iio_dev - industrial I/O device
> - * @modes:             [DRIVER] operating modes supported by device
> - * @currentmode:       [INTERN] current operating mode
> + * @modes:             [DRIVER] list of operating modes supported by the IIO

I'd argue that it may make sense to highlight that this list of modes
is represented as a bitmask.
When reading docs, it may not be obvious at first (I guess).

> + *                     device, this list should be initialized before
> + *                     registering the IIO device and can be filed up by the
> + *                     IIO core depending on the features advertised by the
> + *                     driver during other steps of the registration
> + * @currentmode:       [INTERN] operating mode currently in use, may be
> + *                     eventually checked by device drivers but should be
> + *                     considered read-only as this is a core internal bit
>   * @dev:               [DRIVER] device structure, should be assigned a parent
>   *                     and owner
>   * @buffer:            [DRIVER] any buffer present
> --
> 2.27.0
>
