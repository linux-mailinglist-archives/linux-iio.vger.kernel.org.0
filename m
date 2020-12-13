Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF742D8D44
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 14:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406846AbgLMN2f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 08:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgLMN2c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 08:28:32 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4034206D7;
        Sun, 13 Dec 2020 13:27:50 +0000 (UTC)
Date:   Sun, 13 Dec 2020 13:27:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,mpu6880
Message-ID: <20201213132747.5acae377@archlinux>
In-Reply-To: <20201209195932.GA845313@robh.at.kernel.org>
References: <20201202104656.5119-1-stephan@gerhold.net>
        <20201209195932.GA845313@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Dec 2020 13:59:32 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 02 Dec 2020 11:46:55 +0100, Stephan Gerhold wrote:
> > MPU-6880 seems to be very similar to MPU-6500 / MPU-6050 and it works
> > fine with some minor additions for the mpu6050 driver.
> > Add a compatible for it to the binding documentation.
> > 
> > Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > Note: This applies only on top of the patch for the YAML conversion:
> > https://lore.kernel.org/linux-iio/20201128173343.390165-3-jic23@kernel.org/
> > I guess that one will be applied very soon so I think this is easier :)
> > 
> > Changes in v2: None :)
> > ---
> >  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>
Series applied to the togreg branch of iio.git and pushed out as testing
to see if the autobuilders find anything interesting.

Thanks,

Jonathan

