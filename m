Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650802A66A9
	for <lists+linux-iio@lfdr.de>; Wed,  4 Nov 2020 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgKDOqc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Nov 2020 09:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgKDOqc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Nov 2020 09:46:32 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA6C061A4A
        for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2020 06:46:31 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t13so23172475ljk.12
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2020 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaiOCdl+gFV/W3GxQBKOzgnoA8DGUtjj+AflxrXx1VE=;
        b=QNApSReGppzoDLJ1EOPy3ksAEqpTVn9sY9zPO2GjSAfz0VQeBRUw7QwxMR8IRUxRMj
         uAirIHE2Wcug+fgxUTz6VshERw5LFl7kShV/rWLrGSJ5nI6kVc9+E4EcLO7vdaJKkcwl
         1PEqMnQzqY1c8ra2PCBHji1zaFFmo248zpwRgWVQZrM9QLhUosImyiY2CpzueyIXnzFw
         nxDtYM7QCBPAYhiSaY154in3xIx/NYuBTLgdIDntmIfNOb9ixGPpnSuvZOPYg9sL0CVY
         gLe6CKZgK9mNlyAgOhGyn4wD2zz1Cxt8w84BGSbgPcEkaEB0i8pQ29Fa1XIM34SX19g0
         etMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaiOCdl+gFV/W3GxQBKOzgnoA8DGUtjj+AflxrXx1VE=;
        b=qlynffGbwNv7xoIdrNog61dkxIuUymEmvzPgdrdawkSeOzcH7y6JxuRuWa6+fiTMFu
         i17MqayyG389Nf841/pOt0dZBUmfREIBlBX1X+2anrEF2GglD4EDSy1V3M0H2uTho2z+
         VBlDfXqFkjHQJTSDHenLyR/5yxLLV0Eb0O2R+spgZ+xAP/+UxY1SuycEdM2U0XYR6aGG
         9eC4JpDrLm0wL3bbgWwFNplD005OD8fflUtpRefMpkD9PBWQjqBpxlaOh5xklUytXj/W
         gFPVhzhzYklzqioED94gERFmw7x9N9PBhDeoS1eqaacQmKt4tkKt71ihrYo3oFnbfx7C
         +mmQ==
X-Gm-Message-State: AOAM5313bBVOwgMtf4HysxGUV/PDA6fL7fE8zVsF6TDqE8I+1W6FYrZw
        9RlQ82IG0SrNVo1lMGfXSY8fTLJ8ddkxM+AXExRrfQ==
X-Google-Smtp-Source: ABdhPJyBI14KChgSLBwhEMe8iVmpquoINeKVFw0+u3m71Mf9awhJXdl0JA6nhPdMeH73CcASuZMLW5J5+PhrWbVs4zU=
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr10425849lji.104.1604501189577;
 Wed, 04 Nov 2020 06:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20201031181242.742301-1-jic23@kernel.org> <20201031181242.742301-10-jic23@kernel.org>
In-Reply-To: <20201031181242.742301-10-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Nov 2020 15:46:14 +0100
Message-ID: <CACRpkdbuuiwxmr4BdOHn2LRckhc7+cRb7JCaoVpsL8aR9s65tA@mail.gmail.com>
Subject: Re: [PATCH 09/10] dt-bindings:iio:light:capella,cm3605: txt to yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 7:15 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple conversion using the new iio-consumers.yaml binding in the
> dt-schema.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

FWIW Kevin Tsai has listed himself to maintain all Capella
drivers, also this one, so maybe he should be added as
binding maintainer as well?

CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
M:      Kevin Tsai <ktsai@capellamicro.com>
S:      Maintained
F:      drivers/iio/light/cm*

Either way:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
