Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED85F22CE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJBLIZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJBLIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 07:08:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06323B952
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 04:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4CC4CE0A09
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 11:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD61DC433C1;
        Sun,  2 Oct 2022 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664708900;
        bh=Nc2ydgbMIQ6OD7F0wBMPbQVGKnY8yn+fS6qUUd9/xas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ho8+hC2dVibWioupL83ztIB0d19HmKOELPOWm4YYl1n9E06jLwAIcRcqbpoVxK5E0
         +fl7G557JdnvutgXcy/Oqwes6uaeHSFfqya/gPvC7iJYTbOSSeKT/jXv4ggfRYfsTJ
         MMJbOleuNOeb+9z081hbsrLTm0C5trT+ShlhcQyhJEdEwqZmjKPeEpIjLA+c6RzOYC
         CPclxUq+uhcNNIV4P/spMRwWpKnZqiWGFjiUq+RLBVU0Ht/wUhk+PLux6ikDo/tlWy
         H/lKuwR9nJ3z1AHSvkj5oLn7IG1wRuobp4WjrLONWSurNi4BW6T2I9YfUtMXU4zEqb
         CtpMvDrXwil8g==
Date:   Sun, 2 Oct 2022 12:08:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 14/15] iio: health: max30102: do not use internal
 iio_dev lock
Message-ID: <20221002120830.52699870@jic23-huawei>
In-Reply-To: <d41b131df565e7c7d6083ebbd7de0346c46b9e23.camel@gmail.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-15-nuno.sa@analog.com>
        <20220924165417.46a1fc44@jic23-huawei>
        <d41b131df565e7c7d6083ebbd7de0346c46b9e23.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Sep 2022 12:04:39 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2022-09-24 at 16:54 +0100, Jonathan Cameron wrote:
> > On Tue, 20 Sep 2022 13:28:20 +0200
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > The pattern used in this device does not quite fit in the
> > > iio_device_claim_direct_mode() typical usage. In this case,
> > > iio_buffer_enabled() was being used not to prevent the raw access
> > > but to decide whether or not the device needs to be powered on
> > > before.
> > > If buffering, then the device is already on. To guarantee the same
> > > behavior, a combination of locks is being used:
> > >=20
> > > 1. Use iio_device_claim_direct_mode() to check if direct mode can
> > > be
> > > claimed and if we can, then we keep it until the reading is done
> > > (which
> > > also means the device will be powered on and off);
> > > 2. If already buffering, we need to make sure that buffering is not
> > > disabled (and hence, powering off the device) while doing a raw
> > > read. For
> > > that, we can make use of the local lock that already exists.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > Obviously same dance in here as the related previous patch. So same
> > solution
> > needs adopting.=C2=A0 I just thought I'd reply to make sure we didn't
> > forget to
> > cover them both :)
> >=20
> >  =20
> Hi Jonathan,
>=20
> So I was working on v2 in the morning and went with your
> iio_device_claim_buffer_mode() approach... And bah, well it works like
> a charm in the previous patch, it fails in this one:
>=20
> -               mutex_lock(&indio_dev->mlock);
> -               if (!iio_buffer_enabled(indio_dev))
> +               if (iio_device_claim_buffer_mode(indio_dev)) {
>                         ret =3D max30102_get_temp(data, val, true);
> -               else
> +               } else {
>                         ret =3D max30102_get_temp(data, val, false);
> -               mutex_unlock(&indio_dev->mlock);
> -               if (ret)
> +                       iio_device_release_buffer_mode(indio_dev);
> +               }
> +               if(ret)
>                         return ret;
>=20
>=20
> Note that if we are not in buffered mode we won't get mlock and call
> max30102_get_temp(data, val, true) without any lock. While it's very
> unlikely for someone, in the meantime, to enable the buffer and then
> disable it, it's still racy and possible (at least in theory).

Ah. That's indeed tedious. I'd close the race by claiming direct mode
for the else branch.  If that fails, pah, just fail the call with a suitable
error return (-EAGAIN probably).=20
Or put a retry look around the whole thing to make it even less likely
we'll hit the gap in the locking.

Otherwise, we could do iio_device_claim_current_mode() that locks on one
or the other but that just seems weird.

>=20
> So, I'm thinking again on the flag approach... Just check my comment
> (in the previous patch) about it being refcounted. I mean, I might be
> missing something, but if we need a refcount, I would say things would
> be already (potentially) broken, right?

I'm not 100% sure on the refcount necessity, as I've not looked at
the code again, but these things tend to be symmetric as described in the
reply to the previous.   So you need to cover the case that this call
races with the buffer being disabled.

>=20
> With this step back, I'm planning on a v2 in the beginning of the week
> after we have this sorted out (and I guess we need to settle things
> also in the ad799x patch)
>=20
> - Nuno S=C3=A1
>=20

