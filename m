Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35D3E2F5
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2019 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfD2Mo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Apr 2019 08:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfD2Mo1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Apr 2019 08:44:27 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6860E21530;
        Mon, 29 Apr 2019 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556541866;
        bh=Ggyhg8DPvggSyL5RERc8iJGOFwasiEkW75GgxgRJbZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zqdosaHHAAmr3mNLOGR3uVYumPkTSKqrRwSlxHGLG67URDPSBRiDfSNz6gPYX4/pv
         Xzsq+C3fji5XfZp4lmD2nC2hSyOuQqPBDT7btnEptcEmYl6dt9r9UHtjYw/dANYJ3n
         09kTdrRLbSyMHWQlDfgnqN6S26TcD3PuYlYMm858=
Received: by mail-qt1-f178.google.com with SMTP id c35so11677638qtk.3;
        Mon, 29 Apr 2019 05:44:26 -0700 (PDT)
X-Gm-Message-State: APjAAAXMTaNNA/q1UCy4j7Z8/1r51u46Znppt8X52dFL1JMAOhpyBh9N
        7lW33geW9196vV/cHNjQg12dnn3StUqdH0IdXg==
X-Google-Smtp-Source: APXvYqxiZhiB+jclpAyFocRSvqDl188dZe7YfLRzsfFn+DSKE81H4/Y7PEgye9SmTH9A+ZttmCPhfs4XwVPEsL/HCpc=
X-Received: by 2002:a0c:9384:: with SMTP id f4mr5385619qvf.77.1556541865622;
 Mon, 29 Apr 2019 05:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190427182359.27254-1-masneyb@onstation.org>
In-Reply-To: <20190427182359.27254-1-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Apr 2019 07:44:14 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Wzc8W11E0XYg5bKfGoYNxFu0U0-Rdk5PqXZf40W21ZA@mail.gmail.com>
Message-ID: <CAL_Jsq+Wzc8W11E0XYg5bKfGoYNxFu0U0-Rdk5PqXZf40W21ZA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: isl29018: convert bindings to YAML format
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <anson.huang@nxp.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        Rhyland Klein <rklein@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 27, 2019 at 1:25 PM Brian Masney <masneyb@onstation.org> wrote:
>
> Convert the isl29018 device tree bindings to the new YAML format.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> I'm willing to be listed as the maintainer since this is one of the
> drivers that I moved out out of staging unless one of the original
> authors wants to be listed instead.
>
> I added the BSD-2-Clause to the new binding document. I wrote the
> original document and the only commit since then was from Rob in
> commit 791d3ef2e111 ("dt-bindings: remove 'interrupt-parent' from
> bindings")
>
>  .../bindings/iio/light/isl29018.txt           | 27 ---------
>  .../bindings/iio/light/isl29018.yaml          | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
