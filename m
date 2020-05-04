Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F1E1C35EB
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 11:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEDJlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 05:41:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbgEDJlK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 May 2020 05:41:10 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 015F3B768F29FFD504CC;
        Mon,  4 May 2020 10:41:08 +0100 (IST)
Received: from localhost (10.47.88.153) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:41:07 +0100
Date:   Mon, 4 May 2020 10:40:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 10/11] iio: light: cm32181: Add support for parsing
 CPM0 and CPM1 ACPI tables
Message-ID: <20200504104048.00003f35@Huawei.com>
In-Reply-To: <CAHp75Vdt+shL3yXHfct17DUHdRBBrCzC4vBjQL8YHbimFefV7A@mail.gmail.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
        <20200428172923.567806-10-hdegoede@redhat.com>
        <20200503122237.4af34181@archlinux>
        <CAHp75Vdt+shL3yXHfct17DUHdRBBrCzC4vBjQL8YHbimFefV7A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.153]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 May 2020 19:25:20 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, May 3, 2020 at 2:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 28 Apr 2020 19:29:22 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:  
> 
> ...
> 
> > > This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
> > > Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181).  
> >
> > I assume it's far too much to hope this CPM0 / CPM1 stuff is actually defined
> > in a spec anywhere?
> >
> > There are standard way of adding vendor specific data blobs to ACPI and this
> > isn't one of them (unless I'm missing something).  People need to beat
> > up vendors earlier about this stuff.
> >
> > Grumble over...
> >
> > Code looks fine to me, but I'd like an ACPI review ideally.  
> 
> ACPI didn't cover embedded world and has the following issues
> a) where it should be strict (like how many I2CSerialBus() resources
> can be given and for what type of devices, etc), it doesn't
> b) they need to provides better validation tools, but they didn't
> c) it's still windows oriented :-(
> 
> Above is custom extension on how to add device properties (and note,
> we have now _DSD() and still we have some M$ way of thinking how to
> use them).
> 
> Since the above approach is in the wild, I'm afraid we have not many
> possibilities here (each of them with own problems):
> 1/ shout at vendors to use ACPI properly and simple don't by broken
> hardware (rather firmware)
> 2/ try to support custom changes (may lead to several approaches for
> the same thing)
> 3/ create a lot of board files (something in between 1/ and 2/)
> 
> As a result:
> 1/ is obviously a best one, but I think it's an utopia.

Let's keep the "shout" bit where possible :)  Makes us feel better anyway.

> 2/ in practice we don't have many deviations (luckily OEMs are quite
> lazy to modify reference BIOSes and often reuse existing approaches)
> 3/ may not work, because on cheap laptops the means of distinguishing
> them (like DMI strings) may also been broken.
> 

The UEFI forum are finally making steps in the right direction on
how they develop their specs (sort of) so I guess interested companies
should rock up and see if they can get some of this stuff fixed.
(those that can attend meetings anyway - but that's a different issue).

Spec meetings are fun and everyone loves the EDK2 source code :)

J



