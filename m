Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E3579554
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 10:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiGSIhP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 04:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiGSIhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 04:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA5824F17
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 01:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046156177D
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 08:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4F7C341C6;
        Tue, 19 Jul 2022 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219833;
        bh=OfqS65e3vsZsI3lyapWkjKnDF8YB/quv9ORXjIOofXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RbtiR67vsCYZHX3VFEeL5k1ykdv3OEBB/ma/u66OW7C8ctc0dSpGrmPL1tFvnVSJQ
         lawUCLNLMRmFCoNF9Omrz4stZFWUCKVZLduhpefFXghTe/JLZyrcAl/psl0AM+XAc1
         Tc753D0s3GqCcsBXuvUWk6Eg/zzcgC1NTvwg//XZSHhMpB0TGbRE4TM/NnLP4KE7xy
         /H/LQeqckZbHmTrWrv9tXv7ntcRJEshxIYlQ3sf8/uiLt+AZQnSKwmlhJd793FSUsL
         ANFUPFQbsbbEIz8RUD1d84ZHuNy305sg2X/LpsQDWl+HPuFVINqRPSyX2NA+LPRd8L
         UBUQ45xjfdUgA==
Date:   Tue, 19 Jul 2022 09:47:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@debian.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 3/3] iio: humidity: dht11: Use dev_err_probe
 consistently
Message-ID: <20220719094709.78a52856@jic23-huawei>
In-Reply-To: <CAHp75VdC1eW-KQmQ3EXEh70k4XDQ1HoO9m5dEY9=VGKNN2K-oA@mail.gmail.com>
References: <20220718194258.181738-1-ukleinek@debian.org>
        <20220718194258.181738-3-ukleinek@debian.org>
        <CAHp75Vd983XT=03HMAdJmaHTR4YK-=XmZnYd+gF0SY90ywR2ug@mail.gmail.com>
        <CAHp75VdC1eW-KQmQ3EXEh70k4XDQ1HoO9m5dEY9=VGKNN2K-oA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Jul 2022 22:32:17 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jul 18, 2022 at 10:29 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 18, 2022 at 9:51 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.=
org> wrote: =20
>=20
> ...
>=20
> > And to be honest I don't like this desc_to_gpio() usage. It's not for
> > board files, it will bring confusing information to the user. What is
> > important is the name of GPIO, i.o.w. "connection id". =20
>=20
> Yes, I have noticed that this is in the original code, just if you
> want to make it better at the same time. Not sure if Jonathan wants
> all these in the single patch again, however it will touch almost the
> same line in all (three ?).
>=20
So ideal would be separate patches for the different change types, but
meh, that's a pain as you say so given it's just a few lines I'm
fine with whatever combining you want to do.

