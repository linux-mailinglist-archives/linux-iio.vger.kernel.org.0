Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803CD69BAC7
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBRPur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBRPuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 10:50:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB017164
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 07:50:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ez14so3448182edb.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPO0b69EP2YB+k3ItVJXLMqeM3ohdWLRT3U4CQc63CQ=;
        b=NzTqMNmtWa3r8OXtLW4FJBdcxOac+3ezvAGEhnzDhvbMPeBWU0mhRHZluqzKc0yzuP
         ZYtqI3YxcKHf57SJMdRGkbTO1rEqnLN/ZHO/3/jM7pyAWGRs6XlVrSEbaKva4Fgi3whJ
         w8CjDkcEkuRbTKV6SknJlneFJ6RjSkM4A6A/hOPw0jpzSp3PrUeY2kMEH3dDrgLYzGEW
         2RP55hABpxQ0sn0hC3wJGK99UjWwTXb9rEAsiJQL1tSdf+5EDMX9AvzjnZfBSWM6N1Ab
         9b+d0YRHWmAqqkK49ljzeq2zrTz8ZBvVnzPCof1Dz1rFt2kN5+W4O3IuShqYBMF5ZlRT
         2prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPO0b69EP2YB+k3ItVJXLMqeM3ohdWLRT3U4CQc63CQ=;
        b=HjHBYGT3eLFnDn2W+8omU/5sKeuDCJ5h0C+o/Mtw/m9TBv13uKqWDPOl8Ko+rXFri1
         zuk5zmx2McGplf6wlEQApVDQxksaoFbkXswoQkdxsaqONJA6BglM4piXGOYKgpJDYIzr
         yaKB+6rrUTt5DbZDY5HJ8WA3dCeJDNH6Ms2AmwttxhsiSYiLpwt7k3y0YcTTpLRfyMvj
         xiZdjnyr4MiivpA+OUk1Fn4h+ZgYEoOhuWcGdnCoKMMh7/naxtJFxWusUuN8+AL2tfCU
         cO9qDrdWNLxrn3lQXsaAoi+z01zouLt5lc/28Jc/WCTh4MUsrKrIGz28D+eaLJloaJXi
         cqMQ==
X-Gm-Message-State: AO0yUKW7cycT/GmUxPrNq54LxdruNTBC3wcncPBpOjhdMKCkWA+qth8E
        509oxABzFPV+U7100gwFUGPcdrmspFWpnS0XjBU=
X-Google-Smtp-Source: AK7set/xO7PKbDqF6SekE7NROkLUPWPRQn8n3JP96mu5HqRbij9lt3G1gWcFly6cSy1TmfIw5B6S9/m30ikATBkbo1k=
X-Received: by 2002:a17:906:ce59:b0:8b1:7e1b:5ec1 with SMTP id
 se25-20020a170906ce5900b008b17e1b5ec1mr3046718ejb.6.1676735444390; Sat, 18
 Feb 2023 07:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20230216140725.1181867-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230216140725.1181867-1-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 18 Feb 2023 16:50:33 +0100
Message-ID: <CAFBinCC4zdu+rLk3oGOOyT5mcgoU2qmeF=vjHoarJ9vq1GO59w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: Better handle BL30 not releaseing
 the hardware
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Uwe,

On Thu, Feb 16, 2023 at 3:07 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> meson_sar_adc_lock() might return an error if BL30 doesn't release its
> lock on the hardware. Just returning early from .remove() is wrong
> however as this keeps the clocks and regulators on which is never
> cleaned up later.
>
> So only skip hardware accesses with an error message if
> meson_sar_adc_lock() fails, but disable clocks and regulator and return
> zero to suppress another error message by the driver core.
The clocks and regulators are shared with the BL30 firmware.
In practice I have not seen meson_sar_adc_lock() fail yet.

I think it's enough to print an error message if locking fails, then
continue as if nothing happened. Unlocking obviously has to be skipped
as well in this case.
There's not much we can do to recover from this and I consider the
BL30 firmware to be hanging (or broken) if it doesn't release the
lock.


Best regards,
Martin
