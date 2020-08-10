Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D271E240335
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgHJII4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 04:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgHJIIz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 04:08:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C61C061756;
        Mon, 10 Aug 2020 01:08:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f193so4740799pfa.12;
        Mon, 10 Aug 2020 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5RQ0WwBDdVj5r5k2hkM3cpnmzSwMY7YNRulx0YXxtM=;
        b=pED1iKL08KoHo6CLSIwODFFD6nysIPi+SYm1lyNFMiIALEXsi6pwVNxrKvUlDeMgFb
         jMq3Uxl4WG6k56azcWn/RX1GUnSmfUg8l/VjE1a/jzn1fQU+/cVbCSec69sE0EXlgA7W
         HXXR+yiy+3B1X9WIIQ5i8nSA6sgeU+l3nmvgTkOQ9C87AGn8IiimPT9+o6G1H7PPODHV
         Qs+lnStTZtjSqBGkXQpX7W5RnSEU4dfaxIy7bVy6f643DxND5jkRnA3vgeRw9pScNuHl
         wffhymtJffCRzYqO5i9bTuypzQEszgaync5Gxoge4sOL7D9xcPGvR/jWeRsPQcdVqQqH
         KJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5RQ0WwBDdVj5r5k2hkM3cpnmzSwMY7YNRulx0YXxtM=;
        b=qaMiB7mUBoDQYd1XlAOP0iKQWVaQzVH1VnpFgW4kxHCO/tGuk9OUoyVit/66mmXurl
         4zZiZRrjRshEYvRdzdEQYXNsLybUdjjifwYJZQ1gBT9GPbdH620jbejDaxRDShqin7Cq
         jrGp/DlelZRmUGDCfunDcBfeYdb06G/mKKKrOWpNfrodKyCdRx8dmlbfXxTSnw5v0KeK
         txsIC6j3ckV2GODlN5a/oPUt2w+BhGkQJrFr1jRlhOWhbgniIvU+9rueHQgnYDEkBJDG
         j3LyG4EcAuCK1lZlkBc2vup3D1nDviVgWZN3RRAlb+nI4RBf12KntggqnTuPMn0sxaNB
         lK/A==
X-Gm-Message-State: AOAM533/CkNq6NAtNthhtTQGjG6HB1Y57nSvGw/ugQCBQ/M1twqvsRNq
        we3bxPWUeuyqQBLXJENk3XYDU7FKunu3c8D29xw=
X-Google-Smtp-Source: ABdhPJw7VelfDGME9GV6apg9YyInQ/tDzBB0irEirwAiYjqB7XtHiMJyuygV1lwD4I03Rq94+h8YDRfzrtJcQQyNHMg=
X-Received: by 2002:a62:158e:: with SMTP id 136mr24887514pfv.36.1597046935089;
 Mon, 10 Aug 2020 01:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200809175551.6794-1-trix@redhat.com>
In-Reply-To: <20200809175551.6794-1-trix@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Aug 2020 11:08:39 +0300
Message-ID: <CAHp75Vcomp1mDUm5houAm2j2b2HtxAP8Z78Vfcdmgm_g+bbt7w@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: check st_lsm6dsx_shub_read_output return
To:     trix@redhat.com
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 9, 2020 at 8:56 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this represenative problem
>
> st_lsm6dsx_shub.c:540:8: warning: Assigned value is garbage or undefined
>         *val = (s16)le16_to_cpu(*((__le16 *)data));
>              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> data is set with
>
>         err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
>         if (err < 0)
>                 return err;
>
> The problem with st_lsm6dsx_shub_read() is this statement
>
>         err = st_lsm6dsx_shub_read_output(hw, data,
>                                           len & ST_LS6DSX_READ_OP_MASK);
>
> The err value is never checked.
> So check err.
>


> Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
>
> Signed-off-by: Tom Rix <trix@redhat.com>

You see, the commit message can be divided to three sections

1. Title / very short description
2. Detailed description
3. Tag block

Each of them has some specific rules:
1. One quite short line prefixed by subsystem / driver in the
specified format (usually gathered by reading git log against the
module in question)
2. Should explain why this change is done
3. Should be one tag -- one line, no blank lines in between.

Hope, you will use this in the future.

After addressing that (perhaps Jonathan will do it for you)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index ed83471dc7dd..8c8d8870ca07 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -313,6 +313,8 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
>
>         err = st_lsm6dsx_shub_read_output(hw, data,
>                                           len & ST_LS6DSX_READ_OP_MASK);
> +       if (err < 0)
> +               return err;
>
>         st_lsm6dsx_shub_master_enable(sensor, false);
>
> --
> 2.18.1
>


-- 
With Best Regards,
Andy Shevchenko
