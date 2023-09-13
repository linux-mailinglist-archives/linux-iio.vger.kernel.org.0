Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1C79E2C1
	for <lists+linux-iio@lfdr.de>; Wed, 13 Sep 2023 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjIMI4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Sep 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbjIMI4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Sep 2023 04:56:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D2196
        for <linux-iio@vger.kernel.org>; Wed, 13 Sep 2023 01:56:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19615660732D;
        Wed, 13 Sep 2023 09:56:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694595391;
        bh=4WEW4sE4W55SdLAsrbeCF5RvjuVtlRYZ91ql16VShi8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=PHHZQAkWynt0GuhQR/x2vdlGHd7neJc1IRDfypD29guIPvvU/CsXWLCjQ0GWtTpmI
         Ot6U+FgTGDSWuLhtJmh2TQWovVJQrbV252FvmHigtvJjv3yHaJyHVrgtX+T7aekVVb
         NxU/CZG5gh8tlyhvcffZXES/T0xieLW3vok+JOXT8vdFKzvHtvqObxlDu7ILJnjXah
         ID6AnlqzFTFxK2Gkb7E6hsdAQhD4HRscuYpkmK55p+JoRM8ZLm7sp+CwLnvpOHZoes
         EqjszUx1Bo8f42H/7/8hw3SqK4wTDRyjYm6BpITeUhifA99fcXkQ5d9K/9rqv3lclM
         dK/izhwwcWIdA==
Message-ID: <85f67bf0-469f-b379-7611-ab52c2a07778@collabora.com>
Date:   Wed, 13 Sep 2023 10:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH -next 1/2] iio: adc: mt6577_auxadc: Simplify with
 dev_err_probe()
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
 <20230826035402.3512033-2-ruanjinjie@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230826035402.3512033-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il 26/08/23 05:54, Jinjie Ruan ha scritto:
> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless error
> is printed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


