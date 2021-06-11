Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A83A4805
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFKRox convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 11 Jun 2021 13:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFKRox (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:44:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6A7601FA;
        Fri, 11 Jun 2021 17:42:52 +0000 (UTC)
Date:   Fri, 11 Jun 2021 18:44:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/4] fix regmap, initialization of ltr559, endianness
 and mark structs as const
Message-ID: <20210611184447.1748f4c2@jic23-huawei>
In-Reply-To: <5d237fb56774540fc525109d8e850782@trvn.ru>
References: <20210610134619.2101372-1-mkl@pengutronix.de>
        <5d237fb56774540fc525109d8e850782@trvn.ru>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 00:20:35 +0500
Nikita Travkin <nikita@trvn.ru> wrote:

> Marc Kleine-Budde писал 10.06.2021 18:46:
> > Hello,
> > 
> > here are 3 bug-fixes (probably stable material) and 1 enhancement for
> > the ltr501 driver.
> > 
> > regards,
> > Marc
> > 
> > changes since v1:
> > - all: add Andy Shevchenko's Reviewed-by
> > - 3/4: move endianness conversion to the callee  
> 
> Hi,
> Tested this series on Wileyfox Swift (Longcheer L8150) with ltr559,
> it works nicely now, thank you!
> 
> Tested-by: Nikita Travkin <nikita@trvn.ru> # ltr559
> 

Nice.  All applied to the togreg branch of iio.git as we are rather late in the
cycle to go round trying to merge this fixes first then the final patch
+ it's been broken a while so what's a few more weeks?

Fixes all marked for stable.

I'll push the togreg branch out as testing first to let 0-day see if we
missed anything.

Thanks,

Jonathan
