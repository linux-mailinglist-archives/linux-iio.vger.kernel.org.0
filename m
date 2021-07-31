Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4112C3DC71A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 19:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGaRM7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 13:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaRM6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 13:12:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C362A60F94;
        Sat, 31 Jul 2021 17:12:48 +0000 (UTC)
Date:   Sat, 31 Jul 2021 18:15:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net
Subject: Re: [PATCH v4 0/5] iio/adc: ingenic: add support for the JZ4760(B)
 Socs to the ingenic sadc driver
Message-ID: <20210731181528.5fe57c57@jic23-huawei>
In-Reply-To: <20210726082033.351533-1-cbranchereau@gmail.com>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 10:20:28 +0200
Christophe Branchereau <cbranchereau@gmail.com> wrote:

> This is a set of patches to add support to the JZ4760(B) socs found in numerous gaming handhelds and some
> mp3 players to the ingenic-sadc driver.
> 
> Changelog for this v4:
> 
> Fix patch 4/5 that was missing the .compatible string for the jz4760b.

Series applied to the togreg branch of iio.git which will first be pushed out as testing
to see if 0-day can find anything we missed.

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
>  drivers/iio/adc/ingenic-adc.c                 | 102 ++++++++++++++++--
>  include/dt-bindings/iio/adc/ingenic,adc.h     |   1 +
>  3 files changed, 113 insertions(+), 9 deletions(-)
> 

