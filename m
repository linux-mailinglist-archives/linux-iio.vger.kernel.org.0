Return-Path: <linux-iio+bounces-26086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEADC441E9
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DADCF4E6784
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8B2FFF98;
	Sun,  9 Nov 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNfY/x07"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBDDF59;
	Sun,  9 Nov 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704409; cv=none; b=HbHHn38/wEisaedaHzDC9/B005sFqedn6/HQ1kOjVMAy3VdiQziBgX9VDrTyHAk/xtgNA+gkpAMcZV8Y89ZPzsbQHEdNsrWjcIDc3Ve/sil4X/iHW5wfDWRXtJsnIPDhvS7O4mJW0cNrT+YQ+VG3YWdJJZya2ub4C6ZLcdpETww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704409; c=relaxed/simple;
	bh=gcn7BAdpLSA8lZBC0V0AtycAh/9rpUNW4E8Lh45i3O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEol7k3F+dHZjYa39/4TaM062k+d4KUf1DYSNbOAl0yZoRGDYx0RRTH/EN/5QiO8cVd7gcnHDzh1tbKtZJw2Onq3KWT3XUu0UbttBAfpYRrV+qMZXoSvdptkGa9ZAggRjaq6FyMwbT9V4FhG0Tm7WIDWeBnEy0s6Y5ZbaN7D19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNfY/x07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A745CC116B1;
	Sun,  9 Nov 2025 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704407;
	bh=gcn7BAdpLSA8lZBC0V0AtycAh/9rpUNW4E8Lh45i3O8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNfY/x07zDR1HerxX+HARlWm+gsM4F2ReBFytS40gZURjhFbJTq+NsY85z79IaPhT
	 ZvEgGH211M52qreYTTD9dXXzeatYAgcOr3vTouBzOARLU3nOst1dW64nnSVn3cC/NM
	 G/4LoPHTDCE2qjPpqn9fnDte5AXKT2sIXX7a6PXkQN+qbJVC/E1W305dXWjdfaEKMn
	 zKCzNna1+/JWtSwiDe8/TlWZK9mxT9b7diluyYQzeswY7e9q6PIppqlgsdi0WzxpkQ
	 UZH9JZq+VMNsEh7dxEIUaUXtEbdQI8ZX2AlPyNAWbR9F0H6XMfTvPbFWy2rXifBxF4
	 IeJYF4bR5D+cg==
Date: Sun, 9 Nov 2025 16:06:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 05/12] iio: dac: ad5446: Move to single chip_info
 structures
Message-ID: <20251109160641.360e376a@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-5-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-5-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:10 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Do not use an array with an enum id kind of thing. Use the more
> maintainable chip_info variable per chip.
>=20
> Adapt the probe functions to use the proper helpers (for SPI and I2c).
> Note that in a following patch we'll also add the chip_info variables to
> the of_device_id tables. Hence already use the helpers that internally use
> device_get_match_data().
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

