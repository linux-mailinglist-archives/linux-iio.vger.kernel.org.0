Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E638811C
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 22:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhERUMB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhERUL4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 16:11:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84E9C06175F
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 13:10:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x19so15787733lfa.2
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQxXHB1Ph7+P2xHMeXt5/XrQmHM246cZK2cxKNZ552s=;
        b=Ae2O00o4sZHTYI8szB56TRKiLOXTBPgOr7RGyvNPNXHrArQu9lF683OLOqIYMIUhE5
         Xqv2GBcO2bwaZoqM4lNm7BfEf6i4TLaIPz101hOVcBDS5c9zlKPjwRP79WGhco0ADSCR
         Gj4IJ0Jy65lK9Zjk4y2CigKjLCzoXAY5ARdZ3JRWDi3YH0ZzhZBenHVJOP9NFYaA1Rl1
         jlPVh55IwhUzOqqL6IaABtqClFMaF067v2wMjFjMkX8FqCuGwsSZZMvrSPWeZm14Ng9x
         wrX2Hm5lCRbj4c45DLY6YUdVhmIZnkXDTrQ1RrM83zT3SYEb+Ua/X0XCiUcPiz7fMUtV
         zbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQxXHB1Ph7+P2xHMeXt5/XrQmHM246cZK2cxKNZ552s=;
        b=jEz0ZmV9wucLd6zuRWfCnIPEpyBGV2bsGtF3PfA9QCJus0JG4aU6FanhcZOn5rJgUT
         t3wILY9BPdMUkqI87pTlBRxG+Y2kG5BLL21JH+HDoIJfi7uSBi0rgHesdAqGB3ScBh+e
         w5iVb1g1/t+MKKqcNFIHM/h5qs7YxZGhWVjs+mJYxrqpvlw9R99ZwU7t9uruokE6jHOh
         A8HmqPK+J2s9HxYkze9j6q6ANWlcMkE8IA0RbjNuqUAJcMVAt4Cl2flQVE9Z2+FMUuDs
         hdQ3NbJj1YrYTs14Gh58TABuKGKLOI/yQV5WaLuqYkEw0wql3LxGrzPMbGDilyRUj2Zf
         W6yQ==
X-Gm-Message-State: AOAM531nIeUEc33Bx99QcRZ79LcEQZhz8ciHJhMus2KtQpm4dZLvXIld
        SnnREWLOwsBOWEC8SCqJkUFibnxX6MqBrM30bkJh3Q==
X-Google-Smtp-Source: ABdhPJy/O3f3557dx5LWLnEvRJb07rzCjEyU10gDDCLXd7y0RaH3MvyyIqEGKVXMEulQDobi42C+1nuyWbktgTBTxL0=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr5147305lfn.465.1621368635625;
 Tue, 18 May 2021 13:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210518112546.44592-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210518112546.44592-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 22:10:24 +0200
Message-ID: <CACRpkdZBRGBMgGPeqebHtLD6RczABQDLpA884rm3D=qm-UFBow@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: Drop Duplicated "mount-matrix" parameter
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Robertson <dan@dlrobertson.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 1:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> All of the users of iio_read_mount_matrix() are using the very same
> property name. Moreover, the property name is hard coded in the API
> documentation.
>
> Make this clear and avoid duplication now and in the future.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Excellent patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I will simply stick it in front in my branch when I resend the series
so it applies cleanly on top of this patch.

Yours,
Linus Walleij
