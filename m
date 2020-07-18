Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43630224CD4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGRQGX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRQGV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:06:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E142073A;
        Sat, 18 Jul 2020 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088380;
        bh=pzVdMS6u1xo0HU/Ae/3cQay+CufheJIzPmtKdIjan3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=djtqJbLl0cXBs7wtkm/Mo8UGFZH5zx7NQfoc0j04xcKC7p5rM3kr1jqxhQr1+u+H6
         /jAxKiFXSfVjPvYD+bucW2zBG6yFZkkhXNWIkffTMg+Dafm5sry6FmdnkPWZ3HeK+d
         6+Xg1CAsE08cK7/jtlUo1hPaL2rKSucFzfVrcd0M=
Date:   Sat, 18 Jul 2020 17:06:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 26/30] iio: adc: qcom-pm8xxx-xoadc: Demote standard
 comment block and supply missing description
Message-ID: <20200718170616.1ae2c943@archlinux>
In-Reply-To: <20200717201525.GK388985@builder.lan>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-27-lee.jones@linaro.org>
        <20200717201525.GK388985@builder.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 13:15:25 -0700
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Fri 17 Jul 09:55 PDT 2020, Lee Jones wrote:
> 
> > Kerneldoc is only suitable for documenting functions and struct/enums.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_INTERNAL' description in 'PM8XXX_CHANNEL_INTERNAL'
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_125V' description in 'PM8XXX_CHANNEL_INTERNAL'
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_INTERNAL_2' description in 'PM8XXX_CHANNEL_INTERNAL'
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_MUXOFF' description in 'PM8XXX_CHANNEL_INTERNAL'
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c:412: warning: Function parameter or member 'variant' not described in 'pm8xxx_xoadc'
> > 
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>  
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> > ---
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > index c599ffa45a04c..cd5fa30e77df4 100644
> > --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > @@ -120,7 +120,7 @@
> >  #define ADC_ARB_USRP_DATA0			0x19D
> >  #define ADC_ARB_USRP_DATA1			0x19C
> >  
> > -/**
> > +/*
> >   * Physical channels which MUST exist on all PM variants in order to provide
> >   * proper reference points for calibration.
> >   *
> > @@ -388,6 +388,7 @@ struct pm8xxx_chan_info {
> >   * struct pm8xxx_xoadc - state container for the XOADC
> >   * @dev: pointer to device
> >   * @map: regmap to access registers
> > + * @variant: XOADC variant characteristics
> >   * @vref: reference voltage regulator
> >   * characteristics of the channels, and sensible default settings
> >   * @nchans: number of channels, configured by the device tree
> > -- 
> > 2.25.1
> >   

