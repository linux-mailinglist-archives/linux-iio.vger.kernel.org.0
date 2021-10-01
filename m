Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2116341E80C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbhJAHNZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 1 Oct 2021 03:13:25 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49765 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352057AbhJAHNY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Oct 2021 03:13:24 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CA64D1C000A;
        Fri,  1 Oct 2021 07:11:35 +0000 (UTC)
Date:   Fri, 1 Oct 2021 09:11:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 25/48] mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ
 macro
Message-ID: <20211001091132.748a624d@xps13>
In-Reply-To: <20210929162905.5fc771c5@jic23-huawei>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
        <20210928133143.157329-26-miquel.raynal@bootlin.com>
        <20210929162905.5fc771c5@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Wed, 29 Sep 2021 16:29:05 +0100:

> On Tue, 28 Sep 2021 15:31:20 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Before adding another frequency with even more zeroes, use the
> > HZ_PER_MHZ macro to clarify the number.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> You missed tag I gave on v3.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Oh right, sorry about that.

Cheers,
Miquèl
