Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD92799E85
	for <lists+linux-iio@lfdr.de>; Sun, 10 Sep 2023 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjIJNrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Sep 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjIJNrb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Sep 2023 09:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE9CC5
        for <linux-iio@vger.kernel.org>; Sun, 10 Sep 2023 06:47:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9901C433C7;
        Sun, 10 Sep 2023 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694353646;
        bh=xFc4tO+T8I5KDmtRoBbTvXnC4jdRMSmNcOjHlNHPn/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XPK6d6QtLpOLsz3vtaqMr99VAfkYYc4WCq3szEVEmQ9j3jkbO3ZaHQsh+RaZB9w33
         E00i7wZANqYHKr1XcfiysASkReMFrrZT1oSFWVcPvR/uCSyVlezWMNcCED0w7LRxiu
         yDjmaN8HQndmIERe7XqT0NIy8VDYkDa+4m8E4vjHDvEmVBvvGwpeVB5MFrPhcH9Vmn
         bmd/jVLwUh+t8qMNblvotV4XBK/oTjsw0SYl1PbN5pdMvUBN0yZ2SYVHhLvSpvuVrX
         IUXJ8359eLKffB/MEco9Tp+g5C4Oj7iqEXy9USKIdDlTGHYRJR9Bj2h1/evLo5kPrX
         cUClD28/LYwZA==
Date:   Sun, 10 Sep 2023 14:47:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH] iio: imu: bno055: Fix missing Kconfig dependencies
Message-ID: <20230910144720.4d5a110c@jic23-huawei>
In-Reply-To: <589ab021-4dca-4547-3b5f-d2d9a9210cbb@infradead.org>
References: <20230903113052.846298-1-jic23@kernel.org>
        <589ab021-4dca-4547-3b5f-d2d9a9210cbb@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 Sep 2023 08:27:36 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 9/3/23 04:30, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This driver uses IIO triggered buffers so it needs to select them in
> > Kconfig.
> > 
> > on riscv-32bit:
> > 
> > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/iio/imu/bno055/bno055.o: in function `.L367':
> > bno055.c:(.text+0x2c96): undefined reference to `devm_iio_triggered_buffer_setup_ext'
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Closes: https://lore.kernel.org/linux-next/40566b4b-3950-81fe-ff14-871d8c447627@infradead.org/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Andrea Merello <andrea.merello@iit.it>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
Applied to the fixes togreg branch of iio.git and marked for stable.
I added missing fixes tag as well whilst doing so.  Goes all the way back
to first introduction of the driver.

Thanks,

Jonathan

> 
> Thanks.
> 
> > ---
> >  drivers/iio/imu/bno055/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> > index fa79b1ac4f85..83e53acfbe88 100644
> > --- a/drivers/iio/imu/bno055/Kconfig
> > +++ b/drivers/iio/imu/bno055/Kconfig
> > @@ -2,6 +2,8 @@
> >  
> >  config BOSCH_BNO055
> >  	tristate
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  
> >  config BOSCH_BNO055_SERIAL
> >  	tristate "Bosch BNO055 attached via UART"  
> 

