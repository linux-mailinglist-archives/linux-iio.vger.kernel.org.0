Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDD3BA94D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGCQAF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhGCQAE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 12:00:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE91561628;
        Sat,  3 Jul 2021 15:57:26 +0000 (UTC)
Date:   Sat, 3 Jul 2021 16:59:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 0/4] mfd: rn5t618: Extend ADC support
Message-ID: <20210703165950.6e2aeb89@jic23-huawei>
In-Reply-To: <20210703084224.31623-1-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 10:42:20 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Add devicetree support so that consumers can reference the channels
> via devicetree, especially the power subdevice can make use of that
> to provide voltage_now properties.

Does the mapping vary from board to board?  Often these mappings are
internal to the chip so might as well be provided hard coded in the
relevant drivers rather than via DT. See drivers that have iio_map
structure arrays.

> 
> Andreas Kemnade (4):
>   dt-bindings: mfd: ricoh,rn5t618: ADC related nodes and properties
>   mfd: rn5t618: Add of compatibles for ADC and power
>   iio: rn5t618: Add devicetree support
>   power: supply: rn5t618: Add voltage_now property
> 
>  .../bindings/mfd/ricoh,rn5t618.yaml           | 53 ++++++++++++++++++
>  drivers/iio/adc/rn5t618-adc.c                 | 14 ++++-
>  drivers/mfd/rn5t618.c                         |  6 +-
>  drivers/power/supply/rn5t618_power.c          | 56 +++++++++++++++++++
>  4 files changed, 126 insertions(+), 3 deletions(-)
> 

