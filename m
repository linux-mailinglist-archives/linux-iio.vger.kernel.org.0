Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2E58C637
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiHHKRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 06:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHHKRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 06:17:41 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC84DF85
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659953854; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojpZGYMY8v12je9SdLFxHCCOx323uJTqbcDKzVt4p/8=;
        b=IVVjAbxdVy9N2SiTa9phI5RldjxRDucNJAcplEcFTq81K2kFRu5YNN4H7p9Q7T56Psn9XN
        E1Bc66dPpbFyPQaOsfMOsXqaBAvz2uyfDcULdTHJahhF/6FRPAK1gF69FKBPoll1Sb2tPc
        /OC1VhoBghfqvu87pg7/9Gyn5Hvik+A=
Date:   Mon, 08 Aug 2022 12:17:26 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/6] iio: proximity: srf04: Use pm_ptr() to remove unused
 struct dev_pm_ops
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <2LKAGR.8070IXEHVPDS3@crapouillou.net>
In-Reply-To: <CAHp75VdOy-b=eVKauszmSw4wgQDp1o5wUV8QPyW9NKuaGk17MQ@mail.gmail.com>
References: <20220807185618.1038812-1-jic23@kernel.org>
        <20220807185618.1038812-5-jic23@kernel.org>
        <CAHp75Vf5PX3UsyofUWbaw7ndntp0fSrLhRP2fcQGnjA_wOTZ+w@mail.gmail.com>
        <6MIAGR.E5WEOO3MXOKZ2@crapouillou.net>
        <CAHp75VeEtkSUioMLafQuS+kiyEU71SEjcMj8ZLUEv_AJk2mx+g@mail.gmail.com>
        <3AJAGR.1Z7AWJJTEDPB1@crapouillou.net>
        <CAHp75VdOy-b=eVKauszmSw4wgQDp1o5wUV8QPyW9NKuaGk17MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le lun., ao=FBt 8 2022 at 12:09:35 +0200, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Mon, Aug 8, 2022 at 11:49 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>=20
>>=20
>>  Le lun., ao=FBt 8 2022 at 11:39:56 +0200, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Mon, Aug 8, 2022 at 11:35 AM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>  Le lun., ao=FBt 8 2022 at 11:28:12 +0200, Andy Shevchenko
>>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  >>  > On Sun, Aug 7, 2022 at 8:46 PM Jonathan Cameron=20
>> <jic23@kernel.org>
>>  >>  > wrote:
>>  >
>>  > ...
>>  >
>>  >>  >>  In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS()
>>  >> because
>>  >>  >>  that would provide suspend and resume functions without the
>>  >>  >>  checks the driver is doing before calling runtime_pm=20
>> functions
>>  >>  >>  (whether the necessary GPIO is provided).  It may be=20
>> possible to
>>  >>  >>  clean that up in future by moving the checks into the=20
>> callbacks.
>>  >>  >
>>  >>  > ...
>>  >>  >
>>  >>  >>   static const struct dev_pm_ops srf04_pm_ops =3D {
>>  >>  >>  -       SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
>>  >>  >>  -                               srf04_pm_runtime_resume,=20
>> NULL)
>>  >>  >>  +       RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
>>  >>  >>  +                      srf04_pm_runtime_resume, NULL)
>>  >>  >>   };
>>  >>  >
>>  >>  > static DEFINE_RUNTIME_DEV_PM_OPS(...);
>>  >>  >
>>  >>  > ?
>>  >>
>>  >>  Read the commit message?
>>  >
>>  > Yes, and I'm not sure how that part is relevant. The callbacks=20
>> won't
>>  > be called if pm_ptr() equals no-op, no?
>>=20
>>  Have a look at the definition of DEFINE_RUNTIME_DEV_PM_OPS(). I=20
>> believe
>>  it does not do what you think it does.
>>=20
>>  What the commit message says is that using=20
>> DEFINE_RUNTIME_DEV_PM_OPS()
>>  would add .suspend/.resume callbacks, which aren't provided with the
>>  current code.
>=20
> Effectively the use of DEFINE_RUNTIME_DEV_PM_OPS() enables system
> sleep with the same callbacks as runtime PM. I don't see any
> disadvantages of using it instead of keeping runtime PM only. That
> said, I don't see the commit message that describes that nuance. It
> rather says, as I said, something irrelevant.

Probably no disavantages, yes, but that would be a functional change,=20
so I can understand why it's not done in this patchset. That doesn't=20
mean it cannot be done later, though, but somebody would need to test=20
it on hardware.

Cheers,
-Paul


