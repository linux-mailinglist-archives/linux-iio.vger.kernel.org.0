Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398B214FE97
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 18:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgBBRYf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 12:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBBRYf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 12:24:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6211520658;
        Sun,  2 Feb 2020 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580664274;
        bh=CB/V4ylEcJdiUc+eCTLQx8SjNvEkUUscT8KGY/0JaGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S6lND/nSo/Foexo+6RxCpsvSSS1PLF+WpmopLOCZHHwa4pDvXAm7TModuMe9RGhcL
         YJ8eiqkObMLtwdd30SBDNL0di0CKUsUlA1PX5oO24mejvBju5Ni1WNw2LV9Ix0Rz2u
         J77aYAuq7KkVRdG9ajt9cyfm6L9VMHrDsHr3RDFE=
Date:   Sun, 2 Feb 2020 17:24:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, rpi-receiver@htl-steyr.ac.at,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: devantech-srf04.yaml: add pm
 feature
Message-ID: <20200202172426.485989ea@archlinux>
In-Reply-To: <20200120164454.GA8716@arbad>
References: <20200120164454.GA8716@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jan 2020 17:44:55 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add GPIO line and startup time for usage of power management
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  .../iio/proximity/devantech-srf04.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> index 4e80ea7c1475..8afbac24c34e 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> @@ -51,6 +51,24 @@ properties:
>        the time between two interrupts is measured in the driver.
>      maxItems: 1
>  
> +  power-gpios:
> +    description:
> +      Definition of the GPIO for power management of connected peripheral
> +      (output).
> +      This GPIO can be used by the external hardware for power management.
> +      When the device gets suspended it's switched off and when it resumes
> +      it's switched on again. After some period of inactivity the driver
> +      get suspended automatically (autosuspend feature).
> +    maxItems: 1
> +
> +  startup-time-ms:
> +    description:
> +      This is the startup time the device needs after a resume to be up and
> +      running.
> +    minimum: 0
> +    maximum: 1000
> +    default: 100
> +
>  required:
>    - compatible
>    - trig-gpios

