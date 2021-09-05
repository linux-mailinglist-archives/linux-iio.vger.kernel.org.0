Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDEF401028
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhIEOZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 10:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEOZZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 10:25:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C5B60E8B;
        Sun,  5 Sep 2021 14:24:16 +0000 (UTC)
Date:   Sun, 5 Sep 2021 15:27:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>, robh+dt@kernel.org,
        linux-aspeed@lists.ozlabs.org, p.zabel@pengutronix.de,
        pmeerw@pmeerw.net, lars@metafoo.de, linux-iio@vger.kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew@aj.id.au,
        joel@jms.id.au, devicetree@vger.kernel.org, BMC-SW@aspeedtech.com,
        lgirdwood@gmail.com
Subject: Re: [v5 02/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Message-ID: <20210905152738.2645b531@jic23-huawei>
In-Reply-To: <YS7ZnG05pZvfA/7m@robh.at.kernel.org>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
        <20210831071458.2334-3-billy_tsai@aspeedtech.com>
        <YS7ZnG05pZvfA/7m@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 20:38:36 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 31 Aug 2021 15:14:45 +0800, Billy Tsai wrote:
> > Add device tree bindings document for the aspeed ast2600 adc device
> > driver.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 100 ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I'm going to push on with this series until I hit anything that needs to wait
for the fix to be available.  If that happens I'll have to wait until that's
in Linus' tree before taking the rest.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to work it's magic.

Thanks,

Jonathan


