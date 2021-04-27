Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D036C9E9
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhD0RA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237893AbhD0RAv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:00:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2504C6103E;
        Tue, 27 Apr 2021 17:00:05 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:00:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 0/2] iio:adc:ad7476: Regulator support and binding
 doc
Message-ID: <20210427180050.5c6a9d76@jic23-huawei>
In-Reply-To: <20210425163154.73209-1-jic23@kernel.org>
References: <20210425163154.73209-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 25 Apr 2021 17:31:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver supports a whole load of devices with a range of different
> power supply connections.
> 
> Lars-Peter Clausen pointed out v1 did not handle the the ad7091r which
> an internal voltage reference, but that can be over-driven on the vref_in /
> vref_out pin.  The v2 handles that device properly.  I also realized that
> I'd the binding was more restrictive for devices with internal references
> than it needed to be (required vcc-supply) so I've relaxed that in
> the updated bindings.  Also reorganized the big allOf block in the
> binding doc to put all the constraints on reference voltage first.
> 
> v3 incorporates Lars' suggestion to set the regulator pointer to null
> as a way to indicate that we should definitely use the internal reference.
> 
> v4 fixes case of errors on the devm_regulator_get_optional() that are about
> something different than -ENODEV which signifies the regulator isn't
> specified.
Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it and see what I missed.

Thanks,

Jonathan
> 
> Jonathan Cameron (2):
>   iio:adc:ad7476: Handle the different regulators used by various parts.
>   dt-bindings:iio:adc:adi,ad7476: Add missing binding document
> 
>  .../bindings/iio/adc/adi,ad7476.yaml          | 174 ++++++++++++++++++
>  drivers/iio/adc/ad7476.c                      | 118 ++++++++++--
>  2 files changed, 277 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> 

