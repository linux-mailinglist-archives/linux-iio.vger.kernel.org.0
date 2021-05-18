Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D0387F29
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbhERSCE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 14:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344188AbhERSCE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 14:02:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA89A611B0;
        Tue, 18 May 2021 18:00:43 +0000 (UTC)
Date:   Tue, 18 May 2021 19:02:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: afe: iio-rescale: Support processed channels
Message-ID: <20210518190201.26657c49@jic23-huawei>
In-Reply-To: <b98b4f4f-31e2-7289-99c3-71f5b15305f8@axentia.se>
References: <20210518092741.403080-1-linus.walleij@linaro.org>
        <b98b4f4f-31e2-7289-99c3-71f5b15305f8@axentia.se>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 12:00:10 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> Thanks, this looks nice!
> 
> On 2021-05-18 11:27, Linus Walleij wrote:
> > It happens that an ADC will only provide raw or processed
> > voltage conversion channels. (adc/ab8500-gpadc.c).
> > On the Samsung GT-I9070 this is used for a light sensor
> > and current sense amplifier so we need to think of something.
> > 
> > The idea is to allow processed channels and scale them
> > with 1/1 and then the rescaler can modify the result
> > on top.
> > 
> > Link: https://lore.kernel.org/linux-iio/20201101232211.1194304-1-linus.walleij@linaro.org/
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> Reviewed-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it.

Thanks,

Jonathan

> 
> Cheers,
> Peter

