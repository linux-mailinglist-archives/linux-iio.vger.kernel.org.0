Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3292267F13
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgIMKDq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 06:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMKDp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 06:03:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71FC208E4;
        Sun, 13 Sep 2020 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599991424;
        bh=eF+NCdxa/bNQ0Tax61mNbg/8nJfv0aGzf9zpAk3WTZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOHalwwflSZpU/dlZvtUGEpNlQQ90Fi+5JnueY9DXwgtnA+j/7l2vCSyC9I/r3T4+
         OFr4Wyk/hxK0Xi5XCvdJc2lUEasYyKMGRWKnHGYkmdU6H5P3bB3y5tu2iyKVIpmbmW
         Sn0to4lRhdHoTay0OvPAsKc+/eNaiG81usQy64wg=
Date:   Sun, 13 Sep 2020 11:03:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 01/10] iio: adc: qcom-spmi-adc5: fix driver name
Message-ID: <20200913110335.4687ab89@archlinux>
In-Reply-To: <20200910140000.324091-2-dmitry.baryshkov@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
        <20200910140000.324091-2-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 16:59:51 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> Remove superfluous '.c' from qcom-spmi-adc5 device driver name.
> 
> Fixes: e13d757279 ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

In the interests of getting this one into stable reasonably quickly I've
pulled it off this set and applied it to my fixes-togreg branch of iio.git.

Shouldn't cause any problems taking the rest of the set via whatever path
makes most sense.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index b4b73c9920b4..c10aa28be70a 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -982,7 +982,7 @@ static int adc5_probe(struct platform_device *pdev)
>  
>  static struct platform_driver adc5_driver = {
>  	.driver = {
> -		.name = "qcom-spmi-adc5.c",
> +		.name = "qcom-spmi-adc5",
>  		.of_match_table = adc5_match_table,
>  	},
>  	.probe = adc5_probe,

