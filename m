Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57825E54A4
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIUUnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 16:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiIUUm7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 16:42:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A53A572C
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 13:42:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x18so4862798qkn.6
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=guCVOCdDRU38lnDYA6PMK6yU4bC1D82abNYk70NAAmg=;
        b=jWWeK6b5Mqf9uexE4YU+OQ4+Ggg72JBfBIO5yIAu/1vOILuIUQEvYjh2bQmaeLTjnc
         JeQmsrKzDxUZpPn7+TPASn+AheeWCpxQQ3JKbnTNc2FNKxOgMiC24GhisG9vkVpMay1Q
         zbEGMDjI+uvKHY75zXugcTz8MZl9O9/JftcdMh2wKA/c/KRBCSe4Mwlco+JtAN9i+oI/
         7Jk1gTKEpuv5JbHDyDXoSnC53ouGAjyXZAJmv9txw8KDfmrUMVpmWvik/bGJKweF2O0z
         8WKyN2HFKwjtf+ILpnGSNE67+7ov/PeZghIBJnJkUXOegqjxI5YmESO/Ogw3r0JFEmtM
         kjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=guCVOCdDRU38lnDYA6PMK6yU4bC1D82abNYk70NAAmg=;
        b=8I9nOKFgUHy3NQHJ9heTObW18NYufHIymiwJs71DWPE2si7phYMQ7R8A5/DEMLKHy6
         Bfsq7ZaA7wndYpBgpiWtYh8zCa3NSG3/M3TCkwo9mFIExkLgqjOYetKeiM679iuXviqT
         axJMkHDNgHL7wSGi8Vu3tSEqu8FAbBB0bQwN/GbO2iGJ6d4lp7l12BPGDxmmotD5RQjG
         1//YI9csjgKXZHvfz3inueMQQRshmnqKSSst0iQlmd282BGXxN01jACY48TAPWlusKCC
         gPtq67s+mvrimm38oHlNoLr+llIANF+rzkmnQ+BYhzKWC4ZKcu7fDZu+DgNFTImR/jal
         LZTw==
X-Gm-Message-State: ACrzQf3WDnAEf3mCgPRY5jAHsZB+jTsEpNzaZD6E1WpoI+BD2mXSATMx
        JEkaqT3o/NM/kpoPffH+ADlnRmyk7GAPnbKdqjKmTQg1Q2w=
X-Google-Smtp-Source: AMsMyM4fGUqrt5gN86NINOvDXf/G1lv5f/H/I3Qd8tN3RxP16eAAW3Pc3i1JX1QtbJ6NbiACBRFtG9zdy8ADdg2Tekc=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr22019969qkp.504.1663792950953; Wed, 21
 Sep 2022 13:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Sep 2022 23:41:54 +0300
Message-ID: <CAHp75VfaWS0H6F0LmnmW9SS0JZNwfXRzFoCTP5FOfzMP_CUNLA@mail.gmail.com>
Subject: Re: [PATCH 0/5 v3] iio: Silence no spi_device_id warnings
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 21, 2022 at 7:19 PM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> SPI devices use the spi_device_id for module autoloading even on
> systems using device tree.
>
> Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> compatible") added a test to check that every SPI driver has a
> spi_device_id for each DT compatiable string defined by driver
> and warns if the spi_device_id is missing.
>
> This series add spi_device_id entries to silence the warnings, and
> ensure driver module autoloading works.

Nice, but I would like to avoid the unneeded churn in the future and
right away use a new API for that. I will submit a patch soon that you
may attach to your series as a prerequisite.

-- 
With Best Regards,
Andy Shevchenko
