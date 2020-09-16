Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBAA26C6CA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgIPSEM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgIPSDa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:03:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CDC32137B;
        Wed, 16 Sep 2020 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600279409;
        bh=wekwBAIKPu1Rz5oUbsaznCNgfQb4fGuy2YA7PTMymvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SVFaNdjRvlX2xA5CJGz4fdD1CDDM/wAVxm3wfv9vsDjqVmFBZqoj/HoT/8KZEifIP
         V0C+2baqHooYe68TrshZU7HmpYZ745fbWOYXd66Lcj3vt1sMRGimbCHk2Uwu9xFxzt
         gn7DIsychTc3yYLT6scbS7MrQ0q0Y11qrN0qwTMo=
Date:   Wed, 16 Sep 2020 19:03:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: exynos-adc: require
 second interrupt with touch screen
Message-ID: <20200916190326.3095e945@archlinux>
In-Reply-To: <20200916061747.GB5719@kozik-lap>
References: <20200910161933.9156-1-krzk@kernel.org>
        <20200915194444.GA2384148@bogus>
        <20200916061747.GB5719@kozik-lap>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 08:17:47 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Tue, Sep 15, 2020 at 01:44:44PM -0600, Rob Herring wrote:
> > On Thu, 10 Sep 2020 18:19:32 +0200, Krzysztof Kozlowski wrote:  
> > > The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> > > screen.  In such case the second interrupt is required.  This second
> > > interrupt can be anyway provided, even without touch screens.  This
> > > fixes dtbs_check warnings like:
> > > 
> > >   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> > > 
> > > ---
> > > 
> > > Changes since v1:
> > > 1. Fix if:has-touchscreen, as pointed by Rob.
> > > 2. Add Ack.
> > > ---
> > >  .../bindings/iio/adc/samsung,exynos-adc.yaml       | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >   
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>  
> 
> Jonathan,
> 
> Could you pick up these two?
Done.  Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to possibly poke them.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

