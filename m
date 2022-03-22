Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9A4E4765
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 21:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiCVUXv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiCVUXu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 16:23:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E165825;
        Tue, 22 Mar 2022 13:22:20 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNND83Rvmz67lYX;
        Wed, 23 Mar 2022 04:21:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 21:22:17 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 20:22:16 +0000
Date:   Tue, 22 Mar 2022 20:22:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Michael Srba <Michael.Srba@seznam.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <20220322202215.000046f9@Huawei.com>
In-Reply-To: <5709ab75-2c9e-d7d3-eaf7-4619583bb6c6@kernel.org>
References: <20220310133938.2495-1-michael.srba@seznam.cz>
        <20220310133938.2495-2-michael.srba@seznam.cz>
        <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
        <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
        <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
        <20220320151223.3a9b13bd@jic23-huawei>
        <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
        <20220321150411.00002206@Huawei.com>
        <47d67c82-788e-2ced-54cc-4959c67922fc@kernel.org>
        <20220321174202.00007895@Huawei.com>
        <f8ba569f-d230-92a8-6a56-fbcaf620af36@seznam.cz>
        <20220322101916.0000759f@Huawei.com>
        <5709ab75-2c9e-d7d3-eaf7-4619583bb6c6@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.191]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
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

On Tue, 22 Mar 2022 11:41:11 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 22/03/2022 11:19, Jonathan Cameron wrote:
> >>> Obviously it wouldn't work anyway with an old kernel, but
> >>> without the fallback compatible at least there would be no error message
> >>> saying that the device is not the icm20608 we expected to see.    
> >> I'm not sure if that's really an issue?
> >> The old kernel is clearly not handling the compatible "correctly",
> >> since the compatible says that the interface is a superset of
> >> the icm20608 interface, and that using the icm20608
> >> interface will work.
> >> If the driver makes the incorrect assumption that
> >> the WHOAMI being different means the interface cannot
> >> be icm20608 compatible, then that seems like an issue
> >> with the driver?
> >> And I believe the single reason for why catering to
> >> a broken driver would ever be considered is if not doing
> >> so would result in breaking the devicetree ABI promise,
> >> which doesn't seem to happen here.  
> > 
> > I'll be honest I no longer care that much either way.
> > 
> > If someone would point me to clear documentation of that
> > DT ABI promise   
> 
> Documentation/devicetree/bindings/ABI.rst

Hi Krzyztof,

I am not willfully ignoring your reference. I simply disagree
that it says what you understand it to.  This may be an aspect of
the intended meaning but it is sufficiently vague that I read
that reference several times and did not come to the same
conclusion as you have.

If you want to take your description and propose it as additional
documentation I would be happy to review it.

I'm not keen to continue this discussion because we are talking
cross purposes and going over the same ground with no fundamental
change of opinions, so it is not productive use of time.

Jonathan

> 
> > and how it describes things as being compatible
> > that would be great and provide me with a clear statement
> > to point others to in the future.  
> 
> It's very concise, so let me decipher the first paragraph.
> It is safe to
> add new compatibles to the chain (so exactly like here "icm20608d,
> icm20608") because the system can bind:
> 1. against new compatible bringing all new features,
> 2. old compatible, working with "old" or limited set of features.
> 
> What I was explaining you in mails before, which you responded to with:
> "Whilst I don't personally agree with the definition of "compatible"
> and think you are making false distinctions between hardware and
> software..."
> we do not talk here about software, as in device driver. We talk about
> bindings which describe the hardware, therefore the compatible should be
> rather understood in the hardware model, not driver model.
> 
> The compatible field does not mean that one driver is compatible with
> this or other hardware. It means that devices have a compatible
> programming model or interface.
> 
> Now driver should be implemented in that way. If driver handles
> "icm20608" compatible, it should nicely handle only icm20608 features,
> regardless whether device is icm20608 or icm20608d.
> 
> Now let's imagine, that icm20608d is slightly different than icm20608 in
> the basic feature set. Than it's not compatible and should deserve
> another separate binding entry, regardless how driver handles it.
> 
> Keep in mind what Rob said - driver implementation can changed, but
> device compatibility in bindings should stay the same. Specially that
> bindings are used in other operating systems (*BSD) and software pieces
> (u-boot).
> 
> > Perhaps I've just been missing that documentation or it
> > needs writing.
> > 
> > I think that having to ignore a WHOAMI value that
> > is unknown to the driver because there might be a future part
> > which is compatible is a very bad way to support
> > devices in a reliable fashion and going to lead to annoyed
> > users and bug reports.  
> 
> I see your point. It's a safer choice than just accepting any device.
> However it's a designer/programmers fault to provide a DTB with a
> matching compatible for a non-compatible device. Not driver programmer
> fault. Usually you do not have to protect the driver from it.
> 
> > This is different to electing to
> > using a shared compatible when two parts are introduced at
> > the same time and we are doing detection in the driver of
> > which variant we have.
> > 
> > I mentioned earlier that we have this type of defensive coding
> > precisely because we have had false assessments about
> > compatibility in the past. This manufacturer does not in
> > general document compatibility across parts. I have no idea if
> > they do for this particular part as there doesn't seem to be
> > a public datasheet.  
> 
> Kind of continuing my previous thought also here - it's not a problem of
> driver developer, but DTB developer. If the devices are not compatible
> (thus driver will not work correctly), the person using that compatible
> in DTB made mistake. Bug reports should be sent to that person, not to
> driver developer, not to you.
> 
> > It didn't work before, now it won't work and will complain about it
> > which may lead to some bug reports that won't be resolved but
> > I'll adopt the majority opinion which seems to be that we
> > don't care about that.  
> 
> Yes, we don't care but the DTB/DTS person should. :)
> 
> >  I'd also be happy to see us reduce
> > the problem scope here by having a 'fix' for that rejection
> > of unknown IDs that we can push back to stable kernels.
> > Relaxing it to a warning should be sufficient, though we probably
> > want to screen out whatever comes back from the bus if there
> > is no device present at all as the WHOAMI check is also
> > providing that protection.  
> 
> A dev_warn() with a disclaimer might be actually better approach. Unless
> it might be a safety-critical device.
> 
> Best regards,
> Krzysztof

