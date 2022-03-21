Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073F34E2350
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 10:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiCUJ3E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbiCUJ3D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 05:29:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE139144B63
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:27:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so17022640edu.10
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrPU2T4Fg5xZcRqYBa0kO1LY81KPvKn1X2wZ9j7WOxk=;
        b=d/u6jp/U9EONeA/EoVWmf9plzz+Blo4zDCPu04IZj/BTEr0m/YyD69uxk7PIJbnb5E
         /cAuxmb/HW0cuDpwxYXThZBVCnrNtypvHhsJu0pY7+rPGqCepyHXpsTZ62LZmszXjF15
         j2A87u86sq6/ljiXt4kx54LEMEpQTjkGNF6X8haxYayJLkiaFoCEtcUqDGy40QnE0mj8
         BpOYJwk5Bb8uPpTEGQFx94jrdU3YtgK4KlLrLEnIwPqhKF70Hng0V3Qb/CzXQTimjTQF
         ile50qsuKqV+T8ncE9d2odP7V9w98aDJ7SxVa2cJXr4a6rLfMToeCEPhpMITTI46xrK/
         4s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrPU2T4Fg5xZcRqYBa0kO1LY81KPvKn1X2wZ9j7WOxk=;
        b=GQi7SKbDST7AGbgViR5ykAFw/PoTe5KcAQtvs//VcC94yFQn6wL//G9rsFWEkGsMT3
         OGso3mQFUgh0+6Jjq6dIxwSXS0pDZc9vRhjKcPK9F4JOpd4LIMyNhcexiDdn8Ede5kBU
         nU5Mzb2Im5POkenRNaYSDbZaovil9/0YKsFT1TlAk4sLf2W3sqg3c/haq1t03CSZ4iM0
         uor1ymiyznVM5BFXw0GFq9oOpV8IDPpCvYrtNGTIgMNx2HNM0PsjF5daMqfaAm3VNQHz
         AjUkQ1ukL///VY+Q1/5DZC+bPLlRrlhS1kJlgw/S/wzZn+qajufKyBoZCYhRauG2Ospn
         WlOg==
X-Gm-Message-State: AOAM533Tu1p7OMy6Lw8/f45OlnAH2uImVdi+CTIHJx8heW+IMUkmkoEV
        gPduvUaUuqb1zTF/lgq7knuXc/byrV97i7ihnBg=
X-Google-Smtp-Source: ABdhPJyD3EE2GiqoV9E06oAmHBFgGKDqTVQFFjfjF6cSyxgpw6YUM5rFcNKO/8RIomLAGDO7Vxs7qxv7FWmBdRkQ914=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr21825804edu.29.1647854856447; Mon, 21
 Mar 2022 02:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220320181428.168109-1-marex@denx.de> <20220320181428.168109-9-marex@denx.de>
In-Reply-To: <20220320181428.168109-9-marex@denx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 11:26:25 +0200
Message-ID: <CAHp75VczHX=0yZLjDyLdVjLW6ZRz4-ipJN0VERVj0qhp8CEWFQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] iio: adc: ti-ads1015: Replace data_rate with
 chip data struct ads1015_data
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
>
> Instead of storing only data_rate in private data, store pointer to the
> whole chip data and use the data_rate from chip data throughout the driver.
> No functional change. This is done in preparation for switch to read_avail().

switching

...

>                         if (period <= ads1015_comp_queue[i] *
> -                                       USEC_PER_SEC / data->data_rate[dr])
> +                                       USEC_PER_SEC / data_rate[dr])

I would put these two to one line.

-- 
With Best Regards,
Andy Shevchenko
