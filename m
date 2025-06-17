Return-Path: <linux-iio+bounces-20736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F00ADC5AA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09251897D2E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA76290BC6;
	Tue, 17 Jun 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNKLrWUy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E32156CA;
	Tue, 17 Jun 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151173; cv=none; b=aDx98A2Xk/DoYalCzx2qNUkO98K8Lb5MAkHu32JbKRkcw3yQ/ItStWvV1f9DZmpLGAT+olm2kkd+lF0US3Iz0kqdzhDk3RpzBCf+bzt43zGYCCexreCdI21oa3L3FFlZQIC/zBI3Lx5Jh/rbv4rBz1VhCbLcgNhwf/BXImB3wHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151173; c=relaxed/simple;
	bh=jZgOoYFpNvwzgzRt3ysPnLed5AmQcMwnqp+UrepIMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0y1fTVUtI7C4SIKDo8lFyY1x2gYYMnUcQs3MjvFdnfpOMZjwwYcGtfQHOGtJXs6m3Y/1T+0nxOVW0J8pz0EOi3z0u2rVX80Bo3LvoqeGf13uB0hUEd4p8yw10hshVBcHatSLftJ7stwt/VO8sC5bB3KSP0L335yRoJRt3Gqiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNKLrWUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDACC4CEE3;
	Tue, 17 Jun 2025 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750151171;
	bh=jZgOoYFpNvwzgzRt3ysPnLed5AmQcMwnqp+UrepIMDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNKLrWUy9kJXRbzPfLc9Dvk3y9Zp4eiu77yCQZarASu49VVh1oLA5pAIM0C3Aj+BG
	 5Gq75R3i4HEWNc+imFZteVmCCOu4QlLfMxxGUXPb/brqzs68v+11ZDtE0gU5jXbfVc
	 NBPTosA2R10QBdJ0adyzadIXTyunia8+sAO9kv8qyRDu7pkypfSMznDstgTEd5i6ut
	 U/gSU/3E+HMs477dGBrRFCJ7GlvtgNpSD3kTpdeSpswjz+WXbx4yaVj8viuW5CL8re
	 Aw+G7+ZkpCLeuQMtB3iB0Tm0cAQsadtVqY7Gj0e8t1lbpPNqAoWGdBTPdgxQo2LXkx
	 veBTwXAfjYhgg==
Date: Tue, 17 Jun 2025 11:06:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@axis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA
 PIR sensor
Message-ID: <20250617-vagabond-fulmar-of-penetration-dbe048@kuoka>
References: <cover.1749938844.git.waqar.hameed@axis.com>
 <e2b1b56fbee07047f3fb549f17257dc3764af395.1749938844.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2b1b56fbee07047f3fb549f17257dc3764af395.1749938844.git.waqar.hameed@axis.com>

On Sun, Jun 15, 2025 at 12:14:02AM GMT, Waqar Hameed wrote:
> +examples:
> +  - |
> +    proximity {
> +        compatible = "nicera,d3323aa";
> +        vdd-supply = <&regulator_3v3>;
> +        vout-clk-gpios = <&gpio 78 0>;
> +        data-gpios = <&gpio 76 0>;

Same comment as before.

> +    };
> +...
> -- 
> 2.39.5
> 

