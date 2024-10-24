Return-Path: <linux-iio+bounces-11135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21F9AE99F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73066282F84
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0801E7C0E;
	Thu, 24 Oct 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFUaXhYi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47371B6CE2;
	Thu, 24 Oct 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782130; cv=none; b=mJvqHPiayKiazBLq5k8alWpFwacdMJzZtrjbBpS4Q1Go6iui9rAF/0k7ydAt0tGF6OZKc+cUhO6hRv1w5akBc7M9pFaZNejcIpIx306YEw2uYcZ0R0G+E/9KZxStPAEYG8pFQPg/yPr0bl+eXeVnbOvYZuRl575JA0I5mUJvOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782130; c=relaxed/simple;
	bh=uvcf82lalUuBwLRUPgmQEpxQgX8iDV2arz2E3ydDza4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNyJR5Uueg8s3BS3OOMtKy6MVPkAdb7XusgMpvEKyeCltrqM6dJTMzwbjGSpCwLXPouSV2ZBy5RBSq99zfM1caW0nkXcRjl1uxGFowIXO8++HtgWH6POLOY0s5VLLOuavStTKEZFULPfnUWplLxYjM/dSJacrWgqrRg+3LXiS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFUaXhYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BECEC4CEC7;
	Thu, 24 Oct 2024 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782130;
	bh=uvcf82lalUuBwLRUPgmQEpxQgX8iDV2arz2E3ydDza4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFUaXhYiIacRODB0pP/K3fbU2plJQPP4kbvaFjRllEzQSRPbX4kX68Z9Nz4MqdIey
	 lLOAIFMUkj04igHjdMz6Y89d61dlbb9/5LZlf1FjVpOM8q3EhU+fgPqDhCE727QcUC
	 aSHECg5xHjxiscPOorSlVhncFw+qV3BVB6biKkC7Screy7E3kzOPtvv3yAyf3uRC1S
	 2aFvtKwe3bbnm5/gcEp5pbx/IvhF/laWGWSEx1dXzhi+x/9sQCtnBUzxV42oIR6YLB
	 P8LH52EELra86WcgqCuTH3ZIogQids7F/F452xNF+s/TzqkRRXVdX88OrBAWJaW+Ua
	 FWSwa6Wb6ju2w==
Date: Thu, 24 Oct 2024 10:02:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: magnetometer: document the
 Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Message-ID: <172978212903.435501.2161038660032886280.robh@kernel.org>
References: <20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org>
 <20241021-topic-input-upstream-als31300-v2-2-36a4278a528e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-topic-input-upstream-als31300-v2-2-36a4278a528e@linaro.org>


On Mon, 21 Oct 2024 14:38:54 +0200, Neil Armstrong wrote:
> Document the bindings for the Allegro MicroSystems ALS31300 3-D Linear
> Hall Effect Sensor controller by an I2C interface, mainly used in 3D
> head-on motion sensing applications.
> 
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss unit
> is not available from registers, thus the sensitivity is provided by
> the compatible/device-id string which is based on the part number as
> described in the datasheet page 2.
> 
> Datasheet: https://www.allegromicro.com/-/media/files/datasheets/als31300-datasheet.pdf
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../iio/magnetometer/allegromicro,als31300.yaml    | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


