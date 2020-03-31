Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0EC199CDA
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCaR31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 13:29:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40074 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgCaR31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 13:29:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so8360263plk.7
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2020 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYhvnzrnmu608enwajUfkT/e3MbhwZNhvOVNDcmeYTQ=;
        b=mHPAOccjiWffgOh9dHXj/rxrkHSve1ukv42MrTOPorArWShMyH3vG7S3pORLamyomy
         3XsmSG3x6V3alBHsbZdpy3UUBXar6Moj1JGaNdUwEiNqXu5cv2TnBGWT0GzBHXEUL43C
         +kJqIX7a/iOru9hMHljEb7yMsfB6nVFaUq+Uq663gFUssTzaVKl+D+Ghx7UnLNTZLaT+
         fjFof77jlEoVi4Db52mjqfVZlpWFgfHTK/VragPCqcNmM9OO7ulb6OmoW1UG25LSvZr8
         7wrrHnHzu441tQN64ggMk11XUbOUqnrILf2gRxwgKtXxoaQvx1Moqb6EGRCqMZWw+s2n
         ijcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYhvnzrnmu608enwajUfkT/e3MbhwZNhvOVNDcmeYTQ=;
        b=e3tLxlU5bek49JHrNnEK6N4+8c9T4Vvu8/EljfdaqKQIsOFmbUgGSG2r9XBeseF4Cj
         mL84yH3V5/XLsrIXTsNSqdTSywWI03XaB2p5w8fYPMrWlv/LElsoI8Lr51ZfOGrJyGQK
         9ygRpCYNOeTx/+yJsTsCokNrni6Af4dOg9NtWVlPy6qpCTqFTEpWAzvLfvZOVA9IhG56
         XpnhgPgxQZdtrXDLAVikIqeYvpvNW3cnvGoKPZpDQLd0aS8ZSaeT09QwSkBpjKHFh2M9
         yeo2gZ1E0xgYOXzwty8jmHCPScT+pXTP4UxfdDy7GS4mLSMOOYuTVTu+P1zeA3b23VVT
         +qGA==
X-Gm-Message-State: AGi0PuYihTLUZ3dV6CT7D8bvvLGLIOl27E6JvEN3z/n8XFrxJ8VFawLz
        emY+VJ6K3vntXHtNbTLtRkXjS+RB+0+SZWdL2Ws=
X-Google-Smtp-Source: APiQypIkGaj1ni8fooErM7XDOR2E4dpJrbCg09vH6zZH5yQrAOSARf5/hJUULIyxeWTbqFVaShdnxTscnlxVUib3cfU=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr5237240pjb.143.1585675766428;
 Tue, 31 Mar 2020 10:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133850.23757-1-jmaneyrol@invensense.com>
In-Reply-To: <20200331133850.23757-1-jmaneyrol@invensense.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 20:29:19 +0300
Message-ID: <CAHp75VcSrej_dXeKBXXoVBg-3scUHrZuwRDrdB0Qy4vOGHbLag@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime power
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 31, 2020 at 4:39 PM Jean-Baptiste Maneyrol
<jmaneyrol@invensense.com> wrote:
>
> Suspend/resume were not working correctly with pm runtime.
> Now suspend check if the chip is already suspended, and
> resume put runtime pm in the correct state.
>
> Fixes: 4599cac84614 ("iio: imu: inv_mpu6050: use runtime pm with autosuspend")
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

> +       st->suspended_sensors = 0;
> +       if (pm_runtime_suspended(dev)) {
> +               result = 0;
> +               goto out_unlock;
> +       }

AFAIK this is not enough to guarantee that device *will be* suspended.
That said, in one thread you may get device in the middle of RPM
suspend, while here you are checking if it's okay or not, but after in
the other thread you will get an error and roll back to the resumed
state.

-- 
With Best Regards,
Andy Shevchenko
