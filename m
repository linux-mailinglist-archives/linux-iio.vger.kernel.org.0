Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D382F8EC7
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jan 2021 19:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbhAPSxo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jan 2021 13:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAPSxo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2021 13:53:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94570C061575;
        Sat, 16 Jan 2021 10:53:03 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u14so6206191wmq.4;
        Sat, 16 Jan 2021 10:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1HsSZJY+CiaWPyAUg2aqzTWlv6kMVQjrzRjPDHyiHyQ=;
        b=BXewoFGxrVR2XrHgwx6oqHsAib+VNjNdrZDTA3ruQuNo/xG71/4GHpjgvWloNdoKNz
         NQTe6HwgLL4mj2aFBhTOnDyE3xGF7+coFe0wVsglbCZRIcHIpA2wAh5cJeYS7PtGSos9
         tP2qRcUldFa4boioDbHJFbKY0cmM0z0pSZNQLggX4tLq2irINhgt08Bddsgm2QEeq+yZ
         VwjFV6LQT+E7WIuHUOQtF8iyHDPcgY+dK1JLBOUUSd/AH24UDK7GcCNu0nN7ZFLRauLW
         +gwuZM36Nkwq1agJ3huQIqbWMai6/HBr3lztHyB1BsO6/I8GOeQVKaCS+KRXzgatzfh3
         lVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HsSZJY+CiaWPyAUg2aqzTWlv6kMVQjrzRjPDHyiHyQ=;
        b=LhjEMdD1DuY42HbHja0cdfhXGkBLAHCMEFStw/jNj7/zpzG5fDnccM1MmfvKbk+SmX
         m7kGPCCQgdbd9VJa8op5ecEzDVofX2z1r9X4yPVVEHKr5nh2rcXzFjhJ3cDki5YrPoxq
         FH6svih+fWVh2y7pk+7NIBy/AlfLdVVREqRyNBybXnIdhXeOpatoOfm49bzvw4UPq48Q
         i6SDPxQcwLm3M4/06FgY72yac58gCAOR16tgqqz3N5ETj/zgUq0XVz4yP/08Yl9OMzDu
         nWdrkiITo7JHu41L4D9FClgRkHbJJAWuf1pauMCzBxAxMeFL7wAT7cnbmKbySK1UEjiF
         65PA==
X-Gm-Message-State: AOAM531JdsDJ2s3YVbTkmD0nIriBW3/BhTBmPiEzVlW8a4J+JDD3U6Lh
        rfV6Evjwpd5Gk4NeEh3TGHo=
X-Google-Smtp-Source: ABdhPJzCcJIkDMPddXHuysiFhG3fFuMO+UMKwqR/mO5euK0R51ldACiv/WAaJM/rgORn2ekBrtvF1w==
X-Received: by 2002:a1c:10c:: with SMTP id 12mr14084720wmb.186.1610823182187;
        Sat, 16 Jan 2021 10:53:02 -0800 (PST)
Received: from jonathan-N53SV ([151.81.101.204])
        by smtp.gmail.com with ESMTPSA id 9sm725620wmb.14.2021.01.16.10.53.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jan 2021 10:53:01 -0800 (PST)
Date:   Sat, 16 Jan 2021 19:52:49 +0100
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:adc:qcom-spmi-vadc: add default scale to
 LR_MUX2_BAT_ID channel
Message-ID: <20210116185249.GA24785@jonathan-N53SV>
References: <20210113151808.4628-1-jonathan.albrieux@gmail.com>
 <20210113151808.4628-2-jonathan.albrieux@gmail.com>
 <YAHDOaZoSSGZexFa@builder.lan>
 <20210116174735.05d0fc75@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116174735.05d0fc75@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 16, 2021 at 05:47:35PM +0000, Jonathan Cameron wrote:
> On Fri, 15 Jan 2021 10:30:49 -0600
> Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> 
> > On Wed 13 Jan 09:18 CST 2021, Jonathan Albrieux wrote:
> > 
> > > Checking at both msm8909-pm8916.dtsi and msm8916.dtsi from downstream
> > > it is indicated that "batt_id" channel has to be scaled with the default
> > > function:
> > > 
> > > 	chan@31 {
> > > 		label = "batt_id";
> > > 		reg = <0x31>;
> > > 		qcom,decimation = <0>;
> > > 		qcom,pre-div-channel-scaling = <0>;
> > > 		qcom,calibration-type = "ratiometric";
> > > 		qcom,scale-function = <0>;
> > > 		qcom,hw-settle-time = <0xb>;
> > > 		qcom,fast-avg-setup = <0>;
> > > 	};
> > > 
> > > Change LR_MUX2_BAT_ID scaling accordingly.
> > >   
> > 
> > Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Not entirely sure, but looking at the history I think this used to work
> > - but it's obvious that no one has read this channel for a while...
> > 
> > But I think below is a regression and should be mentioned:
> > 
> > Fixes: 7c271eea7b8a ("iio: adc: spmi-vadc: Changes to support different scaling")
> > 
> 
> Yikes that was a while ago :)
> 
> > > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>  
> > 
> > Jonathan Cameron, if you merge this through your tree I can take the dts
> > addition through the Qualcomm tree.
> 
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
> I'm not going to rush this one given age of the bug, but if I happen to
> have anything else going it'll make it before the end of this cycle.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Regards,
> > Bjorn
> > 
> > > ---
> > >  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> > > index b0388f8a69f4..7e7d408452ec 100644
> > > --- a/drivers/iio/adc/qcom-spmi-vadc.c
> > > +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> > > @@ -598,7 +598,7 @@ static const struct vadc_channels vadc_chans[] = {
> > >  	VADC_CHAN_NO_SCALE(P_MUX16_1_3, 1)
> > >  
> > >  	VADC_CHAN_NO_SCALE(LR_MUX1_BAT_THERM, 0)
> > > -	VADC_CHAN_NO_SCALE(LR_MUX2_BAT_ID, 0)
> > > +	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0, SCALE_DEFAULT)
> > >  	VADC_CHAN_NO_SCALE(LR_MUX3_XO_THERM, 0)
> > >  	VADC_CHAN_NO_SCALE(LR_MUX4_AMUX_THM1, 0)
> > >  	VADC_CHAN_NO_SCALE(LR_MUX5_AMUX_THM2, 0)
> > > -- 
> > > 2.17.1
> > >   
> 
Thank you Bjorn, thank you Jonathan,

Regards,

Jonathan

