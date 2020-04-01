Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2D19AD5E
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgDAOGN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 10:06:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40490 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732879AbgDAOGM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 10:06:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so49729pgj.7;
        Wed, 01 Apr 2020 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G38ErvNfgSPVMkRdhVYHG64wSmL/kIIRmwmS2JA46B4=;
        b=LhfPBI25ELfnr6VS94g6atdYCjjDErnJm3bXIxWMbxiHZJ4VzG09Wx6ZQODHU8PCtn
         NUNOVFiZt/e0GBhTMwoBwqUSuVGAoM94kC0dRLl5mS6dvASg6C8ctK/tLy9V3Bien/vW
         tci3sPEzUw5dZVTExr1jAReaBa2WYr2Ah0FTJeHs64xUhDH0SrcLPb6T7PI9O+Vh5gsj
         uEFiGb+6rT4geZ0XR7vxTBjg1bnBDrNk4fwGQO7ZK8jKleSvrnDv8GkSq0/H5yaCHuLD
         ox0SMLR9M1s9ieKhfn/Wb6O3aWZqh1JTZvVd2xc/SqoOq4IrEJxxBL2S/Kv88RjpCVQ/
         W0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G38ErvNfgSPVMkRdhVYHG64wSmL/kIIRmwmS2JA46B4=;
        b=rhCGcf4mtOPo9CeEaDsOjuTRG9Wy3hccUTnMf6/zQs0NIKRXFo3ArSENXVbMLapEY2
         RfFWSOemII8lc/ZPteh1rB7kncHzY9NbiAjIGZ7yxdHHR2He/P6yatg+KtDzFj0ddip3
         1L1cVwkqw24oKvL4aJqkMlq94CNyVRomu0QdxjjxXLPobsY4TbySc4z28x2IuEomdYFw
         kCqRzNlSmq6ZKmHkiRLNb1rmbs6PzyB9lONDbK9oEd04M5uC6tByltFf3Mnl+FxuG9uj
         hucNilr5kvtH4TYWjv0rSIF8oHbu+Z5XbFl6uGcH4ioksamB68AesMD3F2yK3ZiPMpa4
         kA0w==
X-Gm-Message-State: AGi0PuZrq6fcgMlv+47vUtFPQU3whCibcp1vsCVVmDDWbxFQ4rqTmuze
        8KGmM+ZQVtIctJw3jpTItXsQ3WJj1cF2mnkpWrg=
X-Google-Smtp-Source: APiQypI9GaHgoE/j8f8rUoVIvVvDe2roPST88XbP3ov09nRPSezDdfbn5NrizgUJc463yq51zQgRwxFO7XRWYstbNy8=
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr8992384pgc.4.1585749971287;
 Wed, 01 Apr 2020 07:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-6-nuno.sa@analog.com>
 <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
 <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com> <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 17:06:04 +0300
Message-ID: <CAHp75Vcp5Rs53i_74MvbudcRrDYCD=Agfjh2cO_GNc7TXaS73g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 1, 2020 at 4:27 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > On Wed, Apr 1, 2020 at 10:13 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > > > On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> w=
rote:

...

> > > > > +       for (i =3D ARRAY_SIZE(adis16475_3db_freqs) - 2; i >=3D 1;=
 i--) {
> > > >
> > > > Why those margins? size-2 and 1 ?
> > > >
> > >
> > > The -2 is needed since index 7 is not valid. The 1 I honestly don't r=
emember
> > why I did it
> > > like this. Using > 0 is the same and more "common"...
> >
> > More common is >=3D 0. That's my question basically.
> > And if 7 is not valid why to keep it in the array at all?
>
> Well, I can remove the 7. I honestly took it from another driver and I gu=
ess the idea
> is to make explicit that 7 is not supported. Since this is a 3 bit field =
and the datasheet
> does not state this directly.
>
> As for the >=3D0, I prefer to have either as is or >0 since we don't real=
ly need to check the
> index 0. If 1 fails, then we will use 0 either way...

It makes sense to check to get better optimization (and increased readabili=
ty).
Look for this

i =3D ARRAY_SIZE(...);

while (i--) {
 ...
}

It's much better to read and understand.

> > > > > +               if (adis16475_3db_freqs[i] >=3D filter)
> > > > > +                       break;
> > > > > +       }

--=20
With Best Regards,
Andy Shevchenko
