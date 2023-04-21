Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A276EA60B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 10:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDUIlR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDUIlO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 04:41:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916609031
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:41:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-552d64d1d2eso16680177b3.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066472; x=1684658472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqPKWSvbX4VNO0qn/jU+y/bKk/xVC6QNeAEqYppXymg=;
        b=yWVLZI/+cDslc4+RgLuEeGboDbU2kE1QKtLaMx4vCT9ftlVfidtaLtYUZy1o44M2DA
         PIKJKf+hldVToUeGMor464O/I30mqqSbRS0IV8bgGW+9JeyjISL8SsBvcQRgi68g/m80
         DRu7PieARBWVMG8Et3V2xYBSG9x7z5TsebBmcHUuBKqtWgNbXBa+l00hIWsirEY3G0Db
         hWAhfd+jalAg9LjEzblCzpfg9IUA5zZ1qgHe0fien37hQaYfdA3GyrWZ1Cc48YbqVmX6
         FOhB0XkISqY+jHljzxXSta+vLgyy9vGSXOUzbZnZ5vzuamccqCywRe47v6mKKGwxAkSF
         BlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066472; x=1684658472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqPKWSvbX4VNO0qn/jU+y/bKk/xVC6QNeAEqYppXymg=;
        b=cHJ1Mcui+lBw73apKbmtOm39Sw+bxGHSU/1KqMBDG+7pCurO/yCVfZpU8WSwjtitm4
         EwOOgXfun36I2zR8OD9wiYySVbKTeNeY+jrEdw10FOAyYus3DqGDEwbftln0QejSj9ZU
         AMRPy3gzOa8kyHI0VFU78aQSOYwBeHItwDyays9g1rO9WpyDcH5ek4Vxd4Ov920qYbi4
         l7s96vN8DRC4D/xSYC64fbYpeluFnEqFDnJIxdntCjwrxKWMsdqMgm5z7kb4sNOTdFlF
         IPjMlVsX4Q99Pnd+yJZZmAFcXHUUnfeReMAqhEgmGN3wTvwNDQfMuuC6vsTOa6nLVza8
         IDtA==
X-Gm-Message-State: AAQBX9dk3t4+upFdDlc/dCjLME7nnqlqqp6xoYId5hAcpoIQWRHp1qAt
        UUQxWfhYC/bKLwLLrDK8MWcFnXA8n3jRpbTjDVhfbA==
X-Google-Smtp-Source: AKy350YQfPFjSrCEHnJpmEbkfsp5dzuUEon9/XSrk3k8KQQtjMNb8M2/fv0IHb9dV6OXSvsRXSzVnaA1wTfKME0QdDQ=
X-Received: by 2002:a0d:e2d2:0:b0:536:cb21:7223 with SMTP id
 l201-20020a0de2d2000000b00536cb217223mr1291346ywe.6.1682066471854; Fri, 21
 Apr 2023 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-2-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-2-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:41:00 +0200
Message-ID: <CACRpkdZ_f4gad-AS+HhePE-Z_vUromuDJgXB_WNw47Yr8Po+Uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] iio: accel: st_accel: Add LSM303D
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> The lsm303d has the same register mapping as the lsm9ds0,
> thus we can just re-use that.
>
> Tested on a Lenovo Yoga Tablet 2 1051-F.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
