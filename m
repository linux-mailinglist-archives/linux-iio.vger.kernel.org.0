Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7191F0CC1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgFGQFd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgFGQFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 12:05:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF5C08C5C3
        for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2020 09:05:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so7606042pgn.4
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2020 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyrCkEdEemKi1aPBkHMRQDF+z/OxX0U7rIOvB40P7kU=;
        b=nTIPFNOUj+JpmdjdQtlxNEvpRrUiXZJZzCiVHODMwkGQHZIV/PpnHO1h7G0Leb2D06
         dslFglvS7LZRiVyNobFHXh8iQWc5QLgqnqub01dGzrz+LFsl/+Q49b+3+yzlXpui+7Bu
         NNg3LJXMCTu3wruekRMi3zu6r4lG46QszScFG8hLYNhdlM2iDp36ouHcvA3i0H4QpEZI
         OVOrcG7yRawj6UN1pxLnCNGQ9Jy9LJ0i6MWal7Kr4cKjKamLyK2KcRXCVTx3YNs2M2RO
         kf1xJecu6Kxa8SRyYPD/P9cFNctFItochAMFDLR2qKakYpKljE/MnaCXxZTZA+FFc9FE
         dY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyrCkEdEemKi1aPBkHMRQDF+z/OxX0U7rIOvB40P7kU=;
        b=Qf1qZGyqgcU9qdjHsg2AM0O1nHCGytjZGpmZlSho8NdKUdfEklgK0IkGNenUmR93+e
         2ZebknKO9cbT75BlVi6vBkAhb5o45cONiN075qHV3vOsHq+uTX4ywPy3WlVjBdOhzH38
         u4jHMy8jGAtyZGGHXCbkfTtXikZXQfdjmooxBU2S07We56BJBQMx4c/QyJkBelS+uO+l
         vs/0t1dozKqTTJs9thp0laqiRnl0jHTwHHBJsVUUnlObvbNBvHmnQE7vjmU3O0L0N50G
         rtIVRCoT25j8lprfnoWO7kHvQ/UrxVHXLtBJi2qfrMSWTdQLZq5NrrgjaJWgkcFDL/dV
         Bfuw==
X-Gm-Message-State: AOAM530D8LpU13Xn7aLjTLeQyKCw9sogcnoG2hmnbA8DwQAWuYH+wuqz
        2ve7RZv6OZWTLeVoh3m9u5GAxjL6P8HUdoIbfirZqGNyob4=
X-Google-Smtp-Source: ABdhPJwiOv2eTcuM2dez0Pgm1GCIE45SqB19ghHl38vbohH3ex//PHWpyWk6xVbNxSAGq7tSNbr/BIDN4mLOrNK+gIk=
X-Received: by 2002:a63:305:: with SMTP id 5mr16515614pgd.74.1591545932406;
 Sun, 07 Jun 2020 09:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200607155408.958437-1-jic23@kernel.org> <20200607155408.958437-2-jic23@kernel.org>
In-Reply-To: <20200607155408.958437-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Jun 2020 19:05:15 +0300
Message-ID: <CAHp75Ves+9VpAN80RgML=-_2=AyrpYM72Pi6sM6CWxdptiAn2Q@mail.gmail.com>
Subject: Re: [PATCH 01/32] iio: accel: kxsd9: Fix alignment of local buffer.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 7, 2020 at 6:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
> is not guaranteed by an array of smaller elements.
>
> Note that whilst in this particular case the alignment forcing
> of the ts element is not strictly necessary it acts as good
> documentation.

...

> +       struct {
> +               __be16 chan[4];
> +               s64 ts __aligned(8);
> +       } hw_values;

I'm not sure what __aligned can do better here? It's naturally will be
8 alignment (struct itself due to s64 followed by 4*__be16).

-- 
With Best Regards,
Andy Shevchenko
