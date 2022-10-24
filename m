Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBCB609EDA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJXKVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJXKU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 06:20:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C34D4CF
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:20:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ml12so5188376qvb.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyQm2Xa+x5OgM+9q3Kg7O5cBQOGlnGN1sPswQe1BnRk=;
        b=qdIkaXnIPJ62WYqpgSIg/KmMGlDGnBdrRYh9GX+XVd5xvfx4mO4LtsjVFaNF37uzR8
         DTpOSzg/9nSiosN+Ip/GR9pf96NDYeRJ7iTpcy5/cRndDy76Dbvbr3Gvy++5TKc80Cep
         6DhZwB7V7+6IDJMSvqXmU6nKxJIugCvD24l0D7nqEHIy59oCSNOBfdQCvvbWomLzmGsV
         gNskcLVVReVFUFw3Mj+Rca4a3A/WUbfCO1l8RJlrf3n/4PPrbgM+7LTrXhMKHaNNtRcg
         gGh8WMUE1ktnsiDdoiyMVq9dZ/1oumBf2P771BtmargEfC6yBQqqz5Ge64vs21yFu4/8
         D94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyQm2Xa+x5OgM+9q3Kg7O5cBQOGlnGN1sPswQe1BnRk=;
        b=wg64sqepFDFQ6GnmojOdQmGtNmFiUY1yqF6MwJ9pHiAJHQhnY2UcbKicaM3kU78oot
         nxoCZcT9fge+76yzMov96AMYmFk9UBuTgzID6U2X1324wctdyujqgdH2Gf0SC7BsPauq
         6LujqQm6T7ec2lpVUGcpUcCeO41fHjV8jK+hH0mn7EGB2ZISJAkveQYemO8MACoUcZzA
         0vNFxlJT/WdMctuqPVUyqiuJXP++hoHcc07yJ0NiPz3JTx6io/9mABce2xWnNvcajiI3
         eRcZ9YQoe+3ZQOsNZRUb/YuKHn1iWJ722c7XH6payzpLIGk+nYsvfK0XWkqLw/nQQXKy
         ZIxw==
X-Gm-Message-State: ACrzQf3rrMLpUEa14KvuV7a10BmkgISfO/uE10r9iJRBboPCuEXCcYop
        hlAt9Q+cwo5ZEUJfHo7RUBU=
X-Google-Smtp-Source: AMsMyM7/884wFXZ32ySTuyeD4mj774Q2A1y5/kb39RJivh6sDFP4gel68scLVr7xzDP4Mm0jbyYTtw==
X-Received: by 2002:a05:6214:4013:b0:4bb:6162:8589 with SMTP id kd19-20020a056214401300b004bb61628589mr7847447qvb.96.1666606856876;
        Mon, 24 Oct 2022 03:20:56 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a13e300b006ea7f9d8644sm14347368qkl.96.2022.10.24.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:20:56 -0700 (PDT)
Message-ID: <39f4b8f21f19361e2b87b581f11a348222ea3dd2.camel@gmail.com>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's
 .probe_new
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 24 Oct 2022 12:22:19 +0200
In-Reply-To: <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
         <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
         <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
         <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
         <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
         <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
         <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
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

On Mon, 2022-10-24 at 12:46 +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Oct 24, 2022 at 11:39:51AM +0300, Andy Shevchenko wrote:
> > > On Mon, Oct 24, 2022 at 09:05:18AM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > On Sun, Oct 23, 2022 at 10:06:11PM +0300, Andy Shevchenko
> > > > wrote:
> > > > > On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-K=C3=B6nig
> > > > > wrote:
>=20
> ...
>=20
> > > > > > +static const struct i2c_device_id kxcjk1013_id[] =3D {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"kxcjk1013", KXCJK1=
013},
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"kxcj91008", KXCJ91=
008},
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"kxtj21009", KXTJ21=
009},
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"kxtf9",=C2=A0=C2=
=A0=C2=A0=C2=A0 KXTF9},
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"kx023-1025", KX023=
1025},
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"SMO8500",=C2=A0=C2=
=A0 KXCJ91008},
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > > > >=20
> > > > > I don't like this part. Can we, please, find a way how to
> > > > > dereference this
> > > > > table via struct i2c_client, please?
> > > >=20
> > > > It would be possible to do (on top of my patch here as PoC):
> > > >=20
> > > > diff --git a/drivers/iio/accel/kxcjk-1013.c
> > > > b/drivers/iio/accel/kxcjk-1013.c
> > > > index e043dd698747..00269b25af99 100644
> > > > --- a/drivers/iio/accel/kxcjk-1013.c
> > > > +++ b/drivers/iio/accel/kxcjk-1013.c
> > > > @@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > > > =C2=A0
> > > > =C2=A0static int kxcjk1013_probe(struct i2c_client *client)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct i2c_device_=
id *id =3D
> > > > i2c_match_id(kxcjk1013_id, client);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct i2c_device_=
id *id =3D
> > > > i2c_match_id(to_i2c_driver(client->dev.driver)->id_table,
> > > > client);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kxcjk1013_da=
ta *data;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *ind=
io_dev;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kxcjk_1013_p=
latform_data *pdata;
> > > >=20
> > > > (only compile tested), you could even create a function or
> > > > macro to make
> > > > this a bit prettier on the source level. For the compiler
> > > > loading the
> > > > address from a local symbol instead of from two pointer
> > > > dereferences is
> > > > (I guess) a bit more effective and IMHO more natural.
> > > >=20
> > > > *shrug*, I don't care much, but I don't like to have to rework
> > > > this
> > > > series just because you don't like this part. You even didn't
> > > > give a
> > > > rationale, I can imagine several different ones:
> > >=20
> > > And I don't want to have ping-ponging the pieces of code (ID
> > > tables) because
> > > some API has to be fixes or so.
> >=20
> > In this series it's only ping without pong.
>=20
> Exactly. And it means let's put my problem to someone's else
> shoulders.
>=20
> > To benefit from the local
> > table instead of fishing the table out of client, the table must be
> > declared already when it's used.
>=20
> I don't see benefit of dereferencing tables by name. The table has to
> be
> available via struct driver, otherwise, how the heck we even got into
> the
> ->probe() there.
>=20
> > > > =C2=A0[ ] it makes the patch bigger
> > > > =C2=A0[ ] it results in an unnatural order of symbols in the driver
> > > > =C2=A0[ ] it's some kind of duplication
> > > > =C2=A0[ ] something else
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 please elaborate: ________________________=
________
> > >=20
> > > It adds a burden to the future work with no good justification
> > > along with
> >=20
> > This burden exists in the drivers that already today have the table
> > above the probe function? (Ok, there are none in this series, but
> > it
> > happens, see for example
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > https://lore.kernel.org/linux-rtc/20221021130706.178687-4-u.kleine-koen=
ig@pengutronix.de
> >=20
> > and a few more in the rtc series.) I don't see a burden here, we're
> > talking about the id table being defined before the probe function,
> > right?
> > How is that a burden? What am I missing?
>=20
> Yeah, people haven't had no idea about accessing tables via struct
> driver,
> reviewers of that code neither. Should it be excuse for us to follow
> that
> example?
>=20
> > > a churn in _this_ series.
> >=20
> > The alternatives are: Split the patch into reorder + convert to
> > .probe_new, or add a declaration for the id table. Among these I
> > like
> > the current approach besto.
>=20
> Alternative is to avoid reordering to begin with, no?
>=20
> > > While I like the rest of the series, these things I would rather
> > > postpone
> > > or rework.
> >=20
> > There is no win in postponing, is there?[1] What would be your
> > preferred
> > way to rework?
>=20
> My understand of the probe_new is that an attempt to unify i2c with
> how spi
> does. So, why not teach i2c_match_id() to handle this nicely for the
> caller?
>=20
> This will allow to leave tables where they are (or move closer to
> struct
> driver), reduce churn with the using of current i2c_match_id() as you
> showed the long line to get that table. This might need a new API to
> avoid
> changing many drivers at once. But it's business as usual.
>=20

I guess something like spi_get_device_id()

- Nuno S=C3=A1

