Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D87136A7ED
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhDYPSC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 11:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhDYPSC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Apr 2021 11:18:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984B060FE6;
        Sun, 25 Apr 2021 15:17:20 +0000 (UTC)
Date:   Sun, 25 Apr 2021 16:18:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] iio:adc:ad7476: Handle the different regulators
 used by various parts.
Message-ID: <20210425161802.2627e4b8@jic23-huawei>
In-Reply-To: <3780b584-3a94-4fdd-f6d3-b8823a253de7@metafoo.de>
References: <20210424170346.526242-1-jic23@kernel.org>
        <20210424170346.526242-2-jic23@kernel.org>
        <3780b584-3a94-4fdd-f6d3-b8823a253de7@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Apr 2021 20:20:41 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/24/21 7:03 PM, Jonathan Cameron wrote:
> > [...]
> >   
> > +	/* Either vcc or vref (below) as appropriate */
> > +	if (!st->chip_info->int_vref_uv)
> > +		st->ref_reg = reg;
> > +
> > +	if (st->chip_info->has_vref) {
> > +
> > +		/* If a device has an internal reference vref is optional */
> > +		if (st->chip_info->int_vref_uv) {
> > +			reg = devm_regulator_get_optional(&spi->dev, "vref");
> > +		} else {
> > +			reg = devm_regulator_get(&spi->dev, "vref");
> > +			if (IS_ERR(reg))
> > +				return PTR_ERR(reg);
> > +		}
> > +
> > +		if (!IS_ERR(reg)) {
> > +			ret = regulator_enable(reg);
> > +			if (ret)
> > +				return ret;
> > +
> > +			ret = devm_add_action_or_reset(&spi->dev,
> > +						       ad7476_reg_disable,
> > +						       reg);
> > +			if (ret)
> > +				return ret;
> > +			st->ref_reg = reg;
> > +		} else {  
> We still need to check for errors, e.g. to support EPROBE_DEFER. The 
> only error that can be ignored is ENOENT, which means no regulator is 
> specified.
Good point.  I got fixated on all the different combinations and forgot the
simple 'error' case :)

V4 coming up.

Jonathan

> > +			/*
> > +			 * Can only get here if device supports both internal
> > +			 * and external reference, but the regulator connected
> > +			 * to the external reference is not connected.
> > +			 * Set the reference regulator pointer to NULL to
> > +			 * indicate this.
> > +			 */
> > +			st->ref_reg = NULL;
> > +		}
> > +	}  
> 

