Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AAE3A4872
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFKSOk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 11 Jun 2021 14:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhFKSOk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 14:14:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1FD613D2;
        Fri, 11 Jun 2021 18:12:40 +0000 (UTC)
Date:   Fri, 11 Jun 2021 19:14:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: accel: bma180: Fix BMA25x bandwidth register
 values
Message-ID: <20210611191433.34f04b9e@jic23-huawei>
In-Reply-To: <20210603181208.6fd7b6a3@jic23-huawei>
References: <20210526094408.34298-1-stephan@gerhold.net>
 <20210526094408.34298-2-stephan@gerhold.net>
 <CACRpkdZweO5kCdSky8Nc+QmKWRuGLKX4QEct5LmH4RTPirRLhg@mail.gmail.com>
 <20210603181208.6fd7b6a3@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Jun 2021 18:12:08 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 26 May 2021 14:12:02 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Wed, May 26, 2021 at 11:44 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> >   
> > > According to the BMA253 datasheet [1] and BMA250 datasheet [2] the
> > > bandwidth value for BMA25x should be set as 01xxx:
> > >
> > >   "Settings 00xxx result in a bandwidth of 7.81 Hz; [...]
> > >    It is recommended [...] to use the range from ´01000b´ to ´01111b´
> > >    only in order to be compatible with future products."
> > >
> > > However, at the moment the drivers sets bandwidth values from 0 to 6,
> > > which is not recommended and always results into 7.81 Hz bandwidth
> > > according to the datasheet.
> > >
> > > Fix this by introducing a bw_offset = 8 = 01000b for BMA25x,
> > > so the additional bit is always set for BMA25x.
> > >
> > > [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma253-ds000.pdf
> > > [2]: https://datasheet.octopart.com/BMA250-Bosch-datasheet-15540103.pdf
> > >
> > > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Fixes: 2017cff24cc0 ("iio:bma180: Add BMA250 chip support")
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>    
> > 
> > Good catch!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
> I think I can probably get away with picking up patch 2 into the togreg branch
> without anything blowing up during the merge.

Change of plan here given dependency on this of another set and how late in
the cycle we are. I've dragged this across from the fixes-togreg branch to the
togreg branch lining it up for the next merge window.


> 
> Thanks,
> 
> Jonathan
> 
> >   
> > > After spending some more time with the driver I noticed that BMA253/BMA254
> > > would actually be better supported by the bmc150-accel driver (which
> > > doesn't have this problem and also supports the motion trigger/interrupt).
> > >
> > > I'm preparing a separate patch set to move BMA254 to bmc150-accel at least,
> > > but I'm not sure about BMA250 so this patch is relevant anyway. And I had
> > > it almost done already, so I thought it's better to send it. :)    
> > 
> > I looked at the preliminary patches and this looks really good
> > too.
> > 
> > Yours,
> > Linus Walleij  
> 

