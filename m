Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3B22CFA9
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 22:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXUnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXUnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 16:43:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64083C0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:43:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b13so5527371edz.7
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsJgK7I58ZbRpNM3/ClUx7KPh0wfxlGWyzakGfdqg3Y=;
        b=PF0R3SfHH8RVUjcPLj8/BK4who6GgfWlSRk1IUrGLn5lMqksU9S2WfWaTFWfn1agHN
         l9xBEpq0RBjDb+TQ9M73cXP15o7saZ4PnuWAZiQU/KjuzniJXhheegYkG91Y9KuBMVM4
         y0QX7h5FIyBoURUdHzn5Wt8R4U/7Yu+nUOkxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsJgK7I58ZbRpNM3/ClUx7KPh0wfxlGWyzakGfdqg3Y=;
        b=KQGIKggtGloktctJmo6i/pahavPgahzXBCzvnktb1I+eHAEXNWL76kslgbRfJUf8ph
         lhufA/3QW9uJFe+oJrhG61QG4M0Y3FjFlqvhJgBevTmV1ZE53CAcZlinOlcU4j4Rprz7
         VQu47ilnG0hzpcuwpl/lTkVbxz2gNI4KyqCY/gpyPqdynTCAcdf6OY+nozO55EsX6WOL
         Qw7odtfk6/e7hxN02YQiiltiItcDDJ9acXZQ7NzoeFBcPKNUbg70+Et4GWEko5RPz/r5
         jfnI5gaxSLLDpbXsQllzEgX5UtFlYpKQtCxr9G/IXVf5JhTaq1p2XxNOKuIDt/MluRBB
         pWYQ==
X-Gm-Message-State: AOAM532hZHDtTZ3I+5m6ptbGuNiGmKeeSZzIfx19yuJWdqApYIOnnuNK
        k2alkVGkDsTHzz1yNiaWWypNa7+LGHE=
X-Google-Smtp-Source: ABdhPJyuuP1xRWc0OIUsgQ55eFY/gbf+OHjOnt9GofJulugg+wPbgbBULModPPWabfyaeaCB5HEjyA==
X-Received: by 2002:a50:fe16:: with SMTP id f22mr10721488edt.315.1595623420197;
        Fri, 24 Jul 2020 13:43:40 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id g25sm298755ejh.110.2020.07.24.13.43.39
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:43:39 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id k20so1667722wmi.5
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:43:39 -0700 (PDT)
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr3870968wmc.115.1595623418776;
 Fri, 24 Jul 2020 13:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-3-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-3-swboyd@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 24 Jul 2020 14:43:02 -0600
X-Gmail-Original-Message-ID: <CAHcu+VaW56YSj2NiPvLNZBtgbVUHrBOACKXU18wg2j3M7_TQsQ@mail.gmail.com>
Message-ID: <CAHcu+VaW56YSj2NiPvLNZBtgbVUHrBOACKXU18wg2j3M7_TQsQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: sx9310: Add newlines to printks
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 5:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
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

Reviewed-by: Daniel Campello <campello@chromium.org>
