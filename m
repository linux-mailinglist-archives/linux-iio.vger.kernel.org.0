Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06222CF9A
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXUjj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGXUjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 16:39:39 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCCC0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:39:38 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id c11so2494626vkn.11
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugfc4z1Sse9ZbIN/IxhzK+fXKHAP5kdvENEw9KlUA4k=;
        b=J1sP4XCuyJ7w/J6wNht2mFKaTFqYcEq9mdPZvQB7bFqZB/nkzSCgqNvi4+rhcwghzD
         KxrDKPm7diaDemEPG4Aid4QYfnHaAo4oulmyUgrjY9WJECEvdwHlYK4a+bHX3Qs90ERj
         Ko87bt6yXlGZi76FHOTuiI1fNxLmJeBLJ6KAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugfc4z1Sse9ZbIN/IxhzK+fXKHAP5kdvENEw9KlUA4k=;
        b=otIJ8oVYo+c16dI0J/aDbPw+cNYh22r0t/SOT0/IfippOjGhHBvJEcVp+zsDbFPRfZ
         VlT3Ees4mSpnjrWkWUKjqWsO1K2HWwL2SYxc91yhymxVvZDbRWzB2lj0tYAVfQhfAPCB
         khxBbZtPAizs5CYBwrBFoW2/XQpr4lDyGSvYRJySEBVjzxQiVSon51hbpqq5GSc+Hjv3
         y2A4qLaKn0nKHor8u4wt0zkYRrZZylYxt9UU+lfs++VSGd6l9ahaTEoUUiZBOBTLsCim
         4HpcDZ98B8KOrech199bZw/1xrY3Os3+5t9uZY5FHhffLlNPR5m0pah/XJ3vo7+i/taQ
         CvxA==
X-Gm-Message-State: AOAM530obG6EtV+C5OaTM5C9LpN4cgBBWTGArtehPzBWTN7FkbzqedzM
        mEHifqpp0rZ0SHiiOLFsvzhQUGgzCNE=
X-Google-Smtp-Source: ABdhPJxz2yj2ACFRe7/xdmKoUbVP4RKkZMFxKx5yO0moO6XEr0SsxctqnXezgoZCL44iB4UydN3vXQ==
X-Received: by 2002:a1f:788c:: with SMTP id t134mr8512457vkc.30.1595623177587;
        Fri, 24 Jul 2020 13:39:37 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 185sm255544vkr.15.2020.07.24.13.39.36
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:39:36 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id g22so2501006vke.9
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:39:36 -0700 (PDT)
X-Received: by 2002:a1f:b68b:: with SMTP id g133mr2763682vkf.59.1595623176252;
 Fri, 24 Jul 2020 13:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-2-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:39:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRDWH8wgX5EC3S_dw_riDoY=X4EVY8BbD3ctmA6Wi+GA@mail.gmail.com>
Message-ID: <CAD=FV=VRDWH8wgX5EC3S_dw_riDoY=X4EVY8BbD3ctmA6Wi+GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: Add bindings for sx9310 sensor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> From: Daniel Campello <campello@chromium.org>
>
> Adds device tree bandings for sx9310 sensor.
>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> [swboyd@chromium.org: Add both regulators and make them optional]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
