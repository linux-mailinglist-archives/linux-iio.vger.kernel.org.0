Return-Path: <linux-iio+bounces-16997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7238A65DEB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 20:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6343AD7B5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C741EB1A0;
	Mon, 17 Mar 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ4nNAtX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC71E8355;
	Mon, 17 Mar 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239775; cv=none; b=cvDz5fqFMbQZ4Jo1PwBqj0b2n6LDFyKFMTBKTWJ6lVkGccCdwN3xnaLPnjymfMxjkLAZaq9cW059n0rYpqOnqmqMeJIPWJvesS1HR8Toh2RvIFkVyg2NPowWcyj9qbqFQdqbvVcUCmYRm1UJA0sHMzh/vt7mUwx8YTcRu7Mw4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239775; c=relaxed/simple;
	bh=+0esf4PKuDbD6pVNFtzoxcojgN/+ZfEr2+qB5q3FpXk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cOFYTqiC7yRIiwkWeN/JayS4S1aTxJmuJtE51Sf7g54yN5z3F5r+VnioCmGYWQ4gbi6vHZLaVzf3koEJMoW+PFm2yXOLfYDd9tVTNqbgtuhDlr2TgSIaf+GsPGc3RRedwgHeIB3mylScXidLx7XW2Ml4x+WnyDoO7EXOK5nCyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ4nNAtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFBDC4CEE3;
	Mon, 17 Mar 2025 19:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742239775;
	bh=+0esf4PKuDbD6pVNFtzoxcojgN/+ZfEr2+qB5q3FpXk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WQ4nNAtXRKVbC9ZZ2PjUIak6rmDBqyWa9p2gUMNhqfJ+A5BCgSipAtYz5LcMtvEMo
	 nC9ZF9vYzSqJ1kYy6EYDOvvn+/RrEMR5hWCcP2tFAUxQXgadU07KqAlIliV23Hm0dO
	 B1XYJ9ZhLDgG5qzRAnLjfgnCvJd47fXDTGMx5moBIBSmiW48tyZLiRi+Eyya6nxzPx
	 hzg8ldrCcbODT6DIT5q+Hc9f2a9vq8QAyethP0xuL8bSy7Nk+GWCip0m5FEEwqALQf
	 uL0jsJbC2+RkQQxu359Wf66BV/Grqx7FQBaVPJ7wyi12czxBKdvi2bklgD1bU8ZDRA
	 /E5xymSnT17xw==
Date: Mon, 17 Mar 2025 14:29:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jic23@kernel.org, tduszyns@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Sergio Perez <sergio@pereznus.es>
In-Reply-To: <20250317175621.593-1-sergio@pereznus.es>
References: <20250317175621.593-1-sergio@pereznus.es>
Message-Id: <174223977381.441039.14907108652302034941.robh@kernel.org>
Subject: Re: [PATCH] [v2] iio: light: bh1750: Add hardware reset support
 via GPIO


On Mon, 17 Mar 2025 18:56:21 +0100, Sergio Perez wrote:
> Some BH1750 sensors require a hardware reset before they can be
> detected on the I2C bus. This patch adds support for an optional
> reset GPIO that can be specified in the device tree.
> 
> The reset sequence pulls the GPIO low and then high before
> initializing the sensor, which enables proper detection with
> tools like i2cdetect.
> 
> Signed-off-by: Sergio Perez <sergio@pereznus.es>
> ---
>  .../devicetree/bindings/iio/light/bh1750.yaml |  7 +++++-
>  drivers/iio/light/bh1750.c                    | 24 ++++++++++++++++++-
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/light/bh1750.yaml:50:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/light/bh1750.example.dts:25.38-39 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/light/bh1750.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1522: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250317175621.593-1-sergio@pereznus.es

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


