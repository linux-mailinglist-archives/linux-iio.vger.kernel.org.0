Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2325B72176C
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jun 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFDN2Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jun 2023 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFDN2Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jun 2023 09:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA4DE
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 06:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E83A60EB8
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 13:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB49C433D2;
        Sun,  4 Jun 2023 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685885301;
        bh=3mqyHyyj27CZjn60ub6y2eH6W808VcA1A/iBkCZjmLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SRfQb4s3cYBXSGg23bb/gXHJuPS999rnmlU69YBEFTffcSoii5AETsk3Yo5PqjeGG
         /J1Q+XcmAYm+5wFtmn2fpfQP58DvXOwZHl6Evci8VYL6IcTHRANIT672McbbSTNgBa
         0ho7zByscEvp0qKOXy32kbfBYYRB30dXxKsnN0gyyDK1guxyWnvR+Ut1/doqospu5c
         TT9Va1pE74xtzamIUpCEmP7wsNjoNcH9/w0APo+TXaSHWs1YKjNzmY9tLuriaZDzYs
         oHfuOO1qN3GTOIW2Yl4zCBEaWF+TzyjvabXcWdqU7gCHQ8yextL2qDcI1OwCxzDmDi
         k4buHv7+U+wiw==
Date:   Sun, 4 Jun 2023 14:28:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: ROHM BM1390 support
Message-ID: <20230604142818.5cb35858@jic23-huawei>
In-Reply-To: <2e722c05-9548-f8da-2d72-1ba76a1e2508@gmail.com>
References: <2e722c05-9548-f8da-2d72-1ba76a1e2508@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 May 2023 11:20:59 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi dee Ho peeps,
> 
> Once again I am trying to learn from more experienced sensor folks :)

(Someone get Matti some nice simple devices to add support for - he needs
a rest!) :)

> 
> I am currently working (also) on ROHM BM1390 pressure sensor. The sensor 
> can measure pressure ranging 300 - 1300 hPa. Measurement times can be 
> around 20 - 160 mS depending on the amount of samples being averaged. 
> There is also an IIR filter included in sensor with 3 different settings 
> titled as "weak", "middle" and "strong". Unfortunately the exact maths 
> is not explained. 

Gah.  We all love this sort of dumbing down in datasheets.
There is a picture though... Hmm. Anyone remember enough about filter
design to tell me if you can go from a 63% point on a step response (in time domain)
to a 3DB in frequency?  I'd go with probably not but it's been far too many years
since I did any of this so I could be wrong.
I'd kick this into the long grass - pressure sensors that aren't the type that you
connect to a pipe tend to be for measuring slow changes, so I'd just set it to
the middle value and not worry about making it configurable.

Can revisit later.
 
> Furthermore, the sensor can be configured to store 
> maximum of 4 measured pressure samples in a HW FIFO.
> 
> The sensor can also measure temperature and error for temperature 
> measurement is told to be +/- 2C when temperature is in a range of 25 C 
> - 85 C. On the other hand, operating temperature for the device is said 
> to be -40 C - 85 C.

Helpful to have a sensor with no defined precision in the range
in which the device is meant to operate. *sniggers*
I wonder if it's a typo as the operating range matches the storage range
which is unusual.

> 
> Now, the temperature measurements are not stored in a FIFO.
> 
> Here comes my question - what do you see as the typical use-cases for 
> such a sensor? Or, to be more exact, do you think "quick" changes in 
> temperature are expected to be measured with this type of sensor? 

My understanding of pressure sensors is a bit weak so the following might
not be accurate...

No. Temp stuff on pressure sensors is normally there for temperature compensation
algorithms.

> I am 
> asking this because I would like to support using the hardware FIFO and 
> I am wondering if reading the temperature at FIFO flush and populating 
> also the temperature channel values corresponding to all (up to 4) 
> pressure measurements would be the best approach?
> 
> Other options is to not support using FIFO when temperature is scanned.

A third is only let the temperature be read from sysfs.  That's fairly common
in devices like this where the temp sensor isn't expected to be read as often
as the others and maps to what we can actually control.  (scan_index == -1)
IIRC some of the IMUs do this as again temp not expected to change much, but
it if has radically different stable values it will affect precision calibration.

> 
> I have a gut feeling that the users who measure pressure are often also 
> interested in getting the temperatures. Hence I would like to allow 
> getting both. "Cheating" by using the same temperature value (measured 
> when FIFO is flushed) should be Ok if temperature is not changing 
> rapidly as even with the slowest measurement speed collecting 4 samples 
> should finish in well under a second - and mentioned accuracy for the 
> temperature sensor is such that small temperature changes are probably 
> going unnoticed anyways.

Fifo normally only of interest at high rates anyway, not that it makes much
practical difference when implementing the driver.

> 
> Here I would love to have an opinion from more experienced IIO 
> developers/users - and potentially a hint how similar sensors have been 
> handled previously. (I would assume not storing some slowly changing 
> values in a HW FIFO is quite common because HW FIFOs won't come without 
> a cost).

I don't really mind if you either go with
1 - fill it copies of same temperature.
2 - only have temp via sysfs (this I know we've done a bunch of times)

The mess of switch between fifo and non fifo depending on whether the
temp sensor is in the scan strikes me as too fiddly to make sense.

Jonathan




> 
> Yours,
>   -- Matti
> 
> Oh, in case someone wants to see the data sheet:
> https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/pressure/bm1390glv-z-e.pdf
> 
> 

