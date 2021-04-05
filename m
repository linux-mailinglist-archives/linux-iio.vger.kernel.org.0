Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E78354403
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhDEQCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 12:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237930AbhDEQCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 12:02:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115F9613A3;
        Mon,  5 Apr 2021 16:02:13 +0000 (UTC)
Date:   Mon, 5 Apr 2021 17:02:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] iio:adc:ad7476: Handle the different regulators
 used by various parts.
Message-ID: <20210405170228.02b4dd69@jic23-huawei>
In-Reply-To: <45bfed22-1864-eb3a-f370-c6a38a9de414@metafoo.de>
References: <20210401171759.318140-1-jic23@kernel.org>
        <20210401171759.318140-3-jic23@kernel.org>
        <45bfed22-1864-eb3a-f370-c6a38a9de414@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 10:35:17 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/1/21 7:17 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Not all of the parts supported by this driver use single supply.
> > Hence we add chip_info fields to say what additional supplies exist
> > and in the case of vref, ensure that is used for the reference voltage
> > rather than vcc.
> >
> > Tested using really simple QEMU model and some fixed regulators.
> >
> > The devm_add_action_or_reset() callback is changed to take the
> > regulator as it's parameter so we can use one callback for all the
> > different regulators without having to store pointers to them in
> > the iio_priv() structure.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Michael Hennerich <michael.hennerich@analog.com>  
> 
> Looks good.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> There is one special case that is currently not handled. The AD7091R can 
> either use its internal reference, or an external reference.
> 
> At the moment the driver sets neither has_vref nor int_vref_uv.

Ah. I'd missed that one.  Let's fix that whilst we are here.
Enough stuff will change in V2 that I'll not keep that Reviewed-by tag.

Thanks,

Jonathan


