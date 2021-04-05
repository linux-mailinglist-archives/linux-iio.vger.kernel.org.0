Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907C53542CB
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbhDEO3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235915AbhDEO3l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:29:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD75261284;
        Mon,  5 Apr 2021 14:29:33 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:29:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-iio@vger.kernel.org, Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/7] iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag
 rather than separate irq_disable()
Message-ID: <20210405152949.163a9c20@jic23-huawei>
In-Reply-To: <c8812c32-e748-bb0e-09b1-d3be3bb29872@canonical.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-3-jic23@kernel.org>
        <c8812c32-e748-bb0e-09b1-d3be3bb29872@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 4 Apr 2021 21:20:21 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On 02/04/2021 20:45, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Disabling an irq before the driver has actually atempted to request it
> > may work, but is definitely not as clean as just requesting it as
> > normal but with the auto enable disabled.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>  
> 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Best regards,
> Krzysztof

Applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilders poke at it.

Thanks,

Jonathan


