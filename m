Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201875167F4
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354950AbiEAVDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354943AbiEAVDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 17:03:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F751AF30
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 14:00:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y2so23205367ybi.7
        for <linux-iio@vger.kernel.org>; Sun, 01 May 2022 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LhYhlh64BoR+tp9gHry6l05ysG5vXem36+SNUUa85u8=;
        b=mr2CmCUWoVwMD/fFCzj586VU9j4oafdQJEdP0039pKTxU5J0Hn/yfttBBdWgJXQnf/
         GpXURPI38tFMJGTBPR3dlKAmor+EbYIDEnuDlbQEB2aeQuQElGrt7aPELhDq0J3TQS0j
         BNy9RTD0YGMZeU8CxZYHdV9GV/P+5rVHC19k8jpQmRrXj8GlryqPYRMjmyWDoZWbND5T
         +hoy0P8kU1eA+JXz6w0qzYI/sZuVpFrjuF0U6mGm2H4UBo2lRqW6CogMTDTyyXn3tWW8
         26hOBT+vYNBCN3XO9nrDabhToxQQFJRHYzgWp9jZscxB2cv2VCMjuEIgtRIlFa6yYtQY
         KgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LhYhlh64BoR+tp9gHry6l05ysG5vXem36+SNUUa85u8=;
        b=Ya08gFnOmciS2l9+7PUhmETd5gEiXvDTHxvvz3EeV+n7iEF81LTYL/NFtpaYn0puTE
         Ws+Y3nFDfu6+f5WjW6Z5oXEoKIFQ9RpXkWAuTr8iES0tQ5qpGeV2KjWC8D+boe2B4h7V
         VvzIOKMlDQtQ+DCugKH95ztKBSJLPGQUR5iMK+5M+uoFzIF2w0j+fLJObyFnU7ueiyYZ
         JQBV1ldzHbxVDESrI7sKUvElwQv1XX4pX9zN+OS6o7lLexZ9P8kZxUQcLxEbOxv1NYc7
         VUOx/bfIxANAaSl5NCvsCykWcK8bpAszXW5Ic1DieHatWdQhDERQguJ4KN7gYjS1iSp3
         ti6g==
X-Gm-Message-State: AOAM532mptkgOZfeKZ0golKnbfJvKvWkiiY4OX/sZx+OxLR79zpOFy01
        4vvmTCNEv4vvTmga4TD29lQ/U9xq7Ahi6ZR2w61n9A==
X-Google-Smtp-Source: ABdhPJw4yPO23xJDQ1P9h3MPiDtVzc9AdpUeIyI4AtRKMmHsJDGbxoLRX44wpBTFv+ydLt9clTQQTzf8IJ0k8NGWvU4=
X-Received: by 2002:a25:bcc7:0:b0:648:d728:d39 with SMTP id
 l7-20020a25bcc7000000b00648d7280d39mr8394668ybm.514.1651438803619; Sun, 01
 May 2022 14:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de> <20220430081607.15078-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220430081607.15078-5-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 22:59:51 +0200
Message-ID: <CACRpkdaQC-W61eMrcR-OObwh-nQ_+G0=fH7Q-cz1CTzq1eTTMg@mail.gmail.com>
Subject: Re: [PATCH 4/9] iio:light:bh1780: Remove duplicated error reporting
 in .remove()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 30, 2022 at 10:16 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Returning an error value in an i2c remove callback results in an error
> message being emitted by the i2c core, but otherwise it doesn't make a
> difference. The device goes away anyhow and the devm cleanups are
> called.
>
> As bh1780_remove() already emits an error message on failure and the
> additional error message by the i2c core doesn't add any useful
> information, change the return value to zero to suppress this message.
> While at it, add the error code to the remaining error message.
>
> This patch is a preparation for making i2c remove callbacks return void.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
