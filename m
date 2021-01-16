Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8D2F8E6F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jan 2021 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbhAPRsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jan 2021 12:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbhAPRsT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jan 2021 12:48:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D666223E8;
        Sat, 16 Jan 2021 17:47:38 +0000 (UTC)
Date:   Sat, 16 Jan 2021 17:47:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:adc:qcom-spmi-vadc: add default scale to
 LR_MUX2_BAT_ID channel
Message-ID: <20210116174735.05d0fc75@archlinux>
In-Reply-To: <YAHDOaZoSSGZexFa@builder.lan>
References: <20210113151808.4628-1-jonathan.albrieux@gmail.com>
        <20210113151808.4628-2-jonathan.albrieux@gmail.com>
        <YAHDOaZoSSGZexFa@builder.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 10:30:49 -0600
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Wed 13 Jan 09:18 CST 2021, Jonathan Albrieux wrote:
> 
> > Checking at both msm8909-pm8916.dtsi and msm8916.dtsi from downstream
> > it is indicated that "batt_id" channel has to be scaled with the default
> > function:
> > 
> > 	chan@31 {
> > 		label = "batt_id";
> > 		reg = <0x31>;
> > 		qcom,decimation = <0>;
> > 		qcom,pre-div-channel-scaling = <0>;
> > 		qcom,calibration-type = "ratiometric";
> > 		qcom,scale-function = <0>;
> > 		qcom,hw-settle-time = <0xb>;
> > 		qcom,fast-avg-setup = <0>;
> > 	};
> > 
> > Change LR_MUX2_BAT_ID scaling accordingly.
> >   
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Not entirely sure, but looking at the history I think this used to work
> - but it's obvious that no one has read this channel for a while...
> 
> But I think below is a regression and should be mentioned:
> 
> Fixes: 7c271eea7b8a ("iio: adc: spmi-vadc: Changes to support different scaling")
> 

Yikes that was a while ago :)

> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>  
> 
> Jonathan Cameron, if you merge this through your tree I can take the dts
> addition through the Qualcomm tree.

Applied to the fixes-togreg branch of iio.git and marked for stable.

I'm not going to rush this one given age of the bug, but if I happen to
have anything else going it'll make it before the end of this cycle.

Thanks,

Jonathan

> 
> Regards,
> Bjorn
> 
> > ---
> >  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> > index b0388f8a69f4..7e7d408452ec 100644
> > --- a/drivers/iio/adc/qcom-spmi-vadc.c
> > +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> > @@ -598,7 +598,7 @@ static const struct vadc_channels vadc_chans[] = {
> >  	VADC_CHAN_NO_SCALE(P_MUX16_1_3, 1)
> >  
> >  	VADC_CHAN_NO_SCALE(LR_MUX1_BAT_THERM, 0)
> > -	VADC_CHAN_NO_SCALE(LR_MUX2_BAT_ID, 0)
> > +	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0, SCALE_DEFAULT)
> >  	VADC_CHAN_NO_SCALE(LR_MUX3_XO_THERM, 0)
> >  	VADC_CHAN_NO_SCALE(LR_MUX4_AMUX_THM1, 0)
> >  	VADC_CHAN_NO_SCALE(LR_MUX5_AMUX_THM2, 0)
> > -- 
> > 2.17.1
> >   

