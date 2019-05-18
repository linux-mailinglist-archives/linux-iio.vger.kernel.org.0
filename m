Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E37622502
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfERVHG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:07:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34631 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERVHG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:07:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id v18so7670302lfi.1;
        Sat, 18 May 2019 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3p6wWF59ZsveqGprf3DgYpOGTHja2l9mhpdTwfZFFaM=;
        b=vQzpQaMlTVSiJnQgQXste8BGixnjGcLOfLI6iXbMIb2UdKRjYsteD0wWdmmu/zPmKB
         d9f+UFNq01IfLvcSuXtLrrMTHAOHs7HTav2sqi7K0WkgcjtiIcLSWNbvxrVbZOgXRtzM
         imIHlZ0G3Rsskswi+aXhMCycKU+DGvJLDnlDYnQzg93uvN+jSqotXNwbwjzETP8pzNLY
         8BjAQsjD+xkDh5oqKNGLUN4hOANLNWNKicyVS7Szs4CQ0qzNxKl9456FcRnaPH5PdQB1
         b2R81EMUeVvWrSRQTL9yQ4ZNtIV2Dmg/gSzOD1PkiHpp9mbSEeA3Z27WR2aToLEJt2Vr
         2wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3p6wWF59ZsveqGprf3DgYpOGTHja2l9mhpdTwfZFFaM=;
        b=h4dg+BtoB9kRZdSlSecu2Z5zawbJ5vLQvkO/UsfrecuXbO+jiUEc6WgFxhTQQcrX6h
         xn05XZLL6gQQVq7Y+9avXAaiKw0Mgd+xnHMo11JTCjin9rkrxRN6tHmJdO7gaLCc7Sas
         Ox+kTZyobfH7yZxJJYUJ3M3EJTvmRMRLJbgg4/MtW8NAEFXju0JQ/yRfINsMykG3xtDt
         KKGAQ9H+UixrrBzixpuTSbxv3bEFmeEbxtttVq/tyntSHiAna0XcFyke1olli5E7zjUJ
         sVYtSQj5AbzLAarbRXsXiN7qr+v6/NoQ26maWqCsc/StH7xKU4tOMWMVXLGkfgUIMb+S
         2UjA==
X-Gm-Message-State: APjAAAVogxOepgubLeaOMVDsIft1hv/q5jKfBwYlnuEiAdHLn3dLI+nk
        Cwo+pOZVxCbvs7YfxgFTm2gKF21rel58PYeNtFo=
X-Google-Smtp-Source: APXvYqxurWCLzYbRooydRmlbrAzU6r5dSq9ppZ/jOuDyH4jRwxWgFDP9fyydWEXyJP+merckg0S9bPx351c1hQ5XrqE=
X-Received: by 2002:a19:5045:: with SMTP id z5mr32798202lfj.108.1558213624358;
 Sat, 18 May 2019 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190518210008.20147-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20190518210008.20147-1-lucasseikioshiro@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 18 May 2019 18:06:55 -0300
Message-ID: <CAOMZO5DvKGu61Q1o0f8PvcHGMjgHBKY-fsawzUY0UVX-sHGJSw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adis16240: add device to module device table
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lucas,

On Sat, May 18, 2019 at 6:01 PM Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:
>
> Add a of_device_id struct and MODULE_DEVICE_TABLE call.

Please provide an explanation as to why you are doing this.

Thanks
