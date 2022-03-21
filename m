Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952704E2B5D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349732AbiCUPAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiCUPAS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 11:00:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157427FF0;
        Mon, 21 Mar 2022 07:58:52 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KMd4k0kwRz67JXs;
        Mon, 21 Mar 2022 22:57:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 15:58:50 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 14:58:48 +0000
Date:   Mon, 21 Mar 2022 14:58:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <michael.srba@seznam.cz>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <20220321145846.000066ba@Huawei.com>
In-Reply-To: <Yjdqwlp4NFpuj4vT@robh.at.kernel.org>
References: <20220311161600.1469-1-michael.srba@seznam.cz>
        <20220311161600.1469-2-michael.srba@seznam.cz>
        <20220320151525.34db502c@jic23-huawei>
        <Yjdqwlp4NFpuj4vT@robh.at.kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Mar 2022 13:56:18 -0400
Rob Herring <robh@kernel.org> wrote:

> On Sun, Mar 20, 2022 at 03:15:25PM +0000, Jonathan Cameron wrote:
> > On Fri, 11 Mar 2022 17:15:59 +0100
> > michael.srba@seznam.cz wrote:
> >   
> > > From: Michael Srba <Michael.Srba@seznam.cz>
> > > 
> > > ICM-20608-D differs from the other ICM-20608 variants by having
> > > a DMP (Digital Motion Processor) core tacked on.
> > > Despite having a different WHOAMI register, this variant is
> > > completely interchangeable with the other ICM-20608 variants
> > > by simply pretending the DMP core doesn't exist.
> > > 
> > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > ---
> > > changelog:
> > >  - v2: require specifying "invensense,icm20608" as a fallback compatible  
> > 
> > Apologies that I joined the thread for v1 late, but no. That doesn't work.
> > If the older driver before the new ID is present with this binding
> > it won't probe because of the WHOAMI value difference so it's not
> > compatible.
> > 
> > I'm fine with the v1 version.  
> 
> If the driver didn't check WHOAMI then it would be compatible. So does 
> driver implementation determine what's compatible or not? It shouldn't 
> as those are supposed to be decoupled.

OK. That decoupling needs perhaps to be more clearly stated as it wasn't
something I was keeping an eye open for in drivers.

It does check them and warns if there isn't a match. This is partly historical
because we had board implementers switch to an 'mostly' compatible part
that was fine with their software stack but not with the Linux drivers and
those bugs were hard to diagnose. We didn't support he particular WHOAMI
at the time so the check was dded.

The code could be improved as it carries on using the chip
specified when it should perhaps use the one matched on WHOAMI.  
The discussion of the original patch that added the check
"iio: inv_mpu6050: Check WHO_AM_I register on probe"
included a request for such a change as a follow up patch.
I guess that never showed up.

The driver supports a bunch of parts that aren't completely compatible
from a register interface point of view + we have other drivers supporting
additional parts. The particular question of which part is supported
by what driver is a choice that other software stacks may have made
differently. So we can't have a general compatible covering everything
supported by the driver.

Having said that we could do subsets where a particular compatible
maps to some of the supported parts where the compatibility is such that
it is unlikely another OS would chose to support them with different
drivers.

> 
> Generally, if there are h/w id registers, then we'll rely on them and 
> don't need a compatible for every variant.

I don't mind the driver moving to that model, but it's not true today
and we'd still have to be careful with what we describe with each
compatible.

Jonathan
> 
> Rob

