Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C9A5F2338
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJBMt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBMt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 08:49:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245833E24;
        Sun,  2 Oct 2022 05:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23A47B80D31;
        Sun,  2 Oct 2022 12:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F1C43144;
        Sun,  2 Oct 2022 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664714963;
        bh=Am1RtIdozVCQJlWBrLpQs0UAXpZtMu5QkaEZu9Jo8n8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ab3lfQKiSUTvrOXYqGWt6qI8YNJI2MzUqMMrjuG0kMrlKWOJdZGoIfWGahNixuHuO
         8Id14ajYOYtN/+MhuKNM6EEtSrcI2DRjjO8OPagxLPb1LxGj6qUfHowrvZnvX/5df5
         XaokptoPnsqMxdG70zoJfM0pJXVtVsa9PQp80eF3S33pSRrFz0K9Lr5DBOcWHOZscT
         5tPXxBZl7Sg/aOsoeLySGps0XZOxRsMjgyKvpNzlC6AldEvxMZyYawt95Tkt2AboVF
         S0LWvB/zeWr4IBnDjarJBQ5mkg0Ne6KyPDFyrY64jncDFKM12LUuS+98fUIbRFQ8ui
         QVzqRPwb5cDtg==
Date:   Sun, 2 Oct 2022 13:49:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Jonathan.Cameron@huawei.com>, <corbet@lwn.net>
Subject: Re: [PATCH -next] Documentation: devres: add missing IIO helpers
Message-ID: <20221002134939.76aa2181@jic23-huawei>
In-Reply-To: <850dabb9-e62b-2273-9371-1ae1b7535e50@huawei.com>
References: <20220927074043.942836-1-yangyingliang@huawei.com>
        <850dabb9-e62b-2273-9371-1ae1b7535e50@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Sep 2022 16:09:02 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Add Cc: Jonathan Corbet <corbet@lwn.net>
> 
> On 2022/9/27 15:40, Yang Yingliang wrote:
> > Add missing device-managed helpers of iio to devres.rst.
> >
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
I'm assuming this will go via the docs tree.
Thanks for tidying this up.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   Documentation/driver-api/driver-model/devres.rst | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> > index 2895f9ea00c4..5154844bc222 100644
> > --- a/Documentation/driver-api/driver-model/devres.rst
> > +++ b/Documentation/driver-api/driver-model/devres.rst
> > @@ -286,12 +286,16 @@ IIO
> >     devm_iio_device_register()
> >     devm_iio_dmaengine_buffer_setup()
> >     devm_iio_kfifo_buffer_setup()
> > +  devm_iio_kfifo_buffer_setup_ext()
> >     devm_iio_map_array_register()
> >     devm_iio_triggered_buffer_setup()
> > +  devm_iio_triggered_buffer_setup_ext()
> >     devm_iio_trigger_alloc()
> >     devm_iio_trigger_register()
> >     devm_iio_channel_get()
> >     devm_iio_channel_get_all()
> > +  devm_iio_hw_consumer_alloc()
> > +  devm_fwnode_iio_channel_get_by_name()
> >   
> >   INPUT
> >     devm_input_allocate_device()  

