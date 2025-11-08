Return-Path: <linux-iio+bounces-26050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF4C43355
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531344E5368
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DA279917;
	Sat,  8 Nov 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiyPjzsw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860F537E9;
	Sat,  8 Nov 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762626341; cv=none; b=aWYgeJ2Hkv3R2lefEtt6laaS/CkwfNod+ltNZ2njLhlHFwCXHTeblc5qus0AM/IAb4mw/B2BCxigC8JXipHx+X9pEVr387dyKILNAa9RIkWto+2ZJPTb21JsYKhOysLLhCd4GQksMz8b3dVT7LHe6Y+C+8fjDZENX6b4dSFu6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762626341; c=relaxed/simple;
	bh=AQ3vq22EgJ9RmtiwWkrCuLBW1hgGRP0sSp5l1gWdu00=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bSmZTcZ/MvolBilD2MzWft/LTXmSo6Ye4B1bzJQkxUOfZ3kc6njwt0d6Fms+JQlSxRCF7lUSrcWZNbecl3i4biIp8hl6KKjkWDG4hUdzd8c2lBwHJ+/WcmCRRX5Lggx5gC6zzRWFj0BFS6zf4/cl17/nR8JV8fMHRcDj1TqNJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiyPjzsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00179C4AF09;
	Sat,  8 Nov 2025 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762626341;
	bh=AQ3vq22EgJ9RmtiwWkrCuLBW1hgGRP0sSp5l1gWdu00=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=uiyPjzswVXfhJqZBfuP6BTVhAu7P9LkcNPYSV+5whyak8NTZDeSjndbj0/NA9QmgT
	 4mZ6d3VfQiEGxrGMz6q9gL3d5BPbrFDSrKeHfUoadAsVdDVIFJzElxXpP6NqGW8mhN
	 /VegctvPFSw98SRUzc+32cBT9JOITzl7qWGt/772E/xFGKEu9uuLGzF9XwgK5t8knM
	 Iq7APigR2u6Bd4BFUlxXsdgD1xixBGWsvnOKoeh2EQf8dAKvQIi/GrraipW0xwmWnJ
	 dIvpnSy5WbRvghGVmRg3/YbTP44yqLyZIhXHq4952YK6PD1IsaNSwbXKE9hG7Dhwmz
	 5fHKymbF6sTSQ==
Date: Sat, 08 Nov 2025 12:25:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jic23@kernel.org, conor+dt@kernel.org
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
In-Reply-To: <20251108174357.3748-2-antoniu.miclaus@analog.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
 <20251108174357.3748-2-antoniu.miclaus@analog.com>
Message-Id: <176262633947.152286.18407779482145817795.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: amplifiers: add adl8113


On Sat, 08 Nov 2025 17:43:52 +0000, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> 
> Changes in v2:
> - Enhance External Bypass A mode description: clarify signal routing from RFIN to OUT_A and from IN_A to RFOUT
> - Enhance External Bypass B mode description: clarify signal routing from RFIN to OUT_B and from IN_B to RFOUT
> - Remove adi,initial-mode property and its description, enum values, and example usage
> - Simplify device tree example by removing adi,initial-mode = <0> parameter
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml:43:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251108174357.3748-2-antoniu.miclaus@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


