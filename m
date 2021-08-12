Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824C93EAA1D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 20:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhHLSUR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 12 Aug 2021 14:20:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3645 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhHLSUR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 14:20:17 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Glw1q2PP7z6CBV9;
        Fri, 13 Aug 2021 02:19:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 12 Aug 2021 20:19:50 +0200
Received: from localhost (10.52.121.184) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 12 Aug
 2021 19:19:49 +0100
Date:   Thu, 12 Aug 2021 19:19:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
Message-ID: <20210812191919.00000217@Huawei.com>
In-Reply-To: <PH0PR03MB6366AC51BA01533E28001A3F99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811133220.190264-1-nuno.sa@analog.com>
        <20210811133220.190264-2-nuno.sa@analog.com>
        <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
        <PH0PR03MB6366AC51BA01533E28001A3F99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.184]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Aug 2021 06:54:13 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Wednesday, August 11, 2021 6:15 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Drew
> > Fustini <drew@pdp7.com>
> > Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
> > 
> > [External]
> > 
> > On Wed, Aug 11, 2021 at 4:32 PM Nuno Sá <nuno.sa@analog.com>
> > wrote:
> > 
> > Thanks for an update, my comments below.
> > Depending on Jonathan's wishes it may or may not require a v3.
> > If you address the minor issues I commented on, take mine
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >   
> 
> Thanks for reviewing... Yeah, I will wait for Jonathan's feedback before
> sending a v3. It might be that he can apply your inputs when applying
> the patch.

Patch looks sensible. I can make the tweaks whilst applying when I
happen to be on the right computer.

Having glanced at the datasheet, I wonder if you ever had the
reset pin wired up (and perhaps decided to drop that
complexity later)?  The driver rather oddly
include of_gpio.h and has no gpio accesses which makes me
wonder ;)

Jonathan

> 
> Thanks!
> - Nuno Sá

