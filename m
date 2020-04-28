Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42481BC0B1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgD1OIY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 10:08:24 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:47039 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbgD1OIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 10:08:24 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.4.3])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 24867500160D;
        Tue, 28 Apr 2020 16:08:22 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 28 Apr
 2020 16:08:21 +0200
Date:   Tue, 28 Apr 2020 16:06:53 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
Message-ID: <20200428140653.GA10280@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-2-tomasz.duszynski@octakon.com>
 <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
 <20200424190413.GA2731@arch>
 <CAHp75Vdajf7Ci3ytxP7Qs9=fFaxvVBQoL5uh+HUDwxHS5r9MUg@mail.gmail.com>
 <20200425184130.GA37271@arch>
 <CAHp75Vez8wSaYHbXmvfXUS5N+vScQqHGg055DNKrEnCunP7awA@mail.gmail.com>
 <20200428075606.GB6908@arch>
 <CAHp75VdKqVvJg7T=42w1SzKSDbfWjYKMomgQBshiMAW=_e0y_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VdKqVvJg7T=42w1SzKSDbfWjYKMomgQBshiMAW=_e0y_w@mail.gmail.com>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 4095460913286765727
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedugdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 28, 2020 at 01:16:47PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2020 at 10:57 AM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > On Sat, Apr 25, 2020 at 09:52:25PM +0300, Andy Shevchenko wrote:
> > > On Sat, Apr 25, 2020 at 9:42 PM Tomasz Duszynski
> > > <tomasz.duszynski@octakon.com> wrote:
> > > > On Sat, Apr 25, 2020 at 02:43:35PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Apr 24, 2020 at 10:05 PM Tomasz Duszynski
> > > > > <tomasz.duszynski@octakon.com> wrote:
> > > > > > On Wed, Apr 22, 2020 at 10:49:44PM +0300, Andy Shevchenko wrote:
> > > > > > > On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> > > > > > > <tomasz.duszynski@octakon.com> wrote:
> > >
> > > ...
> > >
> > > > > > As for ABI that's in
> > > > > > a separate patch.
> > > > >
> > > > > It's not good from bisectability point of view. If by some reason this
> > > > > patch or documentation patch gets reverted, the other one will be
> > > > > dangling.
> > > > > Please, unify them.
> > > > >
> > > >
> > > > Huh? Reverting core and leaving leftovers would be wrong and pointless.
> > >
> > > Exactly my point why it should be one patch. To secure impossibility
> > > to do pointless reverts.
> > >
> >
> > But the same applies to other driver parts like i2c or serial
> > interfaces. I don't buy it.
>
> They won't compile without core driver, right? Absence of the
> documentation OTOH doesn't prevent build.
>

Fair enough.

>
> --
> With Best Regards,
> Andy Shevchenko
