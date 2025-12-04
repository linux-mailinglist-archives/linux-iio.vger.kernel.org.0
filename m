Return-Path: <linux-iio+bounces-26774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9472CA57F0
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 22:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571413151474
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A503064AF;
	Thu,  4 Dec 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8xcR65A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397E275AFF;
	Thu,  4 Dec 2025 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884032; cv=none; b=mR5jjRw8NrJTf7k6y69QWdjZZJ/x62ygcH1FH9Sw86tMfFjcSBA+8stpy0DMm1zl39SbqJe+4WFGUCM6+lZnPeTatWKBV/Ae2JvYBWhA1qNPZ4eQ9LVt/3iXLllRw9uk8sC8Xa3kc/f1zljDxaTslnxlrTU/45kdB2R6/ItvcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884032; c=relaxed/simple;
	bh=ZllcKEFsuf2MwVYL4v/IYtcLUBaudASfSmPEepm6+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1riAaAW/oXKSZ5ttr7mNl5f30s3RB7hbE3auP+zAMHkz0KJt/qT7oZ4nZr4E1Grb39SfPWT7iaht/G93PiSIAw+UkqKroQs/7BWbDWMIROfYVyen2st7+L6WNQZvZ1i5ZoHyvHMBSjycYMweYf/E41wRUK6qAKJSIc8pDxF+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8xcR65A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6C3C113D0;
	Thu,  4 Dec 2025 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764884031;
	bh=ZllcKEFsuf2MwVYL4v/IYtcLUBaudASfSmPEepm6+M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8xcR65Ar5f4w3cpSYVX11nTV4PRsyakkWc01N2st/Ok1ftQ3RngdwqMd6nC+Vw/4
	 ocRpGnGZNTr8KCxM5ES0LH6hgBM+sDvqeFVff9kqPHpyu1s1NCzG63nvMebjdJLKxF
	 N85S7Tn02PyXvfWoFrsYUs3so/E1BDNiTfElOLoAoqtpVxedRQ4c+jpM5UWLCdLCEl
	 4su4nL+1B0glGbCRNjxwPWeLhr/XKNRoWBNKlK9b44UAhWMtVc6Bh2jer9yLla5wbZ
	 +K7BldJ1VzSN85pgnNSC5JGaazTWcVfqX+MLm2dF84GPrWVYVUrcJXvrvSCBA6xnK4
	 2KdwYyonmfGrA==
Date: Thu, 4 Dec 2025 15:33:48 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes
 property
Message-ID: <20251204213348.GA2198382-robh@kernel.org>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>

On Mon, Dec 01, 2025 at 08:20:45PM -0600, David Lechner wrote:
> Add data-lanes property to specify the number of data lanes used on the
> ad463x chips that support reading two samples at the same time using
> two data lanes with a capable SPI controller.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v3 changes: new patch
> 
> I added this one to give a real-world use case where spi-rx-bus-width
> was not sufficient to fully describe the hardware configuration.
> 
> spi-rx-bus-width = <4>; alone could be be interpreted as either:
> 
> +--------------+    +----------+
> | SPI          |    | AD4630   |
> | Controller   |    | ADC      |
> |              |    |          |
> |        SDIA0 |<---| SDOA0    |
> |        SDIA1 |<---| SDOA1    |
> |        SDIA2 |<---| SDOA2    |
> |        SDIA3 |<---| SDOA3    |
> |              |    |          |
> |        SDIB0 |x   | SDOB0    |
> |        SDIB1 |x   | SDOB1    |
> |        SDIB2 |x   | SDOB2    |
> |        SDIB3 |x   | SDOB3    |
> |              |    |          |
> +--------------+     +---------+
> 
> or
> 
> +--------------+    +----------+
> | SPI          |    | AD4630   |
> | Controller   |    | ADC      |
> |              |    |          |
> |        SDIA0 |<---| SDOA0    |
> |        SDIA1 |<---| SDOA1    |
> |        SDIA2 |x   | SDOA2    |
> |        SDIA3 |x   | SDOA3    |
> |              |    |          |
> |        SDIB0 |<---| SDOB0    |
> |        SDIB1 |<---| SDOB1    |
> |        SDIB2 |x   | SDOB2    |
> |        SDIB3 |x   | SDOB3    |
> |              |    |          |
> +--------------+     +---------+
> 
> Now, with data-lanes having a default value of [0] (inherited from
> spi-peripheral-props.yaml), specifying:
> 
>     spi-rx-bus-width = <4>;
> 
> is unambiguously the first case and the example given in the binding
> documentation is the second case:
> 
>     spi-rx-bus-width = <2>;
>     data-lanes = <0>, <1>;

I just reviewed this and all, but what if you just did:

spi-rx-bus-width = <2>, <2>;

So *-bus-width becomes equal to the number of serializers/channels.

Rob

