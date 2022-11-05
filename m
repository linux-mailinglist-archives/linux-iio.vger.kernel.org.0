Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A861DB8F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Nov 2022 16:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKEPIY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Nov 2022 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiKEPIX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2022 11:08:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87924E;
        Sat,  5 Nov 2022 08:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E70AB800C1;
        Sat,  5 Nov 2022 15:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B966C433C1;
        Sat,  5 Nov 2022 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660899;
        bh=yWbcC0nag9CXDHgeNIYiUOaIkjJlOv4BI1h6LN5fnEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QeBuCDsvt3qUU/pifZXijpmEQtmwV2rZyeBd+fPS5xgRBo5wQdcTwl8y82gffWsyC
         kCN0toUQPgsI0RXOCbW6WGp+ac6pKwwEic/PXLnVQyCoWGUif1Se+B9mrk0zoI6bKi
         h7yor+NXh3jjo3kRl5vRnkoFRrm/tL3l6M7H4EUdPKV7mhvYY1GGPs4PFiGxBt0lKf
         vq+DL6IwAuprmAb+OzKFyqeY2jTt+RpBBL8Zz4hEAVaPWAoCvPjpq3OUT27u8xfank
         5mPGT9IB07ow1tUlQiT+5jGYthErxvcnysdVV38PM0BowPteo/hgx8swusVA6N8NBl
         ZOOslt7fYWQpA==
Date:   Sat, 5 Nov 2022 15:08:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <Jonathan.Cameron@huawei.com>, <corbet@lwn.net>
Subject: Re: [PATCH RESEND] Documentation: devres: add missing IIO helpers
Message-ID: <20221105150812.66d81f40@jic23-huawei>
In-Reply-To: <20221103023402.1024437-1-yangyingliang@huawei.com>
References: <20221103023402.1024437-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Nov 2022 10:34:02 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Add some missing device-managed helpers of iio to devres.rst.
> 
> devm_iio_kfifo_buffer_setup_ext() is introduced by commit 0a21526bc1d4 ("iio:
> kfifo: add devm_iio_triggered_buffer_setup_ext variant").
> 
> devm_iio_triggered_buffer_setup_ext() is introduced by commit 5164c7889857 ("iio:
> triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants").
> 
> devm_iio_hw_consumer_alloc() is introduced by b688c18d3006 ("IIO: hw_consumer:
> add devm_iio_hw_consumer_alloc").
> 
> devm_fwnode_iio_channel_get_by_name() is introduced by commit 1e64b9c5f9a0 ("iio:
> inkern: move to fwnode properties").
> 
> Fixes: 0a21526bc1d4 ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
> Fixes: 5164c7889857 ("iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants")
> Fixes: b688c18d3006 ("IIO: hw_consumer: add devm_iio_hw_consumer_alloc")
> Fixes: 1e64b9c5f9a0 ("iio: inkern: move to fwnode properties")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
You didn't pick up my

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

or mention that my assumption is that this will go via the docs tree.

Thanks,

Jonathan

> ---
> The previous patch link:
> https://patchwork.kernel.org/project/linux-iio/patch/20220927074043.942836-1-yangyingliang@huawei.com/
> ---
>  Documentation/driver-api/driver-model/devres.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index e0cb7df0f782..4249eb4239e0 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -287,12 +287,16 @@ IIO
>    devm_iio_device_register()
>    devm_iio_dmaengine_buffer_setup()
>    devm_iio_kfifo_buffer_setup()
> +  devm_iio_kfifo_buffer_setup_ext()
>    devm_iio_map_array_register()
>    devm_iio_triggered_buffer_setup()
> +  devm_iio_triggered_buffer_setup_ext()
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_register()
>    devm_iio_channel_get()
>    devm_iio_channel_get_all()
> +  devm_iio_hw_consumer_alloc()
> +  devm_fwnode_iio_channel_get_by_name()
>  
>  INPUT
>    devm_input_allocate_device()

