Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366A645F4A5
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhKZSea (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 13:34:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4175 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhKZSca (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 13:32:30 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J13Cn6kj0z67Pf9;
        Sat, 27 Nov 2021 02:28:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 19:29:14 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 18:29:13 +0000
Date:   Fri, 26 Nov 2021 18:29:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V3 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Message-ID: <20211126182911.00005110@Huawei.com>
In-Reply-To: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 11:27:00 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Made following changes in this post:
> Addressed comments given by Jonathan for qcom-spmi-adc-tm5.yaml.
> Addressed comments given by Dmitry and Jonathan for qcom-spmi-adc-tm5.c.
> Split patch for qcom-spmi-adc-tm5.c into two parts, one to refactor
> code to support multiple device generations and the second to add
> actual Gen2 ADC_TM changes.

Series is missing a change log.  Either in cover letter, or in
individual patches after the --

Jonathan

> 
> Jishnu Prakash (4):
>   dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
>   iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
>   thermal: qcom: Add support for multiple generations of devices
>   thermal: qcom: add support for PMIC5 Gen2 ADCTM
> 
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++-
>  drivers/iio/adc/qcom-vadc-common.c                 |  11 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 451 +++++++++++++++++++--
>  include/linux/iio/adc/qcom-vadc-common.h           |   2 +
>  4 files changed, 541 insertions(+), 33 deletions(-)
> 

