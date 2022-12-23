Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79733655292
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiLWQOH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 11:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLWQOH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 11:14:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EFA1CFFC
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 08:14:06 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p8kgJ-0001pp-RM; Fri, 23 Dec 2022 17:13:59 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p8kgJ-00080q-FP; Fri, 23 Dec 2022 17:13:59 +0100
Date:   Fri, 23 Dec 2022 17:13:59 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <20221223161359.wla6l5kd5gddloid@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
 <20221221092801.1977499-4-m.felsch@pengutronix.de>
 <20221223151056.4f7d4b7e@jic23-huawei>
 <20221223150728.34d5agqr4ruixjbu@pengutronix.de>
 <20221223153929.3fbad6b2@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223153929.3fbad6b2@jic23-huawei>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22-12-23, Jonathan Cameron wrote:

...

> > > > @@ -118,27 +127,28 @@ static int tmp117_identify(struct i2c_client *client)
> > > >  	int dev_id;
> > > >  
> > > >  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
> > > > -	if (dev_id < 0)  
> > > 
> > > Keep this handling of the smbus read returning an error.
> > > Otherwise, you end up replacing the error code with -ENODEV rather than
> > > returning what actually happened.
> > > 
> > > 	if (dev_id < 0)
> > > 		return dev_id;  
> > 
> > You're right, I will change this thanks.
> > 
> > > 	switch (dev_id) {
> > > ...
> > >   
> > > > +	switch (dev_id) {
> > > > +	case TMP116_DEVICE_ID:
> > > > +	case TMP117_DEVICE_ID:
> > > >  		return dev_id;
> > > > -	if (dev_id != TMP117_DEVICE_ID) {
> > > > -		dev_err(&client->dev, "TMP117 not found\n");
> > > > +	default:
> > > > +		dev_err(&client->dev, "TMP116/117 not found\n");
> > > >  		return -ENODEV;
>
> As per the other branch of this thread.  This isn't an error.
> If we want fallback compatibles to work in their role of allowing
> for newer devices that are actually compatible, the most we should
> do here is warn.
> 
> Say a new tmp117b device is released. It's fully backwards compatible
> with the exception of an ID - or supports only new features + backwards
> compatibility then that would have a fallback to tmp117 and we need
> it to work.

This isn't part of this patchset and IMHO implementing something which
may happen in the future is not the way we should go.

Regards,
  Marco
