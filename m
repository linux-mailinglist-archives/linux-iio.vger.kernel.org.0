Return-Path: <linux-iio+bounces-23699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F396FB436CE
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44D95833A3
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F22EE61B;
	Thu,  4 Sep 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlAflKCD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755A2EE286;
	Thu,  4 Sep 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977458; cv=none; b=dORYGXMCwaIXkTkrgp62/IIXvvg223xq0djxyYYwFgeVlqAnXIcDZTHhUcKPcZXe//1vERvaUdmwRhesbESJ6Q9rHTJ7UX6iqkdjTd6eQuhhW8/HBrDG1rn9z+gbVxaGFnqsHZQ4pZOC2n+69/2WvZxc72E54qhLfNmV6OYjyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977458; c=relaxed/simple;
	bh=0MmnVzpzU6gWyC/cUdsfoXzqPUDCX7NyIifVAJ0azTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6SpWcH8okzwXoNESLACpIslvKdCA9ocZD6PFVy3LgGz5hLEOql/4kByGl0YVgZ9dIuH6cFZZBTuVQ632PF1asu2HpHV3ESn5vOwt5QxNuLRupIVMbsoGsoyaQ+V97v6KKXWa0iEnbnguZRmOchYFwPOm9yHWcyHZtIMrClQw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlAflKCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8F8C4CEF0;
	Thu,  4 Sep 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977458;
	bh=0MmnVzpzU6gWyC/cUdsfoXzqPUDCX7NyIifVAJ0azTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlAflKCD6F+7Cd0lmVxfjA++Yh0k//cLYBSTZbn9qvmIbftU7fweSjYCeXlU5YIxj
	 pVKR/ZZzhLiLuHW6ZWjwwXmUsghslV33IDvPasQ5nzaeF70z6jlwenBFan44xblXPP
	 RMwLmwkuK/t5nyFnfSQzn/GaW3KQzobIcMo07+lkopCcasNBta51q9cnVh9NVQ8y3+
	 22T4ajyJYSqgKuobUgakXTuWYjdrP2VGKziF79z40Mw+v684KWhJMOdL/NuVGasZsZ
	 8yapBUWq4w0poU5rYwFRHxVBxjZTRTE4KjLk2Pf7dievHz4xlSrtZu+ju0srNmChfF
	 BXvePHgyyHEtg==
Date: Thu, 4 Sep 2025 11:17:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] dt-bindings: iio: afe: current-sense-amplifier: Add
 io-channel-cells
Message-ID: <20250904-tangible-practical-partridge-a1b0e4@kuoka>
References: <20250903113700.3079626-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903113700.3079626-1-primoz.fiser@norik.com>

On Wed, Sep 03, 2025 at 01:36:59PM +0200, Primoz Fiser wrote:
> The current-sense-amplifier is an IIO provider thus can be referenced by
> IIO consumers (via "io-channels" property in consumer device node). Such
> provider is required to describe number of cells used in phandle lookup
> with "io-channel-cells" property, otherwise the following kernel error
> is present:
> 
>   OF: /iio-hwmon: could not get #io-channel-cells for /current-sense

Also, how can I reproduce this error? Do you paste here real errors or
just some invented ones from some out of tree code (hint: such would not
be relevant).

> 
> Also fixes the following dtbs_check warning:
> 
>   current-sense: '#io-channel-cells' does not match any of the regexes:
>   'pinctrl-[0-9]+' from schema $id:
>   http://devicetree.org/schemas/iio/afe/current-sense-amplifier.yaml#

Best regards,
Krzysztof


