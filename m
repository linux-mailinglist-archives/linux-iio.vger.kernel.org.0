Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122273A952C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFPIkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhFPIkf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jun 2021 04:40:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E6CC06175F
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 01:38:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p17so2973439lfc.6
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/rrUBRBKr4+tIfljhgk6uKWo9IRMgLxxsoOB9I8YGI=;
        b=QYGc2XXGDuQT8k39pSCunL/cqnKQ4dae501GTofBf0roPJEm83xUKWTiW5EN3K4biQ
         Xb+9+mDa/5GMPvPjUTjlCYEbTmcz2x5gZhL1tDtNq+0FcKb7AYPD1R8t7/CH80W+ax5T
         gbm4VWsurXzothvPvZW10287TGFQYCWAt1GtJDahhVW9PfSAQjeH/u/UfpffzgxlyDq7
         T8SGNJdpKEUz9CVGMbWZKkRQm0uuuK1+wwHgCIGWJ4CiNX6K7Wi5huA7ljOi28E2zDsC
         ZMReRZVT23gS4JPlk1OqT0nn78Ox7MoQMUg8eW9DiryxL7CFc+XlmA5AmJ3znrrqI8wV
         8xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/rrUBRBKr4+tIfljhgk6uKWo9IRMgLxxsoOB9I8YGI=;
        b=sqXmDSH0C+XkrYRg/i7soK4SD1v6yAUZ+jVFdiArmPPC+lWgV2v4br324jbleYix1z
         6nT0dEQTlXllgYLfsGTWDsl03kFTG6RO2nA26wxh1hiV/tToey5macHjUZJlPwiVmnV2
         pT403blDnA6sAOgEh5E2/nvU7etTbYvjYuJe0AW2HesvL9e0M4r3oks7EzoLVqtRhCm4
         UKSoAmd3/lk4WFERtKhEJQby6A/0/oiMiNUfYtoM0h473v/eHbvrjVewR6W4m5fU1DX4
         FIv/iVCs0TwuGdUNcykkzTBb0pimIifFZS627nsinTk+5A/sga3O7LGMe+2HNB2jaDTc
         c2Ow==
X-Gm-Message-State: AOAM531Y9aumMlHFKMStfj9UuGCAmvmoeS5BtHMQRn/9VNCpK7DW1mRk
        /EtqJkq0JPM5zLMuoPgvLMqh8T/uvJhE32IMWR7M6Q==
X-Google-Smtp-Source: ABdhPJzV8rcxUyxYn8NVP3dd+mKcvzZFOcNT17YroYdYGlp71gmpX2hIgMkExGRpBrdNAGn4haW5sKD6K0oc9a5jmsU=
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr2787448lfl.157.1623832707400;
 Wed, 16 Jun 2021 01:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210614163150.7774-1-stephan@gerhold.net> <20210614163150.7774-3-stephan@gerhold.net>
In-Reply-To: <20210614163150.7774-3-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jun 2021 10:38:16 +0200
Message-ID: <CACRpkdYSpf32bR4MZ4ZdMA+-tR5=OC-HXhEOP9x1ihxcDseZug@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: accel: bma255: Sort compatibles
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 14, 2021 at 6:34 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Similar to recent rework in the bmc150-accel driver, sort the compatible
> list in the DT schema so there is a consistent order.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
