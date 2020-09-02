Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB325AC0C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIBN2y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 09:28:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbgIBN2e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 09:28:34 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 2EAC270F14B6100C9EDC;
        Wed,  2 Sep 2020 14:28:29 +0100 (IST)
Received: from localhost (10.52.121.91) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Sep 2020
 14:28:28 +0100
Date:   Wed, 2 Sep 2020 14:26:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
Message-ID: <20200902142656.00007ad1@Huawei.com>
In-Reply-To: <CAHp75VeOQpR00AZhaw=Dy3sEArhSQAPHXb7mhJGB80uyrSZ3Qg@mail.gmail.com>
References: <20200827201707.27075-1-krzk@kernel.org>
        <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
        <20200829155410.6d34a8b9@archlinux>
        <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
        <DM6PR03MB441122FDB3323690166C21A0F92F0@DM6PR03MB4411.namprd03.prod.outlook.com>
        <CAHp75VeOQpR00AZhaw=Dy3sEArhSQAPHXb7mhJGB80uyrSZ3Qg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.91]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Sep 2020 10:49:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 2, 2020 at 8:56 AM Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> wrote:
> >
> > [yes, I know, bad-email format, but I wanted this to come from my work email]
> >
> > Apologies also for the delay here. Things pile-up on my side and I defer things a bit.
> >
> > Talked to Michael Hennerich about this [since he's the more senior contact at Analog].
> > We can replace the email from Beniamin Bia with Michael's.
> > Or, we can remove the "Orphan" blocks and just have the catch-all "drivers/iio/*/ad*" cover this driver and others that were upstreamed by Beniamin.
> >
> > Either option is fine from us.  
> 
> As a participant of activity to put MAINTAINERS in some order, I
> prefer to have similar blocks be squashed.
> If there will be a dedicated maintainer for a certain driver in the
> future, we can always split into separate sections.
> 
> So, something like
> ANALOG DEVICES ADC (I guess it makes sense to have some grouping still)
> ...
> F: .../ad1234
> F: .../ad2345
> 
> In one section (no need to have wildcards right now).
> 

ANALOG DEVICES INC IIO DRIVERS
M:	Lars-Peter Clausen <lars@metafoo.de>
M:	Michael Hennerich <Michael.Hennerich@analog.com>
S:	Supported
W:	http://wiki.analog.com/
W:	http://ez.analog.com/community/linux-device-drivers
F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
F:	drivers/iio/*/ad*
F:	drivers/iio/adc/ltc249*
F:	drivers/staging/iio/*/ad*
X:	drivers/iio/*/adjd*

Already exists.  We could potentially clean that up.

For the block that started this thread, we can just drop it.

Jonathan

