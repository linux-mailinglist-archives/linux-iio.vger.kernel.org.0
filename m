Return-Path: <linux-iio+bounces-16943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE19A649BA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80EC188A9D1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B80234994;
	Mon, 17 Mar 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA9jxrVR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CB238142;
	Mon, 17 Mar 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206818; cv=none; b=mglo8quGuMBJ+JFuQitMPpL+DGqL2awY3p4qq5oYz+SAGtTCqU0oDLK7lPo3c1l05cLvVoPIg47t3uXXl5kyQyghlEjLHUIIjCfgGb2KtiNTalaH2TdxENw0d10ORTmfHavnasQh8Qr6XDvmrCbwTgQeV/S4HYtwu1fFZ77j69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206818; c=relaxed/simple;
	bh=AXL3S+UXmXWsnrdSKH8aIWKMQxs3uIqHHvZfQWxskDk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qnNDQGbNii1Dgz2pMmCQgcW5x9oejMa8WMcEuEJSVDXarK5jPUUI0TDopxYl1TIuyOLJG7Fz/Mhp9Gh4+EDt9Q02DIlGTQ1rXL6rSVYHi/AcU4MPBxUHFf8mR/vt1gX0AAIlFURznOC0FB/OJA9j5POJ1XhHTywWmz1dfPY90SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA9jxrVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E603C4CEE3;
	Mon, 17 Mar 2025 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206817;
	bh=AXL3S+UXmXWsnrdSKH8aIWKMQxs3uIqHHvZfQWxskDk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mA9jxrVRoR1MWndHhnSw3bvKK9p6bTvgAoBvai2grcmy2X9VIrYoYPPqEkkJTtAjQ
	 50SYsqM85E/Ud+17P2Tx93ETXe57vnpCFtdXLvmTpwrMgy2A0YiU61bUcsAvmURMMk
	 lJH4ItQsVQZcGT5kJSm2Df03ZmLcs/DUROdo9SZGyubjYDDjxzUIF8b1lWk6LzeH1W
	 AspqOdymfSlsQb+Rmiap/kuO6M9hNX0DDm64QE3cgNiaBklZQ1adMXiTL6GZ4vSvBR
	 BHkpNg/fbrlOy4o2svb45NEGDKIUtI4zqet9PmpuQWP6j9wfNKmMwKHV0zpqiaSeNV
	 6cG8JmhL4Qcuw==
Date: Mon, 17 Mar 2025 05:20:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org, 
 oskar.andero@gmail.com, krzk+dt@kernel.org, lars@metafoo.de
To: marius.cristea@microchip.com
In-Reply-To: <20250317090803.30003-2-marius.cristea@microchip.com>
References: <20250317090803.30003-1-marius.cristea@microchip.com>
 <20250317090803.30003-2-marius.cristea@microchip.com>
Message-Id: <174220681643.3406351.8233477682051642594.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding support for
 PAC194X


On Mon, 17 Mar 2025 11:08:02 +0200, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for Microchip PAC194X and
> PAC195X series of Power Monitors with Accumulator.
> The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
> 32V Full-Scale Range.
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices are
> for high-side current sensing and the PAC194X/5X-2 devices are for
> low-side current sensing or floating VBUS applications.
> The PAC194X/5X-1 is named shortly PAC194X/5X.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1944.yaml   | 195 ++++++++++++++++++
>  1 file changed, 195 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml: properties:interrupt-names:items: {'enum': ['alert1', 'alert2']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250317090803.30003-2-marius.cristea@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


