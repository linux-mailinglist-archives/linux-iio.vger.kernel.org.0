Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777913D4E2A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhGYOPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 10:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhGYOPG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 10:15:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78A760E09;
        Sun, 25 Jul 2021 14:55:34 +0000 (UTC)
Date:   Sun, 25 Jul 2021 15:58:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH 0/3] iio: adc: meson-saradc: Three small improvements
Message-ID: <20210725155806.0d22449c@jic23-huawei>
In-Reply-To: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
References: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Jul 2021 01:37:15 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hello,
> 
> the first patch from this series saves a few CPU cycles on G12A, G12B
> and SM1 SoCs. The other two patches are small whitespace cleanups.
> 
> In my opinion none of these patches are any real bugfix, which is why
> I omitted the "Fixes" tag.
> 
Series applied to the togreg branch of iio.git and pushed out as testing
to let 0-day poke at it in ways I can't be bothered to ;)

Jonathan

> 
> Martin Blumenstingl (3):
>   iio: adc: meson-saradc: Disable BL30 integration on G12A and newer
>     SoCs
>   iio: adc: meson-saradc: Add missing space between if and parenthesis
>   iio: adc: meson-saradc: Fix indentation of arguments after a
>     line-break
> 
>  drivers/iio/adc/meson_saradc.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

