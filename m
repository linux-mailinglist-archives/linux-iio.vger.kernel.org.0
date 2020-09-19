Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFC270E3D
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgISNzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISNzR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:55:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416DC208C7;
        Sat, 19 Sep 2020 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600523717;
        bh=OJj8kvRTNAzpLdBsE/UkMYbJjDXr/8IizZIhUVeg1Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nkS21Zk8UgtnEmvVIREQfeqb1MHDwBYklUx56NY9tVV2oPojFKCvuOThCPb72FGiS
         dufCnhWW9xzZgCY9pqIMYZjT/092Xyvnx4KaasFIMkq67R1oGgNFp/cjoER+HL3nE8
         gVadQkK0ubP5v0lvcHCWak78MTJDyaxzG05WdJ98=
Date:   Sat, 19 Sep 2020 14:55:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/20] dt-bindings:iio:adc:marvell,berlin2-adc yaml
 conversion
Message-ID: <20200919145513.1be621a6@archlinux>
In-Reply-To: <20200915190427.GA2318799@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-6-jic23@kernel.org>
        <20200915190427.GA2318799@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:04:27 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:31 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Part of a general move of IIO bindings over to yaml.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  .../bindings/iio/adc/berlin2_adc.txt          | 19 -------
> >  .../bindings/iio/adc/marvell,berlin2-adc.yaml | 50 +++++++++++++++++++
> >  2 files changed, 50 insertions(+), 19 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied,

Thanks,

Jonathan
