Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0425EE27
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgIFOZk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgIFOY7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:24:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623082080A;
        Sun,  6 Sep 2020 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402299;
        bh=06V45EMdGaN9yTRsyCZ4Mrb5+S2PGIlyBvgPv8ULiAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rp6IUSgFEQAhH/DEh2a3bdjMwuyP/XF3fkCY4RPMX438ITSGybr9UlXRdNFzy72Hv
         F4Xvml2tGhSS4/8AB56gnF0ktfRzoH0jzBkNNIMuwCfC2ImgOgZ310+WCjempC55/z
         A68aMPTsvO2HKhiqQ4ss4qr/qPOCZ/H18cGXTZmQ=
Date:   Sun, 6 Sep 2020 15:24:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: adc: qcom-spmi-adc5: fix driver name
Message-ID: <20200906152452.58f322db@archlinux>
In-Reply-To: <20200904111402.GC4056@mani>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
        <20200903132109.1914011-6-dmitry.baryshkov@linaro.org>
        <20200904111402.GC4056@mani>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Sep 2020 16:44:02 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On 0903, Dmitry Baryshkov wrote:
> > Remove superfluous '.c' from qcom-spmi-adc5 device driver name.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>  
> 
> Please add Fixes tag, with that:
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Ouch.  Technically this is ABI change, but given I'd hope anyone using
the name would have noticed the .c was odd and shouting about it I guess
no one is using it.

Could you pull this to the front of v3 (with fixes tag) so I can pick it up
for stable without having to deal with fuzz etc.

Thanks,

Jonathan

> 
> Thanks,
> Mani
> 
> > ---
> >  drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > index 30b8867b31e4..c2da8f068b87 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > @@ -919,7 +919,7 @@ static int adc5_probe(struct platform_device *pdev)
> >  
> >  static struct platform_driver adc5_driver = {
> >  	.driver = {
> > -		.name = "qcom-spmi-adc5.c",
> > +		.name = "qcom-spmi-adc5",
> >  		.of_match_table = adc5_match_table,
> >  	},
> >  	.probe = adc5_probe,
> > -- 
> > 2.28.0
> >   

