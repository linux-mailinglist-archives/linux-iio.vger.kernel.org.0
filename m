Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E15DCEE7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbfJRTCG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 15:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbfJRTCF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 15:02:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765832070B;
        Fri, 18 Oct 2019 19:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425325;
        bh=JtxGSvUXjUGS/UHlWGqie3e3jRciJz7apHnurysh3S4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byFUN+rihBHIF1YafECJiAgkLZ0Ci85bEyBuIrC5N56hTAPpfff5KmiKmC5Miji5c
         1nogaDLf6NC/MgGM+OTBkyokhPdtmVPh1h8F36mEiOOwSdOBVyCwq9h2iE+dHofEc1
         fTeTNRjYdmY4pLBR+SMcnHyNC8gnfekSpDDJoacI=
Date:   Fri, 18 Oct 2019 20:01:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: use
 devm_platform_ioremap_resource
Message-ID: <20191018200157.6333d754@archlinux>
In-Reply-To: <CAFBinCDUQm6pSVgbWV8UEpBZW+zNjC2=7e0FxeHMo1b_33vTmw@mail.gmail.com>
References: <20191013153759.1840761-1-jic23@kernel.org>
        <CAFBinCDUQm6pSVgbWV8UEpBZW+zNjC2=7e0FxeHMo1b_33vTmw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019 23:05:12 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Sun, Oct 13, 2019 at 5:40 PM <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Avoid local boilerplate.
> > Suggested by coccinelle via coccicheck.
> > CHECK   drivers/iio/adc/meson_saradc.c
> > drivers/iio/adc/meson_saradc.c:1218:1-5: WARNING: Use devm_platform_ioremap_resource for base
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>  
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> thank you for this cleanup!
> 
Applied,

Thanks,

Jonathan

> 
> Martin

