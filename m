Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B955F2B48
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiJCH4Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiJCHzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 03:55:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724045053F
        for <linux-iio@vger.kernel.org>; Mon,  3 Oct 2022 00:32:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id gb14so5911283qtb.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Oct 2022 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w5rR5EXhcgIyvWgV1ZRdHwlCj3Oix44qKG7rRkEa6P8=;
        b=gx64ljxBRXAG6tsUG+IwWrtEEigTn5QivDn7H8ybeJ53Xvb0YlQIP1F7607+STSrvq
         Co1sRgL0ZH+m1ScFIqBfTLB7Xce9TZkhr6HJpUeH3BGvh82UkNg6G2GAlurVQH1akelt
         ZdBkbd1VyJ0RHtWui75BlbN+BfjrBvDQbQGEETzkYZibm2e8o9VHShGTWtjTU+HpsXUo
         4pwAFM0hzbOYdS6Q1sI7M4EHCqyusPQ+f6yYOjVyattEIAyjwAuc6pTv5Q5ss65nq0fj
         AqL0zX+tK49olEDHwCC2r7HQgdSMJls5Gy2eNRTJBbC0tkgT1bgIO1vfYd1/CFdCsiEZ
         M2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w5rR5EXhcgIyvWgV1ZRdHwlCj3Oix44qKG7rRkEa6P8=;
        b=wjKSTIEGSZRCrRudRW+6JeYCUeVVZxepYo2KrF2EXzhicVpGXj/d0FdtYkmTigv6Yw
         JQZi/p7/VAD6+nkQ+HEmLZ1LDO2D2Q9qT6THCezS4rZXzTOcgU/dx3kvh8dl3YL+FVqV
         kveFxrXL2kMSGsNm0HOO/bm0RMKLeDoq4v3Dd1/CABJyiF8qnLYfdnHLa3CAVvIZSVSG
         3jJnSE0gbI8NMd3aKL51lItMqqydqukYkXMBqcwRQPdY2hlbeo4KWMbjOyDFPKl5vkg1
         Sr/7ov8QyW5OJxBTMI1HYUwzT4dYNTErgrYoB7k0PuA1SBPc5WozUyYGFQlWDun8pbQO
         +PQw==
X-Gm-Message-State: ACrzQf2KYC+EJsg78YJ4CaHVPSbkkBG/1w+8t0OB82efUeynzePafIk0
        dheFYkuDs/1IOI2qpd3yIvxTgTwvyVmZ1kHhL9Y=
X-Google-Smtp-Source: AMsMyM51+lJ5qTFyhUrSEHh2p7l4Ddav4UhDSRX81vHlOBHoyHoo6zyC+nYGqbOLMoXIiJ1Q0atRDjtbDcgidWjI548=
X-Received: by 2002:ac8:5e07:0:b0:35c:e7fd:1e94 with SMTP id
 h7-20020ac85e07000000b0035ce7fd1e94mr15264132qtx.384.1664782231151; Mon, 03
 Oct 2022 00:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
 <CAHp75VfaWS0H6F0LmnmW9SS0JZNwfXRzFoCTP5FOfzMP_CUNLA@mail.gmail.com> <20221002150341.48b071dc@jic23-huawei>
In-Reply-To: <20221002150341.48b071dc@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Oct 2022 10:29:55 +0300
Message-ID: <CAHp75VcimKRzJoRRWc+_qVjnr+17=CPSxrLnxe6DL2bpCGRG3w@mail.gmail.com>
Subject: Re: [PATCH 0/5 v3] iio: Silence no spi_device_id warnings
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
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

On Sun, Oct 2, 2022 at 5:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 21 Sep 2022 23:41:54 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> Given Andy's suggestion (which I like, but no one else has replied to!)
> isn't moving forwards particularly quickly.... I've applied this series
> as it stands.  We will just have to cope with the churn (there will be
> a lot beyond these few drivers anyway to fully take advantage of
> the utility function Andy has suggested)

dev_fwnode() now takes a const pointer, so the needed API can be
submitted after -rc1, for v6.2 as well, but then conversion can happen
later on.

-- 
With Best Regards,
Andy Shevchenko
