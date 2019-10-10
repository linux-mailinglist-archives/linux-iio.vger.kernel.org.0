Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA2D3373
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfJJVbe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 10 Oct 2019 17:31:34 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45023 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVbe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2019 17:31:34 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BAD3A240009;
        Thu, 10 Oct 2019 21:31:30 +0000 (UTC)
Date:   Thu, 10 Oct 2019 23:31:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 8/8] dt-bindings: Add max12xx SPI ADC series as
 trivial devices
Message-ID: <20191010233129.67a1d76c@xps13>
In-Reply-To: <20191010204751.GA22206@bogus>
References: <20191007132657.4190-1-miquel.raynal@bootlin.com>
        <20191007132657.4190-9-miquel.raynal@bootlin.com>
        <20191010204751.GA22206@bogus>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Thu, 10 Oct 2019 15:47:51 -0500:

> On Mon, Oct 07, 2019 at 03:26:57PM +0200, Miquel Raynal wrote:
> > Update the compatible list with three Maxim ADCs compatibles.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/iio/adc/max1027-adc.txt          | 28 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |  6 ++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1027-adc.txt  
> 
> Devices are supposed to be documented in one place or the other. So 
> either make max1027-adc.txt a schema or drop it.
> 
> I'm fine either way. Obviously, trivial-devices.yaml is trivial to add 
> to, but it does leave some ambiguities. Like is an interrupt required, 
> optional or non-existent? What about power supplies? Or what are allowed 
> values for spi-max-frequency.

Rhaaa... I obviously wanted to drop the *txt file, just forgot to do
it. As the interrupts are optional I found the trivial device
description accurate enough.

Thanks,
Miquèl
