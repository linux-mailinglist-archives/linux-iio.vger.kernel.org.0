Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2528CAC2
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404161AbgJMJGb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403963AbgJMJGb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 05:06:31 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473BC0613D0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 02:06:31 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id o18so19750950ill.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1Kn1e9l6DefK7UeWxKl0RXZdndEdV2fl2mFTDouCI8=;
        b=IZZqgx3XirUM6a1686Gvw+XBThwLkKU+a3xuShyhmkoSPZ48SquqAhA9Z4BnAarFXW
         LbYClxfi0KkhUIMPl6p7oUskobKyJBDmxaNC1tMv5jCC8F+6jlPzqVK4nlk+wVMAGHKD
         Rbie1+mSpsusVDCdqjdjG1a0lCsUrJCic3Q/A732XhRB70efFDFvORaQj6cfdFKixTIt
         v/OrAGeLC+uM+zSSDmm5J5VRLoj3lncu7aMNBB5UgwIQYW47UnuiELot0tiOBG6bPFkG
         h2O63hEybPIWYxcPm/yFySfGBtoS4rpSzspXAHPEG4LfbD0KWzY/BlhYv1VTR8hUMCr2
         DiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1Kn1e9l6DefK7UeWxKl0RXZdndEdV2fl2mFTDouCI8=;
        b=VIz7jYi8GFTYQykt0PE5JYQmzVd/qQGafSkGSDQ8Fh8NEnKC8INOm93PDsojYXO22e
         RPrN9D0Oynv3Hp075B4ervr5xMAvFJBFN6rgGSJHQtLzYWDZzD2ZSiQDjkIvDyUjr+MD
         ArEqbCe/WExVYVdK+XCGbTO+E1t5eBmY4cRZmnlw9OvTvfm1jq3DPbNbksLRAoZjJKoI
         fRLY1hWMfKC6H7HZYaBqCyUrUXVyCxgauIg3JQ3COo6+YW25j/4GizHXrIHvh5oFmJTb
         1RFDkwc/6ytV+pBJ2p+uyRcA+d3mSUOrGbuoq0OuCuU6wqJwxODG/d4aYIwdLbJFN0TS
         b4tw==
X-Gm-Message-State: AOAM532vPdqlVGm91loNIRZjqRmhAEs/80AR7wVXMyVe96ES0gCbMcjo
        qg7bfCLvSMdCc6arHx4aFFW0a8vQiZpID22KVV2eAw==
X-Google-Smtp-Source: ABdhPJwk5H+Z635Qt/KH04jq7L0usmATbmKO3VNhzThntbBFHaS6R0l7HMM0l/U1X1TkdfOiSYVqKCKcJHL7SaOdHCc=
X-Received: by 2002:a92:5e18:: with SMTP id s24mr2067841ilb.48.1602579990710;
 Tue, 13 Oct 2020 02:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201012205218.3010868-1-fparent@baylibre.com>
 <20201012205218.3010868-2-fparent@baylibre.com> <81a12664-639e-20cc-8b49-6bcb53822a3f@gmail.com>
In-Reply-To: <81a12664-639e-20cc-8b49-6bcb53822a3f@gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 13 Oct 2020 11:06:20 +0200
Message-ID: <CAOwMV_yqK+yLZH1tOSeUHP7qz35k-bYmWf7jg6qQpvhO9LeJ6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8516: add auxadc node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matthias,

> Any reason you don't enable the status in the pumpkin dts?

No particular reasons. I looked at what other MTK SoC did for this IP,
and half went with the status to be disabled and the other half went
with an enabled status.  So I went the mt8183 way since it is the last
MTK SoC to have been merged and disabled by default. If you think it
is better to be enabled by default, I can change it, I don't have any
strong opinion about this.
