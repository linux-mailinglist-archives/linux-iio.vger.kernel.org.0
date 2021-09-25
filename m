Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3ED418302
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbhIYPFR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Sep 2021 11:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234173AbhIYPFQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 11:05:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B153660F43;
        Sat, 25 Sep 2021 15:03:38 +0000 (UTC)
Date:   Sat, 25 Sep 2021 16:07:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add
 vid reg
Message-ID: <20210925160727.11abc0f1@jic23-huawei>
In-Reply-To: <YUo/BzWUBQArrMkS@robh.at.kernel.org>
References: <20210913181949.83179-1-david@ixit.cz>
        <YUo/BzWUBQArrMkS@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Sep 2021 15:22:31 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, 13 Sep 2021 20:19:49 +0200, David Heidelberg wrote:
> > Driver and device-tree also use vid-supply regulator.
> > 
> > Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml        | 5 +++++
> >  1 file changed, 5 insertions(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks David, Rob,

Applied to the togreg branch of iio.git and pushed out as testing for 0-day etc
to take a poke at it an see if we missed anything.

Jonathan
