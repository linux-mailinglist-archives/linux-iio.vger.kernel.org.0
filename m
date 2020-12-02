Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEDA2CBC4B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgLBMDW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 07:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLBMDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 07:03:21 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82809C0613D4
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 04:02:41 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so3266632ljo.11
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ok4K+mIqVXyay2RRW3bp7ozJI179etZKu1jwJ6RDs4=;
        b=B3dUpz4sabBgma2BRdldpuDu77t/6Hd5lDUuvP2UyT57QkTTBtcsG5ebn+eJRKhNxZ
         0tdoF5Bp/ZEBL0dBJska6fRvtOuajzs4+lE+Wt7Oe7Gt6z6u8QSWAOPtGWBHkLvA6JFy
         FvbysdhrWUIJ64INRgtiHPHSqLCPcK1OLc34nqR7v1eEouVpMtMvzMBB8RZAk0Ox6Eyd
         6SvpUNsTdGDRY4WsxDQwtJ2xreRodOLD0AC57OlIK9v8sQlhHUJ9GCqARsE+w3liRS6c
         D2QmBRCCrHdkStEYG4BJQ2cqfaKJLQxZGOGPAB873jyOrFomzrwUnK3AiR4zvMBOVV2D
         0KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ok4K+mIqVXyay2RRW3bp7ozJI179etZKu1jwJ6RDs4=;
        b=qpVkASysSQRlPO0NcVIv+laT7uL49TZr0jYCv3k50DT138SadL+L7s3QSkvuaqDlhp
         usepaZ86MwaoMRrFhEEBG4Tw+EXe5aahiyoj2Y08CWsGC5YesKtbB4PFMJMeuaaRu2CP
         HpKb4/kI+p4xp46k7zAzEqyTyl3PSaTqhkS7pR9v5i9kC/a7JuYTCXMt+JW0O96CCyDI
         /PT2Y+X5xzosNN95ITCe3890BNlb9JqrEDz2iCg/3fEPSu19+iL61vbu+Wp8SkiHvG77
         asJCXZLwRqlt90425e+8ENolCPLorC7i7bqXetyLFeh7rTU+GSt4DWWHi38j+Iwdg9d8
         WKLg==
X-Gm-Message-State: AOAM531JQlulJ2ZtQz4fJgfpIaqUuPPDOEd29Rr8C4iU+1ROLwzDS9sx
        U6phYZfhEzHsU479rS7KucCH8vYCh4umwEkkDyj8rA==
X-Google-Smtp-Source: ABdhPJyzfJL3KBSA209hDbk3QOHKy7wLOVNaFMCkj5BA/Way2Q/UljZAi4TUbX9lLOqQK8SYae+wTJ/YZQpq0qMGwMk=
X-Received: by 2002:a2e:97c8:: with SMTP id m8mr942845ljj.338.1606910560052;
 Wed, 02 Dec 2020 04:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20201202093322.77114-1-stephan@gerhold.net> <20201202093322.77114-3-stephan@gerhold.net>
In-Reply-To: <20201202093322.77114-3-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 13:02:27 +0100
Message-ID: <CACRpkdaBxerf0QOzaK8SH0AuJQa9khD_1TrDYegkb5Mk8Vbadw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: iio: gyroscope: bmg160: Document
 regulator supplies
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 2, 2020 at 10:33 AM Stephan Gerhold <stephan@gerhold.net> wrote:

> BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Document support for vdd/vddio-supply to implement this.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
