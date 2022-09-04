Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C125AC4FA
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 17:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiIDP2I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Sep 2022 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIDP2G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2022 11:28:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDAD2D1DA
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 08:28:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11edd61a9edso16482237fac.5
        for <linux-iio@vger.kernel.org>; Sun, 04 Sep 2022 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hcFXKaVN7xLyFAVBIOuj4texmheiWWevA2tOjfJ8uMo=;
        b=QGzRpVGHHSYMZSChpI6UOWocLebJIhN8z/UccDWkh7prx0Hhb0R1mXK2uvkng9K2Eq
         ARBh3KoCsoL+0KqAsvuM96ozoS8Ab7GqIlKq9eER7PjIQyEEPGywKGfbvkAeab+OUdBy
         4eWl7+ZT4tEkS2xuuOVGMkQ07f3HO2k3x1tNk+Rvu1tx5UFNAunwKm0oAMh3e8YnJrkX
         PRToYK4Un97B1wqCG0m31feN4ABVftPXxsKdrnze+EO4QcOaCj/85eXUcIkY4uNMTNTX
         KD8cvVGLoS7DSza0Zi0x0GbA1T0cf1tLTyJlOgrw9ePPvterJ+oWbUDPEjMQzK5t2FDK
         tH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hcFXKaVN7xLyFAVBIOuj4texmheiWWevA2tOjfJ8uMo=;
        b=hs2aLjd+zqji7h9pAXoRch5v6w0/ZFEec3E+ZzZcZTcuukiCnKEiUfvnUQ9RMmHEIJ
         Z4uZy+7KqHb+mPt2Qqav0omglYJv7ODm8O1/2TuoLmzt36swzdLyC+Ss5WAj4aIhe1yQ
         HghmIqO0o7i+znIL6tdWtGzCSoNRoXt7ilSAzzongrrYBnQpJbB8o/bgyU5bj3a9lQPB
         /MngJje/Ffdi3LvxNIDev71XGx3v82QzLlR1N3s2mOcRNYfxqxxIKhB31rgbLoppJu+F
         2dhVb/NeotQFGZ408k/CEQiKfhj9BcZiwsKWPYRnbU5Z9dEDMdV/ktAJdUTuEAX+Dgd1
         9egQ==
X-Gm-Message-State: ACgBeo1uBew7iT6a/yI7GLjBT3NdFjOylTO84RKlRRafkFL+KDeGZPjm
        ZQLOKj7i+Go5CTdzSfd/miDT7YOaLawSda8tmOVSWw==
X-Google-Smtp-Source: AA6agR47OSA0XlJqPUCLUCCGQ3UKBuX73ZHWcrtQU6ox8Mbji9REVND6L/50TqhkIXfJ8D8/mR/mp8/yQIe+bBWHreY=
X-Received: by 2002:a05:6808:21a6:b0:344:beb5:1fb1 with SMTP id
 be38-20020a05680821a600b00344beb51fb1mr5939271oib.175.1662305284897; Sun, 04
 Sep 2022 08:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220903222422.3426156-1-cmo@melexis.com> <20220904154923.33b79d83@jic23-huawei>
In-Reply-To: <20220904154923.33b79d83@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 4 Sep 2022 17:27:28 +0200
Message-ID: <CAKv63uviUbiAy6tYjkqFP-Qgs7dwAV5BPrr2aTTxQyjPBeA+Og@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: temperature: mlx90632 Change return value of
 sensor measurement channel
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 4 Sept 2022 at 17:23, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  4 Sep 2022 00:24:22 +0200
> cmo@melexis.com wrote:
>
> > From: Crt Mori <cmo@melexis.com>
> >
> > The current EINVAL value is more applicable to embedded library, where
> > user can actually put the fixed value to the sensor. In case of the
> > driver if the value of the channel is invalid it is better in inform
> > userspace that Channel was out of range as that implies more to internal
> > driver error than invalid input. It also makes for easier debugging of
> > where the error comes from during the development.
> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> Hmm. That's an obscure return value - I think it's mostly going to confuse
> anyone who ever gets it.  So not sure this change is wise even though the
> descriptive text for that one does seem very much suited to this usecase.
>
I did get it few times during the development due to read when sensor
is not busy, but the measurement data not yet updated correctly due to
powermode switch. I think I added enough delays all around to avoid
hitting it and with proper power mode switching, but there might be a
case, so it will be easier to spot in the source code in future. I
would not remove it, if that is what you are proposing.

> > ---
> >  drivers/iio/temperature/mlx90632.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index 37edd324d6a1..d511d36942d3 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -435,7 +435,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
> >               *channel_old = 1;
> >               break;
> >       default:
> > -             return -EINVAL;
> > +             return -ECHRNG;
> >       }
> >
> >       return 0;
>
