Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9813445BB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 14:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCVN3Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCVN3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 09:29:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E95C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 06:29:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y200so10934782pfb.5
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JOqBcqeT7G+YS0pOe2a4IclloLfcSxur26S9VswuX0=;
        b=RwK707flKgHso9EXhkbserJfPnZl2shfMibtOP9MxckVbfswDSwZLeE3XBY9WtSOpL
         NamlYdeiwiL70O2lUcsvE2RB8f7AZKBYpJBls3e8olOgmkBFymGk4Mah8H8QbftuJxmZ
         8vHVvDg/7e0/ZfEjVhdesZ9zD41hdr4ce9Flj3FXKTdKYUR7A4PkYr/pxfNLUnTU4BVz
         4IFL3BU3vvQYUDn+GuTnG/9kfdb14IeOaDHXj392Vxnm1O7q5cgFU4ZKsS9D7ExRvIrc
         qsO/VaMm4/1iIUMD3bfTr4lXV1YMNMV7OigZIf55i9M6US/4zH5xoataDoKONFmGGlUo
         VVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JOqBcqeT7G+YS0pOe2a4IclloLfcSxur26S9VswuX0=;
        b=ZOU1VaaL7o0F4McG2qSW6HNJCVyOAcre3Z2rFkCPu2f9tHSNjN/0Tb6MG4EDICpMBu
         n8961bUH3yaQ1l50Y55S7nMIxkA5YgaWAYMmtX0aErNew4ow7BVYTpVu9ysYOXoPN4ZY
         MTLyoTP4Sb4JCSvP1BQoPm6yL7T5DlOxy31dyfAqUFjZBsN/OAdzUfsTl79pWKXNU4DZ
         85hK1R5BQbr6XxRS2LZ8uEaghgs8RDbTZeankpLDLUWsETRk2klD+WO8yPJF/M0XeyQy
         Oj9z5DbCCIxxbj1oC7cQxgFCKE+lag/df/oUyrdn5DD3/kzjTPIbjeQOuLF4hPZ3wQkd
         JLsw==
X-Gm-Message-State: AOAM533ivFV7H2UpAJbSeFqV77wHFy6Ur66Us9/LlrYafWWVVEKlDjhM
        parsZYK/5qpO0iitUlsZy72lE9i4SqXuPsRSmSc=
X-Google-Smtp-Source: ABdhPJxXxXqT6fHsNxFQn3CAcm5qXP0gLb+25qqbKosMQuw2zMtjPxmDPtH9NT8ZlqrhUORfD/L2EEwuySiR8dCrkAE=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr22245102pgq.203.1616419751201;
 Mon, 22 Mar 2021 06:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210322073220.1637117-1-gwendal@chromium.org>
 <20210322073220.1637117-2-gwendal@chromium.org> <CA+U=Dspk-BdZoDNnNdXMMZ+hA=bCzea8v2zxsuCkf5-ecHr7Bg@mail.gmail.com>
In-Reply-To: <CA+U=Dspk-BdZoDNnNdXMMZ+hA=bCzea8v2zxsuCkf5-ecHr7Bg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 15:28:55 +0200
Message-ID: <CAHp75VcULMoQaDh5YEcJjJV2n_zSH236A=465Nki8QxPZ4n0jQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: sx9310: Fix access to variable DT array
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 1:16 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
> On Mon, Mar 22, 2021 at 9:33 AM Gwendal Grignou <gwendal@chromium.org> wrote:

...

> but i think there may be a bug, in the fact that number of elements in
> the array must be 4 (no more, no less)
> that is, when reading the DT, it implies a variable array size of 1 to
> 4, which doesn't seem true in the code;
>
> maybe a better idea would be to use of_property_read_***variable***_u32_array()
> this would allow for a flexible array size;

Wouldn't work in conjunction with the second patch.
The above API is OF specific.

>                count = of_property_read_variable_u32_array(np,
> "semtech,combined-sensors",
>                                            combined, 1,
> ARRAY_SIZE(combined));   // min 1 , max 4 elements
>                // count must be int, so that if it is negative, the
> array doesn't loop;
>                 for (i = 0; i < count; i++) {
>                         if (combined[i] <= SX9310_NUM_CHANNELS)
>                                 comb_mask |= BIT(combined[i]);
>                 }
>

-- 
With Best Regards,
Andy Shevchenko
