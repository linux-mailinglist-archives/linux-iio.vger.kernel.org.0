Return-Path: <linux-iio+bounces-9835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6898902C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D8D1C212AB
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF452F71;
	Sat, 28 Sep 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSXFpSno"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E118030;
	Sat, 28 Sep 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538962; cv=none; b=traKNMTkaqi/aRJu/kZE22nk62uXXjlXXbpgtFKIYHl3Row8CzM31FfMQK7EhdEzPuHQlqqN3rve80gDpwzN6qSn6NV/1IBVUVV0yxM2m/T+6rqGBQCN9QazZo1IvVI3kqUy7HPhOv5bs23kjlqEO5Aq1bpUY1RXW1+P21Z0ZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538962; c=relaxed/simple;
	bh=4XV4DRCxMcBo3R9r+qrVgyMtzWsDg+1Ify3KwJ+TaMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eM132ooF4j8APqUKbfoefr0jd6ukV7wf2LEcFAWQiY8SLF6pxMXD/9kHS/Bws3JTJKhtEw0EBh2U+rS6CVYk6ycfScMJciPbz1lcJB05Ke9/ZW5CfvhTyoHwmLZcW1IPne8PTxSQVMvA7tI4N3X9yANhar2Ciuq91WRF0dKuOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSXFpSno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BEFC4CEC3;
	Sat, 28 Sep 2024 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727538961;
	bh=4XV4DRCxMcBo3R9r+qrVgyMtzWsDg+1Ify3KwJ+TaMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cSXFpSnoBge92fLnWwPjvBxrU9n7m5ZfKL9ns6adTljs0KGiV33tuoiQFzArI+a5C
	 4THC0Lt5z0ocO6pyDbJysDYrRRs5neZDaAg+F1CesbJPLOvUpp13nnAuyZ9sCxqlVW
	 Y/M/kkVn1VOAp+Y23Kqtk2Awsl38WHY6TW6xbCbBHnFdq5B0EpZAnOnzNG2tRSiOYg
	 iea0sNg2GL0BncognHCp5poC8xq3+6BEJI7PDc4MvlJQd8C54CnbwveVAnDk2hUV6K
	 bfJOtbOhDTXbstGgNWBflK86CqFVDSzJFM1bpdmx5e7e5Yk4zx5231uXFhNT8Hh2s7
	 zZ93zr2xqHedQ==
Date: Sat, 28 Sep 2024 16:55:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Message-ID: <20240928165552.6d4c2f6a@jic23-huawei>
In-Reply-To: <20240920133615.167726-2-inv.git-commit@tdk.com>
References: <20240920133615.167726-1-inv.git-commit@tdk.com>
	<20240920133615.167726-2-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 13:36:14 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
> They just have better specs, temperature range and a bigger FIFO.

Is that fifo size discoverable?  If not then I'd describe
them as 'backwards compatible' but not 'fully' compatible.

So the binding is fine, as an aware driver would use the
more specific choice anyway and hence deal with that fifo
size change correctly.  Someone who paid for this part
probably wants their bigger fifo.

Otherwise this looks fine to me as does the next patch.

Jonathan



> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> index 587ff2bced2d..a8d30ef015fa 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> @@ -36,6 +36,11 @@ properties:
>        - items:
>            - const: invensense,icm20608d
>            - const: invensense,icm20608
> +      - items:
> +          - enum:
> +              - invensense,iam20680hp
> +              - invensense,iam20680ht
> +          - const: invensense,iam20680
> 
>    reg:
>      maxItems: 1
> --
> 2.34.1
> 


