Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7215174D10
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCAMDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 07:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCAMDf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 07:03:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D852087F;
        Sun,  1 Mar 2020 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583064215;
        bh=Q7jbPDNZgrKgJqA2TRrzbQMV2xFoOgaC5H2v+Xd25Pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPf5GoxYfXGOa7gIlX4E9hXX/HME9aX4ooqhLOMMRal/lpTbPIE7egItfYvxnrGFB
         WrrAdWUN4TrlBs3QkNkspWvvhWr5/680dlhfCsbKkGqF9B2/NNpR9ZHEpoG3V5kG1m
         0JQIRlsRtDk00sotwa5k1tW0GFUKM1B/s8ppuD34=
Date:   Sun, 1 Mar 2020 12:03:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: exynos: Silence warning about regulators
 during deferred probe
Message-ID: <20200301120330.3553b6e5@archlinux>
In-Reply-To: <20200228113314.GE9458@pi3>
References: <CGME20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd@eucas1p2.samsung.com>
        <20200228092121.15918-1-m.szyprowski@samsung.com>
        <20200228113314.GE9458@pi3>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Feb 2020 12:33:14 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Feb 28, 2020 at 10:21:21AM +0100, Marek Szyprowski wrote:
> > Don't confuse user with meaningless warning about the failure in getting
> > regulators in case of deferred probe.
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/iio/adc/exynos_adc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)  
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

