Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414AD6836EE
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAaT6z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 14:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaT6z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 14:58:55 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B2D55295
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:58:54 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 00F7431A;
        Tue, 31 Jan 2023 19:58:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00F7431A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675195133; bh=ZCt1IfkEzUXVywRWkQ7G+I1KBmJtF8RsZ7cPo2Ls5nY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tWwb0yIYkddA8M/1FbCDM/YBn4+NVvCg7aBqZzRsKL4Utcveus+C8jzKcLP7ry9VD
         Ie/UHDVnyimDTmF3M2YLG3EzD84l0wnkIVjBqTiAy7RNKwHyVefCwgtLbIfMP+EB7b
         Cyuvy5NO8W0rN8BEPe9YeH/ZKVzC92OtzDTX5emSplejNqi9LQIz6Gd6tdr24hQbaX
         K0QJlcha3FYtPotvCPO3udgkwsY6fs8BxWKlljw3i/ovSldTsffi0O8WplvhKmO4Ui
         qGd7XcHks25myFIXyHvBluMyv5ve6rnQHjRq2VFxA/AN3bihdJkqEDkmMQ4xHaofgG
         u5iyPTtYDaKrg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: ROHM ALS, integration time
In-Reply-To: <20230130201929.52c93ee5@jic23-huawei>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
 <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
 <20230130171218.00007802@Huawei.com>
 <0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com>
 <20230130201929.52c93ee5@jic23-huawei>
Date:   Tue, 31 Jan 2023 12:58:52 -0700
Message-ID: <877cx24gsj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> writes:

> Both the kernel-doc for this header and the ABI docs end up in
> the kernel html docs.  I wonder if a link is possible...
> https://docs.kernel.org/driver-api/iio/core.html#industrial-i-o-devices
> would have the iio_chan_type docs I think if there were any.
> https://docs.kernel.org/admin-guide/abi-testing.html?highlight=abi#abi-sys-iio-devicex-in-intensityy-raw 
> is the matching ABI doc. 
>
> Mauro, Jon, other docs system experts...
>
> I couldn't immediately find a way to link to a specific ABI docs entry,
> is there a means to do it from kernel-doc in a header?

It should just be possible to write out the type or function name and
have the links generated automatically.  Have you tried just putting
"enum iio_chan_type" into the text?  If the automarkup code doesn't pick
it up, please let me know.

Thanks,

jon
