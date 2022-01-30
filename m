Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2904A36E7
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 15:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355174AbiA3Osa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 09:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355165AbiA3Osa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 09:48:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F309C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 06:48:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1346611F9
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 14:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA65AC340E4;
        Sun, 30 Jan 2022 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643554109;
        bh=AleTpGfOO6/DrQNlumuA2g9JIWClKgBLvqIRXh7tKKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DyBqPGIwZMvPLJE/jjBjrith5Lyfto+ywy+pe0wmYP9gkjwrLx5538ncisjFI3IXv
         A+wE+vW/0ykicFA2jcxyDiU2IhMA9U8EuQWlxLyl/23lStlJv7Fdp6oJ0T2wlgDZZ/
         r/QiUYYKh/0JF2k8LhoAnFVVIHJcl7FhwNoM0okUAgTWvaUzJC3P9cp3iEwEGo2SRz
         L1bwx2/itTw+vm+SkX/EwgLre/z3mt+cRbftmyDZFx66z+5r1RphnpZRfHEYJibsN4
         5eBxitUCU84bKAe8wz7eK0ISZlcxQEJJV13cL3LWPGleAIy7eyykadLwMiYIHlyLJB
         GMgP1PZCGHB6A==
Date:   Sun, 30 Jan 2022 14:54:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mma8452: Fix probe failing when an i2c_device_id
 is used
Message-ID: <20220130145454.41c216bf@jic23-huawei>
In-Reply-To: <25fd03a5-4b85-a112-1897-0a6d662aa88d@redhat.com>
References: <20220106111414.66421-1-hdegoede@redhat.com>
        <20220109151043.54d92a79@jic23-huawei>
        <25fd03a5-4b85-a112-1897-0a6d662aa88d@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Jan 2022 16:35:46 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 1/9/22 16:10, Jonathan Cameron wrote:
> > On Thu,  6 Jan 2022 12:14:14 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> The mma8452_driver declares both of_match_table and i2c_driver.id_table
> >> match-tables, but its probe() function only checked for of matches.
> >>
> >> Add support for i2c_device_id matches. This fixes the driver not loading
> >> on some x86 tablets (e.g. the Nextbook Ares 8) where the i2c_client is
> >> instantiated by platform code using an i2c_device_id.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> > Hi Hans,
> > 
> > At some point we'll want to get rid of the of_ specific stuff in here in
> > favour of generic firmware properties and I suspect at that time we'll
> > move the device name into the chip_info_table[] entries so that we
> > can just use device_get_match_data()
> > 
> > In the meantime this fix looks good to me.  Is there an appropriate
> > Fixes: tag?  
> 
> I did a quick dive in the git history and the of_match_device() ||
> return -ENODEV behavior was introduced in:
> 
> c3cdd6e48e35 ("iio: mma8452: refactor for seperating chip specific data")
Applied to the fixes-togreg branch of iio.git with that as the fixes tag.

Hmm. Sending "Fixes: tag?" was a  bad idea on my part as b4 picked it up as
a fixes tag. Good think I was editing it anyway or I might not have noticed.

Thanks,

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> >> ---
> >>  drivers/iio/accel/mma8452.c | 23 +++++++++++++++--------
> >>  1 file changed, 15 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> index 09c7f10fefb6..c82841c0a7b3 100644
> >> --- a/drivers/iio/accel/mma8452.c
> >> +++ b/drivers/iio/accel/mma8452.c
> >> @@ -1523,12 +1523,7 @@ static int mma8452_probe(struct i2c_client *client,
> >>  	struct iio_dev *indio_dev;
> >>  	int ret;
> >>  	const struct of_device_id *match;
> >> -
> >> -	match = of_match_device(mma8452_dt_ids, &client->dev);
> >> -	if (!match) {
> >> -		dev_err(&client->dev, "unknown device model\n");
> >> -		return -ENODEV;
> >> -	}
> >> +	const char *compatible;
> >>  
> >>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >>  	if (!indio_dev)
> >> @@ -1537,7 +1532,19 @@ static int mma8452_probe(struct i2c_client *client,
> >>  	data = iio_priv(indio_dev);
> >>  	data->client = client;
> >>  	mutex_init(&data->lock);
> >> -	data->chip_info = match->data;
> >> +
> >> +	if (id) {
> >> +		compatible = id->name;
> >> +		data->chip_info = &mma_chip_info_table[id->driver_data];
> >> +	} else {
> >> +		match = of_match_device(mma8452_dt_ids, &client->dev);
> >> +		if (!match) {
> >> +			dev_err(&client->dev, "unknown device model\n");
> >> +			return -ENODEV;
> >> +		}
> >> +		compatible = match->compatible;
> >> +		data->chip_info = match->data;
> >> +	}
> >>  
> >>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> >>  	if (IS_ERR(data->vdd_reg))
> >> @@ -1581,7 +1588,7 @@ static int mma8452_probe(struct i2c_client *client,
> >>  	}
> >>  
> >>  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
> >> -		 match->compatible, data->chip_info->chip_id);
> >> +		 compatible, data->chip_info->chip_id);
> >>  
> >>  	i2c_set_clientdata(client, indio_dev);
> >>  	indio_dev->info = &mma8452_info;  
> >   
> 

