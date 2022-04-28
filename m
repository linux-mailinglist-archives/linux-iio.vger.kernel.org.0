Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C99B513B7A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350651AbiD1S0J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351009AbiD1S0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 14:26:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567EB7C6A;
        Thu, 28 Apr 2022 11:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9679B82EF7;
        Thu, 28 Apr 2022 18:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84677C385A9;
        Thu, 28 Apr 2022 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651170167;
        bh=SK4cnaKCFvD7agMfaQTGJeSZhEoquGO61ZO3kbORHxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pUgCbZCylmk8RbiDwT/u819kC4N/Ex5M+2wMgFzBj3E7Fm8uZKIyYAWxI1D7zWGxs
         j8a2WoApFVJ64dah71+7HkYG8j8/fb7d7wCrXrhXsOCauMvaCOhAdadmHoXbF8yroS
         YKBNlu+IBf8m4D1MbwMleSIcHVuE8k/0IohXG6ASEpUscjNPNeV9z+dN5X23CI27Ny
         Pq8/gozbVAMKRrby0ACqseuJADsHZTK0ZSW+GEuoXa+HWdN2qxduL5Tzm5dWPItc14
         DzaLtzRZ5BAA32XUANMdheNRzoJWm2NJwEpsjdjQm5rXRTKwzAJ3+KMmb0LoeZYnOV
         6ELbCzIzLfC9w==
Date:   Thu, 28 Apr 2022 19:30:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     navin <navin@linumiz.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: temperature: max31865: Make use of device
 properties
Message-ID: <20220428193059.67fdbaff@jic23-huawei>
In-Reply-To: <80b6a194-53d7-bacc-23f9-7526f51b5463@linumiz.com>
References: <20220413185335.21743-1-andriy.shevchenko@linux.intel.com>
        <20220416114801.0865fcba@jic23-huawei>
        <80b6a194-53d7-bacc-23f9-7526f51b5463@linumiz.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Apr 2022 16:47:20 +0200
navin <navin@linumiz.com> wrote:

> On 16.04.22 12:48, Jonathan Cameron wrote:
> > On Wed, 13 Apr 2022 21:53:35 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  
> >> Convert the module to be property provider agnostic and allow
> >> it to be used on non-OF platforms.  
> > This one should call out the addition of missing mod_devicetable.h
> > If nothing else comes up I can add that whilst applying.
> > Looks fine to me but I'd like to give a little time for
> > Navin to comment if they wish.
> >
> > Jonathan  
> 
> Looks fine for me. Thanks

Thanks,

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at it.

Thanks,

Jonathan

> 
> Navin
> 
> >  
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >>   drivers/iio/temperature/max31865.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
> >> index 86c3f3509a26..e3bb78184c6e 100644
> >> --- a/drivers/iio/temperature/max31865.c
> >> +++ b/drivers/iio/temperature/max31865.c
> >> @@ -12,9 +12,11 @@
> >>   #include <linux/delay.h>
> >>   #include <linux/err.h>
> >>   #include <linux/init.h>
> >> +#include <linux/mod_devicetable.h>
> >>   #include <linux/module.h>
> >>   #include <linux/iio/iio.h>
> >>   #include <linux/iio/sysfs.h>
> >> +#include <linux/property.h>
> >>   #include <linux/spi/spi.h>
> >>   #include <asm/unaligned.h>
> >>   
> >> @@ -305,7 +307,7 @@ static int max31865_probe(struct spi_device *spi)
> >>   	indio_dev->channels = max31865_channels;
> >>   	indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
> >>   
> >> -	if (of_property_read_bool(spi->dev.of_node, "maxim,3-wire")) {
> >> +	if (device_property_read_bool(&spi->dev, "maxim,3-wire")) {
> >>   		/* select 3 wire */
> >>   		data->three_wire = 1;
> >>   	} else {  

