Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBF1E20BA
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbgEZLOL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbgEZLOK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 07:14:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B118C03E97E
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 04:14:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b6so24000616ljj.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b95M1qQh0VwLNbffB8TC+GO9hdEpk++WQAqAR1kMuGk=;
        b=CyyFzJoY9V+UOZE9Zq5BHN5OPMjRTB9U0j20sE/x7pReF4+V9W78PVIUWrwHBYLzMP
         rLOAbtJHzzZTHEmz7PD4BPZpE6TnctpFocBmp3tkUNdkOnz3onsvuyYAG+ov/WWmiUlE
         nd90Psp70XfId9AEk8N4EPX+Sm31SmlSezJEdRLSVbPPF8O0NDZoftwRR+Ka0SvHJuKa
         ZPYoT5Qj0cZq6yhAeaEf0UaPTK2Tfd8Ge2G9zHcT2c+vEZB14JbiLZQayt43q87LxwMf
         l7oXh4oxF8t18Zd195Xj12CKw+e3AVYxCRdI1PAQ3BP8IaS6WdUJPskZQxA5yzegdpy3
         /qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b95M1qQh0VwLNbffB8TC+GO9hdEpk++WQAqAR1kMuGk=;
        b=fTS9kb6AhbVlVl6zN33PBtYl/GWKN7ZA9O1t5bUjJT1Fc0lfSIuBlJM8aZNCS9Xlt0
         Zp67zcqtJ0vbswrffYBAib1kND43YtjyjMlu8gkxAP1pv7STjuEmYT86y4a+1FDt1MkE
         5WHQbOd2B7sJhs2+bxyr9kvlyDC6obavvZvna8eIskxN1DIBYgRYoaELlWM/6V/X63WM
         gATPt69t7GjTHd2uZTGb4iZrVuEi8mAfyMeriAxcY9UtPO5wwJLqY+jVltSt/333lg70
         SJkLTF62gemkORyFTw3wjdgSKGON2OG2rCPE4W50/DCa2zXJ8aNJkZIvJ4z5UYtN+Bbu
         A52A==
X-Gm-Message-State: AOAM531+Fg1qjhRtxJEU7tW3v5Uiz04fDOGVFaLLPBYW2UoB1lqiNb6+
        vj6rTSAGEuzHd7/ahIlzWJldUJF6g/wwcbRT0yOQaw==
X-Google-Smtp-Source: ABdhPJwI/7tMWVQBuQb05BL+Cu99HZR22lWtX466GsK/CcdoTAdF2CJS2VzlilKepOXhDSo6yGbqfQJQ5ReghXHYW2g=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr369834ljk.144.1590491647997;
 Tue, 26 May 2020 04:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104717.3181-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200526104717.3181-1-dinghao.liu@zju.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 13:13:56 +0200
Message-ID: <CACRpkdZi=UaGES_bupj_fQB+sPj5zOvONdCn7_Rs_j9mcukAAQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 12:47 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When devm_regmap_init_i2c() returns an error code, a pairing
> runtime PM usage counter decrement is needed to keep the
> counter balanced. For error paths after ak8974_set_power(),
> ak8974_detect() and ak8974_reset(), things are the same.
>
> However, When iio_triggered_buffer_setup() returns an error
> code, there will be two PM usgae counter decrements.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>
> Changelog:
>
> v2: - Change 3 goto targets from "power_off" to
>       "disabel_pm". Remove unused lable "power_off".
>       Move 3 PM runtime related calls to the end of
>       the function.

Thanks for fixing this Dinghao!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
