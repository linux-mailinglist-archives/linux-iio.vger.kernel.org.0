Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8A4E2F44
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345607AbiCURnf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiCURne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 13:43:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF818CD17;
        Mon, 21 Mar 2022 10:42:08 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KMhjr0NYSz67M4k;
        Tue, 22 Mar 2022 01:41:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 18:42:06 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 17:42:04 +0000
Date:   Mon, 21 Mar 2022 17:42:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <20220321174202.00007895@Huawei.com>
In-Reply-To: <47d67c82-788e-2ced-54cc-4959c67922fc@kernel.org>
References: <20220310133938.2495-1-michael.srba@seznam.cz>
        <20220310133938.2495-2-michael.srba@seznam.cz>
        <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
        <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
        <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
        <20220320151223.3a9b13bd@jic23-huawei>
        <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
        <20220321150411.00002206@Huawei.com>
        <47d67c82-788e-2ced-54cc-4959c67922fc@kernel.org>
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

On Mon, 21 Mar 2022 16:22:38 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 21/03/2022 16:04, Jonathan Cameron wrote:
> > On Mon, 21 Mar 2022 09:04:11 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On 20/03/2022 16:12, Jonathan Cameron wrote:  
> >>> On Thu, 10 Mar 2022 22:24:03 +0100
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> >>>     
> >>>> On 10/03/2022 19:56, Michael Srba wrote:    
> >>>>> Hi,
> >>>>> the thing is, the only reason the different compatible is needed at all
> >>>>> is that the chip presents a different WHOAMI, and the invensense,icm20608
> >>>>> compatible seems to imply the non-D WHOAMI value.      
> >>>>
> >>>> But this is a driver implementation issue, not related to bindings.
> >>>> Bindings describe the hardware.    
> >>>
> >>> Indeed, but the key thing here is the WHOAMI register is hardware.
> >>>     
> >>>>    
> >>>>> I'm not sure how the driver would react to both compatibles being present,
> >>>>> and looking at the driver code, it seems that icm20608d is not the only
> >>>>> fully icm20608-compatible (to the extent of features supported by
> >>>>> the driver, and excluding the WHOAMI value) invensense IC, yet none
> >>>>> of these other ICs add the invensense,icm20608 compatible, so I guess I
> >>>>> don't see a good reason to do something different.      
> >>>>
> >>>> Probably my question should be asked earlier, when these other
> >>>> compatibles were added in such way.
> >>>>
> >>>> Skipping the DMP core, the new device is fully backwards compatible with
> >>>> icm20608.    
> >>>
> >>> No. It is 'nearly' compatible...  The different WHOAMI value (used
> >>> to check the chip is the one we expect) makes it incompatible.  Now we
> >>> could change the driver to allow for that bit of incompatibility and
> >>> some other drivers do (often warning when the whoami is wrong but continuing
> >>> anyway).     
> >>
> >> Different value of HW register within the same programming model does
> >> not make him incompatible. Quite contrary - it is compatible and to
> >> differentiate variants you do not need specific compatibles.  
> > 
> > Whilst I don't personally agree with the definition of "compatible"
> > and think you are making false distinctions between hardware and software...
> > 
> > I'll accept Rob's statement of best practice.  However we can't just
> > add a compatible that won't work if someone uses it on a new board
> > that happens to run an old kernel.
> >   
> 
> The please explain me how this patch (the compatible set I proposed)
> fails to work in such case? How a new board with icm20608 (not
> icm20608d!) fails to work?

I'm confused.  An actual icm20608 would work.
I guess you mean an icm20608d via compatible "invensense,icm20608"?

> 
> To remind, the compatible has a format of:
> comaptible = "new", "old"
> e.g.: "invensense,icm20608d", "invensense,icm20608"

Old kernel fails to match invensense,icm20608d, matches on invensense,icm20608.
Checks the WHOAMI value and reports a missmatched value and fails the probe
as it has no idea what the part was so no idea how to support it.

Obviously it wouldn't work anyway with an old kernel, but
without the fallback compatible at least there would be no error message
saying that the device is not the icm20608 we expected to see.

Jonathan

> 
> Best regards,
> Krzysztof

