Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F014FF778
	for <lists+linux-iio@lfdr.de>; Wed, 13 Apr 2022 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiDMNP7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Apr 2022 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiDMNP6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2022 09:15:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573955BC2;
        Wed, 13 Apr 2022 06:13:33 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kdjdy4qjrz6842y;
        Wed, 13 Apr 2022 21:11:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 15:13:31 +0200
Received: from localhost (10.81.205.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 14:13:30 +0100
Date:   Wed, 13 Apr 2022 14:13:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <amit.pundir@linaro.org>,
        <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v13 5/9] iio: adc: qcom-spmi-rradc: introduce round
 robin adc
Message-ID: <20220413141326.000018af@Huawei.com>
In-Reply-To: <YlY+k4FcWoT/jEkJ@ripper>
References: <20220323162820.110806-1-caleb@connolly.tech>
        <20220323162820.110806-6-caleb@connolly.tech>
        <20220327160329.6a3866d7@jic23-huawei>
        <YlY+k4FcWoT/jEkJ@ripper>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.148]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Apr 2022 20:08:03 -0700
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Sun 27 Mar 08:03 PDT 2022, Jonathan Cameron wrote:
> 
> > On Wed, 23 Mar 2022 16:28:16 +0000
> > Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >   
> > > From: Caleb Connolly <caleb.connolly@linaro.org>
> > > 
> > > The Round Robin ADC is responsible for reading data about the rate of
> > > charge from the USB or DC input ports, it can also read the battery
> > > ID (resistence), skin temperature and the die temperature of the pmic.
> > > It is found on the PMI8998 and PM660 Qualcomm PMICs.
> > > 
> > > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>  
> > Whilst I said this patch was fine a few versions ago I didn't add a tag
> > on basis I would probably end up picking it up.
> > 
> > To make things more flexible, I'll add one and either Lee or I can
> > do the immutable branch once Lee has had a chance to take a look and
> > is happy with the mfd parts.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> 
> Are either of you planning to pick up the driver changes?
> 
> The dts changes can be merged independently, so I would prefer to pick
> those through my tree. But I would like to know that the binding and
> implementation is agreed upon before doing so.

I need an Ack from Lee for the mfd changes and ideally Stephen for the SPMI
patch.

Lee, guessing you are busy, but if you have a chance to check this set over
that would be great.

Jonathan

> 
> Thanks,
> Bjorn

