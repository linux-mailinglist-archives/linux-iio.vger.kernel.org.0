Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E02F80D7
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbhAOQby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbhAOQbx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 11:31:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28489C061795
        for <linux-iio@vger.kernel.org>; Fri, 15 Jan 2021 08:30:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id c18so3277665oto.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Jan 2021 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3zlhE1VQoC0YQoOVBpqCppA99bsDhHzDe1MR/nnPda8=;
        b=BbV4E43/1M1Vmn39MFeDNpZOcyiOIdxjYFAJXjgk6V9LN7JUmebkYjQqv9L4c9bk0B
         Jh6LnqqDExgti8XlbpAURUR/LcR23gs+qC4qPzQRLSvIiJyc7XPoulVYQRQBPZhjWUmx
         xojSbm70qMh7UW7LsrICI8aJtgl7u4vzHWlr4yZdP0zj7DYI2K6jH+WsWn1oTZqufRz4
         boV+VXwlAnE3Qf+5C4AumEbZelr8GwHUEtN7vXDjaPdTYE0j6Dmx3pYySjbEKoXNONAe
         1Hi2CPLC8sTzsgwtRiEyQ0QeplfkrlSZ14exg4Qi2XUxMV4q+8vSACZLU/eeIqxRijfy
         pc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zlhE1VQoC0YQoOVBpqCppA99bsDhHzDe1MR/nnPda8=;
        b=WPkZiaOIue0xEeq7ZxHxkzBRjSu53N8iteje2FAGFY12e1+7sJ3XJpvJhQj+zDEP24
         a68UFzraiLiEIEgiBJKi4ZssNNbb00FSySO1W4zR4qOgTtr53VuN6+a8HgGG3XEiGJeO
         ua+YzQu1lR+NsvIvMgcs92AypU+i+w2eniLVP12iQnsaeGKiZ6d2fFTFKjgNXGRYkWUY
         RLGSygbQmzX0Zoi4h6vy6fT30YJkZW9kF/sPtWtz0T9TbIwAA7/vi8ECekIP0KPD2Bpg
         qpP9w0l3xDKjf2oVNfl2WQ/fo4Ir3fV8k9o6lYvTxEWXGb0qbqDFc1BvebffyuvqIs6J
         xUTw==
X-Gm-Message-State: AOAM532JRxhCVECQuXuJXK55O1SIkaC/nfGt3pJQbgP57op0rPjcFOGA
        iWLHZc6n09dxo3Sc9G5qcJIGtuHCHjZsAw==
X-Google-Smtp-Source: ABdhPJw9QuYGlWtxZKlmSYDACbI1/xs++9fTUIQlKrR2IpKC1dLXb4iCeDvN8vx4NykIIQRb44fzIQ==
X-Received: by 2002:a9d:19cb:: with SMTP id k69mr8999620otk.75.1610728252325;
        Fri, 15 Jan 2021 08:30:52 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w10sm1749903oic.44.2021.01.15.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:30:51 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:30:49 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:adc:qcom-spmi-vadc: add default scale to
 LR_MUX2_BAT_ID channel
Message-ID: <YAHDOaZoSSGZexFa@builder.lan>
References: <20210113151808.4628-1-jonathan.albrieux@gmail.com>
 <20210113151808.4628-2-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113151808.4628-2-jonathan.albrieux@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed 13 Jan 09:18 CST 2021, Jonathan Albrieux wrote:

> Checking at both msm8909-pm8916.dtsi and msm8916.dtsi from downstream
> it is indicated that "batt_id" channel has to be scaled with the default
> function:
> 
> 	chan@31 {
> 		label = "batt_id";
> 		reg = <0x31>;
> 		qcom,decimation = <0>;
> 		qcom,pre-div-channel-scaling = <0>;
> 		qcom,calibration-type = "ratiometric";
> 		qcom,scale-function = <0>;
> 		qcom,hw-settle-time = <0xb>;
> 		qcom,fast-avg-setup = <0>;
> 	};
> 
> Change LR_MUX2_BAT_ID scaling accordingly.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Not entirely sure, but looking at the history I think this used to work
- but it's obvious that no one has read this channel for a while...

But I think below is a regression and should be mentioned:

Fixes: 7c271eea7b8a ("iio: adc: spmi-vadc: Changes to support different scaling")

> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Jonathan Cameron, if you merge this through your tree I can take the dts
addition through the Qualcomm tree.

Regards,
Bjorn

> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index b0388f8a69f4..7e7d408452ec 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -598,7 +598,7 @@ static const struct vadc_channels vadc_chans[] = {
>  	VADC_CHAN_NO_SCALE(P_MUX16_1_3, 1)
>  
>  	VADC_CHAN_NO_SCALE(LR_MUX1_BAT_THERM, 0)
> -	VADC_CHAN_NO_SCALE(LR_MUX2_BAT_ID, 0)
> +	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0, SCALE_DEFAULT)
>  	VADC_CHAN_NO_SCALE(LR_MUX3_XO_THERM, 0)
>  	VADC_CHAN_NO_SCALE(LR_MUX4_AMUX_THM1, 0)
>  	VADC_CHAN_NO_SCALE(LR_MUX5_AMUX_THM2, 0)
> -- 
> 2.17.1
> 
