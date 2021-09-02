Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B103FF342
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346973AbhIBSdD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 14:33:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53079 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhIBSdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 14:33:02 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 236B660004;
        Thu,  2 Sep 2021 18:32:00 +0000 (UTC)
Date:   Thu, 2 Sep 2021 20:31:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH 28/40] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <20210902203159.60e3175d@xps13>
In-Reply-To: <20210830151010.7dcb1be3@jic23-huawei>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-29-miquel.raynal@bootlin.com>
        <20210830151010.7dcb1be3@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Mon, 30 Aug 2021 15:10:10
+0100:

> On Wed, 25 Aug 2021 17:25:06 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Introduce a new compatible that has another set of driver data,
> > targeting am437x SoCs with a magnetic reader instead of the
> > touchscreen and a more featureful set of registers.
> > 
> > Co-developed-by: Jason Reeder <jreeder@ti.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: Jason Reeder <jreeder@ti.com>  
> There is one bit in here that I think should have been back in patch 16 but
> maybe I'm missing something.

Good catch, indeed I should have wired the compatible with the driver
data since patch 16. I will fix this.

Thanks,
Miquèl
