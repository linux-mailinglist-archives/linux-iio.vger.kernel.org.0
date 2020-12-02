Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AE82CBC3A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgLBMBB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 07:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLBMBA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 07:01:00 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77635C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 04:00:14 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so3339039ljk.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 04:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Pr4aXRxL4+KxlMsXEdnWIU22w73sQ7oorqpnDzXWS4=;
        b=N1hje+/SPa7H5gIZ4+LYxmHuZ3ccp4iGeQkhO5JFmBnSXGzoyf0iac0CHxS7vtGCAo
         IODr7TUk8PMHOFsUj980sBFggvlmUMpj1a/xafgNJtGYK2E4F5wsUidIHH1Zi5FEMS6C
         ttTucEhGeR3XECQ/hs0WV8efvjHaW3wBySg4/kmC8HXFdbDkwYZaEctJmlyeK1I3+Hfk
         10I8GikJ0BFXqKjNya/VZLMkVFjA9+oN00rydLyRHUk10XfKHwDGtmyg8EPR2En6+YFz
         ybFB579fSScW5l7G82yJ6R8hcFNUZ9DV6otdeWDxy24qqRdOyE7nXO17URNwdRpocqWR
         WXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Pr4aXRxL4+KxlMsXEdnWIU22w73sQ7oorqpnDzXWS4=;
        b=nd3zivWCxHjW8yzRvLomNt9nIvsRAhaZhTgDC5CHaz46yZv+9sfxuYnmjTVBLd0zMi
         Z8nGLH+clYopuUKd6lF2MqqV4hIJOFSVCFdP88pemmrKhM1/yFs/4yuBGoN3wA0Lgr02
         c47kVqETA93TgvACN8XVlTI/w5im56qw0qjmAHAkcw4KZRjVL3PrlirrIw/NEt+jp8ek
         +pqfOQq85vQ7PQ7yz2brCyhDJA0GYM1Q7WD35LzrokTg6usuGV9U3mXoS7wgwIv0Za0J
         JWvjkoOuig0aiCs7OcBu9CWivB7Mn+D9+Xm13E6x3PpFRwJKjGwOfm18f4A4OwdA3+6Y
         /OFw==
X-Gm-Message-State: AOAM533IL7lc5IdyrkYQB5/P4Mo2mWRVbCjct6efqunRg8UYWqJpPWAf
        83ch6Kry1eW5xqhE5hP8tBwlqRNfc28doUZHG4eTnA==
X-Google-Smtp-Source: ABdhPJx1AtpFBCfPK4SoIuG4Y/AiCKba3Z+76AWPhNbei9pHvO22Ldx9c1MwY8xvE0yiWHvEKza+ErzIexaypVubdfg=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr952043ljp.144.1606910412428;
 Wed, 02 Dec 2020 04:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20201202093322.77114-1-stephan@gerhold.net>
In-Reply-To: <20201202093322.77114-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 13:00:00 +0100
Message-ID: <CACRpkdZ1P-+tg152FFk-9y3sGz9Hbfi8B3HnC6UZx55mFVfGFA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: magnetometer: bmc150: Document
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

> BMC150 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Document support for vdd/vddio-supply to implement this.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
