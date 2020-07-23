Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE922AECC
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgGWMQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMQC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 08:16:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7FC0619DC
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 05:16:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so2997479pge.12
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEA3JWs8YvG0njt6OxOs8SM1U1Gs0Z60/Q08JfEPeNQ=;
        b=RSij+2Q3SuZc2/LivDFDjhlp71svrPckLS9yqK/lzuV7DS32xF853rhmJkCUlbupC9
         iXHtZt19tT3Yahy9L2A40PPw1DxfX8upp9WzzPg3zcVymBxY7NDOK8/XU3fakK2mxlX1
         7WhF+iZt1d58ucNVRMwPUqE+v5Vx3pw7Q6QfgKKf0lNqGQaZlB9viLLKJyVAuevvFQwt
         Tx2tZg/uhaI4Kbt17rDEUJ+UVCYAI08PhMDctEsYqjuSO8zmXSK+ECk69A+8OfPCenKQ
         nEgQcgVK32dMB58HuLm45wYniSQFNa7YY2BEjoJ4AnvMFFj8y/Rz20c6XAWhG1VWlQCX
         9f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEA3JWs8YvG0njt6OxOs8SM1U1Gs0Z60/Q08JfEPeNQ=;
        b=dWpFzeXC+YNZJKRGxJ0NV/67YQPazF48NcsEbodI6z/umntGwa84CCYSYo+IBhvn2X
         Au55bxDvrfDYW1h0LunvHXdTun5Vve/SVjm2a5R0+6OTlJc+iKtNPGmih3Z3ZoEIhim7
         CYxBUCUHGQLZhyn0a4dZ+YtPUUFnUSmFKtIddMpQH1izgCddMw6WsEVZ+uqRBpr9mVxI
         eL+fKc2dafAMa41S8VSUKIUtSfBYmpARhElc9tPIs/dMIEw/wUp3sCSy6z7zhufMxzDq
         /hZDAKKQwrfpYFk6sc4JjSwrKuoCzaxGTNh5UDInueDBGD2gpb5kUV2FxW/PzN1m7HeS
         /hZg==
X-Gm-Message-State: AOAM530V2H8555NsUWgmhtabSePPPcZW4o+YzJ/lerS3I2laIxgXl/c7
        3r6DQuCx9GCNfMOMGdKV4hjpdIejXbKVcrCLv3g=
X-Google-Smtp-Source: ABdhPJzEI7bwSc8yEc/8dslWcY5O7jXHjHJd3kr/nCfMbf+nbGUR9x03HkSMW+hvofI/rRlJfZS17OehO4KptJ6b2aY=
X-Received: by 2002:a62:7657:: with SMTP id r84mr3774598pfc.130.1595506561518;
 Thu, 23 Jul 2020 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-19-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-19-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jul 2020 15:15:46 +0300
Message-ID: <CAHp75Vchi4mfAmZB1yeu-ftwvXP71LTAs_aEDEpE1AYWuY5phA@mail.gmail.com>
Subject: Re: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for
 fifo reads.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> We should not be assuming that we are reading a sequence of
> registers as here we are doing a read of a lot of data from
> a single register address.

> -               result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
> -                                         st->data, bytes_per_datum);
> +               result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
> +                                          st->data, bytes_per_datum);

I don't know the difference between these APIs, but AFAIU in this case
we always ask for a minimum data (like one item of 2 bytes or so) per
access. Because registers are defined like 16-bit wide we are fine. Is
that correct?

-- 
With Best Regards,
Andy Shevchenko
