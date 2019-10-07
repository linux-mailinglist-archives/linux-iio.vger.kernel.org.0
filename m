Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA00CDE95
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfJGKB0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Oct 2019 06:01:26 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40943 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGKB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:01:26 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8621920010;
        Mon,  7 Oct 2019 10:01:23 +0000 (UTC)
Date:   Mon, 7 Oct 2019 12:01:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/7] iio: adc: max1027: Make it optional to use
 interrupts
Message-ID: <20191007120122.6d41532f@xps13>
In-Reply-To: <20191006111837.33fdfe25@archlinux>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-3-miquel.raynal@bootlin.com>
        <20191006111837.33fdfe25@archlinux>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Sun, 6 Oct 2019 11:18:37
+0100:

> On Thu,  3 Oct 2019 19:33:56 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > The chip has a 'start conversion' and a 'end of conversion' pair of
> > pins. They can be used but this is absolutely not mandatory as regular
> > polling of the value is totally fine with the current internal
> > clocking setup. Turn the interrupts optional and do not error out if
> > they are not inquired in the device tree. This has the effect to
> > prevent triggered buffers use though.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Hmm. I haven't looked a this in a great deal of depth but if we support
> single channel reads it should be possible to allow the use of a
> trigger from elsewhere.  Looks like a fair bit of new code would be needed
> to support that though.  So perhaps this is a good first step.
> 
> It's a bit annoying that the hardware doesn't provide a EOC bit
> anywhere in the registers.  That would have allowed us to be a bit
> cleverer.

I totally agree. Actually, this chip does not support any 'register
read', the only things we can read are measures (temperature/voltages).


Thanks,
Miquèl
