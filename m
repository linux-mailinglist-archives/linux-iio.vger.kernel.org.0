Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C83579559
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGSIjK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 04:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiGSIjF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 04:39:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984026578
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 01:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE12DB819F3
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 08:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB10C341C6;
        Tue, 19 Jul 2022 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219941;
        bh=UMvrTTpko9eCF4yWkeOLa7yFHaroP1sHSWIbHvxaCGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a6DGi2nnj61Jz27IjwwhcUKiZ27NlE7SIQW0L8dQ2KWEib21PuPxFwo/Hem7xwwCV
         HN72VOglbqnTK+NEHTic8KfjVMP7ahpXsvzfarv0I8NfLhBlEPiwtRFeD4mQK5cFuI
         4a9uLaRTUJe0zWY4BO4/2n5+j7c4w3zEWGmbxaqT01JwRpWEzfaEtXVlmWQN7nJ2wO
         vOeahHAqALa2Q/scfocWUx5DWKUIl2K4ESKgBgznUTW2zmJbOmhwZGcDD6C8Ux3POh
         yLY00Sfo8EJTsMd+R+eE9ktBYboLa0KlDdKH14S0EAQMeuGsvBA95PevCUTJKd1ynr
         jC2ghR7klDhdg==
Date:   Tue, 19 Jul 2022 09:48:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@debian.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 2/3] iio: humidity: dht11: Emit error messages for
 probe failures
Message-ID: <20220719094858.2d1ec9d6@jic23-huawei>
In-Reply-To: <3a819437-7041-f2bd-fe92-c67b040e3e4b@debian.org>
References: <20220718194258.181738-1-ukleinek@debian.org>
        <20220718194258.181738-2-ukleinek@debian.org>
        <CAHp75VfauFGXHuOGt0WkCmxK-cZRpAhC8yfckGzxB1d3fxK6dA@mail.gmail.com>
        <3a819437-7041-f2bd-fe92-c67b040e3e4b@debian.org>
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

On Mon, 18 Jul 2022 22:35:31 +0200
Uwe Kleine-K=C3=B6nig <ukleinek@debian.org> wrote:

> Hello Andy,
>=20
> On 7/18/22 22:27, Andy Shevchenko wrote:
> > On Mon, Jul 18, 2022 at 9:50 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.=
org> wrote: =20
> >>
> >> There are two exit points in the driver's probe function that fail
> >> silently. From a user perspective this is unsatisfactory because the
> >> device is unusable but there is no hint in the kernel log about the
> >> actual problem which makes it unnecessarily hard to fix the problem.
> >>
> >> Make use of dev_err_probe() to emit a problem indication which also do=
es
> >> the right thing if requesting the gpio return -EPROBE_DEFER. =20
> >=20
> > ...
> >  =20
> >> +       ret =3D devm_iio_device_register(dev, iio);
> >> +       if (ret < 0) =20
> >=20
> > Do we really need this ' < 0' part? =20
>=20
> Not sure, I stumbled about that when I split the patch, too.=20
> devm_iio_device_register only returns a value <=3D 0 and I don't expect=20
> dev_err_probe to behave when the error is >=3D 0. So adding the check at=
=20
> least documents the expectations. But I don't have hard feelings and=20
> dropping " < 0" would be fine for me, too.

Slight preference for if (ret)

J
>=20
> >> +               return dev_err_probe(dev, ret, "Failed to register iio=
 device\n"); =20
>=20
> Best regards
> Uwe

