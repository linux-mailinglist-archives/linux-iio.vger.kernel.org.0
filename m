Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F822CF67
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGXU1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGXU1e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 16:27:34 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FFC0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:27:34 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id h1so2494830vkn.12
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2ruj0z8uszwGspJCW6p4c9P/N6BQb51KF9h33pNyFs=;
        b=gTwVBgw3J0BD/uJ5XicjBCeS+kjnEBhCXyjixE8mPUgsBsei2Y9WlpbTkFCkqVV7Zb
         RoIyUfEgwdF+XErM9mrmXe2hv5+O9Da2Q2MpiA00rDeJfjOMpn23dTjk8NKhDCclzXqi
         msFpOIG/Xnb1D9ankx7iexK8zmAvem+uYH8LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2ruj0z8uszwGspJCW6p4c9P/N6BQb51KF9h33pNyFs=;
        b=RW2xBkO4mDH7H6XZPZ5i4yyT/dONOXSHQ9z2Iquqq8tY9EeCowuOF00duDDZ6Huy73
         htqvkM/CwVBbMVjBlB86Ohzg1p4xoQ1xl8CUNMgCNr9+RZJaK1XqmL731rwA1ZhVHwnk
         PM10MDq8jAzLwhKTb0RyKGFWEl3dGleeePpjm5Fg+Wgrqkv0kjgq+es/Aev675wOreR4
         MaQy5f5n5CRKjbDgP0IGbqEGlgqV7WcDtTEp+1y4adxePoG2LLsTJj6hFLq+ULiPV3ku
         2Wa3EM6EajlTAhuBW1imaW5CnocciVhHlHsmP1yI8YppgNrpS4ox70V87pHu1QgY3lJR
         Kf4A==
X-Gm-Message-State: AOAM5320Rc3hkVVUf8yut2HKXZMk2KBr1x24L5gJ9UpFASkSpSiwpb9c
        AFUAcaE0DgRw9wmAPUQe8rb0FuPSOM8=
X-Google-Smtp-Source: ABdhPJxeBgw9GdlLfu+IdNyasG1XHHLyzVrO+eJ/8uKTfdEVaHejni3f2qh+dYNnEKhbKiTWzVvSdA==
X-Received: by 2002:a1f:2ed4:: with SMTP id u203mr9372863vku.72.1595622453077;
        Fri, 24 Jul 2020 13:27:33 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id i4sm254221vkg.55.2020.07.24.13.27.31
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:27:32 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id b6so1011272vkb.6
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:27:31 -0700 (PDT)
X-Received: by 2002:a1f:4e81:: with SMTP id c123mr9478657vkb.100.1595622451504;
 Fri, 24 Jul 2020 13:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-3-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:27:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9Ksm+=EdkLB2xenXxx5PoB_z3E7Vfi5JQ0a+dJj2dMQ@mail.gmail.com>
Message-ID: <CAD=FV=W9Ksm+=EdkLB2xenXxx5PoB_z3E7Vfi5JQ0a+dJj2dMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: sx9310: Add newlines to printks
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Printks in the kernel have newlines at the end. Add them to the few
> printks in this driver.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
