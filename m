Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD11640894
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiLBOiB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 09:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiLBOiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 09:38:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF252D1C0
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 06:37:59 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z20so6671101edc.13
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2022 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9b45kXHDUGhUZK34Z2HQuRSOFdEcfNuj4oBnoE+44XY=;
        b=VcbaRmTMSYGTDDeJc9iT4i5jZGnelXtcgWvm1VjPPKnj6A2FBjvE5YsSlOeREewyrm
         cvZ/2k4tuLafuPfw5evham7pIkClHxtp67NW4OD2rbMz3RYbLrRHubjEBUljHJqOOM3a
         rUslkQMMKa8/nA9YzYHbbM7IFMIDLOQLlLxFJle3av4Yk1nqBINpne8SljhZDemBTZwm
         wkVkbL2LoLrOjcDYl9Pe1Y65agz1ewKykglgElTInOU46CjdNbjLWXlUAvFcC314ffFE
         m5tqKwN9HP4lJN8KqFRYJYdTv1bFrbn/3VB1nZyqu14DMnlaKJBPNxXyywoKyhATgpT4
         Ocyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9b45kXHDUGhUZK34Z2HQuRSOFdEcfNuj4oBnoE+44XY=;
        b=0FSx5wkz2t1KMJ6lHupAKqre4BW5z5tG7pUaBHDCYa9TjXPPheq6anYO6G0DbrAPdz
         In159v8axpcbWmKSmHVqWkOFnuNsxFlTSN416liUK2JXfePlgngXc9knao6M3Y6RXRg2
         ZBbGCwhIQfdPqGRkVQbuyUnyFSYirriYY9orSfr+ECwXO/rMVIwv+htR/dNy8XvwHycf
         Iq4CuarfvPNU+XY1FhBmQiOw2SYy63W+oVMopBys66kU9LScWrxwVcoExGQetDqh6nHb
         7I0TuL0FrTlY9a3m20USn1H10ImsWdmFDRF7mXmsve3GURvUZsghU0RfxCBatIiyqI8j
         ekTA==
X-Gm-Message-State: ANoB5pnzrFRcD9rMy8qwsCfp11l7aouUB56u5GMBMUlskziO1bL9xvvu
        vEwYVe+EyYyBBkGwwpv/f2c=
X-Google-Smtp-Source: AA0mqf5eeOr4d78sWsAC7ZoTLktnwGDdV4fu7tbxr1dnlABHgZJg3xk6JmjEJ6SRfyGfbx34LKTxCg==
X-Received: by 2002:a05:6402:4286:b0:458:7489:34ea with SMTP id g6-20020a056402428600b00458748934eamr12834443edc.264.1669991877978;
        Fri, 02 Dec 2022 06:37:57 -0800 (PST)
Received: from p200300f6ef00dd002a61a50eb1e4cc6d.dip0.t-ipconnect.de (p200300f6ef00dd002a61a50eb1e4cc6d.dip0.t-ipconnect.de. [2003:f6:ef00:dd00:2a61:a50e:b1e4:cc6d])
        by smtp.gmail.com with ESMTPSA id h18-20020a170906829200b007c0bcfe6ebbsm1238390ejx.99.2022.12.02.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 06:37:57 -0800 (PST)
Message-ID: <0833ed443220263ce068f5faec33fdef4435226a.camel@gmail.com>
Subject: Re: run-time change of configuration of ad74412
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date:   Fri, 02 Dec 2022 15:39:32 +0100
In-Reply-To: <b9e4c447-6bd0-9450-7410-6fb0b872dd36@prevas.dk>
References: <b9e4c447-6bd0-9450-7410-6fb0b872dd36@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-12-02 at 12:16 +0100, Rasmus Villemoes wrote:
> Hi,
>=20
> My customer wants to be able to change the configuration of the four
> channels of the ad74412 at run-time; their board can be used in
> various
> scenarios, and having to specify the functions in device tree is too
> inflexible.
>=20
> Is there any precedent in other iio drivers for such a configuration
> change, and/or is it feasible to implement this in the ad74413r.c
> driver?
>=20
> I do not need to be able to change it continuously, just once after
> userspace has come up and before anything actually starts making use
> of
> the device, but it is not possible for me to know the correct
> configuration in the bootloader, so having U-Boot patch the dtb is
> not
> an option. A somewhat hacky way would be to build the driver as a
> module, and allow module parameter(s) to overrule whatever is in
> devicetree, but that doesn't really work if there was more than one
> ad74412/ad74413 present, unless one invents and parses some weird
> syntax
> to have certain settings apply to $this-chipselect on $that-bus.
>=20
> Rasmus

Hi Rasmus,

I did not looked too deep into this but from what you described it
sounds like a nasty hack that I'm not sure if it's feasable... Would
devicetree overlays be an option for you? Some userspace daemon could
decide which one to load depending on the usecase?

- Nuno S=C3=A1
