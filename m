Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084BC2C7503
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbgK1Vt3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbgK1TEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:04:30 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BDC42465E;
        Sat, 28 Nov 2020 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606569857;
        bh=XmjUN2I4WMAlzLSRxKyvs9ruGcfQgVA/e2xf3jsYNSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1UJLhhR1nmW4z9S3MEm3SRQbhOG3J9VTRoSgwUUV1XI45loVseWiuY0A1gH9gjO5
         jSDG2N17gpjTxoWpq3kOxNr3ECng5QIMJa1SI3BGv6+7D5y/lV+3DyrsTtRcPkuAYt
         Xxok7SSQN19PR5og7+XkQeVsGPJTbV8LldDq0L4s=
Date:   Sat, 28 Nov 2020 13:24:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] hts221: add vdd power regulator
Message-ID: <20201128132413.182c44de@archlinux>
In-Reply-To: <cover.1606045688.git.lorenzo@kernel.org>
References: <cover.1606045688.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Nov 2020 12:56:47 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce support to control VDD power line available on hts221 devices
> 
> Changes since v1:
> - update vdd-supply binding
> - rely on dev_err_probe() in hts221_init_regulators() to avoid
>   printing error message is the deferred case
> 
> Lorenzo Bianconi (2):
>   iio: humidity: hts221: add vdd voltage regulator
>   dt-bindings: iio: humidity: hts221: introduce vdd regulator bindings
> 
>  .../bindings/iio/humidity/st,hts221.yaml      |  2 +
>  drivers/iio/humidity/hts221.h                 |  2 +
>  drivers/iio/humidity/hts221_core.c            | 37 +++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
Applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan


