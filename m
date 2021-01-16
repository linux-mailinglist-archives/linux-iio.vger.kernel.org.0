Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8672F8E4B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jan 2021 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbhAPR3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jan 2021 12:29:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbhAPR3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jan 2021 12:29:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1703922AAB;
        Sat, 16 Jan 2021 17:28:19 +0000 (UTC)
Date:   Sat, 16 Jan 2021 17:28:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Pop <cristian.pop@analog.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20210116172818.4091a0ee@archlinux>
In-Reply-To: <20210115164605.GA1425845@robh.at.kernel.org>
References: <20210115112105.58652-1-cristian.pop@analog.com>
        <20210115164605.GA1425845@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 10:46:05 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 15 Jan 2021 13:21:03 +0200, Cristian Pop wrote:
> > This adds device tree bindings for the AD5766 DAC.
> > 
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> > Changelog v6:
> > 	- Use microvolt unit
> > 	- Remove unrelevant to the binding comment
> >  .../bindings/iio/dac/adi,ad5766.yaml          | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Fixed up a line with just white space on it in the example and applied to the
togreg branch of iio.git, pushed out as testing for the autobuilders to poke
at it and see if we missed anything.
