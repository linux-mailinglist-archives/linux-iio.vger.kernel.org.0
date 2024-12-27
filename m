Return-Path: <linux-iio+bounces-13813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4649FD1DF
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD4B1883981
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049814F9EE;
	Fri, 27 Dec 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmyNvC5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992174204E;
	Fri, 27 Dec 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735287470; cv=none; b=SCSr04BnuqRk/fII5KFK4y4yZYHxCUX9g0poZMyNKPDzsESMBAGXu3vQNDJ1W5Cw5s+on8PwhhRruGB8FY+Ht+AMznXuyIgOHuqJ5Kkwhi1+2ddysQQTQD8BFqDA0fn6OFvWoEK68xIbiIo1caZFa40To1ozdhXGjhaM/u3IdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735287470; c=relaxed/simple;
	bh=TZfQMDuOUiOku2tocDJE/MOog1QxlRrq59siThHFlm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL3/JpYGZs24ep8cEI0mwRzDvWeLpgu29WuyRsZtPNAcSio55/GcZcMzsBHcq3f3x/GV3d60H7qPrh+kdVpl5iGheE3tBIIMDRsaD8NSDpsbx7FN5lIrpGdaQuwXk07SS44A4qGOfKT6Tm8eFgwLDajO+H3LuxmpYJ6IHqM1dCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmyNvC5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F933C4CED0;
	Fri, 27 Dec 2024 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735287470;
	bh=TZfQMDuOUiOku2tocDJE/MOog1QxlRrq59siThHFlm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmyNvC5hhlproSM8IRx63sjNFTIfuc+0R5crGQrMFZe9OSGTcEWdsxt7wl9bdUoFX
	 6UWUjyGe8UAtpE7iI61xBH1id0waMBrllvZVLsoEuDz9QPWDBhUbY+Io66RqlDncka
	 h7RLFMvZIqHzGng1T46cFOjSz/BEqRl+6pikux7bU0XnviiEbbAJFEwVd6GQqDOuaN
	 Y4y+yCTm/KiWohwy2NXtSGOrTrMOK1o5B7b4MYm0PV1OQ0f4DLqrxgtvxCAszc96Jp
	 K48WDajJVSOsgrh4TuYYEDUO4MHOGw8boe3lC+IE9BEHkavXF6xOuWQK69PbL+/TYY
	 Z0x9n66QVwlVw==
Date: Fri, 27 Dec 2024 09:17:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, jic23@kernel.org, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com, 
	alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com, 
	herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
Message-ID: <lfthwnvwodqogsk446r5nzpmjunfnpdv33xmaookedwjgpdu4n@llvla6siyl5f>
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
 <20241226055313.2841977-2-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226055313.2841977-2-j2anfernee@gmail.com>

On Thu, Dec 26, 2024 at 01:53:12PM +0800, Eason Yang wrote:
> Adds a binding specification for the Nuvoton NCT7201/NCT7202


I gave you link to exact line with exact text to use. Read it again and
use it, instead inventing your own wording. The documentation does not
say "Adds" but explicitly asks you to say "Add". Why using different?

Subject: nothing improved.

> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> ---
>  .../bindings/iio/adc/nuvoton,nct7201.yaml     | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> new file mode 100644
> index 000000000000..08b52258e4af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton nct7201 and similar ADCs
> +
> +maintainers:
> +  - Eason Yang <j2anfernee@gmail.com>
> +
> +description: |
> +   Family of ADCs with i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7201
> +      - nuvoton,nct7202

Devices aren't compatible? Explain in the commit msg why they aren't or
use proper compatibility (oneOf, see numerous other bindings or example-schema).


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Reset pin for the device.

Drop description, obvious.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1d {
> +            compatible = "nuvoton,nct7202";
> +            reg = <0x1d>;


Make the example complete: add interrupts and reset-gpios.

Best regards,
Krzysztof


