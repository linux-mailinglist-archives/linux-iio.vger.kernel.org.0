Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390622743DB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIVOJA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 10:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgIVOJA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 10:09:00 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D0B239D2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2020 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600783739;
        bh=erQxMNGvhm6ysJW+DTu0wfYq1AFUIjhcSSCKNSKoT/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bfk7Q5p7bE0xmp0KFtnTb5kDB5T3Oofryw6nlBdt/V12vI5q+2VawFn7z5M6g2ezy
         GlpiaXK12XWtnNsrabOgvNxUw2rmWctKFTKjiAfBNjMkPTzPnnlA+kM5d0yyKClS20
         lHgqFtO2VRTVXNK7KxPAEaydPkiV77mQ+MEpq4ac=
Received: by mail-oi1-f174.google.com with SMTP id 185so21140744oie.11
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2020 07:08:59 -0700 (PDT)
X-Gm-Message-State: AOAM531cFnU1v4oroGn2MEMomDi7C2ntkg8iaqsFf+7Rx7BZn58XKBCO
        PcD3BHt45it8HBppEZkqQY3AvzbXCs5RRAP4+A==
X-Google-Smtp-Source: ABdhPJyxE7pC6wVSBA5VplZfg8X0Ab8nQhcQc8TnmTFGBvxjkocPRtzEvoD3ip0idNyud3gkWd8abZqJz2B2Cxl1cNY=
X-Received: by 2002:aca:4d58:: with SMTP id a85mr2807068oib.147.1600783739138;
 Tue, 22 Sep 2020 07:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200920135436.199003-1-jic23@kernel.org> <20200920135436.199003-2-jic23@kernel.org>
In-Reply-To: <20200920135436.199003-2-jic23@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Sep 2020 08:08:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-2MA8ych91Ln_sY=VJQtU=muRk9ZtBcRqoTYEOY6ezA@mail.gmail.com>
Message-ID: <CAL_Jsq+-2MA8ych91Ln_sY=VJQtU=muRk9ZtBcRqoTYEOY6ezA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 20, 2020 at 7:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This binding is non trivial due to the range of different parts
> supported having several subtle quirks. Martin has helped
> clarify some of them.
>
> Note, I haven't restricted the amlogic,hhi-sysctrl to only
> be present on the relevant parts if nvmem stuff also is, but
> it would seem to be rather odd if it were otherwise.
>
> Perhaps we look to make this binding more restrictive at a later date.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
>
> ---
> Changes since v2
> (thanks Rob and Martin)
>   - consistent capitalization
>   - clock names etc all shared, only the number of them changed dependent
>     on type.
>   - missing maxItems for nvmem-cells.
>
>  .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
>  .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 48 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
