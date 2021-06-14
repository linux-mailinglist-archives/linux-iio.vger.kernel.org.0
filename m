Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2C3A5EB6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFNJBW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 05:01:22 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:44950 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhFNJBT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 05:01:19 -0400
Received: by mail-pj1-f43.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so9730495pjq.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Jun 2021 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=URUKRFLpdGM/01QGOSuh4l0He6e9uRi1O8O1D/ixrHc=;
        b=Bn59XeqbScpdWaa315idTviDIkKLA8s53m8eX2LVwTvqgUqYwNjnB3aVILfDT/3uTz
         Qg7rykT5n3Qvh3THgDGF72FDuSE4xDrUwcQ7nt1Pl3lHBY5ZhT9LCRLZsklfpMEvaKLm
         kDrIObB3imZWNPwfQwcTar8tncQ8S6K6yhxrONyJTHRiBVU0W/1IH0NKcoetFcOTEv5P
         NYsTafgOa3uDqq18QzfyMr54CXznxih+fLaDlVrMOaAi6QBFHhcssp3Ce36mI8erDPPm
         UqLlajYlZRa4s5vABkmCfoxUJXxZGn7ZcOB8aVDBM0jtL2Dz7KgTj35/mU9RiuTScRkk
         J0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=URUKRFLpdGM/01QGOSuh4l0He6e9uRi1O8O1D/ixrHc=;
        b=ap3GuwFVStTyPm7tkGclw0FX5wdzfAAu4USknGScQLepSBxWkO1MrtLivPWUcnWecJ
         rS/nUvASzHJvqOYHjN3FYTCMPRJML+ftZn03c0idKA8a9Segt0WYH57tlhpHlSTvaDvk
         +cwSROUpGrjMD61yuOxO/GJnT+GWioFQuWjFBCRQOgMNIM3y/NgE2iCalvBY6gkJwMc8
         p21jb8MNX/L73Ja3bQvAiyMLtn61HdC9tTeeYsZGB+I9/bRJgjglFTRnXyqECNQrmObK
         8WeE2XtV2358aqdfveTs4YgjKNvgI39JsskybHAEwHmiJsylCuaDSG/8O+3RVSkiwUZ8
         RAxQ==
X-Gm-Message-State: AOAM5302eoiVvaTuR+PdSVrYZBOwBiHN1oBAnghmzZ/0/3ZU8QGzOi0v
        zpM6Cz4t1RzDl+/Mk9smJrYp4TF//0wIWdpYGDk=
X-Google-Smtp-Source: ABdhPJxUQvgvWYMPngfyxrR9tlAAnwLLSdGqMZtLxhQ4Aoe/ifMWY0fQ5288akeTWz6x7vvqvV637QC11r6H8xGbF2U=
X-Received: by 2002:a17:902:c784:b029:104:9a21:262a with SMTP id
 w4-20020a170902c784b02901049a21262amr15990378pla.21.1623661082309; Mon, 14
 Jun 2021 01:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
 <20210611115558.796338-2-jarkko.nikula@linux.intel.com> <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
 <839944ff-e4e3-86c1-8d53-abaf96fa9271@linux.intel.com>
In-Reply-To: <839944ff-e4e3-86c1-8d53-abaf96fa9271@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Jun 2021 11:57:46 +0300
Message-ID: <CAHp75VfqUftwaGrJVR0qAkLG=-=qNLEV=9fLAC5SCNtt2i_bJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Uwe Kleine-K=C3=B6nig

On Mon, Jun 14, 2021 at 11:24 AM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> On 6/13/21 1:36 PM, Andy Shevchenko wrote:
> > On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:
> >>
> >> Use to_pci_dev() helper instead of container_of(d, struct pci_dev, dev=
);
> >
> > ...
> >
> >> -       struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev=
);
> >> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> >>          struct intel_qep *qep =3D pci_get_drvdata(pdev);
> >
> > Why not change both lines to dev_get_drvdata()?
> >
> I thought it before and Uwe had a good point why it isn't necessarily a
> good idea:
>
> https://www.spinics.net/lists/linux-pwm/msg15325.html

I understand this point, but the problem is that we often use
different callbacks for different layers. For example, the PM
callbacks are operating with generic 'struct device' and using the PCI
device there is non-flexible layering violation, so in my opinion it's
the opposite to what Uwe says. I.o.w. we need to use corresponding API
to what we have in the callbacks. If the callback comes from generic
level =3D=3D> generic APIs more appropriate.

Anyway, it's such a minor detail, that I'm not going to insist on
either way independently on the arguments.

--=20
With Best Regards,
Andy Shevchenko
