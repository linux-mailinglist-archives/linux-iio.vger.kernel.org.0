Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C261FA4A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 17:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKGQqb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 11:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiKGQqa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 11:46:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8A60C4;
        Mon,  7 Nov 2022 08:46:29 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5cWx0RY4z67QFM;
        Tue,  8 Nov 2022 00:44:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:46:27 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 16:46:27 +0000
Date:   Mon, 7 Nov 2022 16:46:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <corbet@lwn.net>
Subject: Re: [PATCH RESEND] Documentation: devres: add missing IIO helpers
Message-ID: <20221107164626.0000223b@Huawei.com>
In-Reply-To: <7e984b00-8845-8938-1495-334c8d4db878@huawei.com>
References: <20221103023402.1024437-1-yangyingliang@huawei.com>
        <20221105150812.66d81f40@jic23-huawei>
        <7e984b00-8845-8938-1495-334c8d4db878@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Nov 2022 09:25:28 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Hi,
> 
> On 2022/11/5 23:08, Jonathan Cameron wrote:
> > On Thu, 3 Nov 2022 10:34:02 +0800
> > Yang Yingliang <yangyingliang@huawei.com> wrote:
> >  
> >> Add some missing device-managed helpers of iio to devres.rst.
> >>
> >> devm_iio_kfifo_buffer_setup_ext() is introduced by commit 0a21526bc1d4 ("iio:
> >> kfifo: add devm_iio_triggered_buffer_setup_ext variant").
> >>
> >> devm_iio_triggered_buffer_setup_ext() is introduced by commit 5164c7889857 ("iio:
> >> triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants").
> >>
> >> devm_iio_hw_consumer_alloc() is introduced by b688c18d3006 ("IIO: hw_consumer:
> >> add devm_iio_hw_consumer_alloc").
> >>
> >> devm_fwnode_iio_channel_get_by_name() is introduced by commit 1e64b9c5f9a0 ("iio:
> >> inkern: move to fwnode properties").
> >>
> >> Fixes: 0a21526bc1d4 ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
> >> Fixes: 5164c7889857 ("iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants")
> >> Fixes: b688c18d3006 ("IIO: hw_consumer: add devm_iio_hw_consumer_alloc")
> >> Fixes: 1e64b9c5f9a0 ("iio: inkern: move to fwnode properties")
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>  
> > You didn't pick up my
> >
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > or mention that my assumption is that this will go via the docs tree.  
> I changed the commit message, it's not same as the earlier patch, so I 
> didn't add your ACK tag.
> It's nice that you acked this patch.
> 

Ah understood.  For something as small as that, just keep tags.

Thanks,

Jonathan

> Thanks,
> Yang
> >
> > Thanks,
> >
> > Jonathan
> >  
> >> ---
> >> The previous patch link:
> >> https://patchwork.kernel.org/project/linux-iio/patch/20220927074043.942836-1-yangyingliang@huawei.com/
> >> ---
> >>   Documentation/driver-api/driver-model/devres.rst | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> >> index e0cb7df0f782..4249eb4239e0 100644
> >> --- a/Documentation/driver-api/driver-model/devres.rst
> >> +++ b/Documentation/driver-api/driver-model/devres.rst
> >> @@ -287,12 +287,16 @@ IIO
> >>     devm_iio_device_register()
> >>     devm_iio_dmaengine_buffer_setup()
> >>     devm_iio_kfifo_buffer_setup()
> >> +  devm_iio_kfifo_buffer_setup_ext()
> >>     devm_iio_map_array_register()
> >>     devm_iio_triggered_buffer_setup()
> >> +  devm_iio_triggered_buffer_setup_ext()
> >>     devm_iio_trigger_alloc()
> >>     devm_iio_trigger_register()
> >>     devm_iio_channel_get()
> >>     devm_iio_channel_get_all()
> >> +  devm_iio_hw_consumer_alloc()
> >> +  devm_fwnode_iio_channel_get_by_name()
> >>   
> >>   INPUT
> >>     devm_input_allocate_device()  
> > .  

