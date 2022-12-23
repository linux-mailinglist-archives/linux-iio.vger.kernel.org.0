Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA1655307
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 18:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiLWRDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 12:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWRDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 12:03:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248151743C;
        Fri, 23 Dec 2022 09:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8D5DB8203D;
        Fri, 23 Dec 2022 17:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0CFC433EF;
        Fri, 23 Dec 2022 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671815018;
        bh=rWHD3WKFWP45wAXsJsLtw98sfGpFSD5wdqfd/D3fzcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PgPzlXteKY+CpuE+Unx4LXlFp1wFsWGCIosQeENZaCrjQF8WuDVVAOyLdS5kKovA8
         +UmL12FsCKz1S/9B+Efb9O1HWji8aLI5GrAYtMA1xP78T/0bx0XrqXN73p97qJsh+U
         W8ErpVNHBtqI5CpsXzCV83GNtYcU2Fm9QV0OndxuiXWOI84c81Brqp5oBz84OXlqCY
         0N+zUqEKaTH7AKLzeBizoZ4Opl5Knf2dBYqkLAHsYCdOf4Srlggi5KSg9cyxbYn0T4
         WFfz/oFv5Ra2ABXxqYAI7fmHhaFdsw9jsBCAh9xrsCIqaTdw5W3CxyyvTGelFG7gb+
         /0nXYC3Ezs4vA==
Date:   Fri, 23 Dec 2022 17:16:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <20221223171647.43a6153e@jic23-huawei>
In-Reply-To: <20221223161359.wla6l5kd5gddloid@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
        <20221221092801.1977499-4-m.felsch@pengutronix.de>
        <20221223151056.4f7d4b7e@jic23-huawei>
        <20221223150728.34d5agqr4ruixjbu@pengutronix.de>
        <20221223153929.3fbad6b2@jic23-huawei>
        <20221223161359.wla6l5kd5gddloid@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Dec 2022 17:13:59 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> On 22-12-23, Jonathan Cameron wrote:
> 
> ...
> 
> > > > > @@ -118,27 +127,28 @@ static int tmp117_identify(struct i2c_client *client)
> > > > >  	int dev_id;
> > > > >  
> > > > >  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
> > > > > -	if (dev_id < 0)    
> > > > 
> > > > Keep this handling of the smbus read returning an error.
> > > > Otherwise, you end up replacing the error code with -ENODEV rather than
> > > > returning what actually happened.
> > > > 
> > > > 	if (dev_id < 0)
> > > > 		return dev_id;    
> > > 
> > > You're right, I will change this thanks.
> > >   
> > > > 	switch (dev_id) {
> > > > ...
> > > >     
> > > > > +	switch (dev_id) {
> > > > > +	case TMP116_DEVICE_ID:
> > > > > +	case TMP117_DEVICE_ID:
> > > > >  		return dev_id;
> > > > > -	if (dev_id != TMP117_DEVICE_ID) {
> > > > > -		dev_err(&client->dev, "TMP117 not found\n");
> > > > > +	default:
> > > > > +		dev_err(&client->dev, "TMP116/117 not found\n");
> > > > >  		return -ENODEV;  
> >
> > As per the other branch of this thread.  This isn't an error.
> > If we want fallback compatibles to work in their role of allowing
> > for newer devices that are actually compatible, the most we should
> > do here is warn.
> > 
> > Say a new tmp117b device is released. It's fully backwards compatible
> > with the exception of an ID - or supports only new features + backwards
> > compatibility then that would have a fallback to tmp117 and we need
> > it to work.  
> 
> This isn't part of this patchset and IMHO implementing something which
> may happen in the future is not the way we should go.

I held a similar view, but the response I got from the DT maintainers was
that a driver should not reject a DTS that says it is compatible based
on an unknown ID - because it prevents that case of an old kernel working
absolutely fine with a completely compatible newer part.

Jonathan


> 
> Regards,
>   Marco

