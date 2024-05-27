Return-Path: <linux-iio+bounces-5354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16A8D08D0
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5851C2183B
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28773460;
	Mon, 27 May 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdAlFkuE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B917E8E3;
	Mon, 27 May 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827846; cv=none; b=Skyk3T6elAZztvbrKWpCo1QXVYaRTMsyzJEEZiJ1We+WPuRb9W+EjXU81+wo/TD+PU0Gg7ixT3bsNgtmUw5ODh58uvbQHP/ydbqW+8fvFzPl0yjMNDtj4+sB1hnZljXbhcQeps2jmY6+Amwid2dlCyQwVV88WOMw0Z8ubUwLvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827846; c=relaxed/simple;
	bh=09vNHjWI7xZll07lwlGlHMkbk/dDA5bQd3OY0FlL8dQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Gukt+XaG6FIfVVtcULhp5SHqCqXWxdDttTr9BhlO53QJzhZydLZHWqGohfA2VHvdNAWS55Mo9SkwFPuxjE9mXiyqOCqukrCOXtpRU+j+QVvtn+PbH0N4vSy4XDUkZfVa4DqtzTP6MJZKU1XagLmOxkMdHWsoCkaw7/PQDIStGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdAlFkuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31259C32781;
	Mon, 27 May 2024 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827844;
	bh=09vNHjWI7xZll07lwlGlHMkbk/dDA5bQd3OY0FlL8dQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TdAlFkuEs0ZPY3kb0w1T+tVNcDH2H0n/HLp+Hk0LPrWJoJ1NouhCK6xgMl/5EHQ2d
	 rN/25tAEZbJgtTTPa2RdZCGedly/uf7mwRYQSLi5fJuYxRIgvxDuiNHROeUy136f07
	 MXDrasFwvAay/e3A5KrnvDkv5v+soGk9WLP5kcjQL5rv8QMDkt6UM7Qqly5FLiNstc
	 MBeMt3tWxjk8CsmZtBov3gA9+sCEXCXQqiTdQtBZ2InmXmWk0StKWm1cemfDqMTOWk
	 5frOeSI/CKM6rr5p8nPQgsjr2N6pvgyLa/cHT9pjNA7x9YHpf1hkBGoAaUkVnr9UxS
	 lJabOjceLyZAw==
Date: Mon, 27 May 2024 11:37:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240527154050.24975-2-francesco@dolcini.it>
References: <20240527154050.24975-1-francesco@dolcini.it>
 <20240527154050.24975-2-francesco@dolcini.it>
Message-Id: <171682784307.1866394.1200692340690360713.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add ti,ads1119


On Mon, 27 May 2024 17:40:49 +0200, Francesco Dolcini wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> with I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../bindings/iio/adc/ti,ads1119.yaml          | 122 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml: ^channel@([0-6])$: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240527154050.24975-2-francesco@dolcini.it

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


