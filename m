Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6323115A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgG1SMG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgG1SMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:12:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA0C061794;
        Tue, 28 Jul 2020 11:12:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so12399847pge.12;
        Tue, 28 Jul 2020 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjLgJ2kx9zASOVgXbtMLwC0IMtJSKoc5t3BdK9GAuJo=;
        b=AJzW4k0LNMklpfjGajVomvel9jSSofc/qtP22y2foIkQNOWsu9C7dBsOK+HAGQ/kM1
         K9UyRGpr0XVDlwEoJVrsP2PaF3F+9rVj/YmiVilXx7odzLr/cn9Ki3DZSsj5x7rBRJ4V
         HrAcXz7r9bz3jM4+SEzsMDo2EBeLhdpPRyfcZOHkrnoemEf+eMNpWyvz9PgY2+8NAmy/
         695LykbpcjHNNzEgoWT6mcDPEnjik5cx0GezoXzH8qBrQRA9VFgFJGndeEKIA72SqblX
         vK/m2t7ruYNvpUMoDAFtLalSG/atbDQT6UyUrtXQkFijwhduwhQv2nS67eMnQBjA3qle
         ApKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjLgJ2kx9zASOVgXbtMLwC0IMtJSKoc5t3BdK9GAuJo=;
        b=cutxH45/FNUkBJTPV5jJBE8olcHEWq6dK0R6f41ifutJEs1zHTlc7A4WMnfGlyY/5s
         xTLxnYZ3hfz/bhMHPKtwZ4vkkMDjqUa8BL3XJQ9D8hjJMTAeB50kWCDXKB3JHc/0J9Xd
         F04N4qvpXaax0erqzs2fAyfv9/W6grqCHqBp3fw2iX1SSeWoXMvjJProQS5pNOmlXid8
         H6ljDYOcWQDq8xWdyokcoQHVx4tDv29nwsScGtB4EGxgDlMST2pW8HlwOUVSWyoLLfFq
         zR2uhNtFHaS96L01RCVl6PVme3nZkQA6bV/+rmvpJ4BjxfLZpEF2KVZxuw4SbUwubw0g
         gj8A==
X-Gm-Message-State: AOAM533ZmtQ3j5xK03Jjbzm4dHH/t5UEA9qs1/LbrI7ghLHIgFFxKC6e
        ca+B0hcCN8fw6JJce2h6jrN983NxgvzVGDq1ZaQ=
X-Google-Smtp-Source: ABdhPJyB4lC+0j5ouKy9XkcsTDxBljab2ETqN5PtDotkP5Og0M57wSLtS1cLz8XQBkX/hpCetjA44N3rEjS1Xb3nfqw=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr12355913pfc.130.1595959925726;
 Tue, 28 Jul 2020 11:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.6.I27a5605d9cb3ff643ef040c4ef932a30df9a8fac@changeid>
In-Reply-To: <20200728091057.6.I27a5605d9cb3ff643ef040c4ef932a30df9a8fac@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:11:49 +0300
Message-ID: <CAHp75VfLYqPpO5M6GaHfSBBkQoZpnVTHFKVX5k9Pu_RjMO-whw@mail.gmail.com>
Subject: Re: [PATCH 06/15] iio: sx9310: Align memory
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:15 PM Daniel Campello <campello@chromium.org> wrote:
>
> Use __aligned(8) to ensure that the timestamp is correctly aligned
> when we call push_to_buffers
>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index de52afd7c13333..fb5c16f2aa6b1a 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -131,8 +131,8 @@ struct sx9310_data {
>          */
>         bool prox_stat[SX9310_NUM_CHANNELS];
>         bool trigger_enabled;
> -       __be16 buffer[SX9310_NUM_CHANNELS +
> -                     4]; /* 64-bit data + 64-bit timestamp */
> +       /* 64-bit data + 64-bit timestamp buffer */
> +       __be16 buffer[SX9310_NUM_CHANNELS + 4] __aligned(8);

If the data amount (channels) is always the same, please, use struct approach.
Otherwise put a comment explaining dynamic data.

-- 
With Best Regards,
Andy Shevchenko
