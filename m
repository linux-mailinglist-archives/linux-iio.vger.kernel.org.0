Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8165F373BD1
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 14:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhEEM6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhEEM6Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 08:58:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060FC061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 05:57:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u25so2311060ljg.7
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODXe3xYzwnhXuXU9jpKFNrAfV8cDn0UE8iFVs6M/w3I=;
        b=iEwuSr9QWHRvvtc4GYBjJ7/bn41bYPSBgs62ztAcvFATrOblbeVDVcZZI7IGiZrMnx
         1ZkeQCZYBfRUsCFjvNJN7SQbklDI+mEIyxPmpIQsjAqdtS7vLP2urAA/3DYa6JDOA39o
         B7Aetxxi5P/EowUymx/TkvZF9frt+wHFhUuP2UwvgWsaH+l7FLDYrGCEnBAvDVwpAHzJ
         85AwiJsNgsczWo8X/A9GhnwBYVFAkT+KN/7yOqZpyhVqmS1pwzMb9vH1PZkBjbcx3mvw
         3BnsOQSpfoJbBXjfWCYx7GYGjUACG1UgbtWwX2yfvtRq6pwjHwEykyVBrUi/+dn88j5Q
         pMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODXe3xYzwnhXuXU9jpKFNrAfV8cDn0UE8iFVs6M/w3I=;
        b=XqLJz6MhQsajVrNDGdf3P4uJjROK6PfdGSXigv4pvIpxEaYtFiedd7lhPllpHJBQSg
         7hVINe/ZqwXaJeixsTLnb+Rah5G/CQJ2Q9DDz3dyvgn0zaHeFhAs5cffg/vxx/6IbK+X
         WJMg1FBwHMOCylx/f5TQWigHi7zXwyw+DYFsaP4200HL8NJx/Mn2DU9cpJOln8svwyut
         z3Xfmur/q/vapJE85Tif3SovxWtC1NXTbYoGhAtrsSZNQuRapGPls15aX/MN8zfRobq1
         9g3XSIyBvQ1DbGV2fsbgrkbucko3A0n7qzsv/K/mSOff83dkok4sY8cbAMxHRtV5FQyj
         HtiQ==
X-Gm-Message-State: AOAM5334dUj4J2mnXc2WvSb3YZOS8tl9zTZxpRSfSWocnQnOr3tPI81n
        4Jb/1yNtp3RGX8K3rNmy3Fbk6K/YoYoNxFRIl1QGEA==
X-Google-Smtp-Source: ABdhPJxlCvvSiyEF+PwjvlLmPoKVt7FMVWkN4Q4wCupCRFTa6E6qyEsIYd6LodCL9TFNPhk8JVT7K5FK3dyfELxTlTI=
X-Received: by 2002:a2e:a369:: with SMTP id i9mr21697854ljn.273.1620219442998;
 Wed, 05 May 2021 05:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210501170121.512209-1-jic23@kernel.org> <20210501170121.512209-17-jic23@kernel.org>
In-Reply-To: <20210501170121.512209-17-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 May 2021 14:57:12 +0200
Message-ID: <CACRpkdbYemUZCPwET4=dCGcJUfph3En+STtNphK8fbN0er1Z3Q@mail.gmail.com>
Subject: Re: [PATCH 16/19] iio: magn: bmc150: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 7:03 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
>
> Found during an audit of all calls of uses of
> iio_push_to_buffers_with_timestamp()
>
> Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Excellent work Jonathan.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I wonder if there is some way for us to abstract this into the core so
we can't get it wrong.

Yours,
Linus Walleij
