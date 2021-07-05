Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566883BB956
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGEIeY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:34:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3354 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhGEIeX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:34:23 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJJTP1dRRz6H8Lx;
        Mon,  5 Jul 2021 16:17:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 10:31:45 +0200
Received: from localhost (10.47.85.51) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 09:31:45 +0100
Date:   Mon, 5 Jul 2021 09:31:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>, <robh+dt@kernel.org>,
        <lars@metafoo.de>, <sre@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <leonard.crestez@nxp.com>,
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <20210705093129.00005aab@Huawei.com>
In-Reply-To: <YOK2aKYU6TK1GO7H@dell>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-3-andreas@kemnade.info>
        <20210703170405.60828c57@jic23-huawei>
        <YOK2aKYU6TK1GO7H@dell>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.51]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Jul 2021 08:36:08 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Sat, 03 Jul 2021, Jonathan Cameron wrote:
> 
> > On Sat,  3 Jul 2021 10:42:22 +0200
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > This allows having devicetree nodes for the subdevices.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  drivers/mfd/rn5t618.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > > index 384acb459427..b916c7471ca3 100644
> > > --- a/drivers/mfd/rn5t618.c
> > > +++ b/drivers/mfd/rn5t618.c
> > > @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
> > >  };
> > >  
> > >  static const struct mfd_cell rc5t619_cells[] = {
> > > -	{ .name = "rn5t618-adc" },
> > > -	{ .name = "rn5t618-power" },
> > > +	{ .name = "rn5t618-adc",
> > > +	  .of_compatible = "ricoh,rc5t619-adc" },  
> > 
> > Odd to have a name of 618 and a compatible of 619.  Why?
> > Definitely deserves a comment if this is necessary for some reason!  
> 
> Actually this is the norm.  We have lots of drivers named after the
> *first* device they supported before expansion.

Ah. I'd missed that this cells array is specific to the 5t619, though if
the driver is the same I'd also expect it to be needed for the 5t618 entry.

> 
> > > +	{ .name = "rn5t618-power",
> > > +	  .of_compatible = "ricoh,rc5t619-power" },
> > >  	{ .name = "rn5t618-regulator" },
> > >  	{ .name = "rc5t619-rtc" },
> > >  	{ .name = "rn5t618-wdt" },  
> >   
> 

