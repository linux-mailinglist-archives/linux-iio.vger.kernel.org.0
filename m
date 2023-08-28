Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A4B78B722
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjH1STP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjH1SSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 14:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B53413D;
        Mon, 28 Aug 2023 11:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFB661C77;
        Mon, 28 Aug 2023 18:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC241C433C8;
        Mon, 28 Aug 2023 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693246721;
        bh=h2X0Jfn0FcPh3E5fShkoArhaOpTc6XdwRjgZl6vS/rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X9TCA3SU8KZm3LN4/u5CC9XR+rrv6QWux/1hbqBgyaJZUEW0NJuAzY4tTlUts+kgA
         D/hrlIdm+mBXezq1Qos97JRoH9klskzAAv/nz+CZKOcomED0ka21ve68qGxXyOVwQn
         MD+OH1mqI7Cbc9Xevuk3NLVlLHvC76k1U7CENc1EgXzhi6C2lKwLduQQgKF+HDRSQ/
         PAUzJNiFjh147rAkUcavcQMK1wSws5BgSBoHNNjbETcEPx/ahiEdhxF7WULt43RgS8
         qKbDqJ/2Bk4t0CB4PKpDWWONogIWaPGHzKYEU2OeHpqtaSVDgx3AUvGKxsWeCv1ECj
         Q+v9VDGxjD84w==
Date:   Mon, 28 Aug 2023 19:18:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mighty <bavishimithil@gmail.com>, lars@metafoo.de,
        liambeguin@gmail.com, linux-iio@vger.kernel.org, peda@axentia.se,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Message-ID: <20230828191859.2cced5cb@jic23-huawei>
In-Reply-To: <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
References: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
        <20230824073933.80-1-bavishimithil@gmail.com>
        <CACRpkdYOpz7gDQsM+tgxj7sjKzv8FtehEsjezD8_bpDk-F_b=A@mail.gmail.com>
        <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Aug 2023 10:28:01 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Aug 24, 2023 at 10:24=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
>=20
> > This should definitely be reflected in the scale attribute for the
> > raw channel instead, =20
>=20
> Actually both IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET
> as it looks.
>=20
> I usually use tools/iio/iio_generic_buffer.c to test the result after
> applied scale and offset as it takes those into account.
>=20
> Yours,
> Linus Walleij

Not 100% the follow is relevant as I've lost track of the discussion
but maybe it is useful.

Worth noting there are a few reasons why RAW and PROCESSED can coexist
in drivers and indeed why SCALE can be absent.. (OFFSET is much the same)

1) If SCALE =3D 1.0 the driver is allowed not to provide it - the channel
   might still be raw if OFFSET !=3D 0
2) If the channel has a horrible non linear and none invertable conversion
   to standard units and events support the you might need PROCESSED to
   provide the useful value, but RAW to give you clue what the current value
   is for setting an event (light sensors are usual place we see this).
3) Historical ABI errors.  If we first had RAW and no scale or offset becau=
se
   we had no known values for them.  Then later we discovered that there
   was a non linear transform involved (often when someone found a magic
   calibration code somewhere).  Given the RAW interface might be in use
   and isn't a bug as such, we can't easily remove it.  The new PROCESSED
   interface needs to be there because of the non linear transform..

Odd corner cases...  In this particular case the original code made no
sense but might have allowed for case 3 by accident?

Jonathan

