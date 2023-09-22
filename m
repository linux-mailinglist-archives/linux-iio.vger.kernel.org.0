Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77D97AAAE5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Sep 2023 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjIVHzX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Sep 2023 03:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjIVHzR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Sep 2023 03:55:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF18CC1
        for <linux-iio@vger.kernel.org>; Fri, 22 Sep 2023 00:55:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ad8a822508so225709866b.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Sep 2023 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695369308; x=1695974108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo0lap6Lgs4aUClULX8HNoJkpzCnX/7Jsbfgdxnl/pY=;
        b=U40KPtjDZ5oaO5BjIETV5ge09nMGO25IctNP7IsHQ1RRdgr+d5AWtS/eOxi9zPPo9P
         pSaNJFh4AXorjtnS6ssNF8FgMJisx0AD5s/ZgRdBXjgsDAa2rQ4zUmM73IRTnk8e05v9
         QoZFjnHJGlsfI2+Sg8EU/WiDfJ7znOgNPgg4msTJV2SUU99KxQEl3EtVMnJqfDzQ1sn4
         SEdQYPehpYYUpnWyxBZSsYAUaXp5W7flb+1GDokdD84vpx+t2/1IhI1WOCuhFZ1z2rTm
         u4EMBp1npo35emO8jl2kkmb6X/H1FiXtRNcH1obDEPaU0S9lmPQf2anXE6fI5+nfXc9V
         w9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369308; x=1695974108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo0lap6Lgs4aUClULX8HNoJkpzCnX/7Jsbfgdxnl/pY=;
        b=Lct7Jt2xpP6BykPOVb6tXF/SnHGS5hMmDmNonfIT0lywgIjcikg9ZeUA4dOOy2w4FJ
         OMq88NH/RrbQ8FuITYHW3B1rO7VZ2tT9Scm4FKdhZ3Fjc0dXMbD6uhuAyWEYjeWssIrE
         J5+pkRSjXzbaY11tGIpjHyGKNWz+HPYBefo6JgdPL+6rVFrmGD3u08PsnwNBIOF53TyL
         upVLGA1NEsfdZfeNsXigFu6p8SxpsD72JVC6Q4m97F1WCwJeinEsSC+ReaX6sOwcuDkJ
         dAjWMs4eNl4rDhXeq6EKHLAWHrl85r8mXFriOjFzxnSxYsiSjJ29gHEqLdRHYUElGMzG
         hFUw==
X-Gm-Message-State: AOJu0Yx1/9vA3STPmxMuP+wyEQavsjGJaovr6CmKOCpMTXMTUdxkl79j
        C2sRalkdYuvayJhVHw1EJHwiSygim67z5TOwOMpW2w==
X-Google-Smtp-Source: AGHT+IHSS1vKwEC9knLhqPNk1Y0RB0kqAke1ZsK8aoLkzIhsG+WewxcfwopOZUPCJajquFT5HL9JcQU2cuAIG7Q6jvU=
X-Received: by 2002:a17:906:2009:b0:9a5:c49e:7145 with SMTP id
 9-20020a170906200900b009a5c49e7145mr6718209ejo.69.1695369308485; Fri, 22 Sep
 2023 00:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-5-dlechner@baylibre.com> <20230921154514.GA383967-robh@kernel.org>
In-Reply-To: <20230921154514.GA383967-robh@kernel.org>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 22 Sep 2023 09:54:57 +0200
Message-ID: <CAMknhBEVLZYQieKPCCf8QHp7H06Vsdobg_7qGm+MsbL8Kg-VCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: resolver: add new driver for AD2S1210
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 21, 2023 at 5:45=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Sep 20, 2023 at 12:02:53PM -0500, David Lechner wrote:
> > This adds a new driver for Analog Devices, Inc. AD2S1210 resolver to
> > digital converter. The driver is based on the staging driver with the
> > following improvements:
> >

...

> > - Use devicetree to specify resolution instead of sysfs attribute.
>
> Why? sysfs allows a user to change at run-time. DT is a firmware
> change. What/who determines the resolution? Unless it's the hardware
> design/designer, it probably doesn't belong in DT.
>

This one is a bit of a gray area since it could be either way. The chip
has two input pins for selecting the resolution. If the hardware
designer decides to connect these to gpios, then they could be changed
at runtime. But if the hardware designer decides to hard-wire these pins
then we need to supply this information via the devicetree.

The choice of the resolution is determined by the physical requirements
of the full system. This device measures rotational position and velocity.
So the main reason to pick something less than the full 16-bit resolution i=
s
if the max rotational speed of whatever is connected is going to be greater
than 125 revolutions per second (assuming 8.192 MHz clock).
