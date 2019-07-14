Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6676567FCA
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfGNPV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 11:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNPV5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 11:21:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C93F2063F;
        Sun, 14 Jul 2019 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563117716;
        bh=ILrUsZZP1jcAU1UmSStKRc3zHCaHr61V33dU0wu2u8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WI+2np0eZhQ7uKg5kcXd/SUVeEvT0wz8jf0mBT80mUYkqUEpGRBa8AhdiQBxi9w6o
         w7NaKeT9w/TfiTFfSfbYOObFaq+jZ4itPvoljpZjLZYpNMF/1CmatDJHfHtIPUR9bO
         LC4BOM4bGcUwBeGEKVxahBjcb6GYcTZw3CJrKbRQ=
Date:   Sun, 14 Jul 2019 16:21:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vivek Unune <npcomplete13@gmail.com>,
        Hannes Schmelzer <hannes.schmelzer@br-automation.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~martijnbraam/pmos-upstream@lists.sr.ht
Subject: Re: [PATCH 2/3] dt-bindings: iio: light: add stk33xx
Message-ID: <20190714162149.0812b187@archlinux>
In-Reply-To: <CAL_JsqJU5nBf+tzudpXVseeb8FMoJUK3ANJs3btb=6gbcG41EA@mail.gmail.com>
References: <20190703180604.9840-1-luca@z3ntu.xyz>
        <20190703180604.9840-2-luca@z3ntu.xyz>
        <CAL_JsqJU5nBf+tzudpXVseeb8FMoJUK3ANJs3btb=6gbcG41EA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Jul 2019 10:23:11 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Jul 3, 2019 at 12:06 PM Luca Weiss <luca@z3ntu.xyz> wrote:
> >
> > Add binding documentation for the stk33xx family of ambient light
> > sensors.
> >
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  .../bindings/iio/light/stk33xx.yaml           | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/stk33xx.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Hmm. Not totally sure it makes sense to list me as the maintainer,
but I don't suppose it really matters as I think the author has moved
onto other things and it'll fall back on me.

Anyone who wants to pick up this one is most welcome!

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
