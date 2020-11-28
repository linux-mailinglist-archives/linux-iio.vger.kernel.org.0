Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D712C7488
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgK1Vtb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbgK1THB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:07:01 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3890E206DF;
        Sat, 28 Nov 2020 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606589985;
        bh=+coEsG0GeAk2A2pOd+HdfZfhpjiLgHFoWZr3vNTLLJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QF0ckU0vWiGT04fLPTOPTFUzJpiPVgOf6Sf9F6jQllamFuM7hYQ69VrORoVaHT+OB
         qu6BuPfhYvkQwlHjmfP5gSfXYS4xbEIUSEaKN6/c2x6Qbzi2v/ZbSmE5BGcf5qSdLQ
         GE9CPV6OAGfDNNx/jvzlgeosWNbrmSoDBJ+D7V7g=
Date:   Sat, 28 Nov 2020 18:59:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 6/9] ARM: dts: qcom-pma8084: Drop incorrect use of
 io-channel-ranges
Message-ID: <20201128185940.401c0465@archlinux>
In-Reply-To: <X8KXMrFg1g8OsjZj@builder.lan>
References: <20201115192951.1073632-1-jic23@kernel.org>
        <20201115192951.1073632-7-jic23@kernel.org>
        <20201128153702.7d144f68@archlinux>
        <X8KXMrFg1g8OsjZj@builder.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 12:30:10 -0600
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Sat 28 Nov 09:37 CST 2020, Jonathan Cameron wrote:
> 
> > On Sun, 15 Nov 2020 19:29:48 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > This property is used by io-channel consumers, not providers so should
> > > not present here.  Note dt_schema will now detect this error as there
> > > is a dependency between this property and io-channels.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Andy Gross <andy.gross@linaro.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>  
> > +CC Andy on an up to date email. Also added linux-arm-msm
> > which I should have cc'd in the first place.
> > 
> > I've taken the yaml fix related to this so just a question of
> > cleaning up this loose end in the dtsi
> >   
> 
> Thanks Jonathan, I missed your patches earlier. The yaml change looks
> correct and I've merged this for 5.11.

No problem. I've added your tag to the yaml change.

Thanks,

Jonathan


> 
> Regards,
> Bjorn
> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  arch/arm/boot/dts/qcom-pma8084.dtsi | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
> > > index ea1ca166165c..e921c5e93a5d 100644
> > > --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
> > > @@ -68,7 +68,6 @@ pma8084_vadc: vadc@3100 {
> > >  			#address-cells = <1>;
> > >  			#size-cells = <0>;
> > >  			#io-channel-cells = <1>;
> > > -			io-channel-ranges;
> > >  
> > >  			die_temp {
> > >  				reg = <VADC_DIE_TEMP>;  
> >   

