Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA829170F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgJRLAw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 07:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgJRLAw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:00:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3388F20897;
        Sun, 18 Oct 2020 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603018851;
        bh=3vvzUsZpHL+oefHlU7WKYPhRI0zVkgLGxOZEq7wNmSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CZDi2Z/2zFGYO7fQZV0L+hjJSX+tQQvGoaFH09zR2rLyUT/Ixh/9LI8/ZxPMRKNIz
         AGrszrUAH8sg8oZx2kMwTWiJaC+1Baz1xYQpBAvZxu1QCBMZEq9XVLOL+pBt5B6ppN
         pWCyv1McqzAlzBaO35NMVn2HYexawE+z/64BqXnU=
Date:   Sun, 18 Oct 2020 12:00:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rui Miguel Silva <rui.silva@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: fxas21002c: convert bindings to yaml
Message-ID: <20201018120046.42689d19@archlinux>
In-Reply-To: <20201016185707.GA1743713@bogus>
References: <20201014104926.688666-1-rmfrfs@gmail.com>
        <20201016185707.GA1743713@bogus>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Oct 2020 13:57:07 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, 14 Oct 2020 11:49:26 +0100, Rui Miguel Silva wrote:
> > Convert fxas21002c gyroscope sensor bindings documentation to
> > yaml schema, remove the textual bindings document and update MAINTAINERS entry.
> > 
> > Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
> > ---
> > v1 -> v2:
> >    Jonathan Cameron:
> >        https://lore.kernel.org/linux-iio/20201013153431.000052c9@huawei.com/
> >        - remove Unit from tittle
> >        - reword interrupts description
> >        - drop interrupt-name description
> >        - add spi example and bindings
> >        - remove vddxx from required list
> > 
> >  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 ------
> >  .../iio/gyroscope/nxp,fxas21002c.yaml         | 95 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 96 insertions(+), 32 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Nice patch.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to maybe poke at.

I'm still not 100% sure if unevaluatedProperties or additionalProperties makes
sense here, but as Rob's happy, I'm happy :)

Thanks,

Jonathan

