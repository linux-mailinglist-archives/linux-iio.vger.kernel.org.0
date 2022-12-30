Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A80659B07
	for <lists+linux-iio@lfdr.de>; Fri, 30 Dec 2022 18:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiL3Rmm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Dec 2022 12:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3Rmm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2022 12:42:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F442A452;
        Fri, 30 Dec 2022 09:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B733961B19;
        Fri, 30 Dec 2022 17:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEC9C433EF;
        Fri, 30 Dec 2022 17:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672422160;
        bh=i3XwKN6BpXFvy+XIJ24PzvzFUAvWk2LGqWNk56jmzlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MJ3f+DP4mAUzxmpxQLY87wmxTmEWwWwvj2AhdQTs/+CsFeABZyG9eeWkeykeJ3Eyf
         Kt13RQNCJr2fPM+2jwlkdXFltscl4jeWvkc8FmFHyOBUiPAz8g5wgTglEyPhJM5VSL
         nnaTYpyLPraPXEqAdLQr4y5pGzilbF8J/m91N/4u8w7ht7gcjnWTjLS4FDuGtH/xSR
         UIbjAtGFdtNg+2iCmzNASKud6rCAdfpJInL20q47SX7I4d2c5LTduEmTsk7sZTAzLw
         HAPPTIRWlbbAYhy07WkFVKREGD+cq5rAxSbwhfmcSRKYoMW/A4KNR/YJXSrDRKnsfO
         vhW9/nv9xTsng==
Date:   Fri, 30 Dec 2022 17:55:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <20221230175558.4495bc00@jic23-huawei>
In-Reply-To: <34b6b5b3-079d-3f6b-b55a-6d05a775e3b8@linaro.org>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
        <20221221092801.1977499-4-m.felsch@pengutronix.de>
        <20221223151056.4f7d4b7e@jic23-huawei>
        <20221223150728.34d5agqr4ruixjbu@pengutronix.de>
        <20221223153929.3fbad6b2@jic23-huawei>
        <20221223161359.wla6l5kd5gddloid@pengutronix.de>
        <20221223171647.43a6153e@jic23-huawei>
        <34b6b5b3-079d-3f6b-b55a-6d05a775e3b8@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Tue, 27 Dec 2022 09:30:08 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 23/12/2022 18:16, Jonathan Cameron wrote:
> > On Fri, 23 Dec 2022 17:13:59 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> >> On 22-12-23, Jonathan Cameron wrote:
> >>
> >> ...
> >>  
> >>>>>> @@ -118,27 +127,28 @@ static int tmp117_identify(struct i2c_client *client)
> >>>>>>  	int dev_id;
> >>>>>>  
> >>>>>>  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
> >>>>>> -	if (dev_id < 0)      
> >>>>>
> >>>>> Keep this handling of the smbus read returning an error.
> >>>>> Otherwise, you end up replacing the error code with -ENODEV rather than
> >>>>> returning what actually happened.
> >>>>>
> >>>>> 	if (dev_id < 0)
> >>>>> 		return dev_id;      
> >>>>
> >>>> You're right, I will change this thanks.
> >>>>     
> >>>>> 	switch (dev_id) {
> >>>>> ...
> >>>>>       
> >>>>>> +	switch (dev_id) {
> >>>>>> +	case TMP116_DEVICE_ID:
> >>>>>> +	case TMP117_DEVICE_ID:
> >>>>>>  		return dev_id;
> >>>>>> -	if (dev_id != TMP117_DEVICE_ID) {
> >>>>>> -		dev_err(&client->dev, "TMP117 not found\n");
> >>>>>> +	default:
> >>>>>> +		dev_err(&client->dev, "TMP116/117 not found\n");
> >>>>>>  		return -ENODEV;    
> >>>
> >>> As per the other branch of this thread.  This isn't an error.
> >>> If we want fallback compatibles to work in their role of allowing
> >>> for newer devices that are actually compatible, the most we should
> >>> do here is warn.
> >>>
> >>> Say a new tmp117b device is released. It's fully backwards compatible
> >>> with the exception of an ID - or supports only new features + backwards
> >>> compatibility then that would have a fallback to tmp117 and we need
> >>> it to work.    
> >>
> >> This isn't part of this patchset and IMHO implementing something which
> >> may happen in the future is not the way we should go.  
> > 
> > I held a similar view, but the response I got from the DT maintainers was
> > that a driver should not reject a DTS that says it is compatible based
> > on an unknown ID - because it prevents that case of an old kernel working
> > absolutely fine with a completely compatible newer part.  
> 
> I don't think that there was such generic recommendation. Accepting
> unknown devices (unknown register IDs) is a risk - device might behave
> correct or not. If it is a critical device, like regulator, misbehave
> might damage something.

Agreed - I didn't express that there are limits to such a requirement.
Indeed not a good idea with regulators etc!  However, for input devices
like this one things are a little simpler - in theory they could be used
for something that ends up damaging hardware if done wrong, but it's much
less likely.

> 
> What's more, how Linux driver behaves on device IDs (not compatibles) is
> also a bit outside of DT scope.
> 
> If a driver claims it handles compatibles tmp117, then indeed it should
> work fine with any DTS node claiming to be compatible with tmp117.
> However driver is free to make further checks (if possible) whether the
> device (e.g. tmp116 or tmp11X) is really compatible and reject unknown
> devices for safety reason.

Ok. For input devices at least in IIO we went around this a few times and
ended up with deciding that a dev_info() type message was the best balance.
We will need to be more careful for output devices.

> 
> The same as x86 kernel is fine to reject to work on newest (unknown) x86
> processors for safety reasons... which is terrible from user-experience
> point of view unless it is real safety case.

Hopefully that never happens :)

Jonathan

> 
> Best regards,
> Krzysztof
> 

