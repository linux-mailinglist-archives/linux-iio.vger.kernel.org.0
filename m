Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3419541180C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhITPWt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 20 Sep 2021 11:22:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44183 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhITPWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 11:22:49 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EB1D74000C;
        Mon, 20 Sep 2021 15:21:16 +0000 (UTC)
Date:   Mon, 20 Sep 2021 17:21:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v3 28/47] mfd: ti_am335x_tscadc: Drop useless
 definitions from the header
Message-ID: <20210920172115.5b918e71@xps13>
In-Reply-To: <20210918173154.70c0b04b@jic23-huawei>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-29-miquel.raynal@bootlin.com>
        <20210918173154.70c0b04b@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 18 Sep 2021 17:31:54 +0100:

> On Wed, 15 Sep 2021 17:58:49 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Drop unused and useless definitions from the header. Besides the STEP
> > ENABLE register which is highly unclear (and not used), drop all the  
> 
> Agreed - I started trying to figure out what they were in the earlier patch!
> 
> > "masks" definitions which are only used by the following definition. It
> > could be possible to got even further by removing these definitions
> > entirely and use FIELD_PREP() macros from the code directly, but while I
> > have no troubles making these changes in the header, changing the values
> > in the code directly could IMHO darkening a bit the logic and
> > furthermore hardening future git-blames.  
> 
> Hmm. Maybe on that...  I'm not that bothered either way but there is
> definitely clarity in FIELD_PREP being used inline for writes to a device.
> You can very clearly see what is going on.
> 
> Note that it only really works here because the driver only ever uses
> the masks to 'set' the value, but never to read any of them back from the
> hardware.
> 
> Your point about it making a messy history is true of almost any change :)
> 
> > 
> > Certain macros are using GENMASK() to define the value of a particular
> > field, while this is purely "by chance" that the value and the mask have
> > the same value. In this case, drop the "mask" definition, use
> > FIELD_PREP() and GENMASK() in the macro defining the field, and use the
> > new macro to define the particular value by feeding directly the actual
> > number advertised in the datasheet into that macro, as in:
> > 	-#define STEPCONFIG_RFM_VREFN   GENMASK(24, 23)
> > 	-#define STEPCONFIG_RFM(val)    FIELD_PREP(STEPCONFIG_RFM_VREFN, (val))
> > 	+#define STEPCONFIG_RFM(val)    FIELD_PREP(GENMASK(24, 23), (val))
> > 	+#define STEPCONFIG_RFM_VREFN   STEPCONFIG_RFM(3)  
> 
> This is indeed an improvement.
> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> I'm a bit in two minds out about how you should handle the multiple patches
> involved in cleaning these up.   Definitely not good to do modifications on
> elements you are going to drop - so for those pull them out earlier.
> 
> The others are a little odd because you first introduce some of the GENMASK stuff
> then rework it in this patch.  Perhaps this split is the best way to handle those.

I must admit I got lazy, the ordering reflects the order of my
decisions and once these made, it was too painful to rebase and move
this patch earlier but I fully understand the request :) I will ping Lee
in the cover letter to ask him what is his feedback over the entire
series and if he agrees with the main idea I whish I could only respin
these three patches in the right order in v4 and request him to take v3
for all the other patches.

Thanks,
Miquèl
