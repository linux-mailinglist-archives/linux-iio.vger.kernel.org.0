Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E511072632B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jun 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjFGOpS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jun 2023 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbjFGOpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jun 2023 10:45:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383A19BA
        for <linux-iio@vger.kernel.org>; Wed,  7 Jun 2023 07:45:16 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6259c242c96so56851226d6.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jun 2023 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686149115; x=1688741115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PijH6sZIMeWGyL7xNuljFEtMZ30sNp4YZfQYGCRx7sc=;
        b=H/bjAsf5Xoh77H7CzUZ1tEznTbOKGUHaz+FrFg7te16HzynErrJmeR+dFasA/xpQYb
         gUEAunlhJkn5CsZeYeyYi9yJmiAUT6Rq81I7uTWe7cOLOsupjZsDVxxkyHKkaNSVNXXt
         D6hk47p9XZ/bBNJ25tQrQ2mBWwz/b5cchOdU0KLZO9P5Gb/fjIP1OyyNt507BlN9hR+D
         3iQmHAlOAbxwEDruiZAL4Vzl50nvwlP+Mao9rHp1+ybgmAMuZcsVcdHUtHzBMEcwjdc8
         axE57eCB2VFqe1Pm1CzM/4i6o6jSD29x3tNhdxZtK/9F3roI0GUyb0NBd/MwCEjgLMGl
         Kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149115; x=1688741115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PijH6sZIMeWGyL7xNuljFEtMZ30sNp4YZfQYGCRx7sc=;
        b=TPWYxw4EZV5wdCVieaWkreJ18ZrhPRHxA52S42rSWZmvOvTvJ47LA2wtjtLPCeUAim
         uRuMPjcDTGEEfJtUSp4TyMwE1qBLQJtVYt1+GQY43Mvdt6uMhYxAB0yxCBZ58V/mpJ05
         eqTmTCp8ji2GwCILcHLEnNZn/5fo8osEZnlPZYUa8i9snLEglfiVO17LGLy0LmTCebzu
         frAFC6O5StmCasJ1b0mPWShEp6ARkSrtTZkg7KwkYbrKKUZfFUiqaaH9vM0qbByic4Rq
         nJwTA7ALHL3knfEIl0sWfGrdV0O9IrMDT9XtyO+T0XF90YzfOaeqJ3z8fuKxQ+NUnZug
         OVcQ==
X-Gm-Message-State: AC+VfDwFGLixMnmHx8Qt1/aD4HQdV/xfGwAlokrk87jlPh/jB7G72I4u
        gTZ/eUbpQuDS9HSAMzcG0UFxTAIGGhNnWWWku4k=
X-Google-Smtp-Source: ACHHUZ4bnXOu2z61NApr3gL55yVXzefETNYdmbpAuY60VQS5SrxobU/7hNAlzoSUNaRBWxYEoZemmadTRR74Hyq8N2o=
X-Received: by 2002:ad4:5cce:0:b0:626:101a:f8 with SMTP id iu14-20020ad45cce000000b00626101a00f8mr3841279qvb.25.1686149115335;
 Wed, 07 Jun 2023 07:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
 <ZIAjFMhJbnndgL-G@surfacebook> <FR3P281MB17572FE25C24840A4030315ACE53A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB17572FE25C24840A4030315ACE53A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Jun 2023 17:44:39 +0300
Message-ID: <CAHp75Vd+VK2B=rjYitXSDhHxbbyUNxNpvD1KgrsB=3sBxk6Pkg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Factorize timestamp module
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     INV Git Commit <INV.git-commit@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 7, 2023 at 12:28=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> Hello Andy,
>
> really sorry, I forgot to do that. I'm still not very familiar with all t=
he details of the process, sorry.

Understand.

> I will send a new v3 with the Reviewed-by tag. Is it OK like this?

I believe no need to resend right now as I can simply repeat it here
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
But next time be more careful.

And thank you for what you are doing!

> Thanks a lot, and sorry again.

> From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> Sent: Wednesday, June 7, 2023 08:26
> To: INV Git Commit <INV.git-commit@tdk.com>
> Cc: jic23@kernel.org <jic23@kernel.org>; linux-iio@vger.kernel.org <linux=
-iio@vger.kernel.org>; lars@metafoo.de <lars@metafoo.de>; Jean-Baptiste Man=
eyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: Re: [PATCH v2 0/4] Factorize timestamp module
>
> [CAUTION] This is an EXTERNAL email. Do not click links or open attachmen=
ts unless you recognize the sender and know the content is safe.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Tue, Jun 06, 2023 at 04:21:43PM +0000, inv.git-commit@tdk.com kirjoitti:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >
> > The purpose if this series is to make timestamping from
> > inv_icm42600 driver an independent module and use it for both
> > inv_icm42600 and inv_mpu6050 drivers.
> >
> > Create a new inv_sensors_timestamp common module based on
> > inv_icm42600 driver and use it in the 2 drivers.
> >
> > WARNING: this patch requires following commit in fixes-togreg
> > bbaae0c79ebd ("iio: imu: inv_icm42600: fix timestamp reset")
>
> > Changelog
> > - v2: do some headers cleanup and add some justifications in
> >       the patches descriptions.
>
> What I haven't noticed is my tag. It's your responsibility to add given t=
ag and
> it's polite to Cc to the reviewers (but this will imply by the tag anyway=
 in
> this case).
>
> Any explanation why did you do so?
>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
With Best Regards,
Andy Shevchenko
