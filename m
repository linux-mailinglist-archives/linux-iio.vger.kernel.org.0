Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B02457CD7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhKTKTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhKTKTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:19:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F73C061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:16:34 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w22so16072547ioa.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luJxBIunwp5HtLgeMjpxnjM3IrUXs2waLGqNavG6cPc=;
        b=HEvei7hjmOLgeDiiXRrup09gt0W/S9yUfp+TcGwsqh6sr/ryZJneQOydAMZOAdlCcz
         z9FxqPhFakRZPvT+jcYbor+YvWG+Fenyvie4VU6M5qThPLQoJuNOI9/zn9nvFW3f8taq
         U9y0dzLhKIYw6q3cOiLRcDHGiSE0e1JoDE908=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luJxBIunwp5HtLgeMjpxnjM3IrUXs2waLGqNavG6cPc=;
        b=b9i2uUDUjCoKx3zniIZ1wQx6hFEm6//qXTVVRggK8aQaMiuZhjlL5/04ZlGDr5HSZl
         9TeyRuTZ+Ya18KSzzM7Au6zhAuDkp93Ax2kL7miGeuYy2bhrCG6fv5de81tR1gm3XYVn
         jZ23/LjTRI25dqBPOE+6uj9+MjW7tNlBts/9070PF7Z2bKNyAPcUfJ3KaxiBRLK/csW/
         gvPAQaLGYLab8MHRJMrMABHWTndEuTuuxlo4oE58vu/0e8a9X3L/hMuSb/j+CnDfDn5s
         5ff/Ly453EclNaohYqWbK3HZJyuf9c3iV1hGTrCcOEkpn1JnSpWvH7fmS5lPNl0XEgzD
         Y3vA==
X-Gm-Message-State: AOAM532Jjy2YVGCkVG1PAhQ0Mypz2EhZGsLaaJIgeZ37x+RF6qN+/GSA
        y7piBb/M65Fo8kZDGpb0CE0G6GxuFbP+3jS1FoAbCA==
X-Google-Smtp-Source: ABdhPJw9IKaRIRECtAFFMZQlqInTXKfXcRKZou66MXgJZRR96ZB3yioLkR/BTqACPRcxi9JmsEl4jDUjE2uPWI1pVG0=
X-Received: by 2002:a05:6602:8ce:: with SMTP id h14mr10165834ioz.177.1637403393991;
 Sat, 20 Nov 2021 02:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20211117084631.2820014-1-gwendal@chromium.org>
 <20211117084631.2820014-6-gwendal@chromium.org> <CAE-0n51iE2bYLUmkXxuwPcdQ7GkBW+bkeJEbNOWjbV5o1qjCvQ@mail.gmail.com>
In-Reply-To: <CAE-0n51iE2bYLUmkXxuwPcdQ7GkBW+bkeJEbNOWjbV5o1qjCvQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 20 Nov 2021 02:16:23 -0800
Message-ID: <CAPUE2uv_fAP5GbF=kn+qiNBfMb2vUhZwqNFs3Bta2Xu5OdzJHA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] iio: sx9324: Add dt_bidding support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 17, 2021 at 10:49 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Subject has a typo, maybe should be "dt binding support"
Done.

>
> Quoting Gwendal Grignou (2021-11-17 00:46:31)
> > Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
> > retrieving sensor hardware property and alter default values.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
