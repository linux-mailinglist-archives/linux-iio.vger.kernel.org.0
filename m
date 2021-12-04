Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907CF468654
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355352AbhLDQud (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 11:50:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44472 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhLDQuc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 11:50:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64FCAB80D13
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 16:47:06 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B6C341C0;
        Sat,  4 Dec 2021 16:47:03 +0000 (UTC)
Date:   Sat, 4 Dec 2021 16:52:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/12] iio:dac:ad5755: Switch to generic firmware
 properties.
Message-ID: <20211204165212.08416837@jic23-huawei>
In-Reply-To: <2f6dad36-45d6-9acd-ff1d-edf925f99b88@metafoo.de>
References: <20211128192635.2724359-1-jic23@kernel.org>
        <20211128192635.2724359-2-jic23@kernel.org>
        <2f6dad36-45d6-9acd-ff1d-edf925f99b88@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Nov 2021 20:40:33 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 11/28/21 8:26 PM, Jonathan Cameron wrote:
> >   static int ad5755_probe(struct spi_device *spi)
> >   {
> > @@ -751,8 +736,8 @@ static int ad5755_probe(struct spi_device *spi)
> >   
> >   	mutex_init(&st->lock);
> >   
> > -	if (spi->dev.of_node)
> > -		pdata = ad5755_parse_dt(&spi->dev);
> > +	if (dev_fwnode(&spi->dev))
> > +		pdata = ad5755_parse_fw(&spi->dev);
> >   	else
> >   		pdata = spi->dev.platform_data;  
> Considering that it is possible to supply fw_node data through platform 
> files we as well just completely drop platform_data support. And make 
> the platform data struct local to this file.
> 
Good point.  I'm in two minds about whether there is any advantage in
leaving the enum definitions in the platform_data header.

They aren't used in the dt binding (which includes an unrelated header - I'll
fix that as well..), so I'm not sure what the logic of exposing them for other
firmware bindings would be...

I'll squash them directly into the c file for now and we can always put them
back in a header if it turns out someone needs them later.

Jonathan

