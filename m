Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0321B602D
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgDWQCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 12:02:39 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:55505 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729556AbgDWQCi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 12:02:38 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.16.2])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 92B435A9E7E8;
        Thu, 23 Apr 2020 18:02:35 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Apr
 2020 18:02:35 +0200
Date:   Thu, 23 Apr 2020 18:01:12 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6/6] MAINTAINERS: add myself as a SCD30 driver maintainer
Message-ID: <20200423160112.GC43448@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-7-tomasz.duszynski@octakon.com>
 <CAHp75VeQComzEs0JmOBAqtKQ5Ez79sRHmsMNHiU9X2zWfnrpew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VeQComzEs0JmOBAqtKQ5Ez79sRHmsMNHiU9X2zWfnrpew@mail.gmail.com>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 13554427507541040287
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 10:25:03PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 5:23 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > Add myself as a SCD30 driver maintainer.
>
> > +SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
> > +M:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > +S:     Maintained
> > +F:     drivers/iio/chemical/scd30.h
> > +F:     drivers/iio/chemical/scd30_core.c
> > +F:     drivers/iio/chemical/scd30_i2c.c
> > +F:     drivers/iio/chemical/scd30_serial.c
> > +F:     Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
>
> Broken order. Run
>   scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order
> to fix.

Indeed. That order argument seems to be some fairly recent addition. Thanks for
pointing this out.

>
> --
> With Best Regards,
> Andy Shevchenko
