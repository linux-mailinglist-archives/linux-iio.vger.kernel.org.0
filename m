Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629201C2CFF
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgECOVQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 3 May 2020 10:21:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49341 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728277AbgECOVQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 10:21:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-195-H0ScGf_APEKaLWptspzlKw-1; Sun, 03 May 2020 15:21:12 +0100
X-MC-Unique: H0ScGf_APEKaLWptspzlKw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 3 May 2020 15:21:11 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 3 May 2020 15:21:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jonathan Cameron' <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     "kamel.bouhara@bootlin.com" <kamel.bouhara@bootlin.com>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "david@lechnology.com" <david@lechnology.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "fabien.lahoudere@collabora.com" <fabien.lahoudere@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "syednwaris@gmail.com" <syednwaris@gmail.com>,
        "patrick.havelange@essensium.com" <patrick.havelange@essensium.com>,
        "fabrice.gasnier@st.com" <fabrice.gasnier@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: RE: [PATCH 0/4] Introduce the Counter character device interface
Thread-Topic: [PATCH 0/4] Introduce the Counter character device interface
Thread-Index: AQHWIVUDUyU0PU/R2k6dJAMe78u4OaiWaHyQ
Date:   Sun, 3 May 2020 14:21:11 +0000
Message-ID: <b2d51e3f9dfb4dd78156b2e945607e8d@AcuMS.aculab.com>
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
 <20200503151314.2ac1fc2e@archlinux>
In-Reply-To: <20200503151314.2ac1fc2e@archlinux>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron
> Sent: 03 May 2020 15:13
...
> > The following are some questions I have about this patchset:
> >
> > 1. Should enums be used to represent standard counter component states
> >    (e.g. COUNTER_SIGNAL_LOW), or would these be better defined as int?
> >
> >    These standard counter component states are defined in the
> >    counter-types.h file and serve as constants used by counter device
> >    drivers and Counter subsystem components in order to ensure a
> >    consistent interface.
> >
> >    My concern is whether enum constants will cause problems when passed
> >    to userspace via the Counter character device ioctl calls. Along the
> >    same lines is whether the C bool datatype is safe to pass as well,
> >    given that it is a more modern C datatype.
> 
> For enums, I'd pass them as integers.
> 
> Bool is probably fine either way.

Always use fixed size types in any API structures.
Ensure that fields are always on their natural boundaries.

So no enums and no bools.
It may even be worth using uint64_t for any userspace pointers.

At some point you'll live to regret anything else.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

