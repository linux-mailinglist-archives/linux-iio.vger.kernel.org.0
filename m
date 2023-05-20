Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B570AABA
	for <lists+linux-iio@lfdr.de>; Sat, 20 May 2023 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjETT23 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 May 2023 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETT22 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 15:28:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBD103
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 12:28:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-562191bcfb9so19768947b3.3
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684610907; x=1687202907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE+hreSXew8zQmuI4jk+1obMeFixg55Fh6SK2LtA9eY=;
        b=BrVMEO2UG59pdtZGVSKpjnI6GBCgYAysx9c3Pk8NP3NEHmqgkCt423sk1XI2N9uwPw
         6AbdCjURFnPjRZpzeK6J+WQ0SvLTXjIVhhZZjR7AoDg7FKti/NfIFx2QmVxc8O7JDePR
         /X3F2jG/v/fWl1c9aO39vI3sLp+f0PWqVGvfXc8EUOzSirAb9OXwxdFrRJM3AvJUFYtZ
         7cLDGqzLXzxh/IIMhr8kzNBgxdOT4mZSD5TBipwF/ZfTqLIEbEjBEygTE6Yph5i+K1V4
         XmofeUPENhXjeDgKhNG4O0LJTzE3DP+mtK+wpxAP6gLksshjPtcRp02QyDrJlY2SUflS
         kUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684610907; x=1687202907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE+hreSXew8zQmuI4jk+1obMeFixg55Fh6SK2LtA9eY=;
        b=VhAjsKtSR9qdQeu/Mye0HdOI/WhsHspWu3yv6FYFnQQJME664vAn0jAgZIXK9PBoDS
         QMKNLZOx5vxDfvYr5pRX5hN/soq0STkdRc9jknYt3pYI46AWHIpnmvoHoWu2gBf8/0Wu
         w90u/XUcxUnrHdXn42ksmjrYMQZDVdlCt4AE/BjQrzxXetB9h4isAgqewGDN8ekpdlM4
         QpkBn8QOVnxmxGTJwmRJbLnDZezVYiEvMYdYuLFq5qmoZ7oiqxksl+ECH5gm9qbsh54j
         njyTyPDFsM3DvmHZP7O5aGtO++lqauyQz0OtLdCBxaz9qkup5mTC5G2/40jXz0nWChg0
         rxeg==
X-Gm-Message-State: AC+VfDzmdYdqnuxwGcykXvTNZjY8wGnbHTEE9oksRtxJm9PAf2dW1TSw
        MQu+we9izW9Yi3+zAVi1TslwXZpN6l2LXn+sY+AxgxZhG3HKo8xa
X-Google-Smtp-Source: ACHHUZ5G1DN400VCBYTM0VJ8d2+nX62IWGvCDJ/4h2441VeAM1K4yE025blsPOHoiVBYUlh6UMaEamhUulTMrjlsJ1o=
X-Received: by 2002:a81:4e8f:0:b0:549:2623:6f65 with SMTP id
 c137-20020a814e8f000000b0054926236f65mr6215831ywb.33.1684610906884; Sat, 20
 May 2023 12:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681665189.git.william.gray@linaro.org> <dc4d0d5ca6ea28eda18815df114ecb21226cb345.1681665189.git.william.gray@linaro.org>
In-Reply-To: <dc4d0d5ca6ea28eda18815df114ecb21226cb345.1681665189.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 May 2023 21:28:15 +0200
Message-ID: <CACRpkdYdcU1JNmk7Jyyw+MA+GBKG950P1Nbn7QB4Nx7YJ1jwig@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: 104-dio-48e: Add Counter/Timer support
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 16, 2023 at 7:37=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:

> The 104-DIO-48E features an 8254 Counter/Timer chip providing three
> counter/timers which can be used for frequency measurement, frequency
> output, pulse width modulation, pulse width measurement, event count,
> etc. The counter/timers use the same addresses as PPI 0 (addresses 0x0
> to 0x3), so a raw_spinlock_t is used to synchronize operations between
> the two regmap mappings to prevent clobbering.
>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Very interesting development here.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
