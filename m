Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A85E748D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIWHIh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Sep 2022 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIWHIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2022 03:08:31 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C1F121643
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 00:08:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j8so8448220qvt.13
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=AN3ZCzI4hzTDAtQhd9esMCU82s7dfFJKfj6APKDHk08=;
        b=WFhpPPoVIIXnFb6fAGVkWYOrQjIVLDK45tFqHZXcQ2TVsRJEPxVhs3cVIM7Jve2Ekr
         msUn1LUVH2Fbr2wzVp9unrQLcx8WPCD8p3EezkgXZnylcXMMLroc+3JbrIi0fobEjtxl
         8g8OPpbwr9KZgcSGQCJRffhHjyEfJHoYMZd4MsSlGVUPzNfAy5DyzaWYBRWU+ci1GQbQ
         LIK0/pkgTV9pat/9PPqQHWwkviX6wGtCMzve8ReJJmr5OeFxYKDhXUU8Pju2mkzoR0xn
         6iG/AUwv2DWQfA95RVMBThXMJKWfBeKTvG/X/0nKB7D2JlsUZKUlxxMHjyrqqYbQz1e0
         Eqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=AN3ZCzI4hzTDAtQhd9esMCU82s7dfFJKfj6APKDHk08=;
        b=0iEjId5BIKxRyXbns5CS/ExYbesd84cGHUioTeblNkbrr3cOJkA3aPMjYgl6vjMdsT
         lLsHhZJWb2VAxBhpr6nreGNBJZ3TlLvMRPbUKLrkj0j5XsIKGhP2tmV/NAVrHjwaejWP
         jwBIxjDQ+kFTEiisnK1Vsvj0iEcYUWP/qNqxttyYjVkKa4JvQScTSUTJEp686s710jis
         JK4kyK+CyHICyNBPtSFW/Dh2z/fr+7RktoqRZh+ryxqMQfcOug3ziKRprUr8kMp5pWrS
         FnsJjuTW9Oum+Lt+k+PZAmU3PGY+rmEHVzQX7rGpuHwzEl6LNrpdLGvhATLgHryUhiMM
         GLFw==
X-Gm-Message-State: ACrzQf1GlgZtaONAje4xYZg+opYFf2xnlTCkpVwPh6UED4cOmQzZ7nwv
        RtZGCfrgRenJzTzPFznc7tM=
X-Google-Smtp-Source: AMsMyM7/Qaelja88GYPtYzsMM6cJISOXIW4nQ+nNMmaduRCZ8XSwEUpIwQCfkRQkgL7fyBuAh1TPbg==
X-Received: by 2002:a05:6214:2528:b0:4ad:6fa4:4170 with SMTP id gg8-20020a056214252800b004ad6fa44170mr5674785qvb.113.1663916909116;
        Fri, 23 Sep 2022 00:08:29 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b0035bb6c3811asm4774224qtp.53.2022.09.23.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 00:08:28 -0700 (PDT)
Message-ID: <ec8aedaeb47ecf9d3dbb345eb323b9d8adfe7168.camel@gmail.com>
Subject: Re: [PATCH v1] drivers/magnetometer/ak8975: check the return value
 of ak8975_set_mode
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Li Zhong <floridsleeves@gmail.com>
Cc:     linux-iio@vger.kernel.org, zheyuma97@gmail.com, nathan@kernel.org,
        paul@crapouillou.net, lars@metafoo.de, jic23@kernel.org
Date:   Fri, 23 Sep 2022 09:09:44 +0200
In-Reply-To: <CAJCx=gkhj9ZmVOe37rGyyjF+3b9Tgb2-bjDQc5kgO3Tt4NmD9A@mail.gmail.com>
References: <20220922225012.1709173-1-floridsleeves@gmail.com>
         <CAJCx=gkhj9ZmVOe37rGyyjF+3b9Tgb2-bjDQc5kgO3Tt4NmD9A@mail.gmail.com>
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

On Thu, 2022-09-22 at 16:50 -0700, Matt Ranostay wrote:
> On Thu, Sep 22, 2022 at 3:50 PM Li Zhong <floridsleeves@gmail.com>
> wrote:
> >=20
> > Check the return value of ak8975_set_mode(). When it fails to write
> > the
> > register, the error should at least be propagated to the caller.
> > Currently function ak8975_remove() returns the success value 0
> > no matter the execution fails or not, which will silently leave the
> > error unhandled.
> >=20
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> > =C2=A0drivers/iio/magnetometer/ak8975.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/magnetometer/ak8975.c
> > b/drivers/iio/magnetometer/ak8975.c
> > index 2432e697150c..e08f10fe16d0 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -1022,16 +1022,17 @@ static int ak8975_remove(struct i2c_client
> > *client)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =
=3D i2c_get_clientdata(client);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ak8975_data *data =3D=
 iio_priv(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D 0;
>=20
> Not needed to initialize to zero since it will get set below.
>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(&client-=
>dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_noidle(&clien=
t->dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(&client->=
dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_unregister(indio_=
dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_triggered_buffer_cleanup=
(indio_dev);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ak8975_set_mode(data, POWER_DOWN)=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D ak8975_set_mode(data, POW=
ER_DOWN);
>=20
> I am not convinced there is a real reason to report this failure from
> .remove() since
> device is still unregistered and at the worst case it isn't in low-
> power mode.
>=20

Agreed.. Also look here:

https://lore.kernel.org/linux-i2c/20220609091018.q52fhowlsdbdkct5@pengutron=
ix.de/

I'm not sure the status of this but the key point is that returning an
error code does not make a difference.

- Nuno S=C3=A1


