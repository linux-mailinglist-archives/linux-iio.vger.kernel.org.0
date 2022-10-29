Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B26122F7
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ2MhE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ2MhD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B5057E20
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 05:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAD360921
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 12:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0F3C433C1;
        Sat, 29 Oct 2022 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667047021;
        bh=rzHEwV7m5N8/MXONmwj3YtvM2Zbt6L1lQYgSkUmIFDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X3vBbxdYlgkpFMhJJnpBmMWdKmB7trqnQcDatG/gqQdH6iXGwCLzCzyQUJrPnTCPi
         cOiAi9WLTe/HjPXVX/N2fXTZ8baV9WWq2+TkefkcRAkVox+7OC6OY2SIQk+iP1DfX3
         inKTeN84UgjdpRUGTaeCF97Fijv8tdW3hOqGrP7Zdj4cvb/ZXpeXKN72cz7rr9LVUJ
         fSQKTnyseU67mOrJsJwPwNhsWo6LDnVlpjatT815ma1AhZbN+0Xg95xMey1VQDNJ8T
         B7Xo9/QJZX9a35JBS6eCSJJXwb/FP4r5CmozaEa5dupTv5oXRq/SXTJ9PlQFLH94F4
         SzbzYAbGzkazQ==
Date:   Sat, 29 Oct 2022 13:48:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <lars@metafoo.de>
Subject: Re: [PATCH -next] iio: trigger: sysfs: rename error label in
 iio_sysfs_trigger_probe()
Message-ID: <20221029134856.03ea79e4@jic23-huawei>
In-Reply-To: <20221024105250.873394-1-yangyingliang@huawei.com>
References: <20221024105250.873394-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Oct 2022 18:52:50 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Rename error label in iio_sysfs_trigger_probe() to make more readable.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Nice

Applied to the togreg branch of iio.git and pushed out as testing to let
the autobuilders see if they can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/iio-trig-sysfs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index d6c5e9644738..63ce01ac2036 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -138,18 +138,18 @@ static int iio_sysfs_trigger_probe(int id)
>  		}
>  	if (foundit) {
>  		ret = -EINVAL;
> -		goto out1;
> +		goto err_unlock;
>  	}
>  	t = kmalloc(sizeof(*t), GFP_KERNEL);
>  	if (t == NULL) {
>  		ret = -ENOMEM;
> -		goto out1;
> +		goto err_unlock;
>  	}
>  	t->id = id;
>  	t->trig = iio_trigger_alloc(&iio_sysfs_trig_dev, "sysfstrig%d", id);
>  	if (!t->trig) {
>  		ret = -ENOMEM;
> -		goto free_t;
> +		goto err_free_sys_trig;
>  	}
>  
>  	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
> @@ -159,17 +159,17 @@ static int iio_sysfs_trigger_probe(int id)
>  
>  	ret = iio_trigger_register(t->trig);
>  	if (ret)
> -		goto out2;
> +		goto err_free_trig;
>  	list_add(&t->l, &iio_sysfs_trig_list);
>  	__module_get(THIS_MODULE);
>  	mutex_unlock(&iio_sysfs_trig_list_mut);
>  	return 0;
>  
> -out2:
> +err_free_trig:
>  	iio_trigger_free(t->trig);
> -free_t:
> +err_free_sys_trig:
>  	kfree(t);
> -out1:
> +err_unlock:
>  	mutex_unlock(&iio_sysfs_trig_list_mut);
>  	return ret;
>  }

