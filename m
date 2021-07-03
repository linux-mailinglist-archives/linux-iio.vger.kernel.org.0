Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44F03BA9BE
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhGCRVh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 13:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCRVg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 13:21:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0856192B;
        Sat,  3 Jul 2021 17:18:58 +0000 (UTC)
Date:   Sat, 3 Jul 2021 18:21:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/2] Renesas RZ/G2L ADC driver support
Message-ID: <20210703182122.0cb192e3@jic23-huawei>
In-Reply-To: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Jun 2021 23:03:26 +0100
Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Hi All,
> 
> This patch series adds DT binding and driver support for ADC block
> found on Renesas RZ/G2L family.
> 
> Patches are based on top of rzg2l-update-clock-defs-v4 branch found on [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/

Please aim to call out any dependencies that I need to be aware of.
That tree has lots of random things on it so I have no idea if there is anything
I need to be aware of.

> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
>     A/D converter
>   iio: adc: Add driver for Renesas RZ/G2L A/D converter
> 
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 +++++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/rzg2l_adc.c                   | 489 ++++++++++++++++++
>  5 files changed, 629 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
>  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> 
> 
> base-commit: 06c1e6911a7a76b446e4b00fc8bad5d8465932f8

