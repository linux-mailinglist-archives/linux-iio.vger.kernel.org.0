Return-Path: <linux-iio+bounces-17953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B2A860E7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 16:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C45A18909D4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707591F4E3B;
	Fri, 11 Apr 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ZmcKGp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562045948;
	Fri, 11 Apr 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382400; cv=none; b=BElfpUcsO4lO3zLq6qwG8YOp3WUtdYUeL07xDIsTdQGBInAkdx8C0MUiM6SpeZa/C8OgPixrlDYfAqkVLAodnxdSEAu6lDLCTQl3X/Xl5C24nKohFUCsyGWykWpQ/oWyoNH6dMDPneU7x5VfevAXvcX4D/6RfRy8lOWYWqGycMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382400; c=relaxed/simple;
	bh=Z97OYE/NcKg9tLL41XS8aSmgXASHjHGExZoZa0NkhD8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lsTP6jEV+dS1NSv+Vfm6g8AhVAA6fXs8OwJRE236rawvtPSTEk/It0VwIQuQfa7gXWrmf1CVLyb6hH5dZvHyuokVO1OIvS4RrItgFRrZ6ODtOtJuyb70aICfOYBvVTL7iqCdNfaK/0A2vbbhq14SnnWCdiRZvA1MnpnfGDlk8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ZmcKGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0EBC4CEE2;
	Fri, 11 Apr 2025 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382400;
	bh=Z97OYE/NcKg9tLL41XS8aSmgXASHjHGExZoZa0NkhD8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=l+ZmcKGpu9gylYDItuBlArpzuIFChrqQ0YaBFmQwUyg14zNonQLO4ixzLmoQD/iLN
	 GNpvPYm6Q1reFU+HHmBYkNKRBli2zbkiRAO8Pp9waRi6aTNChGdmCzGtvYZBcsl0nn
	 xyLHIcEVG90p9+ZtDbnpCXTrWpa1/icIWG+JwIJYyGUDktCrP7pmz5VW487BoVPPVY
	 kahWR4fIIG5iCQfkYa79q+l8+1pXh0vg964gyeo1pfr/vZdNmc38Z/XRg6jEE9XpAw
	 /Kwuf9zMdHQyw1bPjX2MLc7pzQrQSHlU7rJZ7DKOY+ANnjESn1o6ofwkp58Rlm3y+Y
	 +hnNW+gW1bQ+Q==
Date: Fri, 11 Apr 2025 09:39:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Remi Buisson <remi.buisson@tdk.com>
In-Reply-To: <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
 <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
Message-Id: <174438239866.3224246.7536607585769069581.robh@kernel.org>
Subject: Re: [PATCH 7/8] dt-bindings: iio: imu: Add inv_icm45600
 documentation


On Fri, 11 Apr 2025 13:28:39 +0000, Remi Buisson wrote:
> Document the ICM-456xxx devices devicetree bindings.
> Describe custom sysfs API for controlling the power modes.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 ++++++
>  .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++++++++++++++++++++
>  2 files changed, 173 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/imu/invensense,icm45600.example.dts:35.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/imu/invensense,icm45600.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):
[WARNING] /sys/bus/iio/devices/iio:deviceX/in_accel_power_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600:1; ./Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600:1
[WARNING] /sys/bus/iio/devices/iio:deviceX/in_accel_power_mode_available is defined 2 times: ./Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600:13; ./Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600:13

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250411-add_newport_driver-v1-7-15082160b019@tdk.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


