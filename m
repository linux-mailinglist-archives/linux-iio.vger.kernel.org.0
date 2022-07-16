Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08057702C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGPQlp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiGPQlp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 12:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A21D0FA
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 09:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8544611AF
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 16:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575C1C34114;
        Sat, 16 Jul 2022 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657989703;
        bh=HHijj0AXwYGbDYV6lmP3/uUD5bPI8Y5YnGon4p/uTLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S8Ol6pzScKwtyoZSptiwf03R12X3/np5RXxgwTKzFASZSaScns7cQUNaDuQ1J1Wzk
         4YEikES4gO9NP3N7SzH2ezrHAkC5REcqFeaxF3pZ2LmrBUphV32llMUWdtcTIk5F5T
         mVgHTwOL1gCGTJqolp42XecqddDfokzFEcb0tCVjHq7tbytiM2nVlYfcL9cfs7VVFU
         ekt1vtsPNtoHj30lEdtkH0E5HFv1/3QRe347xW0KJ7vHOycJStqPl0loLrip5x96tr
         lEgKrolj0T5Mvfe7aTUVsW4ggUrnT4Aej4r3OYFn4iCnqYGl5AvfcEiy16wXtx0k0t
         cTiIfzF9GmpHw==
Date:   Sat, 16 Jul 2022 17:51:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@debian.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH] iio: humidity: dht11: Improve error reporting in
 .probe()
Message-ID: <20220716175136.31600985@jic23-huawei>
In-Reply-To: <2ed20f22-1628-9596-b6a7-fcad250984f1@debian.org>
References: <20220630063528.205327-1-ukleinek@debian.org>
        <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
        <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
        <CAHp75Vf45tDDHYv4fyUsXbQhbseecFE7SAcTQxgozXbBbBZN1A@mail.gmail.com>
        <2ed20f22-1628-9596-b6a7-fcad250984f1@debian.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jun 2022 16:15:05 +0200
Uwe Kleine-K=C3=B6nig <ukleinek@debian.org> wrote:

> On 6/30/22 12:26, Andy Shevchenko wrote:
> > On Thu, Jun 30, 2022 at 12:25 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian=
.org> wrote: =20
> >> On 6/30/22 09:17, Andy Shevchenko wrote: =20
> >>> On Thu, Jun 30, 2022 at 8:58 AM Uwe Kleine-K=C3=B6nig <ukleinek@debia=
n.org> wrote: =20
> >>>>
> >>>> Don't emit a message for -ENOMEM, the kernel is already loud enough =
in
> >>>> this case. Add a message if getting the GPIO or registering the iio
> >>>> device fails and use dev_err_probe for improved behaviour on
> >>>> -EPROBE_DEFER. =20
> >>>
> >>> Why do we need additional messages? =20
> >>
> >> I don't understand the question. Do you really wonder why there is a
> >> benefit of an error message if a resource allocation in probe fails?
> >>
> >> Current state is that for Yves-Alexis (on Cc:) the driver is silent but
> >> unbound. I guess that's because gpiod_get fails, but seeing a
> >> confirmation in the kernel log would be nice.

Giving that example in the patch description makes for a very strong
reasoning.  Mostly I want this captured so that others who might consider
similar patches and see this, understand the reasoning.  Messages for things
that can happen in real life are definitely a good thing!

> >> =20
> >>> They should be split in a separate patch, perhaps, with the explanati=
on.
> >>>
> >>> Actually the rest I would split to two: converting to dev_err_probe()
> >>> in the case where it's not right now, and dropping ENOMEM message. =20
> >>
> >> So we're at three patches:
> >>
> >>    - drop ENOMEM message
> >>    - convert existing messages to dev_err_probe()
> >>    - introduce errors for devm_gpiod_get() and devm_iio_device_registe=
r()

That lines up with how I'd prefer it split. If I'd not wanted the patch des=
cription
additions above anyway I 'might' have just picked it up.  Given we are going
around again, let's set a nice example.  In particularly it will make the
description easier to read as separates -ENOMEM case from the new additions.

Jonathan


> >>
> >> I can rework accordingly, but for me this looks a bit over engineered.=
 =20
> >=20
> > Perhaps, but they three are about different stuff. =20
>=20
> The different things could be named as follows:
>=20
>   - Improve error reporting in .probe() for devm_iio_device_alloc()
>   - Improve error reporting in .probe() for devm_gpiod_get()
>   - Improve error reporting in .probe() for gpiod_to_irq()
>   - Improve error reporting in .probe() for devm_iio_device_register()
>=20
> Even after the discussion I think it's ok to summarize that to a single=20
> patch "Improve error reporting in .probe()". I'd wait for Jonathan's=20
> feedback with his opinion before reworking the patch.



>=20
> Best regards
> Uwe

