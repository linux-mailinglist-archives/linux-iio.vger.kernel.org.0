Return-Path: <linux-iio+bounces-14693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DBEA219D9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783B11882CAB
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35C1A9B4D;
	Wed, 29 Jan 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+fn+1oP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFC8462;
	Wed, 29 Jan 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142933; cv=none; b=nyCh6jd64+IMwehYfxu+oMpSoUGy4d1Ijlq5vc/ybqQsPU0TrUGYXhPUqR8ccbfWka087IRqcQU2Sd5bpd/AYEFHXgf4SKi2mbAkHTZVo3JUxDH5W30OWTzMA915WDe9yU8prWTbJ/HqQkfUVJamAsi7gUX5sRw4U/aQarW0jzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142933; c=relaxed/simple;
	bh=MP79IH1CmJE5JMHDNfccrR4Cb1g7yACtbwIITUe6FS8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KZOewoILF5rzk14+Nw24TpK+QqGtUhLIPsDwfX8LbMuBQRx32FlvVnfKcd11wjk9SYV8Gye/V2ky5MPezzt0otog/YNtQdebydtKFYJDNjTwT0SfSsSgxKtVFakZpUa2wkoocSiYbngOV9NVVfufFRAo1tl8ahTUcC1OAdmkS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+fn+1oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5775AC4CED3;
	Wed, 29 Jan 2025 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738142932;
	bh=MP79IH1CmJE5JMHDNfccrR4Cb1g7yACtbwIITUe6FS8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=N+fn+1oP0h6FkUGs6aIghl7gas3RxZKUMoUJKI6oH3QOseY2FKsR/0dYF8Zu+Ylt1
	 5YWxS1gS9N9m5ISp7kEGKlmwwjShw9NAN5ySQU0X9M976o6BAswdnsBV73qJdbj6EB
	 xbLaSEPadwU+EMolDezpd4v0Va5rNODZcDTBpna7uGzd8q64MhKkfFcw4kRYe7+LWZ
	 56EQrNJLOqhBsvOCdWXrUWDenoKe2BSryaenkpH1tGfLx+mw6EHjw2gCybnlVO1YB5
	 ZjztHzDkD2WEnncFytw9OBPOf1HjJHtpySxGEir/tVdsOImhMb/bYuNKw0N7lKODwO
	 L6B8Samyp+tGQ==
Date: Wed, 29 Jan 2025 03:28:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nuno.sa@analog.com, corbet@lwn.net, devicetree@vger.kernel.org, 
 Michael.Hennerich@analog.com, conor+dt@kernel.org, 
 linux-iio@vger.kernel.org, lars@metafoo.de, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lanzano.alex@gmail.com, 
 antoniu.miclaus@analog.com, jic23@kernel.org, ramona.gradinariu@analog.com, 
 krzk+dt@kernel.org
To: Robert Budai <robert.budai@analog.com>
In-Reply-To: <20250129082053.19077-5-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
 <20250129082053.19077-5-robert.budai@analog.com>
Message-Id: <173814293125.1202566.9263115749619658807.robh@kernel.org>
Subject: Re: [PATCH v5 4/6] dt-bindings: iio: Add adis16550 bindings


On Wed, 29 Jan 2025 10:20:44 +0200, Robert Budai wrote:
> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> v5:
> - removed sync-mode binding
> - added binding for external clock frequency
> - removed adis16550w
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  9 +++
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.example.dtb: imu@0: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250129082053.19077-5-robert.budai@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


