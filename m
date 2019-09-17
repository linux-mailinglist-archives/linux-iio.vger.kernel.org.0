Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF94B5030
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfIQORx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 10:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfIQORx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Sep 2019 10:17:53 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C26A21852;
        Tue, 17 Sep 2019 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568729872;
        bh=OZUHz0ILqWnQzg+cEQF4D+eR3PkQ1eO8Zocxa61Z+IU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wMayQXu1akeImT79oURF+820WJwJz6/DZVtk4sNb1ZKIzBiPuk6zmblZu8d6/bpcZ
         JRTXwLbkQ5vSkD7RMz+5iBJ8dBatlxlFpais2zqL/p5GQB972Xc2EY/iEiwADyAzHT
         i14M0QGQKt2GBzKoeNLKtQVDLw9wgzSqF1XvmpXM=
Received: by mail-qt1-f170.google.com with SMTP id g16so4558885qto.9;
        Tue, 17 Sep 2019 07:17:52 -0700 (PDT)
X-Gm-Message-State: APjAAAXTcGT0ovZETAUF3ymaq6Iu697gCUNzsnU6yQ43ugMcOZMnz8w2
        U3MeKp0tZLC6+5ena9X95iI/c7XG+cJ2GiuwrA==
X-Google-Smtp-Source: APXvYqxUjT3xBWDRzzYOq8ha8KQprh0recH91D+MUMG4lhAjKcdHvS8EUmV28FYlHtKH2oeoikKpp0/cfj5A1xLEqvY=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr3961560qtn.110.1568729871878;
 Tue, 17 Sep 2019 07:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190916190024.9955-1-tduszyns@gmail.com> <20190916190024.9955-2-tduszyns@gmail.com>
In-Reply-To: <20190916190024.9955-2-tduszyns@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 09:17:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLj6jpgC5e607uDdVJGhKE6b53k=HHgZ3_dq8Qk-X5WDg@mail.gmail.com>
Message-ID: <CAL_JsqLj6jpgC5e607uDdVJGhKE6b53k=HHgZ3_dq8Qk-X5WDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: bh1750: convert bindings to yaml
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 16, 2019 at 2:01 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Convert existing device tree bindings to yaml.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/bh1750.txt  | 18 --------
>  .../devicetree/bindings/iio/light/bh1750.yaml | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
