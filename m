Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE49A36A259
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhDXRXv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 13:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhDXRXv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 13:23:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB0761131;
        Sat, 24 Apr 2021 17:23:11 +0000 (UTC)
Date:   Sat, 24 Apr 2021 18:23:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20210424182351.2c444232@jic23-huawei>
In-Reply-To: <20210409143115.GA3605953@robh.at.kernel.org>
References: <20210401140956.224084-1-jic23@kernel.org>
        <20210401140956.224084-3-jic23@kernel.org>
        <20210409143115.GA3605953@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Apr 2021 09:31:15 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, 01 Apr 2021 15:09:56 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Fairly simple conversion with the exception of the XOR between
> > spi-cpha and spi-cpol.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Link: https://lore.kernel.org/r/20201031134110.724233-17-jic23@kernel.org
> > ---
> >  .../bindings/iio/dac/ti,dac082s085.yaml       | 72 +++++++++++++++++++
> >  .../bindings/iio/dac/ti-dac082s085.txt        | 34 ---------
> >  2 files changed, 72 insertions(+), 34 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

