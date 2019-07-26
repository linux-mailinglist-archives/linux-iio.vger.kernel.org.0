Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE376739
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGZNV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 09:21:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44231 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZNV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 09:21:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so53232246edr.11;
        Fri, 26 Jul 2019 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aEPGoQmeQt4va0p2hGnrM5rQgBeB6NOs8t/gLhx0kGI=;
        b=J3DFbTYocQneB6oHubp9dHGTI2iL0Rx4t3mTkLiBOW2oRrQ5Dx4o7aQuMpww/UUMl+
         UCVhhHd286oIqAlTYWbrlTfSb/34zb4jSF5rCHiDv1K+wdM72yC2dk1pSyDgINAw1wFj
         JrR5jK7srTYboiGt9fPLXKlDSrEMNs/VacIVcK17vNdUDlEiv0ne0MV2DYzroF+onS2q
         oPJlAVRfQIKXFFjIpjwVnCctqATCbVbpu8197lKXjp2SlMx1J80n3mu8uDqvwGtBja8c
         Sb6thrqNTUGu2TFdackYNxJhVJq8y8jcKs4xKjyPY0bUQQTGbDWc227zGP/ldr+JHzSn
         iEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aEPGoQmeQt4va0p2hGnrM5rQgBeB6NOs8t/gLhx0kGI=;
        b=XSn9B6LynWVou1MyjGyjP9jVpgEB/SB7faP22dgVa9lB8UkLbiybyq5lcK8nMTJUKd
         Z1j66znAGEsEDdBHganYv4jbmlE8xWosEruSK/WcW9Si+LLo+noG58Dx5gS+Omk86k0F
         VeUBEfNb4CEuXJkLlUqX9XrMamhjvH9TRnXwao1uQR9AhIG1ajHVxBgiGoqaFGd0haG3
         Cw5XwNVfmBz8Stj6Krxt+xltRUUGmCzA7BqRDj34/iChzQS/gkT+Ra5lscJRVcPjNFU1
         pJziFfu6ujaac5/JepT0YFRJQi0eaKSvAIm7zVYNBoQ1l/6jRZXku6IJq4yNTyMhLwUt
         J7OA==
X-Gm-Message-State: APjAAAUhPzdvY/lsxcAVzkSdRAtetpI0xo9eerSUF3TUyIH49Zfbei6C
        3+OBo4k8P9n6a2OtKPdvnb8RZX/8rlZObfzVmao=
X-Google-Smtp-Source: APXvYqzbxn/aUzm9t7YNHRy11YRjgXr3D4RCTMRYzXKzStfRn2jaR8dRB/UpDeutOze0783Eexm6xW1m00L9hhbNX/M=
X-Received: by 2002:a17:906:6d2:: with SMTP id v18mr72287447ejb.279.1564147284696;
 Fri, 26 Jul 2019 06:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190726022836.7182-1-hslester96@gmail.com> <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
In-Reply-To: <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 26 Jul 2019 21:21:13 +0800
Message-ID: <CANhBUQ2Qu3Ttvi3PNWyyTNhZhVF7q2VE_TXgBcog6gah=cGxyw@mail.gmail.com>
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patrick Havelange <patrick.havelange@essensium.com> =E4=BA=8E2019=E5=B9=B47=
=E6=9C=8826=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:51=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hello,
>
> On Fri, Jul 26, 2019 at 4:28 AM Chuhong Yuan <hslester96@gmail.com> wrote=
:
> >
> > Make use of devm_counter_register.
> > Then we can remove redundant unregistration API
> > usage to make code simpler.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v2:
> >   - Use devm_add_action_or_reset to keep
> >     resource release order.
>
> This is better now indeed.
>
> However it seems there is an issue with the mail/patch format, I'm
> unable to apply it with git am, and if you look at
> https://lore.kernel.org/patchwork/patch/1105782/ the diff section is
> missing the beginning of the patch. I don't know why, but I think it
> should be looked into.
>
> Otherwise, it's fine by me.
>
> Regards,
>
> Patrick Havelange

I am also not clear about why this issue happened.
Maybe it is caused by changelog format.
I will revise changelog and resend it later.



>
>
> >   - _remove() function is redundant now,
> >     delete it.
> >
> >  drivers/counter/ftm-quaddec.c | 31 +++++++++++--------------------
> >  1 file changed, 11 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quadde=
c.c
> > index 68a9b7393457..76c70a6c3593 100644
> > --- a/drivers/counter/ftm-quaddec.c
> > +++ b/drivers/counter/ftm-quaddec.c
> > @@ -100,16 +100,17 @@ static void ftm_quaddec_init(struct ftm_quaddec *=
ftm)
> >         ftm_set_write_protection(ftm);
> >  }
> >
> > -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> > +static void ftm_quaddec_disable(void *ftm)
> >  {
> > -       ftm_clear_write_protection(ftm);
> > -       ftm_write(ftm, FTM_MODE, 0);
> > -       ftm_write(ftm, FTM_QDCTRL, 0);
> > +       struct ftm_quaddec *ftm_qua =3D ftm;
> >
> > +       ftm_clear_write_protection(ftm_qua);
> > +       ftm_write(ftm_qua, FTM_MODE, 0);
> > +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
> >         /*
> >          * This is enough to disable the counter. No clock has been
> >          * selected by writing to FTM_SC in init()
> >          */
> > -       ftm_set_write_protection(ftm);
> > +       ftm_set_write_protection(ftm_qua);
> >  }
> >
> >  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> > @@ -316,22 +317,13 @@ static int ftm_quaddec_probe(struct platform_devi=
ce *pdev)
> >         mutex_init(&ftm->ftm_quaddec_mutex);
> >
> >         ftm_quaddec_init(ftm);
> > -
> > -       ret =3D counter_register(&ftm->counter);
> > +       ret =3D devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disabl=
e, ftm);
> >         if (ret)
> > -               ftm_quaddec_disable(ftm);
> > -
> > -       return ret;
> > -}
> > -
> > -static int ftm_quaddec_remove(struct platform_device *pdev)
> > -{
> > -       struct ftm_quaddec *ftm =3D platform_get_drvdata(pdev);
> > -
> > -       counter_unregister(&ftm->counter);
> > -
> > -       ftm_quaddec_disable(ftm);
> > +               return ret;
> >
> > +       ret =3D devm_counter_register(&pdev->dev, &ftm->counter);
> > +       if (ret)
> > +               return ret;
> >         return 0;
> >  }
> >
> > @@ -346,7 +338,6 @@ static struct platform_driver ftm_quaddec_driver =
=3D {
> >                 .of_match_table =3D ftm_quaddec_match,
> >         },
> >         .probe =3D ftm_quaddec_probe,
> > -       .remove =3D ftm_quaddec_remove,
> >  };
> >
> >  module_platform_driver(ftm_quaddec_driver);
> > --
> > 2.20.1
> >
