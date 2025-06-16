Return-Path: <linux-iio+bounces-20695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE0ADA934
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FE33B2F6E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E806213E74;
	Mon, 16 Jun 2025 07:19:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF3213253;
	Mon, 16 Jun 2025 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058350; cv=none; b=Dp/c3wl5e4oIzbuZHCrExOxDtBZzTCAjjlSLD3XxktjyqW+obskF71IQ+r6ofCdIEsIYJ/bPIrdtiyYNWzOddrRdqfYs2hH/lLYUIGvdm+U+Ckd8oL2+aq54pRsuSe1eeZNmbaGRu7HGtYjJiG3rHf5gJdI2Uu92buB+9cFAwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058350; c=relaxed/simple;
	bh=HCEeuBoMJX3BeblVDJWQwUppkrlBt+Ukq0N7DadV344=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVxeHsdtFr8EJXOmaQ1IYN63AaMb0p09DQPQbOkFkp6+trjoOIIKSDgDpGjqz78zP9VJSTR53hR+PPOtL0VT2eT+dOfWj/BA0ZmmC0HVS2EKBdwJJ1l0YmmZJ7drpIYwsgK9qX/gryCn8CyT06MPnm8/mztqZZzR6xOQ/RmLW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D623CC4CEF3;
	Mon, 16 Jun 2025 07:19:09 +0000 (UTC)
Date: Mon, 16 Jun 2025 09:19:07 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: iio: adc: ti,adc128s052: Add adc08c
 and adc10c family
Message-ID: <20250616-wandering-blazing-pug-ea09cc@kuoka>
References: <20250614091504.575685-1-sbellary@baylibre.com>
 <20250614091504.575685-2-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614091504.575685-2-sbellary@baylibre.com>

On Sat, Jun 14, 2025 at 02:15:00AM GMT, Sukrut Bellary wrote:
> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB bits

You have checkpatch warnings.

My ACK was given with conditional - PASSING checkpatch.

Does it pass? No. Don't add tags if you do not fulfill the criteria.

Drop the tag.

Best regards,
Krzysztof


