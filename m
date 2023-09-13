Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF979E2BE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Sep 2023 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjIMI4g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Sep 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbjIMI4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Sep 2023 04:56:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD9B196
        for <linux-iio@vger.kernel.org>; Wed, 13 Sep 2023 01:56:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7764660732C;
        Wed, 13 Sep 2023 09:56:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694595390;
        bh=nqOTtfwX7rRj9GC8sr2U/6FJNTLSLN8f0d2I07koGF8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=n6z/R42AhHSVBEMMVnpq0HkyEmRYjwYH1r++RCb+Z6eM6IvfahC/Mhwn+Wp0X+rSZ
         l82NoT1THmC3L8eZVSjEEYXNolZN5xmI+Co157my/fQ1/dpJ8nbSYWLMO9wLeTr7KU
         KtOrUxL7VCc8F5W3V7F6z7AUFTzrYxn1r3an4klqmVy0MG2R6Vlcc7gdzFZKujIYnL
         FP4oaww6t4o3gffwZ8T8WVFKSwda92f7ftblWG07MpUT+Z8n8XK+YxBFTHTloPBHV5
         d/7MrFgx48pX2DXkdco+a7fgxfb6ElHkNOWyPIUlNSUUn8cNjJh3rczIs4cPdSB5YY
         td++vPQOwA4nA==
Message-ID: <09603bb9-59df-a6a4-fda0-c47fa3941659@collabora.com>
Date:   Wed, 13 Sep 2023 10:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH -next 2/2] iio: adc: mt6577_auxadc: Simplify with device
 managed function
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
 <20230826035402.3512033-3-ruanjinjie@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230826035402.3512033-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il 26/08/23 05:54, Jinjie Ruan ha scritto:
> Add a device managed hook, via devm_add_action_or_reset() and
> mt6577_power_off(), to power off on device detach.
> 
> Replace iio_device_register() by devm_iio_device_register() and remove
> the mt6577_auxadc_remove() function used to unregister the device and
> power off the device.
> 
> Remove platform_set_drvdata() from the probe function, since
> platform_get_drvdata() is not used anymore.
> 
> Remove mt6577_auxadc_mod_reg() call from the probe function error path.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


