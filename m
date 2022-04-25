Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17FE50E9EC
	for <lists+linux-iio@lfdr.de>; Mon, 25 Apr 2022 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbiDYUOS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Apr 2022 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiDYUOS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2022 16:14:18 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6CE8870
        for <linux-iio@vger.kernel.org>; Mon, 25 Apr 2022 13:11:13 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id h7so5775430ybj.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Apr 2022 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VxFi1zkSEq565GSQmc2qJHdxTE8AgYJ50hwsQnDUBmg=;
        b=xfzGNP+55NbfMU3bJc4l2okmRp+tqVCget86dOzmLKdPe6FkWXvZsKMFNq/TPFS+AT
         uPzL//IvtWLPtD/0o7sm8KfchjxPADp3nfX4Ey5Pkk/oUUXWKTxjsNOxGOPSOmDI4STK
         PvZ557TUzGvEKgBDAj3a7Z5ZDKJvv2A13R4hH4b1Xd4jCX1hfHz3CD/NUr7j8HoTGcTh
         c5gN6HWYkuvD8JagM+SZLJIR7t7xsnr0OYxBjwbFXT9UTx7p1eNaGnc3eFtlr0m8YeQT
         jr/59hBm5Omyt1VWzMlnSUXxLVzyeZyylG6QJY73GzLjQUlbsvcsTDlMitrHGqh389xd
         SZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VxFi1zkSEq565GSQmc2qJHdxTE8AgYJ50hwsQnDUBmg=;
        b=KN+MWLeGfC94dzpgM4W+Oi+zdEyN1A1pDlDmJqiMuXmGowZYqiSL1xppKlggChssUg
         kWsBn9RsRNdGNN1KgEpWo4Hb1q4fP0ZSQ7tXDX2yUGLbp7Jc0jBSVrZ5DpX3R8X5lNd4
         9Qbv0T2id0Z42GNA8XrJQrYj361UskrGD3oBf0tD7tFR2T4misziHXZm1D6H66kpeCef
         AX84bUfzaUQssDaGap/LAvkRKPlT2QNcwTSUec+kvZLqIL6pAHQULkUIOGle+aKt1m+8
         X/hHyLxZmZxZtDh3WAGDCCg5tzRTMLGqIXSdeAlQpxKuVN4ikwYhENzOygzNV01aiQmX
         AI9g==
X-Gm-Message-State: AOAM533BH+POY/uvl13nBxw+8h2NgNfdU4XN1JnP9R8gNqc/uOn5F/OZ
        8NMN0ZcqiiJTXb1XsRtOwaD//dTSnIdFGDUgB4Lx9g==
X-Google-Smtp-Source: ABdhPJxNGWM1YbQpgJ/LmPmaKxeftZLsY0M3v1bToXCItdgGZrnHCWtn/z3AotMuZRt3sC0DQoHBzyH8uEtJ2pII98k=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr17704585ybr.295.1650917472551; Mon, 25
 Apr 2022 13:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220425191735.59032-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220425191735.59032-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 22:11:01 +0200
Message-ID: <CACRpkdZJ0ay5rTt5kqeh8UrKEOjJCDOuHvJaauVshcTOni6ijw@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Make mpu3050_common_remove() return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 25, 2022 at 9:17 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> This function (up to now) returns zero unconditionally, so there isn't
> any benefit of returning a value. Make it return void to be able to see
> at a glance that the return value of mpu3050_i2c_remove is always zero.
>
> This patch is a preparation for making i2c remove callbacks return void.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
