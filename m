Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5986D344537
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 14:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhCVNOi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhCVNMY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 09:12:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F91C061762
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 06:12:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g8so14077609lfv.12
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vU58xgcLNpBCRVz4WMeg8LtuWontUc4uncHkOFjslk=;
        b=lsrOzEmODgM6RKXUxS4651R4DLioUgqRFy+MNV09IvzZR5EOlPNSCT2ELtimX0GpeZ
         yG4J473Ib/N4NMBnlf9XpQ3BoKqUBnQeDNd7Z3k74yHW18tpDB5TLFFm8KNODWpG0Bqt
         WXe0SuL3vcGnIJI45Nx7+WnVUAyNguYMQP29czWwqUEgir4ldBdc+WWKK3ZY/S+BIIw3
         UOE2sCCO3GVyg6HD6W2XVrD7fPDQ8usLsH8kTOAX3enC8Wp3O0ZbJpCk/pofwVHoIvqX
         rLtUxd+C9aNG9R53uHPjbuvoRTAJPTTjoPmwpWevjxEvwmfHU7cOQQMGQtY24RCjf4im
         MBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vU58xgcLNpBCRVz4WMeg8LtuWontUc4uncHkOFjslk=;
        b=skHBEAxWpZtGRacuSsLrdr500tvquqC+u3joG11D8J/PBqI7loR+GwYCDOcWGZRJaY
         gVaiAwTnScHP7gFyHmzZ9AcTyuuxcG48k/O4Ix+WhV95cYOJFpqrGvzrBRVwmbxVYoBq
         wDLeKUGroAmlbXWuP3sxIiwf44/+CRG4D41sTVTtfleM49qXgwy91RH3mCCQXJmkKw36
         T4TlOJVHlWOyMmVC1/7AFgqv6e4jl/zDBt7vs6s1S96j45TK17X/B0hESFiTXJbM+EW4
         SJtOILD6UfaI69UG/4KEsMdlw3E5ZBa0q2BLWoGFnPFFFCPlxJwxEcMeOqYJCk72/3Y0
         HN5w==
X-Gm-Message-State: AOAM533aJ9XGOxMcCpEy2J9prYbE/yUlLoUxZrYTjlS4GKAZyPIH7lq1
        MDBgTRYw+lZvYFyCY7CTUB9srC77tyjIShSIbN4dVw==
X-Google-Smtp-Source: ABdhPJxISGlFyU1euCKjscZ6JySMBwTYImgkVAuNgsoQn8WD7urrk8rMPDPCgnoBlEe2/JN7e7RWupHJ48jsqfafWgk=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr8591483lfa.157.1616418741963;
 Mon, 22 Mar 2021 06:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210319133357.541183-1-linus.walleij@linaro.org> <20210320160336.6f53dad5@jic23-huawei>
In-Reply-To: <20210320160336.6f53dad5@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 14:12:11 +0100
Message-ID: <CACRpkdYYtOyzobC51jh9RjVZV4vO_5f6dGCAvRpbXnfWEVva2Q@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Use as standalone trigger
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 20, 2021 at 5:03 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Ah. This corner case. I have a suspicion a lot of drivers
> suffer from this case.

Yeah :/

> I confess I'm often too lazy to
> look at it in a great deal of depth because it's not a particularly
> common thing to do - and we long ago dropped the equivalent
> triggers that just used a periodic interrupt on the basis that
> they didn't add any significant improvement in precision of
> capture over an hrtimer based trigger.

Heh, it works find to use an hrtimer trigger of course.
Just that I am too lazy to set it up in configfs so I go
and poke holes at the implementation by using some
other hardware as trigger like this :)

> Mind you we should definitely close down the bug either way.

I'll find some applicable Fixes: tag and fix Andy's
nitpick and resend as v2.

Yours,
Linus Walleij
