Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C466236C012
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhD0H2j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhD0H2j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 03:28:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65589C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:27:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s22so20635133pgk.6
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/WSLAKfTaub4CiI+nVkeyJc3p26hm1H981sppVOjOA=;
        b=CXOUjPXlFhwgyLriz0p0LK9aeFEmetKoe49JRhduDq9NxzoPu0iY2FKSKnfFKm2yWG
         dt+T+W6h4VI7UddW0cIWklD53vs9gMzNA2gR3fj8XNQu6VE/e0m4Jky0JzWTikJucPZc
         laWT1Ybmn4sW36LLCTonqcaK0lw9nZigtD94kem4/hY5dt9EK8yJ5UfFiRPCsUnaQm99
         K2Q67Z2N90kNOdKIj4FQy9+e6VmVkaLeq6qfDgOpgYv6W59QYSx7eQUw2463NZnA0L7u
         H2NcRzw6c1UlJTx6LygoF5NDpX/BjJjg35n9PfE3Fwlh4mgFpqC/Vqa11XCo3NIL+FRu
         GcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/WSLAKfTaub4CiI+nVkeyJc3p26hm1H981sppVOjOA=;
        b=As+cKrcN5Q6bUjFJ+qxEaqXGaWe4Oo13H75sf0mFzgE62hnRf/pE2gIPp2vruOfMrz
         Q/4wVFxIZSBYLUSqU/i42gu7znn8g10SxYYq/WqDm4rC4RwyWH+kFU5+IwCa7He9Xcns
         rLqdDiSGfGNGskvaYMPmTnY5k+Kwqcju5zJn0OEVhsNGNRKI+KXzJ4fvG0Rj1adDDQSY
         4a/NvoJ/t8+c2JhA0U/cEHVVUYJAAd2TZaJKdDpAIIInRp/wAUtmfHhJBaHMdTjRZJ50
         uxBNDrbLg5XFA2Q5iQQ7q4vVbSJx/p/KLOegTdXm+Gwj6xXCYzYs3/+rt10tiHurTv+v
         fD+A==
X-Gm-Message-State: AOAM532nsP1hS7u01PZxbGqpcWqWadqq7oTtwG0cGzSlCJk4+Jx7wk5E
        KiXXd6bpBzy6haV5FluSOcgCYYMuThpaxBAqcrE=
X-Google-Smtp-Source: ABdhPJyghpfP6y1gbCIUU5IpL9Lv1POmsdM9kccaH0CpYY2qegdWncNeMJzAT8yQkKgfirZA94zKPwWGJhYIJxFF2AM=
X-Received: by 2002:a62:3486:0:b029:24c:34c0:3c7a with SMTP id
 b128-20020a6234860000b029024c34c03c7amr21340984pfa.36.1619508476026; Tue, 27
 Apr 2021 00:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210426170251.351957-1-jic23@kernel.org>
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 10:27:44 +0300
Message-ID: <CA+U=DsoO6tK=y4LNFNsvqDSDTJgX6DHiTxMOR0fW+YEXUoG5pA@mail.gmail.com>
Subject: Re: [PATCH 0/8] iio: cleanup some new instances of manual parent setting.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 8:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> It seems I still haven't trained my eyes to spot these.
>
> I think they have all been introduced since
> iio_device_alloc() and friends started setting this
> 8525df47b3d1e ("iio: core: fix/re-introduce back parent assignment")
> 78289b4a58b58 ("iio: core: pass parent device as parameter during allocation")
>
> Anyhow, all seem fairly obvious to me, but maybe I missed something so please
> take a look.

I've added 2 comments that are unrelated [directly] to this series.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Jonathan Cameron (8):
>   iio: accel: bmi088: Drop manual assignment of iio_dev.dev.parent
>   iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent
>   iio: adc: mp2629: Drop duplicate setting iio_dev.dev.parent
>   iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
>   iio: adc: ti-ads131e08: Drop duplicate setting of iio_dev.dev.parent
>   iio: humidity: hdc2010: Drop duplicate setting of iio_dev.dev.parent
>   iio: position: hid-sensor-custom-intel-hinge: Drop duplicate parent
>     setting.
>   iio: common: scmi_sensors: Drop duplicate setting of
>     iio_dev.dev.parent
>
>  drivers/iio/accel/bmi088-accel-core.c                | 1 -
>  drivers/iio/adc/mp2629_adc.c                         | 1 -
>  drivers/iio/adc/mt6360-adc.c                         | 1 -
>  drivers/iio/adc/ti-ads131e08.c                       | 1 -
>  drivers/iio/common/scmi_sensors/scmi_iio.c           | 1 -
>  drivers/iio/dac/ad5766.c                             | 1 -
>  drivers/iio/humidity/hdc2010.c                       | 1 -
>  drivers/iio/position/hid-sensor-custom-intel-hinge.c | 1 -
>  8 files changed, 8 deletions(-)
>
> --
> 2.31.1
>
