Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4844EB31
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 17:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhKLQSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 11:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233776AbhKLQSU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 11:18:20 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811A760FBF;
        Fri, 12 Nov 2021 16:15:27 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:20:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imx8qxp-adc: fix dependency to the intended
 ARCH_MXC config
Message-ID: <20211112162013.01f4f171@jic23-huawei>
In-Reply-To: <CAOMZO5B4k=UvE5XTgbsjCfoo0h0Y7H+xN6mwh9Bnc2L82QYzwQ@mail.gmail.com>
References: <20211111083954.6286-1-lukas.bulwahn@gmail.com>
        <CAOMZO5B4k=UvE5XTgbsjCfoo0h0Y7H+xN6mwh9Bnc2L82QYzwQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Nov 2021 07:31:25 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Lukas,
> 
> On Thu, Nov 11, 2021 at 5:40 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP
> > ADC") adds the config IMX8QXP_ADC for this new driver, which depends on
> > the non-existing config ARCH_MXC_ARM64.
> >
> > Hence, ./scripts/checkkconfigsymbols.py warns:
> >
> >   ARCH_MXC_ARM64
> >   Referencing files: drivers/iio/adc/Kconfig
> >
> > Probably, the existing config ARCH_MXC is intended to be referred here.
> > So, repair the dependency to refer to that config.
> >
> > Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>  
> 
> This looks good.
> 
> The incorrect  ARCH_MXC_ARM64 symbol probably came when porting the
> driver from the NXP downstream kernel:
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan


