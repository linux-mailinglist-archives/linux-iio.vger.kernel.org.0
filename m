Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD83278A25
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfG2LIR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 29 Jul 2019 07:08:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387457AbfG2LIQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 07:08:16 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9A9B49CBBCFC5F6072D;
        Mon, 29 Jul 2019 19:08:14 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 19:08:11 +0800
Date:   Mon, 29 Jul 2019 12:08:02 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Brian Masney <masneyb@onstation.org>
CC:     Chuhong Yuan <hslester96@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
Message-ID: <20190729120802.000025e8@huawei.com>
In-Reply-To: <20190729080307.GA360@onstation.org>
References: <20190726123058.22915-1-hslester96@gmail.com>
        <20190727125749.63297c28@archlinux>
        <20190728083141.GA14194@onstation.org>
        <CANhBUQ3QiV1mPD6p+AROv6YnK+1CB5voVAHKbmzueUWc7P6vcQ@mail.gmail.com>
        <20190729080307.GA360@onstation.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jul 2019 04:03:07 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Mon, Jul 29, 2019 at 11:03:00AM +0800, Chuhong Yuan wrote:
> > Brian Masney <masneyb@onstation.org> 于2019年7月28日周日 下午4:31写道：  
> > > devm_add_action() could be used in the probe function to schedule the call
> > > to tsl2772_chip_off(). That would eliminate the need for
> > > tsl2772_remove(). See tsl2772_disable_regulators_action() for an example in
> > > that driver.
> > >  
> > 
> > I find that we can use devm_add_action_or_reset() for
> > tsl2772_disable_regulators_action() to eliminate the fault handling code.
> > 
> > I am not sure whether devm_add_action() can be used for
> > tsl2772_chip_off() because it returns an integer, not void.
> > And the return value is used in several functions.  
> 
> I would add a wrapper function (tsl2772_chip_off_action?) with the
> expected declaration that calls tsl2772_chip_off().
> 
> > > Chuhong: Another potential cleanup to shrink the size of this driver is
> > > to move it over to the regulator_bulk_() API. I didn't realize that API
> > > existed at the time I introduced the regulator support. If you're
> > > interested in taking on that cleanup as well, I can test those changes
> > > for you if you don't have the hardware.
> > >
> > > Brian
> > >  
> > 
> > Does that mean merging vdd_supply and vddio_supply to an array of
> > regulator_bulk_data and utilize regulator_bulk_() API to operate them
> > together?  
> 
> Yes.
> 
> > I have an additional question that I find regulator_disable() is used in the
> > end of many .remove functions of drivers, which hinders us to use devm
> > functions.
> > One example is drivers/iio/light/gp2ap020a00f.c.
> > Is there any solution to this problem?  
> 
> There are devm_regulator_*() variants of the regulator API available
> that you can use. Lots of other APIs in the kernel have devm variants
> to simply drivers.
I don't think there are any devm_ versions of regulator disable.

IIRC the argument made when this last came up was that it was rarely correct
to be as course grained as a lot of IIO drivers are.   We should probably
do runtime pm and turn these regulators off a lot more frequently.

The reality is that it is an optimization that doesn't get done in 
IIO drivers that often as we mostly just want them to work and many
usecases aren't actually power constrained,

So we end up doing a lot of devm_add_action_or_reset to power down the
regulators.

Jonathan
> 
> Brian


