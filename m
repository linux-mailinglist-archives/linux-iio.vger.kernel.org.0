Return-Path: <linux-iio+bounces-10582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF299D734
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 21:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206E51F25038
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074241CACE3;
	Mon, 14 Oct 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skwhSlWZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A7153BF8;
	Mon, 14 Oct 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933611; cv=none; b=kgImQq5rwdlaPggy0mF2nQhUy/agc/AKL/50CqnehkgZajHD778eWHJd/tJ1WfG/NfGC1h/liGlWPAwYoc+Gk3uR1jKL+k3zM+Da7Cxv7rjosM1XtYmfUwQX8h8fcjjVWDseFFX4KSu5T3e8/Q1RajlzJ8sEubuDLc/8LgOJ9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933611; c=relaxed/simple;
	bh=oVBpnoWZAGBjYbX2F1GVhytUE4MjLwuvAicTWTgy63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwJSP5wkP4vVz48lf3QQrQvYy0tZhnmPa/dIJ4zWdObggtuYewFFAU8mZBECL1piS0XQhms4bCDBr0fviNsp56LwHkHk5TtScDjLnVgxbDSSYcS/pYRTEddRb5yyvcR/UiQh1dlN74BV6YtB0MPGK0N2Z6pdlC2DMZVHxpgtkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skwhSlWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC83C4CEC3;
	Mon, 14 Oct 2024 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933611;
	bh=oVBpnoWZAGBjYbX2F1GVhytUE4MjLwuvAicTWTgy63Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skwhSlWZ7tRV2WY/Msi8dUaf1pgssNhvS9xYtVBnpEpS94mEwNbKHSdKRYyptMt50
	 fck47SFiPiflQXcuYfO9IrbPLtcx+Q5LUKsJGnsCGj+owIpZZOrGXMC5r3iReQCQAw
	 a2OykhJvsHMaw8YLsaHepOr37+ssyAHD0OWRgwvWtTgQP31LVCNX2fkl12lcKYx8aw
	 rKcdiURhj+WOgYHRNSiAXXfgI49BmVcw08ErCH7SguibdUuplHSUsdYieQk/DD6QRV
	 1OXpNHDDnVleqK8f3jHgisb/2Qq/vFrjL8+RWjeR3tmbgsedz1/GJJhO2BlKfOZCLt
	 brp65uFO6xz9A==
Date: Mon, 14 Oct 2024 20:20:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org, Olivier Moysan
 <olivier.moysan@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <20241014202000.0654a1bd@jic23-huawei>
In-Reply-To: <r2gmorclmtcrykws4sd7l3hkjzg6f72vbh7ulh3ml2jsnev35z@on2stvxr36qm>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
	<172890486251.793259.16216468875581353928.robh@kernel.org>
	<20241014133823.GA1018400-robh@kernel.org>
	<r2gmorclmtcrykws4sd7l3hkjzg6f72vbh7ulh3ml2jsnev35z@on2stvxr36qm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 16:04:35 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Rob,
> 
> On 14.10.2024 08:38, Rob Herring wrote:
> > On Mon, Oct 14, 2024 at 06:21:02AM -0500, Rob Herring (Arm) wrote:  
> > > 
> > > On Mon, 14 Oct 2024 12:08:08 +0200, Angelo Dureghello wrote:  
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > 
> > > > Add a new compatible and related bindigns for the fpga-based
> > > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > > > 
> > > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > > > mainly to reach high speed transfer rates using a QSPI DDR
> > > > (dobule-data-rate) interface.
> > > > 
> > > > The ad3552r device is defined as a child of the AXI DAC, that in
> > > > this case is acting as an SPI controller.
> > > > 
> > > > Note, #io-backend is present because it is possible (in theory anyway)
> > > > to use a separate controller for the control path than that used
> > > > for the datapath.
> > > > 
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
> > > >  1 file changed, 53 insertions(+), 3 deletions(-)
> > > >   
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
> > > 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#  
> > 
> > This is at least the third time this issue has been reported. Don't send 
> > more versions until you fix it.
> >   
> 
> as stated in the patch message, this patch applies to linux-iio testing,
> where there are no errors, from my tests.
> 
> Error is due to the spi-max-frequency fix already applied in iio testing,
> but still not where your bot is testing, proably in mainline.

Whilst it's a fix, given the fix broadens the accepted range and doesn't matter
until this patch (which will behind it) I currently have no intention
of sending that fix until next merge window.

Cynic in me says just change the example to a value under the old limit
and bot will be happy. Example is just that, so doesn't have to reflect
the maximum possible or even what people commonly run.

Or include that patch again in this series with a note to say it's
just here to ensure the base is correct for the bots.

Jonathan

> 
> Regards,
> angelo
> 
> > Rob  


