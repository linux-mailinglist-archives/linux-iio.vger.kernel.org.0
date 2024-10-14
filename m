Return-Path: <linux-iio+bounces-10566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60ED99CBA5
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B041F22AD4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0471AA78D;
	Mon, 14 Oct 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VakXqqcw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0341514CB;
	Mon, 14 Oct 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913106; cv=none; b=uiVHZQwDWXWUDcX4NZXPrJ+5NPFfbGeAjaVC+vlnwCWdqaNvoTDThGKdTPSJZKMHfj0v4ALfVQWDYhZo3d/uu83dV+uiorDjg9CeurpIXEyD+Rd6HSWDw+lgX5s9IAdksG3SX06qY8+ts8uNXIawjicgwpB+we6o85YULprC0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913106; c=relaxed/simple;
	bh=N5ToRTKkWXT8UZrQRbSXfQQT/rH/3H43OU/TiFRwPZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWzL3WpZFc6fYbJtAC9aJK1SWkV64Rdfcx8e7affFW1snnmysv5pi+zg4emjqxyY3zGlYtU7AaWyMOEtNxUyGQvdhHJ2wS9+vWczEpKsfsgDJkt2ypcE6KsnwxqOoScWfbVgbkYlBFhfFV6OxPlN2ZV9ix7yUmmWZcESWx2k7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VakXqqcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7ECC4CEC3;
	Mon, 14 Oct 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728913106;
	bh=N5ToRTKkWXT8UZrQRbSXfQQT/rH/3H43OU/TiFRwPZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VakXqqcwPdaIb9N3fpXgyL4phFi/uZaK+UjgJzF8PfOMBQL5oxNL/R46nRo8JkG3N
	 +LWf7SEDgzwsaVBb2WZ7PBb54UsBo8xy6JHZpP2b3LYo9BdoUzzhbtnLXnw2Ll9FWU
	 10w8iKbJwUGMoYNriZAUX9RQegAm0srkQFLEy+aUwtDiwH8VSyDxw+348ZgfQ3o1Z+
	 o2XtOJbCnXUebgSSWPCJYsIfHvevbMsFyXXmSybOF72mee4xy5wyjxGd/qDSTrgq1Z
	 bLopB7aEzNkTSaQPgOiDbf4pmuIeOuO8DfwzA/Gw//0NQzqqjWvGrXopAiQ1/ug3h6
	 l/0TZ8b08qV5A==
Date: Mon, 14 Oct 2024 08:38:23 -0500
From: Rob Herring <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: linux-iio@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <20241014133823.GA1018400-robh@kernel.org>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
 <172890486251.793259.16216468875581353928.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172890486251.793259.16216468875581353928.robh@kernel.org>

On Mon, Oct 14, 2024 at 06:21:02AM -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 14 Oct 2024 12:08:08 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add a new compatible and related bindigns for the fpga-based
> > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > 
> > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > mainly to reach high speed transfer rates using a QSPI DDR
> > (dobule-data-rate) interface.
> > 
> > The ad3552r device is defined as a child of the AXI DAC, that in
> > this case is acting as an SPI controller.
> > 
> > Note, #io-backend is present because it is possible (in theory anyway)
> > to use a separate controller for the control path than that used
> > for the datapath.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
> 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#

This is at least the third time this issue has been reported. Don't send 
more versions until you fix it.

Rob

