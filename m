Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433B73344F9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhCJRTy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 12:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhCJRTX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 12:19:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58163C061760
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 09:19:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so7592267pjh.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 09:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WPCFP83VInxACGek2HQqsu83lhhu/y34KH2+fCNV0cg=;
        b=DTGvZQyiqjIKQAKQCS//UCkNFHOWZuyZrvO0r/aOZ+N1qdv3iWBeAhVeYZsw+o8UwW
         UiYOCl/9tDmQXoG9OGegblnHaazLFilpqe6FlZL7lU5+iTz9BIFQLRws7gqdpYInlmEm
         nE2TTVgenDH+13PI6WtGDXel93HLgl7sVtN5DCT46vxfxda8XG9rxKWhTYL7qZjPb+cU
         /b6vyjL2bsaWX3syPzqodq61gLEgTQuFyrOOhdR6fUrBS/+kEKUD27KB9NqEn2iqzZUf
         j3ltD/X5stk+o2nJ88a7hfa/zqXxfG/aQoyM5qOIlhWu6/29fUHLpPzRJBzZHZtNCIOP
         rx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WPCFP83VInxACGek2HQqsu83lhhu/y34KH2+fCNV0cg=;
        b=MZ/TGLnI/RgD0xTycUbCxxT98DnbSquccNDVjLLiAcRw4TJ7OczVTV0Zws0nBAoK3c
         ruFRn2IMcoWd9HSDiTJo4a+dI3TyP4rs35w0G1I9Wi/Pqbhugc+m4mm9I4Sfjg3LMjBq
         lgTG5QcZc1geSKDT9/WkldvRayy7w/lf91DokgxLzINne4Uoy811Mw0XKTcpbusJ6pQO
         D5lFiaCKtYt9Qxf1sLQeoEg2pYhCEavKLtxREX072rUNzFxkf0BmyM/ZL7jNOfFJqVCE
         6Iy3rwtkyzQ0efDOUL83JCpxcgd2mg9St5xNK54YRTdffVvxm7o7vRHMCH8l5JX8kBZK
         pMLA==
X-Gm-Message-State: AOAM5309GvwXop9+YA/QjXa3UPmzaz3+6k/UvmwaRJ3gXzXzw8d6s6uS
        anBLPhJSq8Ca2/tOlenFG/9as9nCMwY/WmTRYM9cYg==
X-Google-Smtp-Source: ABdhPJzQMx6UZCB3GhZrkgUEYQ8v4TKFODzh4fYY2zanT1JZRSmfcwDedBkmBhR3yw2L1cepy0U0UCNyyw7imbIPOXY=
X-Received: by 2002:a17:902:c589:b029:e6:3a39:d4a0 with SMTP id
 p9-20020a170902c589b02900e63a39d4a0mr3820097plx.76.1615396762767; Wed, 10 Mar
 2021 09:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20210309231259.78050-1-jbhayana@google.com> <20210309231259.78050-2-jbhayana@google.com>
 <0b9483ca-6f61-cc13-34e6-7f8c31c4c626@opensynergy.com>
In-Reply-To: <0b9483ca-6f61-cc13-34e6-7f8c31c4c626@opensynergy.com>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Wed, 10 Mar 2021 09:19:11 -0800
Message-ID: <CA+=V6c1y_zhqinG4zvxCX5hPM9hNH-9_7ESmHJ87c80RFTBWfA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

As already discussed with ARM, the spec clearly mentions that it has
to be uppercase and not case insensitive. So this patch is consistent
with the specs and changing it with means that the spec would need to
change as well. Therefore, there is no need for another version of the
patch

"A NULL terminated UTF-8 format string with the sensor axis name, of
up to 16 bytes. It is recommended that the name ends with =E2=80=98_=E2=80=
=99 followed
by the axis of the sensor in uppercase.
For example, the name for the x-axis of a triaxial accelerometer could
be =E2=80=9Cacc_X=E2=80=9D or =E2=80=9C_X"

Thanks,
Jyoti

On Wed, Mar 10, 2021 at 3:16 AM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
>
> On 10.03.21 00:12, Jyoti Bhayana wrote:
> > This change provides ARM SCMI Protocol based IIO device.
> > This driver provides support for Accelerometer and Gyroscope using
> > SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification
> >
>
> [snip]
>
> > +
> > +static int scmi_iio_get_chan_modifier(const char *name,
> > +                                   enum iio_modifier *modifier)
> > +{
> > +     char *pch, mod;
> > +
> > +     if (!name)
> > +             return -EINVAL;
> > +
> > +     pch =3D strrchr(name, '_');
> > +     if (!pch)
> > +             return -EINVAL;
> > +
> > +     mod =3D *(pch + 1);
> > +     switch (mod) {
> > +     case 'X':
> > +             *modifier =3D IIO_MOD_X;
> > +             return 0;
> > +     case 'Y':
> > +             *modifier =3D IIO_MOD_Y;
> > +             return 0;
> > +     case 'Z':
> > +             *modifier =3D IIO_MOD_Z;
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
>
> Hi Jyoti,
>
> could you still change the above code to also accept lower case 'x',
> 'y', 'z'?
>
> Supporting lower case as well would establish compatibility with the
> lower case naming conventions used for IIO channels. By this change,
> channels could be forwarded without name changes (as long as they fit
> into the name field). I'm sorry to notice this only now.
>
> Best regards,
>
> Peter
>
