Return-Path: <linux-iio+bounces-27023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED784CB6689
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DBF33032118
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3730E3148C6;
	Thu, 11 Dec 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esKifij/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9A313E2C;
	Thu, 11 Dec 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468672; cv=none; b=rrLV/AyNb5Lx7Ih+3sHVILAK1hqmTFblMSFbfATqauiswkYbvgY+WZpEKyiv8qyRvl1Hvwp5P/I1ubU7UVILmNBJHgoe1j4S5l68c1ntB2dew5PW4YM8kK735G4XfTDVOk1saRK09hVLyp9mFDSM2un8A7NEtoceTC49ZgZFtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468672; c=relaxed/simple;
	bh=aQN9YBZJ1/3TgzhE0vb1ucmDOVbahlZuL1in8B8rZXA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FeJVS+w7ufyq7LPfOzvNix2rpYsSN4uBy9HR5XMrqLhgao/oMJt6YxyG3R6yDqBRkkKSaL/z/G7Recx4ICCHXJ09ESJ9qb8mGy8mP0A3apOYugC5wfQk3Li0S4FryhJH27uI55lm6HVkWc/ejS8DKrJERXOuM6RH0p0fUuaxXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esKifij/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A1BC4CEFB;
	Thu, 11 Dec 2025 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765468671;
	bh=aQN9YBZJ1/3TgzhE0vb1ucmDOVbahlZuL1in8B8rZXA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=esKifij/8dhYsEU8w1WyMNuXAVSlN23yCyZg9abVk+EvvGTJik0I6PaTapC6y6lgk
	 9DSN2eWrwg2PpNOnHvWhEH3b/ZgVGsLDmZXqcNrs0NeOlj+x9E0Wh+kGDDwu4CCF8F
	 4XYa/pUqW6wHxb/qBshR7WOIaLTh/0fnn7VoDOSwgWPdwJ8ErIcFxlduWvBivpoFn+
	 IpPjwCGfsiicFSRpmuICleEUojKPqGOGsf3xwCxxLR5+grBffvMpZEQXfSoGKBJmAc
	 +J/H0qT5EqY1z/AglqUXvyaokIxb2Evp3PrfGCq5FsRJG8aPW+KCfP75qCONvUrM3h
	 pXM6DvHSuCwXw==
Date: Thu, 11 Dec 2025 09:57:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, Conor Dooley <conor+dt@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au>
Message-Id: <176546866713.1487167.4918701456595372928.robh@kernel.org>
Subject: Re: [PATCH RFC 16/16] dt-bindings: mfd: Document smp-memram node
 for AST2600 SCU


On Thu, 11 Dec 2025 17:45:58 +0900, Andrew Jeffery wrote:
> The platform initialisation code for the AST2600 implements the custom
> SMP bringup protocol, and searches for the relevant compatible. As a
> consequence, define the requisite node and the compatible string, which
> in-turn tidies up the dtb check results.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml:140:16: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


