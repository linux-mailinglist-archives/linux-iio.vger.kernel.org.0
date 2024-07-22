Return-Path: <linux-iio+bounces-7793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A29393A7
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119BC2809D7
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A816FF47;
	Mon, 22 Jul 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSIrTFtJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE2770E6;
	Mon, 22 Jul 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673677; cv=none; b=OXyfnLhDG8ox9Nucj9QnxJl5KYWZ+U8lezGGj0p0ZPt5YDW3I72PYrKQOC/8zGlrODcM+kf3vzPgI0jiLc9+PEWYs8wB/SI9tMjgq01Hfe+724p2DZeNDRMo1WuGbtWP6ubKl5stsDyCLjhmiuVkNS4ppRB9ZX/EvFfarz8H0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673677; c=relaxed/simple;
	bh=qLIVYR96ExysYvsl5Si59HEtTM9cbLKt7Te6/71ZiOc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ekwlfdnXHDAD4FnN34x9SUsFYtPFICagkomCFVazaG4E2iZ+4dZm6Ct47xPT4rqxDSCDcldlbbTwECNqG/kKtvjiXHpZS9WuQu3muKUA7wGMIYKOOXpTdVYditn1DtFpwkMTobGBCDr6WaGtaqboPnzDaOoJaByp7RWfXyEe+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSIrTFtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1DFC116B1;
	Mon, 22 Jul 2024 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673677;
	bh=qLIVYR96ExysYvsl5Si59HEtTM9cbLKt7Te6/71ZiOc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XSIrTFtJkLz+lK84qNOyYNQFM7fLxqUv6qzkkn8930YexgYCORBevyyAc+SfbD9oG
	 /UvfT9R11EHPfO82JlHRRj3W1UQTZR0gYF6NMFXYscjw5hQWI3qjmLyPZQJ7HfkW8h
	 m00/2MXYIgLZ5b6BCrOOvx5tW5zhZO7YxaTlcBoKUhegLitHy4kk62taCkzXeWq4CG
	 hWZBCVe6OqVJmBWs6KJuT91wytNGNKnlgMtleMee858IQjzJDE+ed//MEVEm7r6BXx
	 /dV2sqBGH+/SRD/LbxCg9Ac+2Nx7zRlOA2v0Iwcnn5PbcfvKe8wxo4rSev4+qCN45p
	 gZN1vEDw3IftA==
Date: Mon, 22 Jul 2024 12:41:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20240721-stk3310-v3-3-98fcb6f551a1@disroot.org>
References: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
 <20240721-stk3310-v3-3-98fcb6f551a1@disroot.org>
Message-Id: <172167362863.4010.2852066025016124644.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: light: stk33xx: add
 compatible for stk3013


On Sun, 21 Jul 2024 15:44:31 +0530, Kaustabh Chakraborty wrote:
> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
> being marketed as a proximity sensor, it also appears to have ambient
> light sensing capabilities.
> 
> The part is fully compatible with the existing implementation of the
> device driver. Add the compatible string of stk3013 to the existing
> list, with a fallback of stk3310.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/light/stk33xx.yaml:23:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/light/stk33xx.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/light/stk33xx.yaml:28:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240721-stk3310-v3-3-98fcb6f551a1@disroot.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


