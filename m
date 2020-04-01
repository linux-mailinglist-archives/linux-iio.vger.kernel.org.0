Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E219B037
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgDAQZJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 12:25:09 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55970 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbgDAQZI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 12:25:08 -0400
Received: by mail-pj1-f66.google.com with SMTP id fh8so185014pjb.5;
        Wed, 01 Apr 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gHFLCKlpXIGAn0egtGMAf9G1WrufJhSv91wXY+Y8f8Q=;
        b=tWM2eX3i801PMq7UXOjk5Rdt+AbUlekjbWhkNHZLubyt7URQ62HbIkd62klBeCS1Ob
         0bechhHZmZz0bUIAD2eQQxzk7/i4Yv9pCZIvNZGUVu4t1x2A56iCLukQ9gDV2p4kjldH
         O+p9CbN7FF+/m3GsmzqB1T20aftGn5qll1X6AbDYLdYTNEx2+uD8m7/IH6REWVJdcSls
         u+VoyYhb3lqNUPLDRXuzTWV9bi4xGRzl/zNJcjAUBV3yELDna/l33VoFKYgPwItULo1J
         KCkG/7DXUDDKN6h9hN4+VI6xFJvMeqVVkfPoYus+LOy9GbUVaxZ5a2b9GSomfQ8MENUs
         q7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gHFLCKlpXIGAn0egtGMAf9G1WrufJhSv91wXY+Y8f8Q=;
        b=mS4XvEIO21jAYcoutoxdpqF4kjXNvK0nxVNQbKjM3MaIRPVnnxZyuhJWXCPU5z/eBD
         1HG8C3SWLOmLjRUa92qSmtaMZkqJL1tbHh4AeMjBi/D6VfT9ipK/G/1UUoiZOKHzUe9u
         d4ebKmeTO8ZP7IGeNcmDf6bekVu2QdUuX4UO+dLOR5g+rKAf29GCF5HFbhbnfABbxYvQ
         X7mjozt1V6UAp8SKZrHlHsSpHJbDzloWdstwqwDy8+QqnPhwixpoG8b18gOrp+NtrxF2
         ue1UZ+eLNucx4ZeVvPpIcuMiILcLS1Y3UTFzs8u5/SH+Zj09lcF5SKQVN+b7zZPjC5TL
         m/Eg==
X-Gm-Message-State: AGi0PuZzbQ/Qr5fvm5aSxtocHuNmErHmMwvyOkZRtOuA8X69LFuSRtRM
        /MaQQQukgB9f1P5ki7lm2i5kMITSPMQuL0+nPik=
X-Google-Smtp-Source: APiQypJFkKtX6ZC6hJ0SDdwypkf/KeP+1RyrvwFBHvlwbJQHvhQXt7QZJ/RME6jjIkwyNRSQ2VZlIfHmuUBQY2B1cL8=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr5878941pjn.8.1585758307412;
 Wed, 01 Apr 2020 09:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-6-nuno.sa@analog.com>
 <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
 <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
 <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75Vcp5Rs53i_74MvbudcRrDYCD=Agfjh2cO_GNc7TXaS73g@mail.gmail.com> <BN6PR03MB33475E91FA8665937E8F3AE599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB33475E91FA8665937E8F3AE599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 19:24:59 +0300
Message-ID: <CAHp75VddBgGtBf=3yNs331EU6HQgL-Aq7tmf+dG3Z9W-d0hdNQ@mail.gmail.com>
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

On Wed, Apr 1, 2020 at 5:18 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Mittwoch, 1. April 2020 16:06
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; devicetree
> > <devicetree@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Ardelean,
> > Alexandru <alexandru.Ardelean@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
> >
> > On Wed, Apr 1, 2020 at 4:27 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > > > On Wed, Apr 1, 2020 at 10:13 AM Sa, Nuno <Nuno.Sa@analog.com>
> > wrote:
> > > > > > On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.co=
m>
> > wrote:

...

> > > Well, I can remove the 7. I honestly took it from another driver and =
I guess
> > the idea
> > > is to make explicit that 7 is not supported. Since this is a 3 bit fi=
eld and the
> > datasheet
> > > does not state this directly.
> > >
> > > As for the >=3D0, I prefer to have either as is or >0 since we don't =
really need to
> > check the
> > > index 0. If 1 fails, then we will use 0 either way...
> >
> > It makes sense to check to get better optimization (and increased reada=
bility).
> > Look for this
> >
> > i =3D ARRAY_SIZE(...);
> >
> > while (i--) {
> >  ...
> > }
> >
> > It's much better to read and understand.
>
> Well, about the readability it's a bit subjective . It depends who is
> reading the code. Just curious, how would you get better optimization
> by doing >=3D0 instead of > 0?

Feel the difference while (i--) vs. while (--i > 0).
The latter one is a bit unusual.

> Either way, I don=E2=80=99t have any strong feeling about this so I can d=
o as
> you suggest.



--=20
With Best Regards,
Andy Shevchenko
