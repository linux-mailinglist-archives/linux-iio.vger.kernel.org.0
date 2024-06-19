Return-Path: <linux-iio+bounces-6588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293490EDA3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E875B250D9
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD477146D49;
	Wed, 19 Jun 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB0wr9yo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435F82495;
	Wed, 19 Jun 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803228; cv=none; b=tTIpjlr324Ib/oWiIIlQkIw2MLCyYdecLuzLcSyfq0o3IyVJ5HzXZPTbdlRXZLHkovT9bEhOBggz6KieoY/NUr59hLWQe6t3kWpP48bcHFVwNsPe5WEvkPzzemPcD7rrDysvDgjHEMasxg50TJA/U19dPt21hks/Ue8YgynKz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803228; c=relaxed/simple;
	bh=uMhnAVTicYrXQjCEWUijVc+qFtdFSA0ClmNfrzE2VdI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SKrfsJQz89mjdS1IZdmZamrVql7GvMqHDGCFrvI39PCPVKqnAOD7Qv9mtBZRpf9KwIfb9Ljpq8gdCP8d+gsp7FbfIrJSM7ECtUXVKolLI3JjNCpOetUYs0OamXsfDCx2nvYuJR0sYYo4iCe5Srg4y1ZrO7LaP389eLVSubx1Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB0wr9yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C324C4AF1D;
	Wed, 19 Jun 2024 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718803228;
	bh=uMhnAVTicYrXQjCEWUijVc+qFtdFSA0ClmNfrzE2VdI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oB0wr9yolvr+hIGh1FVoPJtNwlv6KuKu4ed7TsX+xT+yvr38Hu7tX3TbaffVeawY8
	 yozmeYx4UKeuhRd3bxmsVg8hOwkWRuULJeFkHc36p3qICOfnk9hh66qG+OJK5dQZw8
	 xijRLgGbHMd7zjtgishl9bClSfco48mQyhfh//mRfZrkOf2/zYGj0ArdVqzS8yO78v
	 ISa0gchQOsd/erlzzw6LcazEP/SBli8cKCTv2Q+y0fzSjM1jtQ2d4BsagppMmla1A7
	 kcdwYP5OimkvgMfCjPIbVlnMmzfcMysi/peVjYIxczFcFrXgPwRsiJyYWlzRTPp2LW
	 HsQEVutG+ubjQ==
Date: Wed, 19 Jun 2024 07:20:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, 
 Lars-Peter Clausen <lars@metafoo.de>, Okan Sahin <okan.sahin@analog.com>, 
 Liam Beguin <liambeguin@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Marius Cristea <marius.cristea@microchip.com>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Maksim Kiselev <bigunclemax@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-iio@vger.kernel.org
In-Reply-To: <20240619122105.22642-2-ramona.nechita@analog.com>
References: <20240619122105.22642-1-ramona.nechita@analog.com>
 <20240619122105.22642-2-ramona.nechita@analog.com>
Message-Id: <171880322718.1907032.4194065731980949546.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add a7779 doc


On Wed, 19 Jun 2024 15:20:44 +0300, Ramona Alexandra Nechita wrote:
> Add dt bindings for adc ad7779.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml:69:1: [warning] wrong indentation: expected 2 but found 0 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240619122105.22642-2-ramona.nechita@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


