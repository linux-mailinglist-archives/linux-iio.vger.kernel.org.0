Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38CD67FCD
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGNPWx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 11:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfGNPWx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 11:22:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B4F205F4;
        Sun, 14 Jul 2019 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563117772;
        bh=raB9vkEEe7qFQ9TRMUvaSV5zb0Fq4CC95+AbgJOEm6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uPNWjp79LbcSMSwtaZg0xJpGhHkb2UzgB+Yw0T26r2qtSlp21AKcSR1L4/lVclFB4
         O/93c1kguc+pJmqHaEcbe62wp0upDsdwUxe4yYLbzzq37uxt/+QkDxRdvXLsTF4y7s
         DZo3z69rkcrNOI9pgYzURfcTzZaLtkuu+3hYkNG8=
Date:   Sun, 14 Jul 2019 16:22:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-kernel@vger.kernel.org,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: Add vendor prefix for sensortek
Message-ID: <20190714162231.2b5c94bb@archlinux>
In-Reply-To: <20190703180604.9840-1-luca@z3ntu.xyz>
References: <20190703180604.9840-1-luca@z3ntu.xyz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Jul 2019 20:05:57 +0200
Luca Weiss <luca@z3ntu.xyz> wrote:

> Sensortek Technology Corp. produces Proximity Sensors with ALS and
> Accelerometers.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> This patch series depends on "iio: light: stk3310: Add support for
> stk3335", that's curerntly in linux-next.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 342bb23e0a73..d197c9609ea7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -813,6 +813,8 @@ patternProperties:
>      description: Semtech Corporation
>    "^sensirion,.*":
>      description: Sensirion AG
> +  "^sensortek,.*":
> +    description: Sensortek Technology Corporation
>    "^sff,.*":
>      description: Small Form Factor Committee
>    "^sgd,.*":

