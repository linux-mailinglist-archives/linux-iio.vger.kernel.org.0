Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43873D430A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 00:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhGWWFG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 18:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWWFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 18:05:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47512C061757
        for <linux-iio@vger.kernel.org>; Fri, 23 Jul 2021 15:45:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l17so3504836ljn.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Jul 2021 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgVZroUZsp3ofJIBZ4jj5hAxjrRwXX1RfH2pNgupQ5w=;
        b=xZ3AgcGbj/nzmYromWFaXxQYo0NlLCuU9c4yCm7n3cltWub4vr9pHtc6JIyDLR9d1g
         JIWYWlMtAGaxqHaXsdZHKQTTWX0HFo02Js4qHcChSLv2vEupuXmfwFweZ4s6VvISf821
         Wus7EFrLBrDyBTL8RQ6LZnrvyQnY+lapfMcVHoD3pjxeRFA7+Kyj2GeyZjHLgFW8H7lb
         FvUqiJ/Dk3pMOqHSptG1HHf+vFtr+ymEvQ+rSda8utQzB4hHlUI03uc+r0TyB5BESrXM
         J7o43cXYwTeXwbsJmCdewCmwF4MxF31SfZK9BA51ZnwP80e7205oO/6BWrwGBeDnLRfm
         zgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgVZroUZsp3ofJIBZ4jj5hAxjrRwXX1RfH2pNgupQ5w=;
        b=SgBt/S9eUQTfNUZG+hlEYk7yZzl04M4gmhwvC9ZzNcNKZqWGE51pHuN0nKzalTVghP
         Oc/Fnd7upNcSmaxLIFFOd+5gM6ETsrfsI2V442U0YNMlJ6oAf9sxsJlD1sMIMTobQJ0V
         fVUvkhVY6cyPnNtYigScKeiSV5naIm0QyNOBcmKX8HMkP/6cyiHF5X7ZYCFBzu8GS/tL
         Dif3+2owhm+3jjJ88YzXLC44sqQ83drtQrQfimYAk7GWZjpAjEGSBeYhvIcVW4Y150ZD
         ud0OOaipTSXuLhRwDM5M861HEQDaw9bnu+I2UoagxV04qCzmIwh5q7YG147KnJ4FiAG7
         dnnw==
X-Gm-Message-State: AOAM531EOGGD2+ePh3ApiakTJb0oWS+bx1omPrZUhsbMYz7NTXEZfiJB
        wSEioLoL0D0S9JjXtQ3XywdyB3MQ5Z1NE1QYUOihPQ==
X-Google-Smtp-Source: ABdhPJx1t1Im09n6wOKWCdcGR9PvqJvjgACV0+NT4XpUPfotU1sEGN0pvX1HrCQDJL7VADqtRDJviL+8mPQJj8xvZ+4=
X-Received: by 2002:a2e:950:: with SMTP id 77mr4626817ljj.438.1627080336598;
 Fri, 23 Jul 2021 15:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210721140424.725744-1-maxime@cerno.tech> <20210721140424.725744-16-maxime@cerno.tech>
In-Reply-To: <20210721140424.725744-16-maxime@cerno.tech>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Jul 2021 00:45:25 +0200
Message-ID: <CACRpkdaJG2ghPaafzfTrYYCGh_t6ScC-u3N3angHaw+bw3G6BA@mail.gmail.com>
Subject: Re: [PATCH 15/54] dt-bindings: iio: st: Remove wrong items length check
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 21, 2021 at 4:05 PM Maxime Ripard <maxime@cerno.tech> wrote:

> The original bindings was listing the length of the interrupts as either
> 1 or 2, depending on the setup. This is also what is enforced by the top
> level schema.
>
> However, that is further constrained with an if clause that require
> exactly two interrupts, even though it might not make sense on those
> devices or in some setups.
>
> Let's remove the clause entirely.
>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Oops this was too ambitious. Sorry about that.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
