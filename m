Return-Path: <linux-iio+bounces-21038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BFAEC83A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C426E1748EA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEF212B2B;
	Sat, 28 Jun 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnEUKwJ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC81EB5FD;
	Sat, 28 Jun 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124031; cv=none; b=mXlJrGq/lQkhu1LlSQam4Wb5BlPqe5yqCk8CLOH/19LqeaFictMBiVSLyWB6uppROXqPDxBl0BkDz9bw3yHtG2gcm6+kdOoAuLVSas4EHWQBa/Q/5VOJp3ie0Am3DPnXmE/ck74deRsn8SBbVvjHYdWaV4HKWVlvkCAu6CzGL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124031; c=relaxed/simple;
	bh=/mrdRj2so+n3NyWX7vqnHYBbVjK7lHkTasMH9XQNnkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKYGM61DXmsQadt69f1hRB+E4EtdyZUcvYAFKRJpwrbZ1k7CiPE30GpaLv5Kwoeo0HsoyNflCI0qHz/Euf6Dy6ob2NFEIsqJ/uj9AQgIjZl09/qqU20aXaXQWbBca1QuoUP3T2zd7dTmNa7Zf2b/lJV8mbuV71DV59+V7Mq3mjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnEUKwJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41E4C4CEEA;
	Sat, 28 Jun 2025 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124031;
	bh=/mrdRj2so+n3NyWX7vqnHYBbVjK7lHkTasMH9XQNnkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MnEUKwJ13QIqlt2CA+BhCxuZUnMoo/DxIXwckeRgTd+aVbIJPdThsikMCJimk6OJN
	 sEL+tAv4ZfJEsSvh/ZgmtnvKbjDLGX7AufWy8v1LQ2Vp0SgxP30UUtbMCACBz/Bbww
	 zddteANFV7U0islVgXkPuYbDtdLsW8AMpfxq3htMhbHZn/1tdWNN3U5NRnN3Jpau7d
	 Kbbh83bh/4IRVWlcu2GLAzKalG4AC6f2/L65UMfdWoS4DrndjYd/qzpsZIlkD2SwrN
	 bqCoCOyxgDi6V2kem5v4GAkXASl+zOVMSRHLE2hLzeoNtUZW1fPfkITKro7K3MGfb0
	 GKOeSKrtj2xnA==
Date: Sat, 28 Jun 2025 16:20:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 jmaneyrol@invensense.com, ~lkcamp/patches@lists.sr.ht,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Baptiste
 Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Subject: Re: [PATCH] dt-bindings: iio: pressure: invensense,icp101xx: add
 binding
Message-ID: <20250628162024.5316e66e@jic23-huawei>
In-Reply-To: <20250626212742.7986-1-rodrigo.gobbi.7@gmail.com>
References: <20250626212742.7986-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 18:12:25 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> There is no txt file for it, add yaml for invensense,icp101xx family
> which is already used in the driver.

Don't mention binding in patch title. The dt-bindings prefix makes that obvious.

> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Very simple yaml for a i2c device with psu. The pin out for the rest of
> the family (the other PNs) doesn`t change anything here, since the diff
> were RESV pins (unused).
> 
> This yaml file falls in the same `category` as others that I`ve submitted, the
> driver author, which might be still interested at this hardware, is no long contributing
> (at least for what I`ve looked). Also, it`s email is still "at invensense", not "at tdk", either
> way I`ll ping him here due the mention at the "maintainers" field:

Try a search for their name in recent mails to the list.  +CC Jean-Baptiste at new TDK address.
People don't always remember to send a mailmap update when their company email
changes, particularly if it is due to an acquisition.

Jean-Baptiste has been active in the last week so not hard to find!

> 
> Dear @Jean-Baptiste Maneyrol, I`ve noticed that since the driver was added,
> there was no binding doc for it and this is what this patch is addressing.
> In this case, a maintainer ref is required inside the .yaml file and I would
> like to ask if I can add you in this case.
> I would appreciate your comment or suggestion over this topic.
> 
> Tks all and regards.
> ---
>  .../iio/pressure/invensense,icp101xx.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml b/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml
> new file mode 100644
> index 000000000000..439f8aaafbd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/invensense,icp101xx.yaml#

No wild cards in file names please.  Just pick a device to name the binding
after.  Wild cards have an annoying habit of getting messed up by companies
releasing completely non compatible parts in the middle of what we thought
was a reserved number range.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICP-101xx Barometric Pressure Sensors
> +
> +maintainers:
> +  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

I'd assume switch to the TDK address +CC but I'll need an Ack or RB from Jean-Baptiste.

> +
> +description: |
> +  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.
> +  Those devices uses a simple I2C communication bus, measuring the pressure
> +  in a ultra-low noise at the lowest power.
> +  Datasheet: https://product.tdk.com/system/files/dam/doc/product/sensor/pressure/capacitive-pressure/data_sheet/ds-000186-icp-101xx.pdf
> +
> +properties:
> +  compatible:
> +    const: invensense,icp10100
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pressure@63 {
> +            compatible = "invensense,icp10100";
> +            reg = <0x63>;
> +            vdd-supply = <&vdd_1v8>;
> +        };
> +    };
> +...


