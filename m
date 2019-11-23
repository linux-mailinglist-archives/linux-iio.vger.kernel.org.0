Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DEE107EDA
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKWOdF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWOdE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:33:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D10A20714;
        Sat, 23 Nov 2019 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574519583;
        bh=rQPJJal/2iBJDhq/LDs/90IOhlu3NQ4BVGSZaUY01cQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eszpuZFDprg294+1ZnY80aO/rrBAvAfM1gKd7CKItwCO6AcD/GCIDuYd2HAw7LJ/e
         PjH47LPGtCBgexv8GjkN5e8CKRmOl5Er2/lWJiMl2tkwxcf7WSoz9UIBSE10ojHkXa
         QItnMQCvkLTzuIAgyFUdyVrEv8z4LRJTKq/b25GY=
Date:   Sat, 23 Nov 2019 14:32:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: add vendor prefix parallax
Message-ID: <20191123143257.1a8b4006@archlinux>
In-Reply-To: <20191118073553.2df736if7xk65e3y@arbad>
References: <20191118073553.2df736if7xk65e3y@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 08:35:55 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add new vendor prefix parallax for newly created ping iio sensors.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 967e78c5ec0a..d3f9690e1e4b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -713,6 +713,8 @@ patternProperties:
>      description: Panasonic Corporation
>    "^parade,.*":
>      description: Parade Technologies Inc.
> +  "^parallax,.*":
> +    description: Parallax Inc.
>    "^pda,.*":
>      description: Precision Design Associates, Inc.
>    "^pericom,.*":

