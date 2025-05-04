Return-Path: <linux-iio+bounces-19054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D9AA8830
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C60165559
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B81E1DEC;
	Sun,  4 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSRFzbKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE98F7D;
	Sun,  4 May 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377634; cv=none; b=YZQ4NAB8YNEfdeCfX/n7jmtZiPyDfK9BMMm/aZ8acUrvzPXwDfmcGytMAvBy0pxtalxhWA0VlLAZYfCOAtz+du3LwUzqwGLAwPhms2nnwurJFHup8f6u8mv2AeyDozAmrDlSOYcbS6ZG4/im+E6tE9CtTaQjOya7ekKDCE0YNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377634; c=relaxed/simple;
	bh=0gXJYMgPbvqPvJzZFFCwd3YP+XfNALENWu18AtKI1iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhrqoH1YnbIqm8von2n7ByasMTeHtKtQGHSgWglSL/+6AgllNNtB68KH8kq8VWBaisY6S3uPfA+i39fP8aaWzCO1wxx8HH7237hAdoUxJ4bUGzBYNFIidPEymi8YZl6D3DLQTMqt20mHjNv/C0uk1Oh3zomToitYkQkt+DGy+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSRFzbKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B83C4CEE7;
	Sun,  4 May 2025 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746377633;
	bh=0gXJYMgPbvqPvJzZFFCwd3YP+XfNALENWu18AtKI1iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSRFzbKNybtkZwfKlfVs/kMcJiztW/9nOE3cCYuVmCTSexhgUuLegTWoZ9CFPmmQe
	 aQ2q8Ft9cWlCTHmR/rj4la2QxJz0NDZmSyCbTaKMu0dWhw9bCojR+lJ35jDYmy9ZMx
	 FBnU2CUBT/Ux/MFxwRcw6TnRfslnVb6qTq30gB89EiOKJmRTiO6CP9C8QIVLVcXoa/
	 4B6FqRpukjjL2qAmgC2YAFLsb0jjrYWbz4TqGTx/7mo9EnBQ1gOvfqXp4lB9N//WQ6
	 vMhlV8uchcew4iE4qG9sA3WhB5QsnQ1on03nGukKd7CQVjpGNMr66NKrEWcMxnpeGv
	 ++oeCmfAAj2tw==
Date: Sun, 4 May 2025 17:53:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250504175345.2465f82a@jic23-huawei>
In-Reply-To: <20250430020248.26639-1-rodrigo.gobbi.7@gmail.com>
References: <20250430020248.26639-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 22:50:01 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> Straight forward conversion from spear-adc.txt into yaml format.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Some constraints were extracted from the driver (spear_adc.c) and the public datasheet
> referenced at the yaml.
> 
> Changelog:
> v2: add constraints over properties and remove a ref at MAINTAINERS file.
> v1: https://lore.kernel.org/linux-devicetree/20250423022956.31218-1-rodrigo.gobbi.7@gmail.com/
> ---
>  .../bindings/iio/adc/st,spear600-adc.yaml     | 69 +++++++++++++++++++
>  .../bindings/staging/iio/adc/spear-adc.txt    | 24 -------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 70 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> new file mode 100644
> index 000000000000..afce10eab1c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/st,spear600-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST SPEAr ADC device driver
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  Integrated ADC inside the ST SPEAr SoC, SPEAr600, supporting
> +  10-bit resolution. Datasheet can be found here:
> +  https://www.st.com/resource/en/datasheet/spear600.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,spear600-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sampling-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2500000
> +    maximum: 20000000
> +    description:
> +      Default sampling frequency of the ADC
For consistency probably wants a full stop.  (as well as units)

> +
> +  vref-external:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1000
> +    maximum: 2800
> +    description:
> +      External voltage reference in milli-volts. If omitted

Very short wrap. Go up to 80 chars.

> +      the internal voltage reference will be used.
> +
> +  average-samples:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 128
> +    default: 0
> +    description:
> +      Number of samples to generate an average value. If
> +      omitted, single data conversion will be used.
It is odd to have a default outside of range.  I'll wait
to see what Conor suggests for that. I'm fine with anything
that doesn't trip up the dt parsing!

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - sampling-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc: adc@d8200000 {
> +        compatible = "st,spear600-adc";
> +        reg = <0xd8200000 0x1000>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <6>;
> +        sampling-frequency = <5000000>;
> +        vref-external = <2500>;	/* 2.5V VRef */
> +    };

