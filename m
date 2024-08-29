Return-Path: <linux-iio+bounces-8879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9359646ED
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6536D1F2223C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B21A707F;
	Thu, 29 Aug 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpUvT1IT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831019408D;
	Thu, 29 Aug 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938801; cv=none; b=NjozfiMl8G6VoKCUKrnRMh4krHcPsPWLzAHkMusFzAWc0Ih7LZzvfeWeDxTUmNA7pPbdpMbd+PykPC8Sr7IZWCCODpS1s9jarpDs0lifpqBrIDezsz933JkQvmRZ7gptkWGrNCVhYEjJXmXeX7mc9y8zJOz6rtsc7DfGHS13Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938801; c=relaxed/simple;
	bh=T8uq5UDm0y39JoS8gj7vYpV20ScMyzrUL55wcPe8U0A=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BPsOPVgNKD46NZEz/U4NiFEjaUu8riZzWWkkhQqrECzsXjTIaqcDIhEgZSmKKzZQAPndQNJQSReE2NHvIgPD3+cczxzgIyghRFcrGSH7uYvdLS9gR9ptoAF5PAWJcT5AOoCvIDDrXUjPavuHRhh9I4EyS0cbBmGfrPvl+B8uJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpUvT1IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40B9C4CEC1;
	Thu, 29 Aug 2024 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938801;
	bh=T8uq5UDm0y39JoS8gj7vYpV20ScMyzrUL55wcPe8U0A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OpUvT1IT8u82MSNgks9scGD8Eo+HbsJrIlHP5QLs6GEgVc3kfN7p3isndrBUfQoyM
	 2kG0qv1HNU6rxkzbgSf8WV2ivxtsLvAUy7hkRCLprCA6R8XYsJSHTm6WJJhhOnJs0J
	 qoVWhjdyVTeTgu3Yk2ULi15KhxvgoJ63hXDz/UtZ48ptoLXJpplQ7LEjONdgkx8Txx
	 w8vMXROxtlWJSuytsSZ05bn9kcRgicNf0K9a9xSc007Gw0tJCxy5mT7ceKMoXqWqO3
	 fzBmaKsKTLYv0jM/sm1i5H4SPgcK2ksp+n+F7hvYCkUyBjpCaxAzUT0yxCL9WUgjEL
	 w1XV+jdIjfrSg==
Date: Thu, 29 Aug 2024 08:39:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, dlechner@baylibre.com, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
Message-Id: <172493879919.232012.15230520873780726405.robh@kernel.org>
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property


On Thu, 29 Aug 2024 14:32:02 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add bus property.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml: properties:bus-type: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


