Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3114685E6
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 16:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbhLDP1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 10:27:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37604 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbhLDP1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 10:27:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA7D660E9F;
        Sat,  4 Dec 2021 15:23:40 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A174BC341C0;
        Sat,  4 Dec 2021 15:23:36 +0000 (UTC)
Date:   Sat, 4 Dec 2021 15:28:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Quentin Schulz <foss@0leil.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-iio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
Message-ID: <20211204152845.78828cfc@jic23-huawei>
In-Reply-To: <YaVd8j4fj69pmsnU@robh.at.kernel.org>
References: <20211118141233.247907-1-boger@wirenboard.com>
        <20211118141233.247907-3-boger@wirenboard.com>
        <YaVd8j4fj69pmsnU@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Nov 2021 17:10:42 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, 18 Nov 2021 17:12:33 +0300, Evgeny Boger wrote:
> > Most AXPxxx-based reference designs place a 10k NTC thermistor on a
> > TS pin. axp20x IIO driver now report the voltage of this pin via
> > additional IIO channel. Add new "ts_v" channel to the channel description.
> > 
> > Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> > ---
> >  .../devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml       | 3 +++
> >  1 file changed, 3 insertions(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Given the broader discussion on how to handle the NTC isn't directly
related to these patches and these will be needed for any solution
anyway, applied to the togreg branch of iio.git and pushed out as testing
to let 0-day have first go at breaking things.

Thanks,

Jonathan
