Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BA40B6DE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Sep 2021 20:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhINS0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 14 Sep 2021 14:26:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59371 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhINS0e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Sep 2021 14:26:34 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7A5A6E0006;
        Tue, 14 Sep 2021 18:25:10 +0000 (UTC)
Date:   Tue, 14 Sep 2021 20:25:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 34/46] mfd: ti_am335x_tscadc: Add ADC1/magnetic
 reader support
Message-ID: <20210914202509.0aeb303e@xps13>
In-Reply-To: <20210905142324.3de19916@jic23-huawei>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-35-miquel.raynal@bootlin.com>
        <20210905142324.3de19916@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 5 Sep 2021 14:23:24 +0100:

> On Thu,  2 Sep 2021 23:51:32 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Introduce a new compatible that has another set of driver data,
> > targeting am437x SoCs with a magnetic reader instead of the
> > touchscreen and a more featureful set of registers.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> I'm being lazy and not datasheet diving but otherwise looks good.
> The HZ unit patch is in mm, but Linus hasn't merged it yet.  May well be
> in whatever tree this goes into post merge window though.
> 

I'll rebase the series and add the use of the HZ_PER_MHZ macro :)

Thanks,
Miquèl
