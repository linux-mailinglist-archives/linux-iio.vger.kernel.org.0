Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFDC78BF0D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjH2HRj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjH2HRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 03:17:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABBE1A2
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 00:17:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7d7df4e67so2908471b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293432; x=1693898232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGc0bOEwCL9dLwtf2Uz6R6tmfq5mkAvVX8svpmXULvU=;
        b=qwOezK1uP0TkJo92kr/f3E4WQnMuOBusRjpGtsvc/NSdMnllJe0QQE+00UoRyg81Zi
         lJtAoYcDjVh0nCBkvKMVQuvHfyaEdgyzsD2Xugel/2XMe86SkaQi7TXjc3djqehY2aK9
         fU18BrnAt+L5CsWyG91439sm4vXw+dCfNcwciBAzBEo8pQS8bGcRPQfjpYiH/10MmzRX
         sr2voif8HZS/5//ZWJhZcrwtyXnghpOxk6U5uSsn0Y8rh2wi2yJBz27mhJPpCQ8lGF3u
         nvNV17wAsDkAuSPfp5858YmPbzLhXGoNMAc2sdagDG9LaRER1ikyeWL17hWvwkysiB0e
         R+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293432; x=1693898232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGc0bOEwCL9dLwtf2Uz6R6tmfq5mkAvVX8svpmXULvU=;
        b=TkIA+3tuCz2cL6mvOWzsPYLw4YX/Tw4gEmgWOMN7IR2quFmjgcrL5eQE9oxvIy5uab
         KNOXbdYTZzT4PyeCwyQk9wI0uHqsJNjwgrQVTdSNvl44Jk6p90mE6c7dVjjvovv06ZUQ
         Yj4Okwj6b7t1eFrlnKTHF0BVHybUT5TqtbxZUxtLRPoQtcIPCI1yPaM3Fj+91zuXdsB5
         6+4gi+gKC0YoFBmeIme0z4GYOS7vJubjVMbc2zA3Dz4ppLylSvCqSl3rWS/N/0IJOpsR
         7yR5KcNN7F/hlJ3o1ojecZ30R+n8d0mYh1PsJ3kYtFxU+AVt2e//SUtYuxpIOwFBeC7A
         nDbg==
X-Gm-Message-State: AOJu0YxjJVEMJIpDRVEvtTuK4+9w6ReoofrzHlYC/HGepYJ9d2ddxauH
        nHyIU9sW2DaJpjkjk1PycyQJfz8+haelPBnn4ArbLQ==
X-Google-Smtp-Source: AGHT+IFG2k0Cz4dK+rpKFyu3h3Fn1+ao4KFkvlrORYOUos5Ij37+T9H3uOQaX0CvJcOWnL9RK37UdfeC4iFtBKhJoUE=
X-Received: by 2002:a05:6358:430e:b0:133:b42:69ca with SMTP id
 r14-20020a056358430e00b001330b4269camr30521623rwc.18.1693293432549; Tue, 29
 Aug 2023 00:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
 <20230824073933.80-1-bavishimithil@gmail.com> <CACRpkdYOpz7gDQsM+tgxj7sjKzv8FtehEsjezD8_bpDk-F_b=A@mail.gmail.com>
 <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com> <20230828191859.2cced5cb@jic23-huawei>
In-Reply-To: <20230828191859.2cced5cb@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Aug 2023 09:17:00 +0200
Message-ID: <CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mighty <bavishimithil@gmail.com>, lars@metafoo.de,
        liambeguin@gmail.com, linux-iio@vger.kernel.org, peda@axentia.se,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 28, 2023 at 8:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> Not 100% the follow is relevant as I've lost track of the discussion
> but maybe it is useful.
>
> Worth noting there are a few reasons why RAW and PROCESSED can coexist
> in drivers and indeed why SCALE can be absent.. (OFFSET is much the same)

That's fine. If we have PROCESSED the rescaler will use that first.

What we're discussing are channels that have just RAW
and no PROCESSED, nor SCALE or OFFSET yet are connected to
a rescaler.

> 1) If SCALE =3D 1.0 the driver is allowed not to provide it - the channel
>    might still be raw if OFFSET !=3D 0

I'm not so sure the rescaler can handle that though. Just no-one
ran into it yet...

> 2) If the channel has a horrible non linear and none invertable conversio=
n
>    to standard units and events support the you might need PROCESSED to
>    provide the useful value, but RAW to give you clue what the current va=
lue
>    is for setting an event (light sensors are usual place we see this).
>
> 3) Historical ABI errors.  If we first had RAW and no scale or offset bec=
ause
>    we had no known values for them.  Then later we discovered that there
>    was a non linear transform involved (often when someone found a magic
>    calibration code somewhere).  Given the RAW interface might be in use
>    and isn't a bug as such, we can't easily remove it.  The new PROCESSED
>    interface needs to be there because of the non linear transform..
>
> Odd corner cases...  In this particular case the original code made no
> sense but might have allowed for case 3 by accident?

I think it's fine, we make PROCESSED take precedence in all cases
as long as SCALE is not there as well.

rescale_configure_channel() does this:

        if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
            iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
                dev_info(dev, "using raw+scale source channel\n");
        } else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
                dev_info(dev, "using processed channel\n");
                rescale->chan_processed =3D true;
        } else {
                dev_err(dev, "source channel is not supported\n");
                return -EINVAL;
        }

I think the first line should be

if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE ||
     iio_channel_has_info(schan,IIO_CHAN_INFO_OFFSET)))

right? We just never ran into it.

Yours,
Linus Walleij
