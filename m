Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE22F19602F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 22:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0VGc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 17:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgC0VGc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Mar 2020 17:06:32 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0402073E;
        Fri, 27 Mar 2020 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585343191;
        bh=glWv5x5tYeciSv+1oBtEhputAI81JkmLfjxr2fkT9PM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PaCC08dbyinHbfZ9F7vmFhIzQpFrllzHFBWbULPlH1W+LrtBgoQraHBJjeLan8WWO
         l7y/GJAoB8SBGgXch5XKmLV+oHXMxI2AR8Ol4QGtBrvEoXbBlQ3lGICu798LYR2fde
         CrWZDAUR2L5bPrmluR6xEkggyrP2PZiDegnQFswY=
Received: by mail-qt1-f179.google.com with SMTP id g7so9801180qtj.13;
        Fri, 27 Mar 2020 14:06:31 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0FVASQWhSbxxoSud1fSrJUMzwzeeLzWR+8xUAqbC/zxUUPdW97
        76hOeBN9cRJpUlyFZ1H316UVncI3G6J/ojgvBg==
X-Google-Smtp-Source: ADFU+vtdkc6HI4pCod8iofGlb2QXG/qLvgD3UC/ebV4n7v/H7Ix7pG4LzQ7xNEJ6EGp/RbN6TfHP/KUBvGx3L0q6IaM=
X-Received: by 2002:ac8:18ab:: with SMTP id s40mr1312375qtj.224.1585343190660;
 Fri, 27 Mar 2020 14:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200327131825.23650-1-festevam@gmail.com>
In-Reply-To: <20200327131825.23650-1-festevam@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Mar 2020 15:06:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiv5Ef37xe3mZWKtdY-rMCrquxyF4a9CpxoJRUNYT17A@mail.gmail.com>
Message-ID: <CAL_JsqKiv5Ef37xe3mZWKtdY-rMCrquxyF4a9CpxoJRUNYT17A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: ad5770r: Add vendor to
 compatible string
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 27, 2020 at 7:18 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> The compatible string in the example misses the vendor information.
>
> Pass the "adi" vendor to fix it.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
