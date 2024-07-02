Return-Path: <linux-iio+bounces-7141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AC9241E4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38E11F253FF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF071BB6A0;
	Tue,  2 Jul 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYR4p705"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331DC1BB68D;
	Tue,  2 Jul 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932890; cv=none; b=PyYSHxeFvFJl8SLEHHeH0a5gSUdZDC/3PZ6SjBO8olyB7xGNQZp1kT7HQ0hIQnNsoM7N+Ysh3LHimwV/VmSKcWBRyoEwpgPM26gy/YsZKiJ7wRaOv3dQgiWwM7Bijug78MN+WiTV2CurHQ/AMLQdv1Q/2AoH0YBhFKR8JudyV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932890; c=relaxed/simple;
	bh=2BEp/xQFjVsQI+IPcKnwBwcUgI78+VSrXnR8I30AQRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2TWKuGW15hE7l34TspJ/AoCZkpktn6Ojyx19+eYwzBgjl6X+juL2XGhYQ3RKQvGJM/CTLotULDJMhrdxnIRJYA0uBQCn5JnMik1YsPvLe3Kh1N3KBZ+d+fgomMzSqqSXaZtzAoosGrWtmPxDC2/8O6JrmjBPp8PM1iZ5LjO4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYR4p705; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E29BC116B1;
	Tue,  2 Jul 2024 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932890;
	bh=2BEp/xQFjVsQI+IPcKnwBwcUgI78+VSrXnR8I30AQRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYR4p705kYM2wGDu+juLlWEn74qpeY2oekLMWvilK/+/xXNCrJxLm27UUcEBv3l4S
	 LLRX/iQNiOA5HPft4IL71kjrRJqUAVyT+unzf+3sjaulrkWLgiicjtomh4daqmQJjG
	 qSX5123JDAMEXaV6fUXaaa628HpzqxLepPL3EGTIfljErvGR7Mzxbtgd0RQ9m2NkVl
	 GqtyembOpx6F6zAwFoNTU6ks5Mry+xXCND0LWx+19E0psMCpZyqefq27JCckeRjw8o
	 SfNMlah9tM4hWeAldbTfwnR5Zt5o25/jN4jE3E4WMkHAAYlkWTvhuR/cCfkRN03+K8
	 XrMgSmAmlhadw==
Date: Tue, 2 Jul 2024 16:08:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v5 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240702-septic-cake-f839ff7048a9@spud>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
 <20240702030025.57078-5-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yPz5+S6+ASY1g/ES"
Content-Disposition: inline
In-Reply-To: <20240702030025.57078-5-kimseer.paller@analog.com>


--yPz5+S6+ASY1g/ES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2024 at 11:00:23AM +0800, Kim Seer Paller wrote:
> +  adi,manual-span-operation-config:
> +    description:
> +      This property must mimic the MSPAN pin configurations. By tying the MSPAN
> +      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range can be
> +      hardware-configured with different mid-scale or zero-scale reset options.
> +      The hardware configuration is latched during power on reset for proper
> +      operation.
> +        0 - MPS2=GND, MPS1=GND, MSP0=GND (+-10V, reset to 0V)
> +        1 - MPS2=GND, MPS1=GND, MSP0=VCC (+-5V, reset to 0V)
> +        2 - MPS2=GND, MPS1=VCC, MSP0=GND (+-2.5V, reset to 0V)
> +        3 - MPS2=GND, MPS1=VCC, MSP0=VCC (0V to 10, reset to 0V)
> +        4 - MPS2=VCC, MPS1=GND, MSP0=GND (0V to 10V, reset to 5V)
> +        5 - MPS2=VCC, MPS1=GND, MSP0=VCC (0V to 5V, reset to 0V)
> +        6 - MPS2=VCC, MPS1=VCC, MSP0=GND (0V to 5V, reset to 2.5V)
> +        7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (0V to 5V, reset to 0V, enables SoftSpan)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +    default: 7

I still don't like this property, but I still don't really understand
some of the iteraction between it and the output ranges and cannot
suggest anything better, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--yPz5+S6+ASY1g/ES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQX1AAKCRB4tDGHoIJi
0nWUAP9UyDAtocaLuOOrPmRL9kXLexDGODjjOxKb3odePf5Q5wD/fZFn5DoyuHvg
s8cbkMbQfoyl0EOoxt5wVh5DaKqTcg0=
=ZhuX
-----END PGP SIGNATURE-----

--yPz5+S6+ASY1g/ES--

