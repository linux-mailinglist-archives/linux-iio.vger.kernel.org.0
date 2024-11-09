Return-Path: <linux-iio+bounces-12075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818839C2D9B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57BEB21E20
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA6194ADB;
	Sat,  9 Nov 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqVVjo06"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77EA192B95;
	Sat,  9 Nov 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159868; cv=none; b=fMn0oTZyGbHHyJmPUNPI7/y4sAJhNT01+FmJoQZCficXJRvsxOBjie58KBrds08HQ1fXMyV+Z6QaGVH0XX8MpRtMlZ+TyCyDkAUyf+dk2iMGvczut++oVNZZKNm3fEuyb0dSKXltgoPDTaTsu9O73397NmnAI11KstoyD4+viP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159868; c=relaxed/simple;
	bh=49p+eh795isltErL55vp27x/rduM9Do35UMDcUDQ568=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD1GQ146SPREMijP2Wdpl6J6NHAHI1nbrcybLLuGRyV6qTUjjY3fOi16YAaHycXac926nWbAqEoDP/Hj3HU28qQbb7HYMvnP/aaL/2n+Laprc6gYgFboO6h0x4vDBaEDxnyKN42g+OZrI3yQVbKNjpv1eBg9E7GOdMPBX7px4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqVVjo06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802BAC4CECE;
	Sat,  9 Nov 2024 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731159868;
	bh=49p+eh795isltErL55vp27x/rduM9Do35UMDcUDQ568=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqVVjo06OL/EBPtrjzpJEvEfeFkJYuKeSfBz2fk0SzZIM0HtmuhEmAOVz4krroLzX
	 80eb6GD4dZaQgeO8gNUSnFew8tVEWtMlFU6XdNMtYrd36ZtPkAcu3olVwRP+2s9+Kw
	 OriU8bIh6UX2UBC7+uVRCDIqCG2QDqv+Wtz2CkE/83t4KTARb+zZtfI3ULX8vPMuQ0
	 2leJxqfWPDJ9HOvKYuAf9ufpbiOfoGxyl745M1Omwe6YWc9ozKOo69I3hz8cm3GvTq
	 AsIy8gpQv3ncQNlhUxskZ5nf4bbK3mRe/Kb83gRBbPnYzbOZXaYVipcrzS7YgEp634
	 MRY5XguKDtULQ==
Date: Sat, 9 Nov 2024 13:44:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andy@kernel.org, marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com,
 joao.goncalves@toradex.com, marius.cristea@microchip.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
Message-ID: <20241109134415.2f31c449@jic23-huawei>
In-Reply-To: <20241106023916.440767-2-j2anfernee@gmail.com>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
	<20241106023916.440767-2-j2anfernee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Nov 2024 10:39:15 +0800
Eason Yang <j2anfernee@gmail.com> wrote:

> This adds a binding specification for the Nuvoton NCT7201/NCT7202
> family of ADCs.
> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
Hi Eason,

> ---
>  .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> new file mode 100644
> index 000000000000..3052039af10e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml

Already raised in another review I think, but pick a part number and name after that.  Wild
card get broken far too often for them to be usable like this.


> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton nct7202 and similar ADCs
> +
> +maintainers:
> +  - Eason Yang <yhyang2@nuvoton.com>
> +
> +description: |
> +   Family of ADCs with i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7201
> +      - nuvoton,nct7202
> +
> +  reg:
> +    maxItems: 1
> +
> +  read-vin-data-size:
> +    description: number of data bits per read vin
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16]
> +
> +required:
> +  - compatible
> +  - reg
> +  - read-vin-data-size

If you do keep this, then pick a sensible default (16)
and drop the required.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nct7202@1d {
> +            compatible = "nuvoton,nct7202";
> +            reg = <0x1d>;
> +            read-vin-data-size = <8>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91d0609db61b..68570c58e7aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2746,6 +2746,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/*/*/*npcm*
>  F:	Documentation/devicetree/bindings/*/*npcm*
> +F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
>  F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
>  F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
>  F:	arch/arm/mach-npcm/


