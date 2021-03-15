Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8933ACE2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhCOH6d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCOH60 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 03:58:26 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3DC061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:58:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id w11so6612807iol.13
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rN67eZ8bk5E83Dfs+UiMfYIIK6ZAKquXUGLxfDOEcc=;
        b=o3ev+Vu0B2ICB+tEnjba/OwRa4IP1TXiQ2chtL5weui+B6A2jBNd9KoXSBGJOYninm
         Hj2GVSnCo64GzC+7Y9517VTodHOP9AQvedLrLZg3KR8mevYDZxJQv0P5xeqJW4U4qkAz
         WCaVn3E2gnteCIt73c949814sV6d7hSbR8tlhUp/D41HEMZ9RslztESOy/UV3i+UIuuq
         W+cDLk2IwhhHop/HwqU3ybbDFyUizowIAPg3+Z0dDb/RW3go4J58bLKpVFgobVKUdNpF
         E9cw/m3/rhnKXkZ2pfjMKNaC2UEZSwK4xQA1fjiMjzjll+CKXrDnlANdt9fYQ+Bc2r0t
         +v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rN67eZ8bk5E83Dfs+UiMfYIIK6ZAKquXUGLxfDOEcc=;
        b=nGUnI3/hnBvGhRbrhUio8+1/dw5Xw2BtuwhSpGT/YLPmocujMYRZKwdeVllXKDquuu
         CaPf2FtCrbvxkRBAxhMDPMNf0OJjDaJLVuEsaSUf9P3gyO0VKNeIO0vN2Lf9vr/5EDII
         cZD6vWrG5sr6mwXkc6m1fz/EgZYcfjyug6yFFSRGLRi3XzHkRTbQVxq1U1H3gJCBf/qM
         4Yx6atolq/CZ4vdiewSMWl9muI6w97JTIYbnytl/SfvZASzEA+99znjxdX/6Z7V56y/Y
         hh8VyQlIHEhj56KylG4PyiZiYIpV5UWZij8v85tOKXhfAc6b9Ub7b90jFUhY4qSTAYXY
         J1Gw==
X-Gm-Message-State: AOAM5329AL70K/4py8spCePCz5GhZzyDCxE+pRkpGBKzAnoWPhiU/nLI
        zDSY0DOaexIBTjKoGlT/XSfZs2dzCnGXGjXOqAw=
X-Google-Smtp-Source: ABdhPJzKpMYBxnrXo+O2AeOolhB+1jls4Bt0mC3wjs6t78fYSsjePqjgDPL4pMTPf8fqq2+mBkNbBTugdYWhGEjZmj0=
X-Received: by 2002:a02:cd33:: with SMTP id h19mr8305368jaq.88.1615795105927;
 Mon, 15 Mar 2021 00:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210314164655.408461-1-jic23@kernel.org> <20210314164655.408461-8-jic23@kernel.org>
In-Reply-To: <20210314164655.408461-8-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Mar 2021 09:58:14 +0200
Message-ID: <CA+U=DsqfDBYvLpt5Ry1W4R827hcfy3Y02o9Rpk8WNp-RsSSX+g@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: accel: sca3000: kernel-doc fixes. Missing - and
 wrong function names.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 6:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> All extremely obvious so nothing to add to patch title.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/sca3000.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 467b5fcb81db..cb753a43533c 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -351,7 +351,7 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
>  }
>
>  /**
> - * sca3000_write_ctrl_reg() write to a lock protect ctrl register
> + * sca3000_write_ctrl_reg() - write to a lock protect ctrl register
>   * @st: Driver specific device instance data.
>   * @sel: selects which registers we wish to write to
>   * @val: the value to be written
> @@ -389,7 +389,7 @@ static int sca3000_write_ctrl_reg(struct sca3000_state *st,
>  }
>
>  /**
> - * sca3000_read_ctrl_reg() read from lock protected control register.
> + * sca3000_read_ctrl_reg() - read from lock protected control register.
>   * @st: Driver specific device instance data.
>   * @ctrl_reg: Which ctrl register do we want to read.
>   *
> @@ -421,7 +421,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
>  }
>
>  /**
> - * sca3000_show_rev() - sysfs interface to read the chip revision number
> + * sca3000_print_rev() - sysfs interface to read the chip revision number
>   * @indio_dev: Device instance specific generic IIO data.
>   * Driver specific device instance data can be obtained via
>   * via iio_priv(indio_dev)
> @@ -902,7 +902,7 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
>  }
>
>  /**
> - * sca3000_write_value() - control of threshold and period
> + * sca3000_write_event_value() - control of threshold and period
>   * @indio_dev: Device instance specific IIO information.
>   * @chan: Description of the channel for which the event is being
>   * configured.
> --
> 2.30.2
>
