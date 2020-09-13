Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB1267F34
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 12:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgIMKVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 06:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgIMKV3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 06:21:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D41320709;
        Sun, 13 Sep 2020 10:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599992488;
        bh=qrXlPjdhm46n8PqoKDSkLIH/KCyIpGttHxR5823h9/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=weVNjj2alHKqBcCuws07QUbCYG/Byuyua+HLPeKGfMmV4IVYvtcumPU8GyWhjgAg8
         0qC127o7njBpUSnWa/XN1NMlIFF9utaRmV6AiOv+d6yXaBqLFsDQrTCa9DK3xwGOoZ
         YaO2dkpiuNsB8gANSro6LYzMwck1dTTP66+qIiwY=
Date:   Sun, 13 Sep 2020 11:21:22 +0100
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
Subject: Re: [PATCH v3 00/10] qcom: pm8150: add support for thermal
 monitoring
Message-ID: <20200913112122.0f4ee51b@archlinux>
In-Reply-To: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 16:59:50 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> This patch serie adds support for thermal monitoring block on Qualcomm's
> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> to support thermal zones provided by this thermal monitoring block.
> Unlike the rest of PMIC thermal senses, these thermal zones describe
> particular thermistors, which differ between from board to board.
> 

As far as I am concerned this series is now ready to go up to one or two
things in patch 8.  So on to the normal question based on the assumption
it will pick up other necessary reviews shortly...

What route do we want this to take? 
I can do an immutable branch in IIO if that works for patches 1-8 and assume
the dt file changes will got via usual SoC path?  We are getting a fair way
into this cycle, so this may well end up happening next cycle depending
on how quick reviews come in.

Thanks,

Jonathan

> Changes since v3:
>  - Fix DT description to spell "thermal monitoring" instead of just TM
>  - Fix warnings in DT example
>  - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
>  - Fixed whitespace chanes in qcom-vadc-common.c
>  - Removed error message if IIO chanel get returns -EPROBE_DEFER
> 
> Changes since v2:
>  - IIO: export of_iio_channel_get_by_name() function
>  - dt-bindings: move individual io-channels to each thermal monitoring
>    channel rather than listing them all in device node
>  - added fallback defaults to of_device_get_match_data calls in
>    qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
>  - minor typo fixes
> 
> Changes since v1:
>  - Introduce fixp_linear_interpolate() by Craig Tatlor
>  - Lots of syntax/whitespace changes
>  - Cleaned up register definitions per Jonathan's suggestion
>  - Implemented most of the suggestions from Bjorn's and Jonathan's
>    review
> 
> 
> 

