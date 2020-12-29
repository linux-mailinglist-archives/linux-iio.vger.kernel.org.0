Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A752E72CC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgL2RrZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgL2RrZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:47:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FC220825;
        Tue, 29 Dec 2020 17:46:43 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:46:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:dac:microchip,mcp4725: fix properties
 for mcp4726
Message-ID: <20201229174640.11079e45@archlinux>
In-Reply-To: <20201221192738.GA407457@robh.at.kernel.org>
References: <20201216101316.1403-1-tomas@novotny.cz>
        <20201221192738.GA407457@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Dec 2020 12:27:38 -0700
Rob Herring <robh@kernel.org> wrote:

> On Wed, 16 Dec 2020 11:13:16 +0100, Tomas Novotny wrote:
> > The vdd-supply property is optional if vref-supply is provided for
> > mcp4726.
> > 
> > Also the microchip,vref-buffered makes sense only if vref-supply is
> > specified.
> > 
> > Spotted by Jonathan during conversion to yaml.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
I'm taking this this slow way as we are just providing slightly more flexible
conditions rather than allowing anything we suspect anyone is already using.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to probably ignore it ;)

Thanks for tidying this up.

Jonathan

> > ---
> >  .../bindings/iio/dac/microchip,mcp4725.yaml   | 31 +++++++++++++++----
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

