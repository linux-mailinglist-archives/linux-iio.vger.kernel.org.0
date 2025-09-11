Return-Path: <linux-iio+bounces-23974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5FB52A18
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EC3A03472
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20609274B34;
	Thu, 11 Sep 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flEj1GdX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D226F293;
	Thu, 11 Sep 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576008; cv=none; b=mZFndJwktg3dWTJROCsZcg59XTihEe+Fw+WW0To0sxlBHB59H5bw+aYmXbU7yNd6VXJNp9b0CxYHos6h62BQE71ZFYwSWJgd3QO/uZMONxlHAnu8d709OyEJtqZihkPP0DnPJ9HW0p/5be5ZIKVBvHVj8xdlP3lHFcB0DeOZNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576008; c=relaxed/simple;
	bh=sJlfH9iG87sCpb8Em6OmvGYJXQ18mv64cBfa2QsEh/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC/13cW/1aNceaoJHVakjmqud9soJJTTYxuF54n2oZMBVaJooowXF0c10U0U7NS1cBAXnQ7xra1MNmU+EhvRNp5xQ/KZyAooPHAcpJxLLRWx4J0ajqUY+gDW5wJiZMPctl1KYh7QBPozFY8gVNpAYQ+eNE0uY1Rzx7IfZXjo3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flEj1GdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB99C4CEF1;
	Thu, 11 Sep 2025 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757576008;
	bh=sJlfH9iG87sCpb8Em6OmvGYJXQ18mv64cBfa2QsEh/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flEj1GdXao8QluR1Jflod3IokFSgD3nlWPHvD3YYypUkFd60tMIsb51hHrrLDyBnd
	 xAol/fkmCEqCLT1EXwZDOpoZVub8vYPWrcpiZScGppoUXxX3cEt0eaxRC0QlPznKWB
	 DeImhzeNnp+ZS845dpoFoBgnw3dMSUPZM3Z2hUPBOj1vXOo+8231l7lSh3dxZrtgXd
	 HQp5HTgS/jhxeEd6HZHb0CYF7L9IbVkNInClXs5q4kTS6CFQIzaGtQCncYC100LJ5O
	 ZmJUvsQoL4MT4OxZnhcloTb/NGjMoaiKGfw8XBQzf3XfkHUxmCKO0zKcF9ENuCRv/t
	 /VSZkAHfuzBtA==
Date: Thu, 11 Sep 2025 09:33:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: iio: accel: bosch,bma220 change
 irq type
Message-ID: <20250911-nostalgic-sturdy-markhor-57f87f@kuoka>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-3-e23f4f2b9745@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250910-bma220_improvements-v2-3-e23f4f2b9745@subdimension.ro>

On Wed, Sep 10, 2025 at 10:57:08AM +0300, Petre Rodan wrote:
> Set the interrupt type to rising edge instead of high level.
>=20
> Quoting from the datasheet:
>=20
>  "If at least one of the configured conditions applies, an interrupt
>  (logic =E2=80=981=E2=80=99) is issued through the INT pin of the sensor."

I don't see how this explains/suggests raising edge.

>=20
> The old code did not request an irq line via devm_request_threaded_irq()
> so there is no backward compatibility that would be affected by this
> change.

This sentence is irrelevant. You are changing only example, which has
zero impact.

Rewrite the subject and commit msg to accurately say this - it is only
example - because now you suggest you actually change something...

Best regards,
Krzysztof


