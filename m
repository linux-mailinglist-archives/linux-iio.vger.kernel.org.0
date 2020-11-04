Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC502A66B4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Nov 2020 15:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgKDOsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Nov 2020 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKDOsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Nov 2020 09:48:10 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C298C061A4A
        for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2020 06:48:09 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 184so27456795lfd.6
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2020 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRl1lNTwVEiKC7qk9DRqYh4fSXthHyMqZGuppjy3Avc=;
        b=K/G/3SgOk/0jUCz8Irz8OsNUeEnQfLZbl060roWI8pRlF07gJ5Ra+NAzCQWHrqGGOR
         Lq34q/mGAZ4yvhGp/vr+icjLB84fJONgFiy+ECXgStGkzZQ2feRj+gjx8CYdh+KI9VQo
         5RPEtnHaEyKINikhWVbpCtvIkf86j7Q6olL1XUtk1wEiY0wVp0HWxNo1R4hQuo0Ti4Oe
         aifmq2aBId6eiVGkojaQ/oa30jCmpzCQxTeGrfmgT1T43nBIpiJK+vEersG9RPInTcOG
         jzei3p9ppwF0InmQLFDlezSEuP8112M6ENgI2YEjH+gCnTh8s646jnxfKBD05lFYKVwO
         6yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRl1lNTwVEiKC7qk9DRqYh4fSXthHyMqZGuppjy3Avc=;
        b=OT0p4QKIZIseg1J/8fwuZxpihCVH5FCnlwsL+OIUzNz5DcmB5D8tOEdyBrHcdovNGy
         B5mONll2YJ8Yt3ZnLKcnPdbyuXg3rvYReVJnnj7RVwwWxvwGDccKRdsrCM8GpJykOino
         GZxEpFviESe931ARiTlTsROyEcmNXrWgXg/tSnyzK6wRe6IAeSapi0nSY35Nw8YiZd6f
         WsQWf0OAOyv5T8ksSAIxvvwEbNwpy1/Pj1JncLKA7wuKro+YcY2zAgd8MqjbuuZ2XZnc
         LdEIi/Ywb3BTtqmD0KTMT3IrQY8qtQPXUrMIjz+Oo0n+Bhw6cp3GFKEGvVN0UBIoyqvN
         BVUA==
X-Gm-Message-State: AOAM530fCvFURWO90uqdSwg5CO343k//obOhYL0pwxfUQT76nBO5iFPP
        1wzfner4TzO8nZjmyMybSXyfOKvx96BKitXIXaANGA==
X-Google-Smtp-Source: ABdhPJxKVOIoUCBhlizjZdSjuzNjA1oW/xNxnmLmWCCcXKhOCS7Mmfal7CCoRv8zaG2hApsTWH76hPAH2B6oI5HQFpM=
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr3178864lff.502.1604501287766;
 Wed, 04 Nov 2020 06:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-25-jic23@kernel.org>
In-Reply-To: <20201031184854.745828-25-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Nov 2020 15:47:56 +0100
Message-ID: <CACRpkdYTn59+NJm1f6cYfAZU9+9UaPE5PFbCMMDCcTVO3jbMdA@mail.gmail.com>
Subject: Re: [PATCH 24/46] dt-bindings:iio:magnetometer:asahi-kasei,ak8974:
 txt to yaml format conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple conversion.  I have pruned descriptions that did not add much useful
> detail.  Note that the mount-matrix description will form part of a generic
> IIO binding.  No need to repeat that in every driver that uses it.

Writing the mount-matrix YAML binding is going to be interesting!

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
