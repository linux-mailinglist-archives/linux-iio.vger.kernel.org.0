Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415D01B60BA
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgDWQZL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 12:25:11 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:47439 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729422AbgDWQZL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 12:25:11 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.16.61])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 39DD75A9F339;
        Thu, 23 Apr 2020 18:25:09 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Apr
 2020 18:25:09 +0200
Date:   Thu, 23 Apr 2020 18:23:46 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/6] iio: chemical: scd30: add serial interface driver
Message-ID: <20200423162346.GD43448@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-4-tomasz.duszynski@octakon.com>
 <CAHp75VeXd7hgdZ-1FDCpyad7_rHV1ERiigctn-6AYvVhLyX5QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VeXd7hgdZ-1FDCpyad7_rHV1ERiigctn-6AYvVhLyX5QA@mail.gmail.com>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 13935544623297223839
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 10:55:05PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > Add serial interface driver for the SCD30 sensor.
>
> ...
>
> > +#include <linux/of_irq.h>
>
> Do you need this?
>
> > +static int scd30_serdev_probe(struct serdev_device *serdev)
> > +{
> > +       struct device *dev = &serdev->dev;
> > +       struct scd30_serdev_priv *priv;
> > +       int irq, ret;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
>
> > +       irq = of_irq_get(dev->of_node, 0);
>
> fwnode_irq_get() ?

Okay, that should work equally good.

>
> > +       if (irq <= 0)
> > +               irq = 0;
> > +
> > +       return scd30_probe(dev, irq, KBUILD_MODNAME, priv,
> > +                          scd30_serdev_command);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
