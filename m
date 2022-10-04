Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138BD5F3D7A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJDHvu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 03:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJDHvt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 03:51:49 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0172B624
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 00:51:48 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id mg6so3014193qvb.10
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=9eDs+P1GL8nCLCW93dxyiPgDB7yR3iHl8twFnUGybrI=;
        b=hL1WPJ+QiVJmIPq9w0ctpv2LfS+yx2+QCpSPUDym8PlT80bQrhahmMzJAeX4VNggAm
         vPmrnwJo7oS56/em7xGuCuQe4qkaBJM6c/r/ih3RkNEewZBUJ/X11pMjP1cIkN9/3mtG
         cjSrznZtnE7bKbxTwXuMFM3CcrQwL+fSlrs9HfX/McgeucQv5hH9YHr4P+oGO2ZRSEg/
         DsTLcgeAkWNOMvK9Dkw8/y0GO0U2BjWTtPvnVCjhCIx/1Dr551rvM1PIrre/7SE/kvP8
         GA1cUgR6FkM0X99uvGi8Dy++x1I81MTJ84eqVq9BMkveO89pg5zbBi4S5H1rJ31C1SeM
         oeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9eDs+P1GL8nCLCW93dxyiPgDB7yR3iHl8twFnUGybrI=;
        b=dswMzFHLBDlsz2HvcnwI2zgJTv9yGqncSszbwuCPyQOLNlQhSb67zcJQxww1sVZMre
         lI72Kx5RweI9UHpUXx1DxklpuP58dJzBYF7sRFnDQalMOFCqZheX/Al6w80J0KqQXjaC
         +ZzcM7ZROc8NwS88WsuluF+GtmUh8EMLz1YLRAg2M2y/aQeNAtzhMGuWFNmEFAbKFjvs
         ziy/C5Rl0fp9P4wmMQ+H6SIaZN16F0PYvumlpFFn4i2BB2LcIYdpm7liy1PcGkj7o9mF
         YQ1vzcwBId78G1q3cC6svTybmu6Wd6P3EciSdkbgYKSx25sBJXwLbVT2lLe3+i2jdWdR
         6JPA==
X-Gm-Message-State: ACrzQf1SLBH6wB5Ifp9Sc5u3jR91WpYfWFmY76U8Lzc9HKLrWQ06EXND
        VzFZHAZvXLV0pIGqTN9qVWU=
X-Google-Smtp-Source: AMsMyM66HpCi23rHTq7Msh95SV7hO7BtFz5zjtqFS7UBnac5xLuXCTRKmSMn9eT1HFtjN8UyjkHUmg==
X-Received: by 2002:a05:6214:27c3:b0:4ac:a9f7:49c4 with SMTP id ge3-20020a05621427c300b004aca9f749c4mr19085509qvb.48.1664869907748;
        Tue, 04 Oct 2022 00:51:47 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id fb25-20020a05622a481900b0034035e73be0sm11683672qtb.4.2022.10.04.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 00:51:46 -0700 (PDT)
Message-ID: <9d74aeeafd7987d6a495fb01c76566cf9443bd22.camel@gmail.com>
Subject: Re: [PATCH 14/15] iio: health: max30102: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
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
Date:   Tue, 04 Oct 2022 09:53:02 +0200
In-Reply-To: <20221002120830.52699870@jic23-huawei>
References: <20220920112821.975359-1-nuno.sa@analog.com>
         <20220920112821.975359-15-nuno.sa@analog.com>
         <20220924165417.46a1fc44@jic23-huawei>
         <d41b131df565e7c7d6083ebbd7de0346c46b9e23.camel@gmail.com>
         <20221002120830.52699870@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
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

On Sun, 2022-10-02 at 12:08 +0100, Jonathan Cameron wrote:
> On Fri, 30 Sep 2022 12:04:39 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sat, 2022-09-24 at 16:54 +0100, Jonathan Cameron wrote:
> > > On Tue, 20 Sep 2022 13:28:20 +0200
> > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > =C2=A0=20
> > > > The pattern used in this device does not quite fit in the
> > > > iio_device_claim_direct_mode() typical usage. In this case,
> > > > iio_buffer_enabled() was being used not to prevent the raw
> > > > access
> > > > but to decide whether or not the device needs to be powered on
> > > > before.
> > > > If buffering, then the device is already on. To guarantee the
> > > > same
> > > > behavior, a combination of locks is being used:
> > > >=20
> > > > 1. Use iio_device_claim_direct_mode() to check if direct mode
> > > > can
> > > > be
> > > > claimed and if we can, then we keep it until the reading is
> > > > done
> > > > (which
> > > > also means the device will be powered on and off);
> > > > 2. If already buffering, we need to make sure that buffering is
> > > > not
> > > > disabled (and hence, powering off the device) while doing a raw
> > > > read. For
> > > > that, we can make use of the local lock that already exists.
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0=20
> > > Obviously same dance in here as the related previous patch. So
> > > same
> > > solution
> > > needs adopting.=C2=A0 I just thought I'd reply to make sure we didn't
> > > forget to
> > > cover them both :)
> > >=20
> > > =C2=A0=20
> > Hi Jonathan,
> >=20
> > So I was working on v2 in the morning and went with your
> > iio_device_claim_buffer_mode() approach... And bah, well it works
> > like
> > a charm in the previous patch, it fails in this one:
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_lock(&indio_dev->mlock);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!iio_buffer_enabled(indio_dev))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (iio_device_claim_buffer_mode(indio_dev)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D max30102_get_temp(data, val, true);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D max30102_get_temp(data, val, false);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_unlock(&indio_dev->mlock);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_=
release_buffer_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if(ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> >=20
> >=20
> > Note that if we are not in buffered mode we won't get mlock and
> > call
> > max30102_get_temp(data, val, true) without any lock. While it's
> > very
> > unlikely for someone, in the meantime, to enable the buffer and
> > then
> > disable it, it's still racy and possible (at least in theory).
>=20
> Ah. That's indeed tedious. I'd close the race by claiming direct mode
> for the else branch.=C2=A0 If that fails, pah, just fail the call with a
> suitable
> error return (-EAGAIN probably).=20
> Or put a retry look around the whole thing to make it even less
> likely
> we'll hit the gap in the locking.
>=20

Hmm I did thought about that but it looked very "dirty"... Anyways, I
can do it for v2 just so we have a look on how it looks like.

- Nuno S=C3=A1

