Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10B82D9470
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 09:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407112AbgLNI6A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 03:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406034AbgLNI6A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 03:58:00 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEB3C0613CF
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 00:57:19 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so28169913lfm.8
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 00:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeLskSmDYaVOsZxv9dazYTBEZV4Owe3PpH2dLGUOSKI=;
        b=KWsCICqm5auiKhsRbZlPOGFcRacp9hlIrGS5KIynS4aaQ4DgAkTGJVhw7HGrLsO6oO
         My98Qtyce3BQgZY3NTyROxxZRL7zkL51Syux7ofWkEVIkqBuvZ5QVzgvH05FzJUOhSGl
         hEwQzml6uDxkMxmqyMVdMcaeMvcA1Dt/MuA0v/oieVzcm2gMV0X90yEJwP2BaJSf9X9l
         eP6t4uxbML2qVE2pzH3dJSOf27gtqFcouJFvczJhjcik43RksnkM/gQ9ldsGxZgTiOBK
         CzMjhWm+GFc+ZghGTj6H7LBXFD/Y8ey2eVNXpjVQoO9DRg8yj7Gk7A8GebAoGaut1DvB
         4HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeLskSmDYaVOsZxv9dazYTBEZV4Owe3PpH2dLGUOSKI=;
        b=X+LpAn89erwaB9yJLNggh4T/niKvPQmpQ829IRsXGiQ0W5Vezgf113Efzge0Mzm+Go
         7tYbMKiDbppdsLg1zDjcMHl5MWjFwQWkAjWEHA8Y9nbD4RyxN/4oulazqjUL2YKqOd2v
         YmjWPTuYOMIl+KOg5t/5KwRXAgznCSk1bXJSTS2PJ0M5ql+7pS4d0BFg0GulV/qCMaDQ
         qYYP07MrJI1B/mOjenE6axXdwt7HqN3xKpytv3CTh6oggb4dRA/8YFAJ+/HA4tu8w2wp
         PeJvm7i144qU6WiuAtIbkg+GVhwnerwMCXjTL3ZvIntaEpsG5xVCvv9jsxEsYs9F+x8U
         n/+A==
X-Gm-Message-State: AOAM530FQSY9zWGj2b+8AZuYpYMViXn1bbCZyfC2JNOXyqCogzY73oxN
        wXvDyzqkxSmZFvDcwB8vRgrc76d0b8WHdKkHFL2J/w==
X-Google-Smtp-Source: ABdhPJwsHyoU4o37zHEtZOYqmgDKOY1YjMUhOeqiSTQT16Q9804/21EtJ1z7yMpPlKLKYk+6gufMYxW6U48B7xOH69c=
X-Received: by 2002:a19:495d:: with SMTP id l29mr4671485lfj.465.1607936237341;
 Mon, 14 Dec 2020 00:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20201211183815.51269-1-stephan@gerhold.net> <20201211183815.51269-2-stephan@gerhold.net>
In-Reply-To: <20201211183815.51269-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Dec 2020 09:57:06 +0100
Message-ID: <CACRpkdbEqN95-bYHjo7JEbSrGx9qHNoeW2wHC6KPvwn0sG7isg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: bmg160: Add rudimentary regulator support
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

On Fri, Dec 11, 2020 at 7:39 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them using a devm action.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v2:
>   - Do regulator_bulk_enable() immediately after devm_regulator_bulk_get()
>   - Simplify error handling using devm_add_action_or_reset()

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
