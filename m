Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A91E1E76
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgEZJYy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgEZJYx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:24:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA7C03E97E
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:24:53 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so11910992lfb.3
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4AuYWhRMAG6wbTbzt0yXoxTkjxPoNjjLt2PRJrrnQU=;
        b=fFHVgJu0+xAW8mU/gpcFxK3BMTOaFpzoOZWpvnIHAS2sQgZ29xaFXSCtWSbJQS1p2d
         Hpq49OyvthlWbv7KITbhiztGNJuUemI8ViUk99XINZcxkuitSk0DgmRgB/2vz3IrWnM7
         VHs3ioEmuDShpZ3Rj24PMofmhQdmKwrHCeUMJXenKvc8DeK1d5oJMIuYOULjOfY+1dIY
         /7u7Yr+hxVxqeBoZCffFsRgRwS+9i7pnDDxpcRkIEtcTLk5nn4gtQQvKEa2Cd9HdOeV/
         Z8N2uJOaPmLTfnJ3w2t42GRQUR1pdUlVVQtPaw/ZEqYZr8sEA1WK8hzi8NEYPjJ6ku1o
         xxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4AuYWhRMAG6wbTbzt0yXoxTkjxPoNjjLt2PRJrrnQU=;
        b=eLuFi5S0XSj82HZg7qrVAm53+L35+4ALwWkDibXoENdRasxri26x0axjTMs2SocNkP
         57RKUkrJnZWPxbBdux6AtXU+9vV3EX2kH0LZXqhMwalJzgXwxE99F2bVlXDeKdKdLvEM
         cYxJW/9oum0pFTT7l7+jHCUPLhuXyzVhMM3raHBBkxNEoErC1xziXqbOotEaaduuLjej
         5ohniZ5LP9b5mhUao1afXewkXs3s18oquHZI2+5Fg28APadGkUZkuKKgk2lQ+trirhrm
         FSQvgZbUojIClpTm5i3MEYcQ3rtu2PUlGlY0vCp18/mDoPUpCv+coztuMg1AVzI90wk1
         /TCg==
X-Gm-Message-State: AOAM532tEM2ywHFptXTV19JGGfuZRN/iNC6fGWnyRvWifODPrV+ugSGl
        1LLFDwSTGHMQwQpHmk2c+q5Ugm/s2hxtooX7fCzjHw==
X-Google-Smtp-Source: ABdhPJxGtuI9xXTLbRZiAi+sq7saEO9pAykDJy82lp+STCc5IwD3yendC+QdXzk2P6ya8LiLN9CVNPaj8BpB7LSH++4=
X-Received: by 2002:a19:be87:: with SMTP id o129mr49600lff.217.1590485091727;
 Tue, 26 May 2020 02:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200525170628.503283-1-jic23@kernel.org> <20200525170628.503283-7-jic23@kernel.org>
In-Reply-To: <20200525170628.503283-7-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 11:24:40 +0200
Message-ID: <CACRpkdYmoS3z_5WhCUMHqUmoTZ0UaxNA5oE4HUbXHH9Whwgeeg@mail.gmail.com>
Subject: Re: [PATCH 06/25] iio:magnetometer:ak8974: Fix alignment and data
 leak issues
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 7:09 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
>
> This data is allocated with kzalloc so no data can leak appart from
> previous readings.
>
> Fixes: 7c94a8b2ee8cf ("iio: magn: add a driver for AK8974")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Whoa, good catch! Definitely my mindless coding.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
