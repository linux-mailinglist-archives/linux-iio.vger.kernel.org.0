Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9966249A43
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHSKX4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgHSKXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 06:23:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F3C061757;
        Wed, 19 Aug 2020 03:23:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so898741pjb.4;
        Wed, 19 Aug 2020 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZF+JkSDfbnzvjaa8IC3wj92vlganG6A3YrEjV6Fuv/M=;
        b=UEP9TuJDEd2pHM+8LuXD+l6KqMp5ef2BIAsBD13tY6H/ugcKB9lG/cwi9cFl/ITTRW
         bqpVhsSYTveAaxqRPv1ZNfw2svZa7HFhNMg6PkNKUMeX+CXjLp5/CO3x2GPTSULzlW/N
         qr/Gs4IwFnPFATmVf/JCh/pc7jxxJRYeNuWgFwL5cMAlKGLJUP7et/lNhq9420rFBzLb
         cQgHhddJ+521SyxRgzkfu/KQy8Y5HfwoMhz81eVJnEoSaZuCdM2RNwzk+cCicaIENMup
         rFsylIcxSiuksJkG4nvVeklcP22uP/NvQ0QmEoXLgA/qj6kCRxQbmAaPN1YOSvpozEA/
         +8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZF+JkSDfbnzvjaa8IC3wj92vlganG6A3YrEjV6Fuv/M=;
        b=oo6zaNTFOWlbYQ5YAA8JN12zNBrnR3NrEyxPSCr/DVn4XhmYr2smUacbwqjogQX/Rn
         tPUzfvfspjeP1HhTTlN9or6iPCATbegQZ8lJa+8qmJKmVUuvT6W6Z2Zad0MyJjn+kw8G
         sqRZoaE0l2r4NNI16Fysg7vbpfVhUpePijvUJnJLWgIP4nVdQiPCdm/BaP4ySGEjHl+J
         zPAKFEYLescRO9sStNWRKtd55Dk8ega/vX+k427Kc/RYsgVxz55RJFysty+4sg1Hjkwb
         44+xuh5mwEChfF8EDR42/G7H6c5LABhsWiK/LhDpm4k0JNV6A3gLMYNr0mPQhQiBjka3
         2JpA==
X-Gm-Message-State: AOAM533y/6XoNFbaq6hazjy3VY/zVo7GGRsqJGEkt59F6S72eYpdoTmk
        wQBSVx+fvHu3JX/i0XsaXVaBgQ8g8wJP50KdBBs=
X-Google-Smtp-Source: ABdhPJz/poGFigNWxrEccu1EA8W7dcsV7edr3zwKR57UmL0YcGlTLfXoKLMXSVw5mJOn5HH5iJ8lHmrXY+QKbaxHH2E=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr3641739pjb.129.1597832631782;
 Wed, 19 Aug 2020 03:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213055.103962-1-Sandeep.Singh@amd.com> <20200810213055.103962-2-Sandeep.Singh@amd.com>
In-Reply-To: <20200810213055.103962-2-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 13:23:35 +0300
Message-ID: <CAHp75VcYhJnknZyy1bZBtM87bP=XyoL9o+5TU-PQcDKg47XKHA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] SFH: Add maintainers and documentation for AMD SFH
 based on HID framework
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Richard Neumann <mail@richard-neumann.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 11, 2020 at 12:31 AM Sandeep Singh <Sandeep.Singh@amd.com> wrote:
>
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
> document.
>

> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>

Either you missed Co-developed-by, or the first SoB is wrong here.
Please, fix over the patches.

-- 
With Best Regards,
Andy Shevchenko
