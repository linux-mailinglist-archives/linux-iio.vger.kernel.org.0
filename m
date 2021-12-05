Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390E468C10
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhLEQR5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 11:17:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50808 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhLEQR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 11:17:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A8FFB80EC3
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:14:29 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 974BFC00446;
        Sun,  5 Dec 2021 16:14:25 +0000 (UTC)
Date:   Sun, 5 Dec 2021 16:19:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v2 08/12] iio:adc:mcp3911: Switch to generic firmware
 properties.
Message-ID: <20211205161930.2835fc56@jic23-huawei>
In-Reply-To: <CAHp75VfBYXchpvfpXrHoButYFZ8Hy1h9XPYu=Qyo8vZy2SKhqw@mail.gmail.com>
References: <20211204171237.2769210-1-jic23@kernel.org>
        <20211204171237.2769210-9-jic23@kernel.org>
        <CAHp75VfBYXchpvfpXrHoButYFZ8Hy1h9XPYu=Qyo8vZy2SKhqw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Dec 2021 17:07:37 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This allows use of the driver with other types of firmware such as ACPI
> > PRP0001 based probing.
> >
> > Also part of a general attempt to remove direct use of of_ specific
> > accessors from IIO.
> >
> > Added an include for mod_devicetable.h whilst here to cover the
> > struct of_device_id definition.  
> 
> ...
> 
> > -static int mcp3911_config(struct mcp3911 *adc, struct device_node *of_node)
> > +static int mcp3911_config(struct mcp3911 *adc, struct device *dev)  
> 
> I am wondering if the device pointer is already embedded in the mpc3911.
> It might require assignment reordering in the ->probe(). though
> (haven't checked).
> 
Good point. adc->spi->dev is available and is the same pointer so might as well use
that to keep things a little more tidy.

Thanks,

Jonathan


