Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAACA3040A9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbhAZOmJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 09:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732678AbhAZOlr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 09:41:47 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD58C0611BD
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 06:41:07 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id i17so19867140ljn.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hVEbjVzNCxJEWb0HsEqsvg+LpgOfvFJxL39cDjHZFc=;
        b=mj4F7cPvLPNP/4XKE7hQKA1hGU0hHCkFIHaTG+HI1+3H5aHSleQlMixp5vcxoZ83ij
         gQpgDmNls/Yy4quQAh7oFMC1RH1r4qBSFrClVRNIFbkv6L6kMSpu/lFeQ4LagIYaF7MU
         weSzdhIplCG/RgJ11lAbbRQ/UpekgU/LxZ0w8UntZDlDA4JwfxQnrtJ4UJGKMkuTdxbj
         HMksMcyzAuYo8JKDD5Vn5wuxUtfiyIgMl0bok0f47Ixca6zjXlEoQpJjkwnnExR/GRY7
         B6P2Mb/+3gZMNoh229QHcEI7iUHIXfzEHFO2I74BQJhS1lU4+5qXHc35f6kqtDnOklCp
         MKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hVEbjVzNCxJEWb0HsEqsvg+LpgOfvFJxL39cDjHZFc=;
        b=rsKZUnYUk0m6BVpiJat7u/zwXHxLcFA9HYrfPy1NVoyIvDyjnxU2nB+C243WZ3xlCO
         GlReQmSC6t/LxVSfAjYNnVdFbJTxY/IwEDW+cHXq7vAPKZJNCJur6xldA2p6DFFEdScJ
         2F3MYZhW8JrdoRq8eAtCUUzo0FPiXVzCf3AEdL0Gbm+T9cu2FQCHtNAPxxwBuURR8H9B
         Qr0XBQgR7VMJ01pZpulN9Gx/koTI6It4SRIOpU8s6gZ/gebt+59Un4MEaHhzTi5fIlLT
         4LHAIdmONo3KCy+XQ2Ml9VgzUp9ZTRVSGVIdhGdyBU74GLVN1iYgX3DgT/Mv61o4Z2a3
         j25A==
X-Gm-Message-State: AOAM530MZv5KyLKYVRLOqHQ8E3UvLj6BpW4hj2LWIz+HYrheMLW+UjCz
        fs9QjNDjdfP2lpjzkxGWo/USpOCJSBQwrOpVqNAKiQ==
X-Google-Smtp-Source: ABdhPJy28UNc1zXpn67QuJ8q1XXTcCBoNixwZWj/Y0Rmg9yacHc0ZCJ8oml2qJyFy9gVPYKY9DVxwdRseiJhS/M/7OM=
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr3133315ljm.273.1611672066004;
 Tue, 26 Jan 2021 06:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20210125150732.23873-1-mike.looijmans@topic.nl> <20210125150732.23873-2-mike.looijmans@topic.nl>
In-Reply-To: <20210125150732.23873-2-mike.looijmans@topic.nl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 15:40:55 +0100
Message-ID: <CACRpkdaP-0bw_QJ_A-WFTHY2+83WWrrNPioSs1ugYafnxaspyg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 25, 2021 at 4:07 PM Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Excellent!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
