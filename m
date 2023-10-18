Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137D7CE6A8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 20:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjJRSdC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJRSdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 14:33:01 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9553111B
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 11:32:59 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so7612329276.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697653979; x=1698258779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcuhCkyUkVkJNziShfChcqgUhXGg8fxBljsMorp2LaA=;
        b=ePAoapLTdINEqv0vb+QGSFhX9piNv71BX+6lcbgOhGicNbkA0CTYSeBIpA2wzGnj9t
         Jx8iWGexToXZ/0Mc3Ysw9/hbCUrE3KAK+I0DdAo4rfc2ErNb3jtYaHqC/EHL6gcP2qj+
         zE0pX14WxW5yQ6LBuZNJO2r6RXlEM4U1TM1QpQxKtK8yEfg52XV0iqvRHpFcPwkQh80D
         UvDuFK301kalDuRtdHE3w23IXKN6gL52HzxAk2rKq0YgC8Ml1GuXaNFj3uS2qVigZBww
         ARq3TyxGIzz2X0rLmcFSI9AIkJ9YKra/PMWOGxxM7pvM+u1T25EhhhGCnvTWq2TgzhPP
         vKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653979; x=1698258779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcuhCkyUkVkJNziShfChcqgUhXGg8fxBljsMorp2LaA=;
        b=byAoaL6wV+0Q6ie6KMmax72RdWqCsdLumD1yUUsDofkLMkjMI8u7JDO9BzfMzkEWQV
         xLWYceChCB4N9aB2w+tDX38I/UxeI2XPd3wBDqS9juKc0y9GJ1quY4uz9bFVPOH5GlEi
         zbqPGHCqFlw/S+VTbSgMPGu9Lt/Mo/HXj0fQ+2NvjX3F8UPk7tQCvrPBzaD23XFGYcCm
         N0UeRrAEw4+6b2BfkG8bC+zMLLFD9nS1uSfeFHDXg1m2x5VWbUjqgMEGvw2Cv9g98Dn5
         JY8+oEp7wd9jg0s4jwcS6uE1FI5RSj8sQSAxwgl2/w5CpWNjTMWaImMRzlYF9tSINiR4
         6ysA==
X-Gm-Message-State: AOJu0Yzrj2ACUX122HscmSqaY1qwVCqlOMb3SO6pDGhTLXmf+sautTBa
        l5hOAw9B+np06S7FcpRK1TFGpDwmtveq6DVSGG1vW4VJAO2sfl6m
X-Google-Smtp-Source: AGHT+IHkEoDEJmC+1gcRzR6CUVYIHQaxyD1p/4F2VErdLaQiFO3wf8DlPdOjz/L+K7KLQtAA+Udj5qMsTRqBXRzn9+Q=
X-Received: by 2002:a25:c588:0:b0:d9b:e043:96fa with SMTP id
 v130-20020a25c588000000b00d9be04396famr176582ybe.22.1697653978695; Wed, 18
 Oct 2023 11:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231018152816.56589-1-ak@it-klinger.de>
In-Reply-To: <20231018152816.56589-1-ak@it-klinger.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 20:32:46 +0200
Message-ID: <CACRpkdbyOqxU_2vP1-9P+XwX4YTXfgSyh+abRJxSimxqqDDbwQ@mail.gmail.com>
Subject: Re: [PATCH] iio: bmp280: fix eoc interrupt usage
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 18, 2023 at 5:29=E2=80=AFPM Andreas Klinger <ak@it-klinger.de> =
wrote:


> Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> distinguish the case in which the interrupt is set.
>
> Fix the if statement so that only when the interrupt is set and the chip
> id is recognized the interrupt is requested.
>
> This bug exists since the support of EOC interrupt was introduced.
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC i=
nterrupt")
>
> Also add a link to bmp085 datasheet for reference.
>
> Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
