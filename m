Return-Path: <linux-iio+bounces-24731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC618BB9439
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 08:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 432EE4E10DB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 06:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C21DF75C;
	Sun,  5 Oct 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRoFj2b2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2C1C28E;
	Sun,  5 Oct 2025 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759646715; cv=none; b=OiqlPzB6Y7sTgBMLaXqM+PczBt5m6MXNhC6VrUlMPFLOBZqwXwcEIAIsudDlRxNtfaaYMAoBLInPWhGAzVrw8VkRFx5867UIor3hxpmU7lB4RHZIZwxdJY4bZB/wC4wGUKk5qeh2AQWucVnGhbf53fG+TdIkcDy9yjNUWT/gito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759646715; c=relaxed/simple;
	bh=pd4v5G9qSeuHCK9g5lQEesKWwYfL4dDwpPnx6E3wQrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRso8u3xgxynmjscc3YEdKY9EeXM851saf315iB9ZIn4yBAYr6X8hUC0D7bnCCWK04FfHrc2YIbJdzWLOaIpOhiDHQ3UDysuFqNzBHJNqewS72JzEAExwROMbvvA1rNri16TcK7NjfuFXNPnfT4Mo9NDzRcH6TlAA726i+RKTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRoFj2b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA65CC4CEF4;
	Sun,  5 Oct 2025 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759646714;
	bh=pd4v5G9qSeuHCK9g5lQEesKWwYfL4dDwpPnx6E3wQrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRoFj2b2vXMi4f5icQ1TgIk7qSYmLvKOsTOdSlqUMH+M91GymXT7PoK9ag5RnwOWT
	 2aG2w2Q0avSbkYM+WbRX0L9y2b5NDNNnXudFYErv3xAj9+RjKh/U+nQ6jN2LFn/Jn6
	 Il2Az1gI++JNX6aDycodP7yvwED7KSSjgbqjpt72AvNTSD1676uCIhCKLxKzkeekOv
	 v+SZnde2Z6WEUtY1x2r6LzRHlbwwV1L/9j5rbX7oZBwqORBG+VTnbS+Yy21lCLRIkn
	 J8u77wd2SodGX81PQBask7rhHWjtzOPIv8gXERvWjogFGEjPriN3YWOg+pQkZgmdCH
	 oHJNJZy+91qyg==
From: William Breathitt Gray <wbg@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: counter: Add binding for NXP PCF85263/PCF85363 stopwatch
Date: Sun,  5 Oct 2025 15:45:01 +0900
Message-ID: <20251005064503.2216520-1-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071415.1956219-1-lakshay.piplani@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641; i=wbg@kernel.org; h=from:subject; bh=pd4v5G9qSeuHCK9g5lQEesKWwYfL4dDwpPnx6E3wQrk=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmPhO+8ClwvcDlqVX3+PqP9+QJBdScubzk26d9yi5eMu 2dsM1d93VHKwiDGxSArpsjSa3727oNLqho/XszfBjOHlQlkCAMXpwBMZLkiwz/jBJmtN7Z3df3P uageWPA8q0fh6lJ/rTQORi9W4yCVykZGhkWqdVasCpft521wDP/M/Gkic/5F/ikTj9yNNan2Uy7 ZzgAA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, Sep 15, 2025 at 12:44:14PM +0530, Lakshay Piplani wrote:
> Add a devicetree binding schema for the NXP PCF8263/PCF85363 devices when used in
> stopwatch (counter) mode.
> 
> In this configuration, the device operates as a high resolution stopwatch over I2C,
> counting in centiseconds (1/100th of a second) up to 999,999 hours.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
>  .../counter/nxp,pcf85363-stopwatch.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml b/Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml
> new file mode 100644
> index 000000000000..5fbb3f22ace4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/nxp,pcf85363-stopwatch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PCF85263ATL/PCF85363ATL Stopwatch (counter) mode
> +
> +maintainers:
> +  - Lakshay Piplani <lakshay.piplani@nxp.com>
> +
> +description: |
> +  Binding for NXP PCF82563ATL/PCF85363ATL devices when used in the
> +  stopwatch mode. In this mode, the device provides a centi-seconds
> +  (1/100th of a second) resolution operating over i2c.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pcf85263atl
> +      - nxp,pcf85363atl
> +
> +  reg:
> +    maxItems: 1
> +
> +  quartz-load-femtofarads:
> +    description:
> +      The capacitive load of the quartz(x-tal).
> +    enum: [6000, 7000, 12500]
> +    default: 7000
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      counter@51 {
> +        compatible = "nxp,pcf85363atl";
> +        reg = <0x51>;
> +        quartz-load-femtofarads = <7000>;
> +      };
> +    };

Hi Lakshay,

It sounds like you're trying to implement a clock. Is there any
particular reason you are trying to do this as a counter driver instead
of using the common clk[^1] framework? The Linux counter interface isn't
specifically designed for clock operations so I suspect a stopwatch
module would fit better in the clk subsystem instead.

Wiliam Breathitt Gray

[^1] https://docs.kernel.org/driver-api/clk.html

