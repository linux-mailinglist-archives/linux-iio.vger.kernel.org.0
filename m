Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB661EBCA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 08:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKGHWJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 02:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKGHWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 02:22:08 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09129EA
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 23:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1667805727;
  x=1699341727;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=IzfKSEWu4Y0k1DZ/4wrrb9jyMbhuXKqeYYieOjcIBN4=;
  b=LpVE93y8LqDJ6lDCj+XVZK5MTBlz2wbviHTy5I7K8bPKsLEg0+IbiB29
   8wNOYTKUU1P5+GzKuzWKNHEGi2/0LqPNzxHgGllN4hghjmN59S9ehEt+u
   N+MV96XyP3rBzQ+yBXDa3JNZ+IRtGb3d7jMe6bNqJSp/SeFJSpkSOQonc
   aJhNDaP9qJWwV0npEek6JFErNhXUmeCr5E/t401U4PM7TO4STPtMBEFUJ
   xrjmx8UFR7uKc71gyVDOTFQ2414S7qu9rRaQNlOVl7AeOHYkTpfSjgtj7
   eqhZ6HITNHlQl79cmO2U6iVEV28tSkYPklJ7dDCnSPUl/f4iRjX2gvEg/
   Q==;
Date:   Mon, 7 Nov 2022 08:22:05 +0100
To:     Jonathan Cameron <jic23@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Don't create sysfs PM nodes for
 child
Message-ID: <Y2iyHfNNHmoiCcqJ@axis.com>
References: <20221101122151.221029-1-marten.lindahl@axis.com>
 <20221106152307.4bfb4e49@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221106152307.4bfb4e49@jic23-huawei>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 06, 2022 at 04:23:07PM +0100, Jonathan Cameron wrote:
> On Tue, 1 Nov 2022 13:21:51 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
> 
> > PM runtime is enabled for the parent i2c device, but it is disabled for
> > the iio child device and remains so in this driver. But as the child
> > sysfs PM directory is created by default by iio_device_register =>
> > cdev_device_add => dpm_sysfs_add it doesn't bring any value exposing it
> > since it won't give any usable data for the user.
> > 
> > Tell dpm_sysfs to not create the PM directory for the iio device.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 
> Ah this one..  +CC Sudeep who I am sure has considered such changes in other
> similar cases (he did the original ones that mean this infastructure exists).
> 
> So, the problem here is that it drops an ABI that has existed in IIO for
> a long time. I fully admit the ABI is confusing and pointless.  What
> I'm not sure on is that we are entirely safe to remove it.
> 
> If we are going to do this, it shouldn't be on a per driver basis, but rather
> a global change for all IIO drivers with the proviso that we are relying on
> the 'if no one notices an ABI change, it is fine' exception to never changing
> userspace ABI.
> 
> Until now this has more or less only been used for new subsystems or where
> there were warnings generated due to spurious interface usage in normal flows.
> 
> In IIO, nothing should touch these and I 'think' they don't do anything if
> anyone pokes them.
> 
> Jonathan

Hi Jonathan!

Thanks. I'll drop this change then.

Kind regards
Mårten
> 
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index f6c83ecaad8b..400dc1155559 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -1072,6 +1072,7 @@ static int vcnl4000_probe(struct i2c_client *client,
> >  	if (ret < 0)
> >  		goto fail_poweroff;
> >  
> > +	device_set_pm_not_required(&indio_dev->dev);
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0)
> >  		goto fail_poweroff;
> 
