Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57354A88AB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Feb 2022 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352258AbiBCQgn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Feb 2022 11:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352196AbiBCQgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Feb 2022 11:36:42 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C08FC061714
        for <linux-iio@vger.kernel.org>; Thu,  3 Feb 2022 08:36:42 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 23so10637215ybf.7
        for <linux-iio@vger.kernel.org>; Thu, 03 Feb 2022 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X8SSPf/mraiWro8suMcSqfz+VF8p4sGwr/CfpUCuIGY=;
        b=bkKzAI072p7AqmVFdvgKsK0FnezlalYWZwnV/macVP3CZ/cvwb4SW0vGtjIupJRjVm
         zSPaAsLCggEyYVFrUbfh1LfbEakL8xAA3C+CbNEUcmSNiS7avvTu+kk8RcSEY9XM0yU4
         qj86zaZZy/y/JqHsqv1mgWskcfeeq7uiZB0pngk9/ySmC2ONxStu3Q9L7AClTbOzozpq
         oBYAg5sH6CLcix+F0i87ayv7/uJS8WgU/+sqewVEJJ50bo0/7lDQq3/aWIcmDZZPuSRQ
         jJd5KgGtlI4O0v8hG35cFNZSgYJ0+ZPWbaPLCk/FA7/3qaEDjDhTTP0YHemdF5cVu5w4
         GUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X8SSPf/mraiWro8suMcSqfz+VF8p4sGwr/CfpUCuIGY=;
        b=cKAWEv6HsSM8GExLOcpfkAaNgGi6bQCnhErL/ZXeNKUS/WKbR1h0b+IW2aQEn+LDLT
         nskm3fQnp7aT59qLOFkkEXyxuZa7lBT8MwloQnAYyVJiptQ4KUtVb7ihC/rfJkbUSedD
         hRiSQrw9DRlbcvj1XwVXIVpQSHcxkD55pzihC+LNb/Y0YqFF+EJb1lwNd6DPYtmfY8Fz
         N3u8JROHHHGYm/TNniO2wmDzNgagfO/riPPgg9054auSI3ynyPDnkX7dol5E0Mt6MyxW
         /s5SUDnidAo4d1xAL/yRsqJm9PHTqy6iqNWBcB00mvfhqbGdbWxf8b8nrd9Gqlackeij
         7tUg==
X-Gm-Message-State: AOAM530tIQt6Ck8YDd7PK78wDorpCIdpFTE49fVnnGDaJTzdNd0lEiDJ
        e2HSlhFoNJur0qtmXSE5KIR3sGpJqLG9+kjez3yeHA==
X-Google-Smtp-Source: ABdhPJzBB62u5yYirteberd0CnVV5WELDHeZjWtcpEt+y1J7bjeHeVMwD2pW5t1aZ7XlloYssMx+zNSK8nHO+tpgRjU=
X-Received: by 2002:a25:5143:: with SMTP id f64mr49828104ybb.520.1643906201370;
 Thu, 03 Feb 2022 08:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20220202235049.8051-1-samuel@sholland.org> <20220202235049.8051-4-samuel@sholland.org>
In-Reply-To: <20220202235049.8051-4-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Feb 2022 17:36:30 +0100
Message-ID: <CACRpkdahv_0+TW-8eYT-_FjCN1-bJXU1xU+qKRPxMpeqsXRMaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: accel: st_accel: Add support for Silan SC7A20
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 3, 2022 at 12:50 AM Samuel Holland <samuel@sholland.org> wrote:

> This chip appears to be register-compatible with the LIS2DH. The new
> description is a copy of the LIS2DH's description with a different WAI
> value.
>
> Datasheet: http://linux-chenxing.org/silan/SC7A20-SilanMicroelectronics.p=
df
> Datasheet: http://www.siitek.com.cn/Upfiles/down/SC7A20=E8=AF=B4=E6=98=8E=
=E4=B9=A6_0.92(=E6=99=BA=E8=83=BD=E7=A9=BF=E6=88=B4).pdf
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v2:
>  - Add a comment about the WAI value
>  - Update commit messages

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
