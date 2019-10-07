Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6687ECDEA5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfJGKEl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Oct 2019 06:04:41 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36341 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfJGKEl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:04:41 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E27F2FF808;
        Mon,  7 Oct 2019 10:04:38 +0000 (UTC)
Date:   Mon, 7 Oct 2019 12:04:38 +0200
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
Subject: Re: [PATCH v2 7/7] dt-bindings: iio: adc: max1027: Document max12xx
 series compatibles
Message-ID: <20191007120438.7fa72728@xps13>
In-Reply-To: <20191006112751.775fc849@archlinux>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-8-miquel.raynal@bootlin.com>
        <20191006112751.775fc849@archlinux>
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

Jonathan Cameron <jic23@kernel.org> wrote on Sun, 6 Oct 2019 11:27:51
+0100:

> On Thu,  3 Oct 2019 19:34:01 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Update the bindings documentation with new Maxim ADCs compatibles.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Both DT patches look fine to me... 
> 
> If you happened to fancy doing the yaml conversion it would be
> appreciated... :) 

I'm being requested all the time, that would be my third yaml
conversion, so let's go for it (if it's not overly complicated, I'll
check first...) :)

> If not we'll get to this one one day.
> 
> Anyhow, a few trivial bits in the earlier patches so v3 should be
> good to go.
> 
> Thanks,
> 
> Jonathan
> 

Thanks,
Miquèl
