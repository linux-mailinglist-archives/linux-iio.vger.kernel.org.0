Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2996D3D73C3
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhG0Kw5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 06:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236238AbhG0Kw5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Jul 2021 06:52:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F19F60F59;
        Tue, 27 Jul 2021 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383177;
        bh=o6O8e5HB1DC2SNNVTZK+mEPKiFGCwPXKPNIaW5ZkSwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tlbO2b/KilfGN2L4k7mzU2F9ESv7A8P+KFgiQ4G/y3Y/qp6XWExuT+e7s1gu1c3L4
         Cp3mSjwq8TiuboNWp5dKO5zzuBwWZi8gDthgo9bZ4mjMhWqDjNQ85CT2Y0AvXs3qwU
         OXBlWaX5rd3f0s+hFJCSWTLBP5zaAhHrWnGXcyYou3zDEC+VWmM+BGoKDa8jD7KOeI
         Ca2shEQDRJObSN3E8AIgTT1vVFkPXuVosphi6oI/XPPzd3P9Y580ftp8zoowKV5eN0
         G1oTaKsMYRy0AKGhmmLEruKmsDMVhRW6QpyCWMYiMYsnK0Cr350noSieA7YY+jtRTo
         B3OJMS1vdAlSg==
Received: by mail-pj1-f41.google.com with SMTP id j1so17133101pjv.3;
        Tue, 27 Jul 2021 03:52:57 -0700 (PDT)
X-Gm-Message-State: AOAM5300NcgtBvpdwqHcn6/qjcwQicaeLqjgWeFLfAXzoMwTWK3M7jJq
        rTRMhld7iCJ/K+VN1gAc2IlLKvvFUBREW6m2AmE=
X-Google-Smtp-Source: ABdhPJyfcwQ1u2ibJyIrNkXJnCgzuHBsqbP+LnDm7ZMh42MUC8rRudQhUMpanldUPxxIR7CfCMAtpt1cNDIbn+YMkpE=
X-Received: by 2002:a62:7c52:0:b029:329:d4c2:8820 with SMTP id
 x79-20020a627c520000b0290329d4c28820mr22727273pfc.59.1627383177274; Tue, 27
 Jul 2021 03:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210627163244.1090296-1-jic23@kernel.org> <20210627163244.1090296-12-jic23@kernel.org>
 <20210714155809.GA2653479@robh.at.kernel.org>
In-Reply-To: <20210714155809.GA2653479@robh.at.kernel.org>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Tue, 27 Jul 2021 12:52:41 +0200
X-Gmail-Original-Message-ID: <CAPybu_2EFm74tr74F-ww5WOE9xBrtU0VRzB1CS_2DRTxXWPhyw@mail.gmail.com>
Message-ID: <CAPybu_2EFm74tr74F-ww5WOE9xBrtU0VRzB1CS_2DRTxXWPhyw@mail.gmail.com>
Subject: Re: [PATCH 11/15] dt-bindings: iio: dac: ad5761: Add missing binding doc.
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sorry for the late reply, holiday season :). Thanks for the patch

Acked-by: Ricardo Ribalda <ribalda@kernel.org>

On Wed, Jul 14, 2021 at 5:58 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, 27 Jun 2021 17:32:40 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Straight forward binding with vref optional for those part with internal
> > regulators, but required for those without.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Ricardo Ribalda <ribalda@kernel.org>
> > ---
> >  .../bindings/iio/dac/adi,ad5761.yaml          | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
