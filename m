Return-Path: <linux-iio+bounces-17336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D35A75A1B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BF3AABC5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9491A199FBA;
	Sun, 30 Mar 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLmAvJNL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA914A35;
	Sun, 30 Mar 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743339030; cv=none; b=WnbpHva72YYqyHYEXLzXJ9NPqrhLjtnKhy1sbcpnhcsHjvnH0KyEP3sJfVSKiX9cwiKDM9PODsADYkuQ/YOWVFr0/a74zl4cHjWmL4Dfry1EX0ohFNKHnbBju0NJ2hpz1xjNdmyWAeUIH8z/DcR5vV3ygQjfMzB0IJ9JP19nPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743339030; c=relaxed/simple;
	bh=CAr8XVJWc9Z8+4leUvkmPjeySWmzD22XSjA7GmEBFqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDNlB3Ra0DbBGjdfWp0B1CFgHVySDlgShNfdcwUQy0Sw95BWF5qpFe5Z0hSt25pk7MdJ693eFTBe3p4JPmy0CIB8wmuAnQFC9yRtUhNmQsCSXubHRG6crMKcBTRoPgPLNlGm7+gLhTB6+4igGrqXVOHhFvciDLoL37NzxWFnbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLmAvJNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC7FC4CEDD;
	Sun, 30 Mar 2025 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743339029;
	bh=CAr8XVJWc9Z8+4leUvkmPjeySWmzD22XSjA7GmEBFqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLmAvJNLDYRAUrhgtPLalDlvQbQOndbsNthvecOYpBSwdB1GhY4IrMYKAhIshRnjp
	 YIRNvG+xnoLZE0f9Is+goG/aoWEkti99llC5SOX0ERcomnaiiTVp5i/1mgqlSVnGRN
	 UGpzWh7F/13XMiG6YQg+5OLHwfRuloeFZhhq+k31WUsweB9M0TNUqSqQPXdIReL+sr
	 itEZn2fgyMBnXxn1fpug4KPfcofaxAnaRn0YZZehkkF1miuzk0CimxQyLeRVNBgRNg
	 hXYQix/Cqmdf6ORA4MwAueHnVYbi8J27JBzT/nrJFByBVQaKBgHEvu6+SxC+0reNna
	 8YaYoD90WTQAQ==
Date: Sun, 30 Mar 2025 13:50:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: add device tree support for winsen
 MHZ19B CO2 sensor
Message-ID: <20250330135022.76ff6f2e@jic23-huawei>
In-Reply-To: <20250329164905.632491-3-gye976@gmail.com>
References: <20250329164905.632491-1-gye976@gmail.com>
	<20250329164905.632491-3-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 01:49:04 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Add device tree support for winsen MHZ19B sensor.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  .../bindings/iio/chemical/winsen,mhz19b.yaml  | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
> new file mode 100644
> index 000000000000..c08681e43281
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/dht11.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MHZ19B CO2 sensor
> +
> +maintainers:
> +  - Gyeyoung Baek <gye976@gmail.com>
> +
> +description: |
> +   CO2 sensor using UART serdev bus interface.
> +
> +properties:
> +  compatible:
> +    const: winsen,mhz19b
Hi, 

Welcome to IIO. 

Just one additional comment from me.

Bindings should be as complete as possible and also reflect
the existence of things like power supplies even if your particular
board is relying in them being always turned on.

So you need 
vin-supply: true;

and add it to the required items.




> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    serial {
> +      mhz19b-co2-sensor {
> +        compatible = "winsen,mhz19b";
> +      };
> +    };
> +...


