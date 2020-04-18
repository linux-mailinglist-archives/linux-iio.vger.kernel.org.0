Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0321AF5EC
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 01:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgDRXo7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 19:44:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42075 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgDRXo7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 19:44:59 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4EC7FFF804;
        Sat, 18 Apr 2020 23:44:56 +0000 (UTC)
Date:   Sun, 19 Apr 2020 01:44:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200418234456.GA7326@piout.net>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
 <20200415130455.2222019-2-kamel.bouhara@bootlin.com>
 <20200417135635.GA94725@icarus>
 <20200418192327.151e3155@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418192327.151e3155@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/04/2020 19:23:27+0100, Jonathan Cameron wrote:
> On Fri, 17 Apr 2020 09:56:35 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > On Wed, Apr 15, 2020 at 03:04:53PM +0200, Kamel Bouhara wrote:
> > > Some atmel socs have extra tcb capabilities that allow using a generic
> > > clock source or enabling a quadrature decoder.
> > > 
> > > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>  
> > 
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > 
> I'll need an appropriate ack from at91 maintainers for this bit
> 

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
