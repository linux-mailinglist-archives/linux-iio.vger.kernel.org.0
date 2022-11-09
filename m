Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060B623553
	for <lists+linux-iio@lfdr.de>; Wed,  9 Nov 2022 22:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiKIVBx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Nov 2022 16:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiKIVBh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Nov 2022 16:01:37 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2831222;
        Wed,  9 Nov 2022 13:01:13 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2A2AC37E;
        Wed,  9 Nov 2022 21:01:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A2AC37E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668027673; bh=ITr2R0mtUe/KCYtEsEvbQ007phtJBhesDNR74eyDa8s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UgGFyRZ8JGvPW88XDRVKc/i1yXpdH2cQnF6KWzxrRNQHisnv0R+pYDcLI6QSGJCBo
         eS7Jw7mciZZQwyhwOlLfDEgu+lqghC9K47ebS4riP3utK2ancGqtCvsk9/jJJj2McA
         xK4HtRzv9Wznl7tHx7dnPMVWX/UwdMcBx/jkWfxdw7F8sJm1sHaF26grwVOhc+Gjd7
         ywu3zivVh+UxsZVbcE1q1c7s+xBDD9WEE/ueoaGgc08B/kezCiFIKhqLdai8HSsmzj
         nEJhtzOogJmDpRqJnIhjMj5pzvfBe7Gl/4tZHlx1+dA3d8jZPGabJnl4dFnW2H+Jk7
         Nt8SRuAGma5oQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-doc@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        yangyingliang@huawei.com
Subject: Re: [PATCH RESEND] Documentation: devres: add missing IIO helpers
In-Reply-To: <20221103023402.1024437-1-yangyingliang@huawei.com>
References: <20221103023402.1024437-1-yangyingliang@huawei.com>
Date:   Wed, 09 Nov 2022 14:01:12 -0700
Message-ID: <87tu37j10n.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> writes:

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
> ---
> The previous patch link:
> https://patchwork.kernel.org/project/linux-iio/patch/20220927074043.942836-1-yangyingliang@huawei.com/
> ---
>  Documentation/driver-api/driver-model/devres.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

jon
