Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C011D19E64F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgDDQB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 12:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgDDQB0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 12:01:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA61B206D4;
        Sat,  4 Apr 2020 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586016085;
        bh=prtMsfibgClHmFGAkRVGCyBjS6k4/Rt446TvN90lSCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VIrBT4eZ0UQhdJueNtPyYk/JTg3O55jSj8tXE1/W7MKZTNGK2gHrRi459tY/e3YG+
         bDH3/qnxgavUdBLX77n+z6E/aiKUuObSIai/uJIDtuBw+ZjgKniQAKD4zctTsbg+X6
         PUL/8EZGZZExHFz2OtGEmH5V194SCtnI2u2CvxQY=
Date:   Sat, 4 Apr 2020 17:01:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 5/6] iio: imu: Add support for adis16475
Message-ID: <20200404170120.43ff17e9@archlinux>
In-Reply-To: <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
        <20200331114811.7978-6-nuno.sa@analog.com>
        <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
        <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
        <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> 
> > > > +#define ADIS16475_GYRO_CHANNEL(_mod) \
> > > > +       ADIS16475_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> > > > +       ADIS16475_REG_ ## _mod ## _GYRO_L, ADIS16475_SCAN_GYRO_ ##  
> > > _mod, 32, \  
> > > > +       32)  
> > >
> > > It's not obvious that this is macro inside macro. Can you indent better?
> > > Ditto for the rest similar ones.
> > >  
> >
> > Honestly here I don't see any problems with indentation and it goes in conformity with
> > other IMU drivers already in tree. So here, as long as anyone else has a problem with this, I prefer
> > to keep it this way...  
> 
> I'm not a maintainer, not my call :-)

I'm lazy when it comes to things like this.  Yes it could be better, but
it's still fairly readable so I don't really mind.

That's not to say I don't like beautiful things if you don't mind
tidying it up? :)

Jonathan

