Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398A61D6380
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgEPSTf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 14:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgEPSTf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 14:19:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B861206F4;
        Sat, 16 May 2020 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589653174;
        bh=Gyc9t3X2urr60eF4Vay6002sHovimEfau4gtnVMx/xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H4U+gUAdlba1/cy756hvthqXryByavE0vCKoIQG/ujKlKqbo5epV9pTc3Vrw6KRCp
         AWADzyhnSiPaGeECjcntEsH8H+y+YvuknqenX2cAHJUvlmwIW/FxMLq8ZO/22OORuV
         IqAIOHlzTKnhC05IeSJsgGvaizadnOHS/vTKZ94Q=
Date:   Sat, 16 May 2020 19:19:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Bakker <xc-racer2@live.ca>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, kgene@kernel.org,
        cw00.choi@samsung.com, kstewart@linuxfoundation.org,
        mpe@ellerman.id.au, m.szyprowski@samsung.com, swboyd@chromium.org,
        tglx@linutronix.de, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add scaling support to exynos adc driver
Message-ID: <20200516191914.3b028794@archlinux>
In-Reply-To: <20200511074232.GA7134@kozik-lap>
References: <BN6PR04MB066058A68D6471E7F6AFCFF7A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
        <20200510112417.1e54d66e@archlinux>
        <20200511074232.GA7134@kozik-lap>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 May 2020 09:42:32 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sun, May 10, 2020 at 11:24:17AM +0100, Jonathan Cameron wrote:
> > On Fri,  8 May 2020 14:14:00 -0700
> > Jonathan Bakker <xc-racer2@live.ca> wrote:
> >   
> > > Currently the driver only exposes the raw counts.  As we
> > > have the regulator voltage and the maximum value (stored in
> > > the data mask), we can trivially produce a scaling fraction
> > > of voltage / max value.
> > > 
> > > This assumes that the regulator voltage is in fact the max
> > > voltage, which appears to be the case for all mainline dts
> > > and cross referenced with the public Exynos4412 and S5PV210
> > > datasheets.
> > > 
> > > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>  
> > 
> > Seems reasonable to me. I'd like an exynos Ack though before applying.  
> 
> 
> It's correct, at least with ARMv7 Exynos datasheets
> 
> The few ARMv8 Exynos chips are silent about the voltage levels. The
> Exynos 7 DTS board in mainline kernel does not have regulator but it
> looks clearly like mistake.
> 
> I think they behave the same, so for Exynos:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 
> > thanks,
> > 
> > Jonathan
> > 
> >   

