Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C014D91A1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Mar 2022 01:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiCOAdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Mar 2022 20:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiCOAdk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Mar 2022 20:33:40 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650D5FBC
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2022 17:32:29 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2e5827a76f4so12958777b3.6
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2022 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=on2xumwHejxJMpCRD2md7hxWdybCGSm7KmqkQCUuy3w=;
        b=g3f+lmMYxPjy8nHMcMcvUPNC29FcdCq6xwWgZ5xX9A+j6arqubbqFku3FATbONSQBq
         ZryPM0ffBDepzYoXGfZz1WI2cgy84brZtgjBaPsw3ljeRU43YIOvvFRF7JbZcJGb1mRf
         dTJ9XM30KlK+4rBHURjIkFsth4wuLBx4mXA0N1JFd2Df8B+bGHkf/ofqEBViTKl57WCn
         osmYM1aV5A7FDGxJ5cufqkpHmtCQK1eF6HO8fpfjiS91mWvh3F9kFgagXIL1qz/qkg+Z
         yipviv3Jde0j6Nar9QR+LS66MIt0LtuCTxCf6GNJk4bDZqF+xtUY1GhRszKabfZjwuhx
         MPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=on2xumwHejxJMpCRD2md7hxWdybCGSm7KmqkQCUuy3w=;
        b=0fen6tEbXs8VOJcZ7btQlxj417Nsu6J41S9REKSstwFuYmaQR24xB/MPj1yZNyYIyl
         XMGhAurBn1HFJGeQL30JrNwE/oVQYSiwMUuLPcOesyS2Y8LoUfskmzvlkQoBld0QwsS1
         UTIrMqg1k5FTH//M7/toxRacopHGb6XC7amCvumF634MEqcSxi8ud0KzNnIp4by9Exfg
         Zol9jTyDEYED26yuD1CtubF9rR7y5G6pFPiXXYfbIHyZWsmlWE8KIJedU0cnQIPD6QBc
         hr+7Ct5n6+4zaV9DrSuYTWIficyg+L7WdCwY8CB7Jr4prLgIbE8T9anMSGMP6u3STsAA
         +oRA==
X-Gm-Message-State: AOAM533KzhuO14vmnuSCQxfoWbm645QD+om6xC4hC2gz3SnyJFyw6Bxc
        bCKZjXhZlpzmvT1onmGqJNq3qfp2uAPHL4ybPjoWcfWUigI=
X-Google-Smtp-Source: ABdhPJyDAa4SErNd8FHzjS/Gd72CQWf4D6uGSUpUdXPlBexnzlym0b04pKdxKtuVmghWaPPMYSLeAFWsR/2RS5SLFVk=
X-Received: by 2002:a81:89c2:0:b0:2e5:84b7:83e with SMTP id
 z185-20020a8189c2000000b002e584b7083emr1494107ywf.448.1647304348686; Mon, 14
 Mar 2022 17:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220220175149.503495-1-jic23@kernel.org> <20220220175149.503495-2-jic23@kernel.org>
In-Reply-To: <20220220175149.503495-2-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:32:17 +0100
Message-ID: <CACRpkdZZqZatfZewtW1LUjUS+EBrFeRbbkPKjtkzc2cKDqjQHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: mpu3050: Drop unused symbol exports.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 20, 2022 at 6:45 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This driver is built as a single module.  There is an note in the makefile
> about SPI support being a reason to split the build in future. That
> support has never arrived so drop these symbol exports.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
