Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52933F0ED
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 14:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCQNPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCQNO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 09:14:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F52C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 06:14:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q5so1076667pfh.10
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTuA/N8cDCNc6rzssZACEmhfMaWAAgp8pmZs71LG6WA=;
        b=k1X454aVmDfMVUkbMfZUN0A2T2wU1CyESpF6nbFjAxDXwObxX9ZBHspJ5bjCdhSNhm
         ksI2tC2idp1pZ4pYczUgXmEZfWfp6BMCUglC03CgtB7ls43U29qWrP/xS41JlYfRejY+
         3M5kfua6wjHZsUKm7DacgMqPhoS8oHm3uzFjH5PHeSv1ee5wkFYxbMESUDw1CgDIvYTg
         qqmnsbnGHMGhC9sHcS9deHtEMc+tcm5vRHCqk6Sm5ljSnw8mmMDq8LX4kRhH1rQa9d4K
         2DpkSfTsKgQY4A1YQ+D74+Rof9sILA5yAygadb9WWifMO1o85h1j1BI3lY7fhfx36891
         7GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTuA/N8cDCNc6rzssZACEmhfMaWAAgp8pmZs71LG6WA=;
        b=gjPgHJMcIEo5j35n7MwBapEnSz6pF+AZBnqiEAhTitEFz7fmk2Bi7DLIbhAH5mfM5a
         wsQ0O+UyomLWZE23RNXCUo3DbMZ2WEIJsJNnupBaVKqBJq6RDsbtOA81Pweyej13VhEu
         kJnnbiRSyVIFPDVcae2U0Sj9QvWwm+Dj2A+ZmNL1X2bq9bsQ82IT4Rg0M54fIucu45mp
         JOGgXVmIqUCDbnKm327C8GybwoAK4qoH2F3+tVG0Qx1MzHXWL/830sa717osXq4Uqa1s
         BHVd9XELXRl+wC5nB1ZgM8WElpjiOhJ2RFMZ0ozh0h0GBtwyaeRHXNlQMrX3/HJpPxAk
         rz6w==
X-Gm-Message-State: AOAM530B8vl3JPjQPl8115GrhzqWwWVzhuAG1o7NTNxezo+ZeUH/PE+R
        7+ZJ+9+dg9yHMuNOS0QO3EsGMu/vNELiZT9/Lf8=
X-Google-Smtp-Source: ABdhPJzR0IQYIx1wvgaV+34KaDsOGat9SWZuGOubB+OOsyFEpeJbt83NsWPNA3j+r3/WmLiIarzh3AEdH6v/MVMziBM=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr4242650pfc.40.1615986897335; Wed, 17
 Mar 2021 06:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210316202919.1886616-1-gwendal@chromium.org>
In-Reply-To: <20210316202919.1886616-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Mar 2021 15:14:41 +0200
Message-ID: <CAHp75VcV6xQQJuVeVL5TS0ott-cmR4YB-2P+Y3WBarpWSz676w@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros: unify hw fifo attributes without API changes
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        groeck@chromium.org, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 16, 2021 at 11:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")

Use the proper Fixes tag(s) in the tag block below.

> 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> - sensors send data a regular interval (accelerometer, gyro,
>   magnetomer, barometer, light sensor).
> - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> need to set buffer attributes.
>
> 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> EC does not support FIFO, as there is no FIFO to manage.
>
> 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> specify the buffer extended attributes.

Sounds like three patches in one. Please, split and add proper Fixes
tag(s) to each of them.



-- 
With Best Regards,
Andy Shevchenko
