Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279AA3E5534
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 10:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhHJIay convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 10 Aug 2021 04:30:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30040 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238177AbhHJIay (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 04:30:54 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-227-5M0oF5-pMm2WfYqgjlKDBQ-1; Tue, 10 Aug 2021 09:30:27 +0100
X-MC-Unique: 5M0oF5-pMm2WfYqgjlKDBQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 10 Aug 2021 09:30:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 10 Aug 2021 09:30:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, Len Baker <len.baker@gmx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Thread-Topic: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Thread-Index: AQHXjQAF/V94Z2zj4EedKEnvL+aRB6tsZ9qw
Date:   Tue, 10 Aug 2021 08:30:26 +0000
Message-ID: <9b509d0fd5c4459985aac9b35abe462b@AcuMS.aculab.com>
References: <20210807152225.9403-1-len.baker@gmx.com>
        <20210808172503.5187cd24@jic23-huawei>
        <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
 <20210809102131.000021eb@Huawei.com>
In-Reply-To: <20210809102131.000021eb@Huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron
> Sent: 09 August 2021 10:22
> 
> On Sun, 8 Aug 2021 22:00:34 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sun, Aug 8, 2021 at 7:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Sat,  7 Aug 2021 17:22:25 +0200
> > > Len Baker <len.baker@gmx.com> wrote:
> > >
> > > > strcpy() performs no bounds checking on the destination buffer. This
> > > > could result in linear overflows beyond the end of the buffer, leading
> > > > to all kinds of misbehaviors. The safe replacement is strscpy().
> > > >
> > > > This patch is an effort to clean up the proliferation of str*()
> > > > functions in the kernel and a previous step in the path to remove
> > > > the strcpy function from the kernel entirely [1].
> > > >
> > > > [1] https://github.com/KSPP/linux/issues/88
> > > >
> > > > Signed-off-by: Len Baker <len.baker@gmx.com>
> > > Applied to the togreg branch of iio.git and pushed out as testing
> > > so 0-day can poke at it and see if we missed anything.
> >
> > Isn't it too early? Or am I missing something (see below)?
> >
> > ...
> >
> > > >                       /* use length + 2 for adding minus sign if needed */
> > > > -                     str = devm_kzalloc(regmap_get_device(st->map),
> > > > -                                        strlen(orient) + 2, GFP_KERNEL);
> > > > +                     n = strlen(orient) + 2;
> > > > +                     str = devm_kzalloc(regmap_get_device(st->map), n,
> > > > +                                        GFP_KERNEL);
> > > >                       if (str == NULL)
> > > >                               return -ENOMEM;
> > > >                       if (strcmp(orient, "0") == 0) {
> > > > -                             strcpy(str, orient);
> > > > +                             strscpy(str, orient, n);
> > > >                       } else if (orient[0] == '-') {
> > > > -                             strcpy(str, &orient[1]);
> > > > +                             strscpy(str, &orient[1], n);
> > > >                       } else {
> > > >                               str[0] = '-';
> > > > -                             strcpy(&str[1], orient);
> > > > +                             strscpy(&str[1], orient, n - 1);
> >
> > Why n-1?
> 
> n is the total length and this is printing from [1], so n - 1 is remaining
> space.

If you do:
	/* negate 'orient' */
	n = strlen(orient) + 1;
	str = malloc(n + 1);
	if (n == 2 && orient[0] == '0')
		memcpy(str, orient, n);
	else if (orient[0] == '-')
		memcpy(str, orient + 1, n - 1);
	else {
		str[0] = '-';
		memcpy(str + 1, orient, n);
	}
Then it is probably less confusing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

