Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D108C22A03D
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGVTnc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVTnc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 15:43:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087DC0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:43:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so1503161pls.4
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnl+WGxDXlCYlZvXTHQwvTshqD0cDitqZeDay/qzFiE=;
        b=DPifj3BVcNJYi9lW7eP+sjYXwCCsvmVYNLacg3HmhgPlb2KyxvN3EepYKUkARfOiZk
         Xdtqd9mo5Re2B/OAEzAttnytRCNBvkhTXwKs7tomEFvnDtiYscKs2fNrKdAqnwkOk4Lm
         Jdm6W/klYOH6sh8os3UabOrVbYh9NljQUjPRj09Gof8tEUGS0meGcQ1Z5WDdnBHeQhuD
         6jwDVCDudVp0Qks9B3WS4pnNjopnf3H0XID8RhxNtelgVaDBuryOqsvbePEBpRxkiQW2
         W97Tm/l+G1Mpay/hcaPvhknvvrzj2mnrR7fLVrhjZTJ8u2wQXhPRJUv6LQZTZSYY4ZY8
         WYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnl+WGxDXlCYlZvXTHQwvTshqD0cDitqZeDay/qzFiE=;
        b=kCwA23JWs8R897GvqRfmkI3qDY1cwR40fsJLPc8yb+2eUzXrzjz9IF2A7I9wCTUtdW
         E19nRnOvuSeX1DILzmmDE2peFljO/Xe6iUoQm4XuBDLzZA8khlZzMTOjzZrQBy49FyaZ
         1zNolQ3yLJ0uJuGiRnwAvyeNNDVMBtwABst69HwB90SbBe2RWAXynGJu+bMWUyku3imO
         xMNkXVcDWnjRcHASF7q3VbQ8OMSCGiqbG5+C6LclpQta3yhuWTis4W49uzM+4XI52Ly1
         7E6xeIzAe9Ekzwh2aMLMAUNuGEz8OdIdi9eni0lnPz0tYA1OU3O6bBDTPzFa380Gvlr7
         sKhA==
X-Gm-Message-State: AOAM532t3XfIxF2vST3Et4aZBRhiWzUpTVC8fpEQwJGUUIU1wLPdz0s8
        s5mufzYItmWq4t2rss5tJvIjMSD/3IrnoAxmBlgFoZxa
X-Google-Smtp-Source: ABdhPJx9pi8wootq+GUVJoP+dPfpxZAsuD+ts1gCLe/ROr6iVPhrytGqCF4DQD1uQUlFE8fqFKyeR2mOPMLJ+TmArUw=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr873589pjb.181.1595447011371;
 Wed, 22 Jul 2020 12:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-9-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-9-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 22:43:15 +0300
Message-ID: <CAHp75VdFQYtkA-g2S=Vcvk3Sxp7duTihr3XGfzbUEB5xM4UbTg@mail.gmail.com>
Subject: Re: [PATCH v3 08/27] iio:light:si1145: Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 24 byte array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable array in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak appart from previous readings.
>
> Depending on the enabled channels, the  location of the timestamp
> can be at various aligned offsets through the buffer.  As such we
> any use of a structure to enforce this alignment would incorrectly
> suggest a single location for the timestamp.

...

> +       /* Ensure timestamp will be naturally aligned if present */
> +       u8 buffer[24] __aligned(8);

Why can't we use proper structure here?

> @@ -445,7 +447,6 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
>          *   6*2 bytes channels data + 4 bytes alignment +
>          *   8 bytes timestamp
>          */
> -       u8 buffer[24];

Seems even the old comment shows how it should look like...

-- 
With Best Regards,
Andy Shevchenko
