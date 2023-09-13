Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8579F1D1
	for <lists+linux-iio@lfdr.de>; Wed, 13 Sep 2023 21:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjIMTRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Sep 2023 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjIMTRU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Sep 2023 15:17:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542B19AD
        for <linux-iio@vger.kernel.org>; Wed, 13 Sep 2023 12:17:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60F3C433C7;
        Wed, 13 Sep 2023 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694632636;
        bh=1uNpasMKRDcqodi/AK3ivr+N8diGJYfAl17uGfgdbDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PK8EWJHRi0DzYYdUcWMJAmMkBCqp249M11U0tHD8SBENcAMMy9Y46pqTZqWAP6nxG
         7SAOEjPqICycCuXi036Psj+tVL5ShkGkfbu+IAOxYRVZVroQQdUgcsWTJuxjnBNgtv
         cIJZq18q++MpvGayoBwNYpAxYVgtrLvTeRlXSlMDhakGgc2S4qbt4p2qrcKl3ynDYY
         8QH5L4VKP0Mqj6Zq+uJWY9qwEDyHOeqdywdTWiS9K4AnU0gyu2+ZpD5y/6YebFA/88
         /8dywi8pGG9NMftCp68qyY5jWAoJorxH80Ychymxp4979oK2tVPI6lJO6eVucuIKWZ
         lwf7HmaBYMCDg==
Date:   Wed, 13 Sep 2023 20:17:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>, lars@metafoo.de,
        matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH -next 2/2] iio: adc: mt6577_auxadc: Simplify with device
 managed function
Message-ID: <20230913201708.3136e5eb@jic23-huawei>
In-Reply-To: <09603bb9-59df-a6a4-fda0-c47fa3941659@collabora.com>
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
        <20230826035402.3512033-3-ruanjinjie@huawei.com>
        <09603bb9-59df-a6a4-fda0-c47fa3941659@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Sep 2023 10:56:28 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 26/08/23 05:54, Jinjie Ruan ha scritto:
> > Add a device managed hook, via devm_add_action_or_reset() and
> > mt6577_power_off(), to power off on device detach.
> > 
> > Replace iio_device_register() by devm_iio_device_register() and remove
> > the mt6577_auxadc_remove() function used to unregister the device and
> > power off the device.
> > 
> > Remove platform_set_drvdata() from the probe function, since
> > platform_get_drvdata() is not used anymore.
> > 
> > Remove mt6577_auxadc_mod_reg() call from the probe function error path.
> > 
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>  
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
Just missed. I finally pushed this out as non rebasing (rebased on rc1) on Monday.
Still the patches have a link back to here I think so people can see this if they
come looking!

Thanks

Jonathan
