Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9CD39AA85
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCS4B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCS4A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:56:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5628B613EE;
        Thu,  3 Jun 2021 18:54:13 +0000 (UTC)
Date:   Thu, 3 Jun 2021 19:55:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings:iio:dac:ad5755: txt to yaml format
 conversion.
Message-ID: <20210603195556.73d5c984@jic23-huawei>
In-Reply-To: <20210503171445.GA2030945@robh.at.kernel.org>
References: <20210424173015.534941-1-jic23@kernel.org>
        <20210503171445.GA2030945@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 May 2021 12:14:45 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, 24 Apr 2021 18:30:15 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Straight forward conversion.  Only fiddly bit is the XOR of
> > spi-cpol and spi-cpha.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> > Link: https://lore.kernel.org/r/20201031184854.745828-40-jic23@kernel.org
> > ---
> > This has been in a few different series, so version numbering is a bit
> > scrambled.  Let's just call it v2.
> > V2:
> > * Drop unnecessary refs where units in naming
> > * Drop unnecessary brackets in child node naming
> > 
> >  .../devicetree/bindings/iio/dac/ad5755.txt    | 124 -------------
> >  .../bindings/iio/dac/adi,ad5755.yaml          | 169 ++++++++++++++++++
> >  2 files changed, 169 insertions(+), 124 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

The applied message for this one seems to be missing.
Anyhow for anyone curious, applied some time back.

Thanks,

Jonathan
