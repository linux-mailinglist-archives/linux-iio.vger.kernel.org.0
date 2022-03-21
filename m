Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B54E2B70
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbiCUPFn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCUPFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 11:05:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F654BE9;
        Mon, 21 Mar 2022 08:04:17 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KMdBR42Bgz67Cxn;
        Mon, 21 Mar 2022 23:02:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 21 Mar 2022 16:04:15 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 15:04:13 +0000
Date:   Mon, 21 Mar 2022 15:04:11 +0000
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
Message-ID: <20220321150411.00002206@Huawei.com>
In-Reply-To: <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
References: <20220310133938.2495-1-michael.srba@seznam.cz>
        <20220310133938.2495-2-michael.srba@seznam.cz>
        <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
        <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
        <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
        <20220320151223.3a9b13bd@jic23-huawei>
        <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
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

On Mon, 21 Mar 2022 09:04:11 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 20/03/2022 16:12, Jonathan Cameron wrote:
> > On Thu, 10 Mar 2022 22:24:03 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> >   
> >> On 10/03/2022 19:56, Michael Srba wrote:  
> >>> Hi,
> >>> the thing is, the only reason the different compatible is needed at all
> >>> is that the chip presents a different WHOAMI, and the invensense,icm20608
> >>> compatible seems to imply the non-D WHOAMI value.    
> >>
> >> But this is a driver implementation issue, not related to bindings.
> >> Bindings describe the hardware.  
> > 
> > Indeed, but the key thing here is the WHOAMI register is hardware.
> >   
> >>  
> >>> I'm not sure how the driver would react to both compatibles being present,
> >>> and looking at the driver code, it seems that icm20608d is not the only
> >>> fully icm20608-compatible (to the extent of features supported by
> >>> the driver, and excluding the WHOAMI value) invensense IC, yet none
> >>> of these other ICs add the invensense,icm20608 compatible, so I guess I
> >>> don't see a good reason to do something different.    
> >>
> >> Probably my question should be asked earlier, when these other
> >> compatibles were added in such way.
> >>
> >> Skipping the DMP core, the new device is fully backwards compatible with
> >> icm20608.  
> > 
> > No. It is 'nearly' compatible...  The different WHOAMI value (used
> > to check the chip is the one we expect) makes it incompatible.  Now we
> > could change the driver to allow for that bit of incompatibility and
> > some other drivers do (often warning when the whoami is wrong but continuing
> > anyway).   
> 
> Different value of HW register within the same programming model does
> not make him incompatible. Quite contrary - it is compatible and to
> differentiate variants you do not need specific compatibles.

Whilst I don't personally agree with the definition of "compatible"
and think you are making false distinctions between hardware and software...

I'll accept Rob's statement of best practice.  However we can't just
add a compatible that won't work if someone uses it on a new board
that happens to run an old kernel.

Jonathan


> 
> Using arguments how driver behaves is wrong. Driver does not determine
> hardware/bindings.
> 
> >   
> >> Therefore extending the compatible makes sense. This is not
> >> only correct from devicetree point of view, but also is friendly towards
> >> out of tree users of bindings.
> >>
> >> The Linux driver behavior about whoami register does not matter here.
> >> Not mentioning that it would be easy for driver to accept multiple
> >> values of whoami.  
> > 
> > I disagree entirely. Any driver that makes use of the whoami will not
> > be compatible with this new part.  
> 
> Driver implementation is not related to bindings, does not matter. You
> cannot use driver implementation as argument in discussion about
> bindings and compatibility. Implementation differs, is limited, can be
> changed.
> 
> >   It's a driver design choice on whether
> > to make use of that, but it's a perfectly valid one to refuse to probe
> > if it doesn't detect that the device is the one it expects.  
> 
> Still not argument about bindings and compatibility but about driver. 
> 
> > + There is code out there today doing this so inherently it is not
> > compatible.  
> 
> Still code of driver, not bindings/DTS/hardware.
> 
> > 
> > So no, a fall back compatible is not suitable here because it simply
> > is not compatible.
> > 
> > Now, if intent was to provide a backwards compatible path from this
> > more advanced part then the behaviour of every register defined for
> > the simpler part, must be identical on the more advanced part.  
> 
> There is no backwards compatibility of advanced path, so the DMP core.
> The device (not driver, we do not talk here about driver) is compatible
> with basic version fully. 100%. Only this part you need to keep always
> compatible between each other,
> 
> > Extra functionality could only make use of fields in registers marked
> > reserved, or of new registers that didn't exist on the simpler device.  
> 
> Extra functionality is for new, extended compatible. See
> Documentation/devicetree/bindings/ABI.rst which exactly explains this case.
> 
> 
> 
> Best regards,
> Krzysztof

