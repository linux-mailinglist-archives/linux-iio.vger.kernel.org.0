Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7649F7A9A70
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjIUSjv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjIUSjm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 14:39:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721981FD0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:39:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503065c4b25so2160826e87.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695321537; x=1695926337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpzQyHHzEyWIms3Xvm/C3MN/zZk6cMQQr8BMD0wmneQ=;
        b=2FwGXkh/xUKtSj5L1tXkCqI54O1cBC7v8HxZ5HOf5zJ0dSVmfwhcp4sUc7QjUDVALR
         EDTsCoLzO4fUQ+URtg5pilbmYX0q5/Fpmu60z7gvr5hNc9J/KfAuKqVCsgsBXdms3+6f
         lFDrKhLMQ5LoKl7RvrO5AAO6EYYTutSW7vIvFV2vr3h3uQBus6XXRVsV0+bw2S+wwtHy
         0rW4plkB+tHVJ3i4qs1ac6IGuim4v4FAnyM+yboqg8h/zJGN5pCvXwSy2M8NBwDijAnf
         qkbnfQ+NwQals4j+FRwFttaORVd6vXkgJ3TNbjdZYJm/w953cwETF7ozKu63s9x+OV0Y
         aZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321537; x=1695926337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpzQyHHzEyWIms3Xvm/C3MN/zZk6cMQQr8BMD0wmneQ=;
        b=kQEJlUWk0/WcroQQzrOy5G/5+jmvtK0pgDxE6BDQ4tJdMOpu+oNyJ6lhEC+v/CzmMQ
         XqZg/GC9bzP6GJw0r2Ik/ZlTswP7ebnysCZxj/1o5rrJsvgkgduzoW4s3RdcH6jJAKtC
         tkt5CBGsuzwoAF/UxWPMFjwM2hSO6oMCw9CHUAr4TgwEJ04bMs6IzgAkP8Ys1ZximTw2
         Qw8fv2+WFl4wi1OEgE/oeMt0kr37cfHqD8N0tAQUe0uOWdFlJMKMePS5TADwGf1bYXP8
         Yj3GmH9XMd9F6X4VO8PotqhyCdlWnUZnbiqLgh2Ll2WxZx7WjHW++xGoyB3FVU/Y71ip
         JLwg==
X-Gm-Message-State: AOJu0YyXHO7dBDoUWXLv1vRooKbrNK+/pHH+n/oPXs2+jb4xoU7BvLvJ
        JhFlN97I7d2VY2ijYYNr0PgWaxf9mWaOYEc+jfi1j77GGLoEDhkGOBSftnSJ
X-Google-Smtp-Source: AGHT+IFpyIuxAeI+zJtqVgso5gl/oZPdQPJ8OzyoLwfbQ+BnxcwAYhxcZ6tg7lLrRy8p1y2N9Tuf2kP/Jg+Cn/6HtPI=
X-Received: by 2002:a17:906:30c6:b0:9ad:e43b:1ef2 with SMTP id
 b6-20020a17090630c600b009ade43b1ef2mr4584204ejb.16.1695289242308; Thu, 21 Sep
 2023 02:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-2-dlechner@baylibre.com> <20230921-b304d3fd05b37a8588e101a2@fedora>
In-Reply-To: <20230921-b304d3fd05b37a8588e101a2@fedora>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 21 Sep 2023 11:40:31 +0200
Message-ID: <CAMknhBFfxWy4mWDVYkmaEBx3KkJnRvo1CsNSuab2Rj0TdtozQA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: resolver: add devicetree bindings
 for ad2s1210
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 21, 2023 at 11:06=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> > Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Missing a From: or co-developed-by?

Missing Co-developed-by:. Will fix.

> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
>
> Why's this a chap from analog, rather than the authors?

This was written by my codeveloper so not sure about the why. Michael is
on the CC so he can clarify if this is not correct.

> > +  sample-gpios:
> > +    description: |
>
> What do you need the pipe for here? Don't see some formatting requiring
> preservation. Ditto below.
>

It is just a habit to always do this for multi-line text. Will remove.

> > +
> > +  assigned-resolution-bits:
>
> I figure the lack of a vendor prefix here is "inspired" by the same
> property for stm32?
>

Correct.
