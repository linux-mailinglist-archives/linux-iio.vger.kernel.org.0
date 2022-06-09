Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587C35446A0
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiFIIyj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiFIIyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:54:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE311808
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:52:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r3so6480386ybr.6
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLRBbUkxuAe3aL123UT1/tEUnto7xw/+eJBq/RDDIX4=;
        b=oPx5nKc+eF6vxjkgA+yWtKUSPU/DhZXALzInPHVDm+4lac7KXoObN5umGx7MOTCJdh
         ajZQcpwYbeRbtal60gobYRMZjhTVg/JeXrMtA1flpBkk5NJm1ADeOcNEO9Y7u06OVMZh
         JTuJLnc5QXZ+wGPvJ6LHSb2WYe4o922TGBKJ7k60t2LUD8xUhtI156TxFfIkd/yTue1B
         4cVzWUi31JhavzqwODwsE0ZfPIvy7ZnvNX6GjONCyzOfPzn/JMe5D/TtcFz2drvzp0hf
         P/gbkdAmbLgRhEr323gFEqlhsOI68nd5050h691ctdTAcMzQt2uAA0BrwWuKrvO+76zK
         vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLRBbUkxuAe3aL123UT1/tEUnto7xw/+eJBq/RDDIX4=;
        b=SbOqb9Z/mci6hJfDGuzzyNh4YPp2BppCG5AKf7b2nAleH7exswDEH4gxOYluFhI22h
         2vxi1sL0dNC+N/D/nUH4mwYY5KQLfBSdolovfgS42cFZuU0evYSMHF5fTBa0AnuoqWIm
         MC/5HxMkiKB+7g3FUXi64vL+mZxkwtzwyPRLzPw9h4R7O4OogCkZ/Bk4JQjc8gCDvjVW
         TU/MLq1ZSiNCNGp30+RApBp7bOeP0DjWucX7rcs1ITdi3EAaOhaVOF9PgAkVcprNM5V8
         gFOIpVaN+oarWcMPycQybYC9CyeeoqKfumtoicZcymE9nyEKPHdVbKYZP3vDl5Vkm02x
         lviA==
X-Gm-Message-State: AOAM532iI2p5zCSzjV9sXnIIElNmkmw4hsFIQNbpyHTmQX+leNsRmKZN
        VGxq9k89kaW2nfd+9MaQlLueHuN30ncVw9T67tc3Hg==
X-Google-Smtp-Source: ABdhPJwVp8uNHhAO5LGW6oQ6PTlrWr5m4L4s6MphhIpSEmcQAZzexfY34X40gprHvPquEideZzkdbgsxbRBH2KUMRGg=
X-Received: by 2002:a25:650a:0:b0:663:461f:86f2 with SMTP id
 z10-20020a25650a000000b00663461f86f2mr25015220ybb.514.1654764738144; Thu, 09
 Jun 2022 01:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <b7203b1bd378fc554fc2cdd435176d597272cd89.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <b7203b1bd378fc554fc2cdd435176d597272cd89.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:52:07 +0200
Message-ID: <CACRpkdZo1jNgtQEJgPEBNVs5M5JMD5WnO8gHEEOBFLtOSu=yAg@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: magnetometer: yas530: Correct scaling of
 magnetic axes
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:38 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> Looks like YAS530 raw values return picotesla and YAS532 nanotesla. Adapt
> comments and scaling.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Ooops. In-kernel device trees only use YAS530 so the fix does not seem
urgent, but it's up to Jonathan to decide whether this should even go to stable.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
