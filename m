Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA73D4E43
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGYOjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 10:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhGYOjA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 10:39:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2109460F38;
        Sun, 25 Jul 2021 15:19:28 +0000 (UTC)
Date:   Sun, 25 Jul 2021 16:22:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net
Subject: Re: [PATCH v3 0/4] iio/adc: ingenic: add support for the JZ4760(B)
 Socs to the ingenic sadc driver
Message-ID: <20210725162119.242ae17e@jic23-huawei>
In-Reply-To: <20210724190449.221894-1-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Jul 2021 21:04:44 +0200
Christophe Branchereau <cbranchereau@gmail.com> wrote:

> This is a set of patches to add support to the JZ4760(B) socs found in numerous gaming handhelds and some
> mp3 players to the ingenic-sadc driver.
> 
> Changelog for this v3:
> - Minor formatting change in ingenic-adc.c to remain within 80 lines
> - Correctly set the ingenic,use-internal-divider property in the Documentation so it cannot be used on other
> socs than the jz4760b, and modify the description as requested.
> 
> Thanks to Paul and Jonathan for their help

You are welcome.

Other than Paul's question on the missing entry in patch 4, these look good to me.
We should leave a bit of time for others to review but otherwise once that's
resolved I'll pick them up.

Thanks,

Jonathan

> 
> Christophe Branchereau (5):
>   iio/adc: ingenic: rename has_aux2 to has_aux_md
>   dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
>   iio/adc: ingenic: add JZ4760 support to the sadc driver
>   iio/adc: ingenic: add JZ4760B support to the sadc driver
>   dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc
>     Documentation
> 
>  .../bindings/iio/adc/ingenic,adc.yaml         |  19 ++++
>  drivers/iio/adc/ingenic-adc.c                 | 101 ++++++++++++++++--
>  include/dt-bindings/iio/adc/ingenic,adc.h     |   1 +
>  3 files changed, 112 insertions(+), 9 deletions(-)
> 

