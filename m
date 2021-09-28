Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971E441B11F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhI1Nuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbhI1Nur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:50:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2326C061604
        for <linux-iio@vger.kernel.org>; Tue, 28 Sep 2021 06:49:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z24so93902205lfu.13
        for <linux-iio@vger.kernel.org>; Tue, 28 Sep 2021 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKhQNZjOIfjJSyht2FLszmL1D3tP60bcjgnElckVMHw=;
        b=SWEdIIJwb6X69/Lam+uJXQ6A4Xb8I8sL8BhXeM3sLLTYm81aA3aB2/BC6+HJbIZ9Np
         WiUtxZii+TvQXkeuNHoLpp/YKiZcjUc3Lma1kF6etJ6fJulA7H1Qa8WOsMnSi5VDacoL
         /39tpHlEqw4oO0o7g3FG9oLdkaCQxKO7AbQCK6zgWE6ybQxqsB6INHnMLtSrMMXN31zB
         o9o+clLvDMIS1yiRptqNduVYmZRDoTw+nqRIl1EoKZ08skFyuzAttaoiGBoDTpD6lePa
         LrrE5kHQR/1R/mXEYc1KOigNq/loDqFZHEnIbM6jnTX4khW1moblBvMKPX9ySC7ZbAnH
         lx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKhQNZjOIfjJSyht2FLszmL1D3tP60bcjgnElckVMHw=;
        b=iwCJn9Tg6iadQ7mKGk5lukOS8NqsAIWFhzuzGfHE3Oc1QO+1xKXDHRadhLT9lLVyJq
         kpRkzT2P3hvau1cITI3o055UzgZlftWPCZc/1P93Z5J5H+fn2nfVrRyx7q6ASVD7IGFO
         WGVR6ftBpidu7UMZ48uvz0Tdvf010d0A9mD8qj8fRJiTUUcK+gT69OwnI0LjsFl9plN+
         KKuYzkhEUHrbTtzeMDgtDu+zxDICS+Kkzy1ZphPAAN32DBdCDey8l3ITlDvkPIaqlrBb
         VjELITpLPcYzS+v5LvpD8ChptDCdL4mGuzs1bwpnSSg4ZPhO1OxlDcpdlb/v7W1VIESq
         CDOA==
X-Gm-Message-State: AOAM533V42wu+9TYxzciXAfuM6OAkdMV7EpDPBurU+BDeQw+nRMbeTuo
        5Qi3sflGI0XUplvU+2kYICYajCg7i5uprV8U8byrrA==
X-Google-Smtp-Source: ABdhPJwA3IKyzL3cWJqddBcnon0fBZlmLO9AeCStzXybEnOG68cSahyOUvLzXIRJ0IEALndQdr8Jff18s9lyLDEQzT0=
X-Received: by 2002:a05:6512:e82:: with SMTP id bi2mr5737173lfb.95.1632836938527;
 Tue, 28 Sep 2021 06:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210928014156.1491-1-caihuoqing@baidu.com> <20210928014156.1491-3-caihuoqing@baidu.com>
In-Reply-To: <20210928014156.1491-3-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 15:48:47 +0200
Message-ID: <CACRpkdZMZ2LNP37h=6bkVAsFGNLBnUsZ1AuDtKzuzgq-op7csg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: light: gp2ap002: Make use of the helper
 function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 28, 2021 at 3:42 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
