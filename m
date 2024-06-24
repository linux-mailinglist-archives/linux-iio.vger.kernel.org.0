Return-Path: <linux-iio+bounces-6861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFC915A62
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 01:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370AD284CD4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2521A2C17;
	Mon, 24 Jun 2024 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLHODb/E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880D1A0731;
	Mon, 24 Jun 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271684; cv=none; b=T2uNWopw/VFrtyVIU2HLdwOvNq/UoSwCo1S41Vy5vM3neyyOAwo0Ff5p2sSHUF+vD4Ja+fjKa5ZA2ccgUckXSXUCBEpZJJ5vFSu8fE0sZAWvUni1tvE2P6DYmXCikmGN1UDgDU07qzP04dLjOo3Si6+cG0G5XGmJ4V/p6dEWQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271684; c=relaxed/simple;
	bh=xNxO4J+rVkZVl73erQQXo/4Ljf1gi+GV0ARmHcEM6s8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Cm4X+V+E7TMcaGsA3pRdg4vCHY3k5ucXy5ZU6US+QgHlW3BZ3ILAmc2HiZCsLpGUjrVGnV7OyPncPh+9/vr8GFIxCWIiDx8bot/rC7Z1UqPYS7HruehbrbMelGB9b7WbmcVLPptO5JtI0dsjqz0wJ8Y42nlHG6j555bR2ETlZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLHODb/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250C6C2BBFC;
	Mon, 24 Jun 2024 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719271684;
	bh=xNxO4J+rVkZVl73erQQXo/4Ljf1gi+GV0ARmHcEM6s8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nLHODb/Ei5wCYkdsZB+9cur3yZh/KxbyIXgAoDeLIqKI2IJvf/Rzol1EkHhLrqEDs
	 d6uJim/FvGXXKxM0yyln0uE0eIT6ArypZxb3XQ4UyS5MIJPYvUvSf2/P4F+POHjJ19
	 l2slEA+nyjzcaa0Fk9AZJ/I7R2O0TR1E7oTYllDXd00r1yY68459Nf8MHXSnO2qt2r
	 Hv0Keeyg0s8SHzmzyD3xnt2ly2vtI7kmq33spv4/PA61eet/WiJ5sYSmpOocvzV0aD
	 OP2cKh/7liPl/FD6cforqYlOU1KvBR+xv1XGlxzMYpgmOC0otyKanvEl161l92TbU8
	 yGbb0w7DwbA0w==
Date: Mon, 24 Jun 2024 17:28:02 -0600
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
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240624-iio-adc-ad4695-v3-1-a22c302f06bf@baylibre.com>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
 <20240624-iio-adc-ad4695-v3-1-a22c302f06bf@baylibre.com>
Message-Id: <171927168292.812030.284414420636530087.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add AD4695 and similar
 ADCs


On Mon, 24 Jun 2024 17:01:53 -0500, David Lechner wrote:
> Add device tree bindings for AD4695 and similar ADCs.
> 
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240624-iio-adc-ad4695-v3-1-a22c302f06bf@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


