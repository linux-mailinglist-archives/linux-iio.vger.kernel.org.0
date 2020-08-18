Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB57247C23
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHRC1l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHRC1i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Aug 2020 22:27:38 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF925206DA;
        Tue, 18 Aug 2020 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597717658;
        bh=7dpUROancloQzjAC2paa/N7nHDiunrOPamsHZFEEDx0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Px4C/BEEMvnH4zN9IAbmJ8dgMacQ7n2JGBx9DYUYTTWPZuhjiv4JEcitginamcveq
         6F8ZGXtHAOsyhyti/oB4ewJMY/mjZAzj8gBRZE6f0RC2z+YmsEQOXgQV7HhrYdRF+6
         Np9K/uv+W73bx1C5lbVJp0K4sNziWd8KzNqbNLwI=
Received: by mail-ot1-f52.google.com with SMTP id 93so15115425otx.2;
        Mon, 17 Aug 2020 19:27:37 -0700 (PDT)
X-Gm-Message-State: AOAM533WtoqYAE7+XFgWhnqgOdFERmkyvpc83eQlKrITUWty0XjSEv9d
        awIk94Rnys8iXtDYxBiERp/Pc1czwxbJYjgFXg==
X-Google-Smtp-Source: ABdhPJyzzUar0eV/bf3JSLHVgKTlym4ihE+fsDMzUjI14CmwnIjJdnh/UBKKeTmZ+jzECX/Rq4vGZKkgYQy+pfnzEmo=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr12587883ote.107.1597717657362;
 Mon, 17 Aug 2020 19:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200809111753.156236-1-jic23@kernel.org> <20200809111753.156236-3-jic23@kernel.org>
In-Reply-To: <20200809111753.156236-3-jic23@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Aug 2020 20:27:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjgNx5U7S9+4ShJzofSr__mV6LkJaNVnuKmO+w0ksfrw@mail.gmail.com>
Message-ID: <CAL_JsqLjgNx5U7S9+4ShJzofSr__mV6LkJaNVnuKmO+w0ksfrw@mail.gmail.com>
Subject: Re: [PATCH 02/13] dt-bindings: trivial-devices: Add mcp342x ADCs and
 drop separate binding doc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 9, 2020 at 5:20 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> These i2c devices have simple bindings, well described by trivial-device.yaml
> so rather than convert the binding doc to yaml, let us just add them to
> trivial devices and drop the old binding document.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/mcp3422.txt   | 19 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 19 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
