Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C3F699E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKJPSF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfKJPSF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:18:05 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4701206DF;
        Sun, 10 Nov 2019 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573399084;
        bh=QhkMVi70RlDBV8du51eOWe/KLFUBv5UlOvtmbdNbNnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ywynIBG5PxyYLH3e07zSzve4SyEuRTawwPAhane4BOpKw1q1k7aq4BDjvBR9ry0AW
         G43NwlJ2RTCGXcC8Pbv2a+HoghuSsJadFsThFCghXCXIxzZFRQhyUgp6zsVe30NltQ
         izLzPUnwCDdUQYPEk1R1F9IPpEvZVHw/ZBNspbM4=
Date:   Sun, 10 Nov 2019 15:17:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Migrate MCP3911 documentation
 to yaml
Message-ID: <20191110151758.7c3a1693@archlinux>
In-Reply-To: <20191107010259.GA7930@bogus>
References: <20191106111210.6825-1-marcus.folkesson@gmail.com>
        <20191107010259.GA7930@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 Nov 2019 19:02:59 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed,  6 Nov 2019 12:12:10 +0100, Marcus Folkesson wrote:
> > Rewrite bindings to use json-schema vocabulary.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> > 
> > Notes:
> >     v2:
> >     	- Remove descriptor for reg and spi-max-frequency (Rob)
> >     	- Write better description for clocks and vref-supply (Rob)
> >     	- Remove max-items for vref-supply
> > 
> >  .../devicetree/bindings/iio/adc/mcp3911.txt   | 30 --------
> >  .../bindings/iio/adc/microchip,mcp3911.yaml   | 71 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 72 insertions(+), 31 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan


