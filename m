Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517AC2F23DE
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 01:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403829AbhALA0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 19:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404151AbhAKXjo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Jan 2021 18:39:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A37E22D2B;
        Mon, 11 Jan 2021 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408343;
        bh=ImN5jLoMpV7boZcvXV6X2xFzUxBg7YjK0wzAZTPMTOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yjoyr33QEpYjtIlCdsiQUXu4whXKIMPNHK89fV1kcxxTqujoMs2KfbY4S37h67IVr
         BhsVeGcN0xvH9RHapnW95yV3D/NB0x/TD9qUbGphFClT3A2qraKjQNwa2kxsr1G8ir
         Wp/n+3ScD1Yd9SR4vh9KcT6nKizBqh6V/k1pqO3kTyPFmgxd9sTeSKtiQUSlwE0ynJ
         sTRBxWhQhaMOvYs4Wavkb1GOKodnTwg/mJWMiZcSaxSEBSAIy67Dik0K2FtmnvWZve
         DA6O+lP0O4BTT14h6gQ1/SZfJMDUNuVXm9xYRPqqKCj/W04ua5o5K+gSwcnJ65PB+l
         Tvrg0cwH3Xp0w==
Received: by mail-ej1-f48.google.com with SMTP id jx16so829249ejb.10;
        Mon, 11 Jan 2021 15:39:03 -0800 (PST)
X-Gm-Message-State: AOAM532RhvTAJ7SllI05CiG2xEPgDTkvpt3Ps7b6jddFkkPjn2Cyn60N
        GnJQdLtI6Aw92rKnZyoD6m3IqLM55t8kvZE9LA==
X-Google-Smtp-Source: ABdhPJy/dRRtjyiguVKGN6URlDjTkflvFuAKGUvO8vIkqPv4u5JUwlzC7aIBS7vVPptg4aVgIAS4eFcEK9Odp0d+3c8=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr1203195ejk.341.1610408342000;
 Mon, 11 Jan 2021 15:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20210105110839.5436-1-tomislav.denis@avl.com> <20210105110839.5436-3-tomislav.denis@avl.com>
In-Reply-To: <20210105110839.5436-3-tomislav.denis@avl.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Jan 2021 17:38:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKK_t3d-TiNP_3FHLs82OdVMv+meVEdqrHyZX4uaKKd2w@mail.gmail.com>
Message-ID: <CAL_JsqKK_t3d-TiNP_3FHLs82OdVMv+meVEdqrHyZX4uaKKd2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bindings: iio: adc: Add documentation for
 ADS131E0x ADC driver
To:     tomislav.denis@avl.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 5, 2021 at 5:26 AM <tomislav.denis@avl.com> wrote:
>
> From: Tomislav Denis <tomislav.denis@avl.com>
>
> Add a device tree binding documentation for Texas Instruments
> ADS131E0x ADC family driver.
>
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 181 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
