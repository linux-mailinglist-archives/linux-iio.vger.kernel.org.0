Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF695BBE6C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIROgH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIROgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 10:36:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F920F62
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 07:36:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x94so20487934ede.11
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y9tZ+br6r0d7XxBqm8JDeYyaYm1K/J2dNbvXwEXUpwY=;
        b=M6y3KI3i9CD26LHgTLaNKYeDbR/IuWT56cUD1LA22hjFS6x7/vM73mnQnlNv7rrPDX
         DfKbktRsCq2TxZziBzQCtpIkDTeT3P/uDpr22eYHm8Q3pNQVvbu3v3L1g5a+dzkM5Te0
         IPyG7z1GAPMmdTBa47SuQjq95m83HrrnD5W9+aiOOr1xT7Nk6gkFXARhQ3v5qeBy5hBV
         hlDfxm9U5kqRGb930dHB6oDJY1IYK3/42l9brXFBIGlg9S1fMFWHEy/1jg4sF+cEme/O
         THlPUXizc0LSQDikpkUSmQffFIRVeHrBgopFhs5HjOkCuoOg/g/XhG4iDB7VdFVmcjKZ
         j69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y9tZ+br6r0d7XxBqm8JDeYyaYm1K/J2dNbvXwEXUpwY=;
        b=0fQV37NfNk7qFsC+Q+KKXAVDF8y3NX77vKshg5fqDWauYzy/FoWLAKF7xduluxISQR
         z9sNybqJKgqp9peBjwNdJabqy+/kmdQY/ofauGXbVqfPGwfCCfV53AfQxijS1qar/y5s
         kRT1E6wNSB4aTLsGNv4guorYjs50VeF0ZFNG+V3qf6vC89lTHGMI+rNbRcBf88A969ts
         YR9tRGBMyYe6UcqoQKvvX8mQ229LXwrg6vFqVOY6LiPv715RF/vxzkuCvaVNuu0IVnPD
         zgSIGIN6gCWC8jbzA7et0V2scg2iM7ehVav9DBV63Y8WXK9n5tUUTNlT0LKRxhETN5r5
         DdbA==
X-Gm-Message-State: ACrzQf3SbWDdNxT+EFD1VURPInNLPZElEqxFM0OTZGCxTBvvdKRelym9
        nkrk9hj9WXI+MvZaKJUIPyahO4zj4b+VS0V5ZIc=
X-Google-Smtp-Source: AMsMyM6/UEuPOSep5SvCxWLtxSlc+NWPLXf5KPyLQgOThvXaaRs8b8lKf0k7NYJJGybs4508TRlwXHB6jMncaD/cbCE=
X-Received: by 2002:a05:6402:43cc:b0:451:129e:1b1e with SMTP id
 p12-20020a05640243cc00b00451129e1b1emr11692866edc.258.1663511760056; Sun, 18
 Sep 2022 07:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220917131401.2815486-1-jic23@kernel.org>
In-Reply-To: <20220917131401.2815486-1-jic23@kernel.org>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sun, 18 Sep 2022 20:05:48 +0530
Message-ID: <CAM+2Eu+YCtCMKoWS9yJToEV__YB=enh=54b5thO+q4wGE80wZA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Fix smatch warning based on use of
 unintialized value.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for sending this patch.
If you need a tag for this fix.

Fixes: 961db2da159d ("iio: accel: bma400: Add support for single and
double tap events")

Thank you
Jagath

On Sat, Sep 17, 2022 at 6:44 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Only specific bits in this value are ever used and those are initialized,
> but that is complex to reason about in a checker. Hence, initialize
> the value to zero and avoid the complexity.
>
> Smatch warning:
> drivers/iio/accel/bma400_core.c:1287 bma400_tap_event_en()
> error: uninitialized symbol 'field_value'.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Jagath Jog J <jagathjog1996@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/bma400_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index eceb1f8d338d..ad8fce3e08cd 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1184,7 +1184,8 @@ static int bma400_activity_event_en(struct bma400_data *data,
>                                     enum iio_event_direction dir,
>                                     int state)
>  {
> -       int ret, reg, msk, value, field_value;
> +       int ret, reg, msk, value;
> +       int field_value = 0;
>
>         switch (dir) {
>         case IIO_EV_DIR_RISING:
> --
> 2.37.2
>
