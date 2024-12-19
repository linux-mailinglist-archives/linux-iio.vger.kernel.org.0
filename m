Return-Path: <linux-iio+bounces-13672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D062D9F81DB
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F5818880E8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8445719D060;
	Thu, 19 Dec 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjwn4DpG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFD8633D;
	Thu, 19 Dec 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629136; cv=none; b=lx/9qACRBHkNWP6TebqDfmHZQaM2BxAV6Gz3oAmo+Be+tMmbBIv7PWy2lZ7Wp4rm5s6jhLQiqgsZ434BdX0i6V1OlNWfWNpQ5qZKg8bYylAswhvPwLddSMPfp8uk8nqC+JZ+rYj+zi3PJfUkzFhNDiEX3v9Em6ZtuGFfQtsOKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629136; c=relaxed/simple;
	bh=uUUmXfoLGFamTSYlkZW5UNqU09UayqHzeKin9GpisDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1RIHamhgqIZS3M1UDwJvhgwDUawK1crAbS5BbiIqJliqSIGmnwDKpzzk2M/rAgN2ZwSTZVrFRTE348/hrvOFf3LvJbQmRMEaz8P4N3nxAjPD0GV2gBmRqiweYtYBZ9qmQyt7mdGExb2S3HqUA0Vicv9SajNGmbGMJOBMKxV8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjwn4DpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6939C4CECE;
	Thu, 19 Dec 2024 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734629135;
	bh=uUUmXfoLGFamTSYlkZW5UNqU09UayqHzeKin9GpisDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qjwn4DpGOflgIMxAzhnLSoNcB2itf7dKnwSRLI3wVT3zLeXIniRGFDD4/yHEkLyrk
	 QzxoOfOvctRUQJX+qRc1fVj7bK66VCCkypzH8g6e6vtunSV+qGibv72PTcfSP5znD8
	 +fisG9qMSXdDJnB+9PRPwA1azf0uhOeCPBlvYm0P3tQmDdEh/JXd1edduup1RAgxN8
	 bruBuiUPBtFufCG/oiiLwwBWr6wKoXRRokeXU9E1y+wQ7WIvq9pFtvn+uV0336dXLd
	 A214H2c35s/BlMe4mfZsK7IgiAcjFaY0FEP7WcGLJZFmVBBMdYW5XJPDzvqp9/fc4U
	 mtf7ArvtONbOA==
Date: Thu, 19 Dec 2024 17:25:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, Alex Lanzano <lanzano.alex@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <robi_budai@yahoo.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20241219172524.27b87549@jic23-huawei>
In-Reply-To: <20241216144818.25344-6-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
	<20241216144818.25344-6-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 16:48:11 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> v3:
> - changed sync type to integer
> - conditioned clock only on scaled-sync
> - added: unevaluatedProperties false
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> new file mode 100644
> index 000000000000..e0b07b912484
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16550 and similar IMUs
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16550
> +      - adi,adis16550w
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 15000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      RESET active low pin.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: If not provided, then the internal clock is used.
> +
> +    adi,sync-mode:
This is at least one of the things the bot is complaining about.  Too deep on the indent.
> +        description:
> +          Configures the device SYNC pin. The following modes are supported
> +          0 - direct_sync
> +          1 - scaled_sync

Ah. I see this is lined up with some existing binding.
you should keep the values the same as well given direct and scaled are already in the adis16475 binding.
Just use an enum to constrain the values 1 and 2


> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - spi-max-frequency
> +  - vdd-supply


