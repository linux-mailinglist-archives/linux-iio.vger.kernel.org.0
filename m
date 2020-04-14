Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368E1A8085
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405386AbgDNO4o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405331AbgDNO4n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 10:56:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078ECC061A0C;
        Tue, 14 Apr 2020 07:56:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so14684311wrs.9;
        Tue, 14 Apr 2020 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Ylc2DgJtl9491l3yCt+LfBbKiDxV0gFU9LZJhM118g=;
        b=ixBDd/25zvjZh+eexJVaDlSz/5jQRWtZCmKt1uG6dJFsmwjdFF7DZCC37YvxvTaPQE
         sAnruMTdD2M6moEXP9rR7sDjhLSVA5dL6YPdPqjiSa4SD8h7mOOGCxbTOJRSzsU4x+64
         TaHQwSg+0bjPxX1qBq7we4V5LGDi2MCNpWmowO5LR8TVAskhjSMRAWuO71329L1EDyAh
         R7pNNoqAqziTsKVGwZ1hM5oQgCLfMCTRItzD1GMVDp1bX7RcSW8nLGpVSK0Rbv7ERSQ+
         tSSsldd8IXbk7/cYspmUjiDbqsjv8Qz9PNSGJMBM1VCtnKv5JYoTjiH3pAyOP3l47f1B
         NUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=2Ylc2DgJtl9491l3yCt+LfBbKiDxV0gFU9LZJhM118g=;
        b=mq1k1Qd0hID0BBscNvug/Cw+qGLcVQGm8jdNXd9UesWTi+Uy+KID0zJAqmMiVMDZ9d
         b6IMzyHRWz5jxJO2AcHNFpsKZ1/tgDQ/CzO1Su8F2fC4wR/NW9NY6/EqycwxOXb3FTL5
         fsFuja2CD+/yANOVJTrUWTyPeWMQFcBWx1/icDMzKvwdTxm0q8fl9haetQ9H/ujKHOKq
         TXCP1hLN513g6y1dik1qRRptf1lXv9SoxZ/G4dfy3yI9l143KV6528pP0amRFt7uw/dx
         8HwkJFuXsdp2Ad/ko/dFbbZ/2Avw4jNTGM6XPWdBox/bkEM7+Yzb6jm43L9n33bgu3qE
         f4vg==
X-Gm-Message-State: AGi0PuZx06C57xF9jbEDrXT7BeG39Ok5dlbcvw/A6nJ4V2j7ta05Tp5G
        T72xSfgX6p8+7xky33h+NUg=
X-Google-Smtp-Source: APiQypL2sITqgDY7ck/AHMuQ06IDy4Vb/hp95PW/N5pFGvWeyagsLExZNAHPUKLTnfLHuW+chUQ6rQ==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr5817681wrr.247.1586876201770;
        Tue, 14 Apr 2020 07:56:41 -0700 (PDT)
Received: from meru ([2a01:cb18:832e:5f00:b5e6:d07a:cdd4:c0c6])
        by smtp.gmail.com with ESMTPSA id t20sm8863392wmi.2.2020.04.14.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:56:40 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v2 4/4] iio: vcnl4000: Add buffer support for VCNL4010/20.
References: <20200406145356.25883-1-m.othacehe@gmail.com>
        <20200406145356.25883-5-m.othacehe@gmail.com>
        <20200412144602.25e2b810@archlinux>
Date:   Tue, 14 Apr 2020 16:56:39 +0200
In-Reply-To: <20200412144602.25e2b810@archlinux> (Jonathan Cameron's message
        of "Sun, 12 Apr 2020 14:46:02 +0100")
Message-ID: <87y2qyi09k.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hello Jonathan,

> One nitpick in here which I can fix whilst applying. The series as
> a whole looks good to me.
>
> On a more general note we probably have a merge conflict between this
> series and Guido's one adding the near level property to the driver.
>
> Based on a bit of arbitrary timing I'd like to apply Guido's first
> then try and take yours on top.  If there are any problems I'll
> probably ask you to do the rebase at that point.

No problem :) There are indeed some conflicts to solve, I'll send an
updated revision when Guido's patch is integrated.

Thanks,

Mathieu
