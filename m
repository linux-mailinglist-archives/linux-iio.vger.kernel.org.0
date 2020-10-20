Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17C29434E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Oct 2020 21:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438215AbgJTTja (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Oct 2020 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438114AbgJTTj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2020 15:39:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD0C0613CE;
        Tue, 20 Oct 2020 12:39:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg9so3064561edb.12;
        Tue, 20 Oct 2020 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmEY/3B36rc7sVYS5bmAl4GIQZmQ0TR8py1mNtFFze8=;
        b=NLNalLo9FO4qKv1h1bag9C95ybV5BXHyv2mhky/ilgVIhYxvghmSphinCFBHjeITDI
         OpDgV2f5jxD9MdWdMD4qZ/bHo/k59MSyFjH8OtqJGkXjK3arkY0dtLU23dQuVJ1k1Yjd
         UCfgYCsAYp57jNZsvmE4HBSyDwBFs9p5njLDKDAWkyY2APtkivk6AoDET6aofvzhxPmb
         eqHiv8jnWHr+Sr+m/KiyxT4r9+ksFVhGPXwJkL8szinb2oIoyEiUKaOMVaZ91uT+A56u
         5qVH0gMxkI4VNBWFcmGqgblbASdaZawwkX3f0ADVn2pAZeidb87nj33sbMnUUnnGU3ZJ
         3Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmEY/3B36rc7sVYS5bmAl4GIQZmQ0TR8py1mNtFFze8=;
        b=YF66nNGroPy8uVWDTLUuGqSBkEstA6oLC38h9onQu4EbBDuwbkh7459d+FapxUdbe5
         A5CKghiIqe5KphKheifTPdED0lk8tyV1W8WPLxxYIrfvgCv5VxW1A+QFpWFLGC4Acuqn
         J9/lE78wW3F0bYWjUrzBrMzPnWhFvs8Zvkkvpb+yN9caiRy5ylPRsCn4VNZ+1pH7OM/f
         3bNIuufp1v9+I4EYgP4d5ZksLZhBtVzLJkFyCC0Hebe9zXCFbrbGa/wvNaxrx3IJCzE9
         W82ZI/EFBaoyUsTy/OWro20Cc8a/NiyZbYQYDyJHY/GB8i0HYJCwtnvQ5hga7Dk1cUrn
         Zo6w==
X-Gm-Message-State: AOAM532M3H3PuFKf7XnjwunLQX66yt6wBnISk+nZgTncbfMJplF1yJPQ
        tv9/hNWyPs+FF8rHk7E57gG96HBuHU38r+hc0rg=
X-Google-Smtp-Source: ABdhPJx3YnqPt0OnfWGhREBVBxoIT3gIhF/DGWwfopbOvy/HF8apZgJJDk+qAfk/8yfX3eD1fi9xRR3AbHsGmkfTGK4=
X-Received: by 2002:aa7:d690:: with SMTP id d16mr4503121edr.301.1603222768286;
 Tue, 20 Oct 2020 12:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201019172824.32166-1-trix@redhat.com>
In-Reply-To: <20201019172824.32166-1-trix@redhat.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Oct 2020 21:39:17 +0200
Message-ID: <CAFBinCDKf_TJb9ONfz+383NB0yKDb2a_zxXktAoBHKg_03L2+Q@mail.gmail.com>
Subject: Re: [PATCH] iio: remove unneeded break
To:     trix@redhat.com
Cc:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, andy.shevchenko@gmail.com, krzk@kernel.org,
        alexandru.ardelean@analog.com, jonathan.albrieux@gmail.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 19, 2020 at 7:28 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A break is not needed if it is preceded by a return
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/iio/adc/meson_saradc.c       | 2 --
for meson_saradc.c:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
