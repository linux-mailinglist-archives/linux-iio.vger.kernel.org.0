Return-Path: <linux-iio+bounces-7509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230F92F055
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586F51C21CF8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C419E82B;
	Thu, 11 Jul 2024 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM1ehqaI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999371B51;
	Thu, 11 Jul 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729969; cv=none; b=UeFQn2m8NWtOEueL5+bUl/14hDV8F04/8ZaLhljIAjmYCQFuHy6j+lKh7+0+rQithXOw6ukzC1tJwbSxJJgoe9PHF68BHK6SnJq44mVH6Troh2IhdSzo9Jn9A44jbKhN2AS81XnjdxFDXRMkLAD0jrjj4apUe16QShD9FGflEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729969; c=relaxed/simple;
	bh=Bfi0xFDAdZFAiE6w3WjlXCIy3ZKkk/pUFo1x5TCS4E8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oQY/NQ5DWt9fkxweIKA+58JflvOxe8ILOIgvqSTBKzO1yZ+wMqmd6yC8nQBD9tEh7fPU8za39dIgE7hSVNSYRgC8GUXIQDrqM3St3klIHxnz3s/V0jVXUu+RaId+iAlZ0lr4gB2wwGC3PLhSC9hE4ZMnwuOrB/SWmBY4CeuCzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM1ehqaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEB8C116B1;
	Thu, 11 Jul 2024 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720729968;
	bh=Bfi0xFDAdZFAiE6w3WjlXCIy3ZKkk/pUFo1x5TCS4E8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WM1ehqaIpRfhHRpE3w+gqtQdSy3PLBJJdwXf3TTpQmK0OrumdmSHCf3gItr4ODIu4
	 0+C5n/5QnsYHcPT8R6kB1SYvJjKyu0pQXpjT6JGKNA5pd3WPXHyf9KRC897JvFPYBu
	 6Vs9M5B0gcmECSwye9QtGiK1YC86jr7/mPVJoVS/8WPNkFVlT0Wa/tZsN1bgzgizd7
	 ue7VimVbd5zDby6mdrwh5V8CtdWjf+/jUgnqxQoEKRgJCNOUOe5pmnJmuhMBzf/9Eb
	 T1XrbrUhHftPi2H4yWhYR/OixMk9tQgWjc9C8DBInJGeKLiaCqZafwEfVV0lvpeZhY
	 8evIpWTlFjBuA==
Date: Thu, 11 Jul 2024 14:32:47 -0600
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
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-doc@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>
In-Reply-To: <20240711-iio-adc-ad4695-v4-1-c31621113b57@baylibre.com>
References: <20240711-iio-adc-ad4695-v4-0-c31621113b57@baylibre.com>
 <20240711-iio-adc-ad4695-v4-1-c31621113b57@baylibre.com>
Message-Id: <172072996727.2951364.2243340017408650155.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: add AD4695 and similar
 ADCs


On Thu, 11 Jul 2024 14:15:41 -0500, David Lechner wrote:
> Add device tree bindings for AD4695 and similar ADCs.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> Note, this may trigger a DT build warning "common-mode-channel: missing
> type definition" if the builder doesn't include the recently added
> common-mode-channel property [1]. This should be safe to ignore (passes
> make dt_binding_check locally).
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=d86deaec1c5b0fb60c3619e8d2ae7a1d722fd2ad
> 
> v4 changes:
> * Picked up Conor's reviewed-by tag.
> 
> v3 changes:
> * Change interrupts to be per pin instead of per signal.
> * Drop diff-channels and single-channel properties.
> * Odd numbered pins added to common-mode-channel property enum.
> * REFGND and COM values changes to avoid confusion with pin numbers.
> * Add inX-supply properties for odd numbed input pins.
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
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 256 +++++++++++++++++++++
>  MAINTAINERS                                        |  10 +
>  include/dt-bindings/iio/adi,ad4695.h               |   9 +
>  3 files changed, 275 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: common-mode-channel: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240711-iio-adc-ad4695-v4-1-c31621113b57@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


