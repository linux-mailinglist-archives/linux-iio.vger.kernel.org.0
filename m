Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EAEF31F5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfKGPGT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 10:06:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36309 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbfKGPGS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 10:06:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15so2677007lja.3
        for <linux-iio@vger.kernel.org>; Thu, 07 Nov 2019 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNpdMP+c8tlO1TDBVC9k0h0b00Uv4MokMY8phy3uBZY=;
        b=Plp9ciQgOG5hYRICyBiK09OuHTIwfyXsnNUaZufyuHBW2gt8WTNobqXZ59MKjr0gpI
         xnU+WxvFUzWmufwpssofG3QZupAgDMO5ES5kDp7byODeuSCiTJjD3F+4/bsVzFTNl33f
         jjze2//s0VefzxvM5fc0GXN5ZNanoo3kver6yczND4uavQ+Kncxtlw+34TtV3tag+DmT
         ZokOjbpLhJTRyck2ejy92SJ/LXgspCBjL/6k5iYnrSG5VZbk6vuOxGOyr0OL1Pb6FrEe
         mG3MmlnVXeIBc7Og0MUOlwvJs/znEWe581cxxZ/yah3BCmJb2hsIXCHRlOEsEiZZRORr
         0acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNpdMP+c8tlO1TDBVC9k0h0b00Uv4MokMY8phy3uBZY=;
        b=Mf9SRFu5ATYsJoAR+JI9KFS+ttV/b4/pQBIwUyZTBnpesuhAQRrHuq/joVv/9AqPaC
         p/l82r+WoDzo7ZDWx0juPcj0+5Sh6ll4MeijQvhaflG1fdkB+8mVVrLsXsfWnUGVEpZn
         nLVaSZ7s3Iwe4tGReT+e4wQIhC7LQtXJhuj4sC2YrivJlnIEeljs+daHXwBLj1nT4vmr
         DDLkSr3OsnKv6oCeDndKdd1IPIAIywKOFUCANL3r8UbE0E1ABJM3Vu0xFI8AoL2nM33O
         g0xHKOKTJW0EpoX6ZgG76t9p8y2c2AX2BwMtjDPZFskWRsFHRJCPw/DZsRTc7WnKwmbv
         Oe8A==
X-Gm-Message-State: APjAAAW4xPL328pOozZiedoPmyAB4sRLBeYJ2BaBkaoTkeu4RPre03Ya
        8WmBnkdcm64c1LvEOOmUcvY3XpekdvlQ6FiupXV8eg==
X-Google-Smtp-Source: APXvYqy0UMnhHp0V9kHUNVqUdW8dcWit5TUPdqMJ7p+PhSp0lU3WFWMFc8TaB5tFpYY9hkHHmq2SoFIgo1uRcdaSFgk=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr2825884ljd.183.1573139174709;
 Thu, 07 Nov 2019 07:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20191106183536.123070-1-stephan@gerhold.net>
In-Reply-To: <20191106183536.123070-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 16:06:02 +0100
Message-ID: <CACRpkdZgUR5Wqr7o7Rf2vGavCmx=rU53L6AaHhOQ3w2R0f2XHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 6, 2019 at 7:37 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> inv_mpu6050 now supports an additional vdd-supply; document it.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
