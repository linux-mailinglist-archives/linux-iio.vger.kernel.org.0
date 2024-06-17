Return-Path: <linux-iio+bounces-6431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E190BCF1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805B5B222E8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2216190685;
	Mon, 17 Jun 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0tAakol"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C0163A97;
	Mon, 17 Jun 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659825; cv=none; b=NUEs49NPO3BuEa9FUb/Ooux4wObAI+nZvi/Esjb/x+cDG96op3X+PdN4qpispf9XXNmJV0wTMNeVuxAgSqJN7Mr+G7zoVDl4GavIUonnQk1rd61A6Bz4yG6g3riNl9erV0EgepTonUvrMqewMuQWrz8WXuOxOa1UxRQm9BtYG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659825; c=relaxed/simple;
	bh=j1KCV27yNbGjdb+9lMBc1aIP5sKVrx02spTkpZzT0nU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bn/CA5nPDvWRWaegdNA1pnwSjviF6u9yQ81VHKPVyJO9HfXOs5Vh9p/1EJRSlISFjYHlFrZfX5rxFnObDIppcpCB8FXldl46d29tESGOw41RAK+XcCZayogM6wodAiuQI7wGpPhcQ6F2z/FFwa8wDjk2B61Bgp0Pc3NdcH2xF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0tAakol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C537C2BD10;
	Mon, 17 Jun 2024 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718659825;
	bh=j1KCV27yNbGjdb+9lMBc1aIP5sKVrx02spTkpZzT0nU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=E0tAakolevv8B09S6xnSohGo99lveg4RVPsDyvInPbJafmUFtuP37HWer+dIQSfwn
	 sCa9IYwMO1faH+xNDXVRryfz1cHKK6ltxp4kGK8IejizgYEWHxNGUXEQwRXZyMIMNE
	 /QH8i1jZSVvEZ4gD3nJXekOkE6U05P1/8LQacOPRTPUrJduVhYbafQC3Njg6oR0BSq
	 HtIjidgJiWBy8zEGflbHo0A9ZD/rbQXtZmThydXRvqClsC6UTDGJPhOd8CFsFhDPRQ
	 mFryI4ZKyTfy8zUJGHbPB60HDI2BhmOqPgG5FvoCrRhWsTQa/VIGGXElLd1U0lWev8
	 3CLN4VlcDAH2A==
Date: Mon, 17 Jun 2024 15:30:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
In-Reply-To: <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
 <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
Message-Id: <171865982439.3455065.3692466445202658610.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar
 ADCs


On Mon, 17 Jun 2024 14:53:13 -0500, David Lechner wrote:
> Add device tree bindings for AD4695 and similar ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v2 changes:
> * Drop *-wlcsp compatible strings
> * Don't use fallback compatible strings
> * Reword supply descriptions
> * Use standard channel properties instead of adi,pin-pairing
> * Fix unnecessary | character
> * Fix missing blank line
> * Add header file with common mode channel macros
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 290 +++++++++++++++++++++
>  MAINTAINERS                                        |  10 +
>  include/dt-bindings/iio/adi,ad4695.h               |   9 +
>  3 files changed, 309 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: single-channel: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: common-mode-channel: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


