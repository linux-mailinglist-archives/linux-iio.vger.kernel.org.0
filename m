Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3727D91A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgI2UlH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbgI2Uk7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 16:40:59 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01DC061755
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2020 13:40:59 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d15so7104851lfq.11
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2020 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spH+HpgJiq/gdX69esWNWsroRCjagDdRPU4euwTqGFQ=;
        b=ivvIXFEwI08wSBAgnYBXYrpwkVCB3ertcXpIIMpMctWXUmQFZW9S+4dOLL4ol1Gmg6
         ggBLuu+6nIWpavQrmAa219l7Pqm1qDoGOxYo94xl+O9d/kU6MyQ3XyXd+LtWObf/MF/8
         CK5oXOkifDH9t340L3f7DxQ3HBOxAZXyHbmMQmhq1d2dM9CwuhrUd6S6MDv06QfysDqQ
         6EsYBIQSGbXs8PZS+x0j7FFz+ZsBI/MhLjhLayRmbyASA+P23NEm15nF77ARKl+s2AlN
         acfqg/c5QBUIyxK13LJODfzd3UwiU3bmMSYemP51aoMRaUzwVhINIQGREhQ37SiTXWSf
         7VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spH+HpgJiq/gdX69esWNWsroRCjagDdRPU4euwTqGFQ=;
        b=kf5BhsiPcmlgBiuK1AX8IqtHarfXznFx+SNvrv7SkEDUzX5+8kmHPvqoQvm1AGCXMh
         rklHUY7zGKVtqfJJl+GqiLU1IjrlYjEIfpYcG2NTofMj3GQ5TcQvifkJ3ZKPI/nk0Xdi
         N2ep5NIpHQR1ApqBN6I8fyWSgBJs++ocLURwsxIS1w3EWUWHR39hB+UMEorxCzXmkwZm
         z+c42tPnbsX176OjlOGizHQ3U4w0rsTIktGQymDVsnMrWfcfGFdOkqoFnNH+jSyllU8s
         vwn/YtV05cie9476evZSAtT+pMG5MyNn3qdGyZFPFKqaq3ZDSySaUlxBC2aRYX4h4hnP
         S8cw==
X-Gm-Message-State: AOAM5317jYGUH4JkGwQK/MV8ROoki0x8I+27aLdJUKuvqXlFVGXRA12B
        DYsRRPF1RsZ0hQ5dNE+YmhcJoBEWfkT2HDci13haTQ==
X-Google-Smtp-Source: ABdhPJwqJ63SCnUynZE98yVUAcQe0FL9bV6wPvksP2VYAwJmY/AxoVYO0bSiBs3krBBRMFNjlYi/yjF6SwkZp7zSd/k=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1735118lfr.571.1601412057738;
 Tue, 29 Sep 2020 13:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200920132548.196452-1-jic23@kernel.org> <20200920132548.196452-3-jic23@kernel.org>
In-Reply-To: <20200920132548.196452-3-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 22:40:46 +0200
Message-ID: <CACRpkdaOV-8ONfsGmq9TdVdhu3BDDjcArW-HvhZeBqzbsR=XVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio:trigger: rename try_reenable() to reenable() plus
 return void
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Oder <me@myself5.de>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 20, 2020 at 3:27 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> As we no longer support a try again if we cannot reenable the trigger
> rename the function to reflect this.   Also we don't do anything with
> the value returned so stop it returning anything.  For the few drivers
> that didn't already print an error message in this patch, add such
> a print.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Christian Oder <me@myself5.de>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: Nishant Malpani <nish.malpani25@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@oss.nxp.com>

Nice housekeeping!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
