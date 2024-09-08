Return-Path: <linux-iio+bounces-9322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6011970720
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1E91C21084
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47077158544;
	Sun,  8 Sep 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIZVs9Qj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA1531FB;
	Sun,  8 Sep 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796420; cv=none; b=TxwvoNVMre74wl/Dpt76X+9ZXoK+4AcEGKXQpiH9Em6dEmHGAwyjzug2M9z/7THKRK/NCHw5wtCrkraENk8WWwO+ldBbK+nT8/XfZT/aSbsXEdq2fJXHuv/8hHgxnK+d9hwkcT3Z/3R+KQMTJZ+U1NB7vcj8+Gsd0Ffc+LtkQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796420; c=relaxed/simple;
	bh=6PQro7lkkmhCaUG2D8bXb/ekxm5r5FI3lEV4/QMlhKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4MSHrw8gc2An7xfry1ZyimlD/cHb//HTgXScQKbZN5myiWLq7D6bo1vYQWkF/8MIoTNZ43krYvml9BzTQ8JQ0PZzd9z2hZCjQ9gUdDnO/wVYIkkeohX/uRIh0Ee66367eZVNyjPgJ+E6C3EjTb2dQS36CUL7FmYqHmH97JaWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIZVs9Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240C5C4CEC3;
	Sun,  8 Sep 2024 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725796419;
	bh=6PQro7lkkmhCaUG2D8bXb/ekxm5r5FI3lEV4/QMlhKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIZVs9QjWzVYXetiKOTpgGcPW3sWxhletb3He0igtZyu5MsGvf5gBr/yvnDCYoa7B
	 uX75aBTQz33M1SeszYhfhMvQrZOO+HuMILrbLI+kKF02Pskt1FhEXRxBXRdhO2h+y7
	 mXs2bSFMT3hcIW+e/cW/my4zEP2Zzmaqnv90qtA0yUiAB7jm/Hgm7VXCrCO1Jg3moT
	 KneMSdUBbNdHpIwS6TzNDMm1o1abzgCfrZZJoj30U4j8wr5XT5aeoObzB7ZJ1AWpVF
	 FpEAcLal6rf5EU5bDImpTQ7Jy5DeHxhn4xiXCR2cUVVSfFDpSgWXtiMdjfx3NQV2PJ
	 m4jWwzUIlrupg==
Date: Sun, 8 Sep 2024 12:53:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Message-ID: <20240908125328.004d6ff3@jic23-huawei>
In-Reply-To: <20240904-ad7625_r1-v4-1-78bc7dfb2b35@baylibre.com>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
	<20240904-ad7625_r1-v4-1-78bc7dfb2b35@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Sep 2024 15:14:18 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add a binding specification for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961 ADCs.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Just one minor thing inline. I think the description of the gpios
is currently 'backwards'.

> +
> +  en0-gpios:
> +    description:
> +      Configurable EN0 pin.

Normally when we say a pin is configurable we mean the driver gets
to change what it means. Here there is no bus over which to configure it.
So this is a way of configuring what the device is doing.
EN0 pin used to configure XYZ..




