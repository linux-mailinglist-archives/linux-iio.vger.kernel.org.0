Return-Path: <linux-iio+bounces-17621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A431A7C23F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 19:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EA017C3D5
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172420E70D;
	Fri,  4 Apr 2025 17:16:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E03101EE;
	Fri,  4 Apr 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786989; cv=none; b=myPnD8oEWC8uXHzC8isz+oXVEg8CCzhNVOUwDNPyMOHchTdxfMTcA0mcucHmycxEeb4Z7pL1zHaECl+gRUTqE4/5U7zVb3SUMbhPTAtIKz6oA8lIa6cfn9TGXqRgU2HgU5tmQVwzoQ0NgSsfiBikrgzRS6W3YqoMa0/dkAXAHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786989; c=relaxed/simple;
	bh=52kIOUOCRKbzCv1uY7GkqLGkddWNmTZWrTBtGPORX3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H65lk2msGcbTSqS94/i1QfRMY0LfeNsoZLsDA/zerLD6xNrsmA+BiAYYlnqwyCutyYAGKtGsVspvTEhVfcYGk343vAdf9zLojKX595TKJWYjUuc47pcGdu6oojQI8+gsoc/DL/nSI7bn1rwlONd8K1gyIL8G3h6u9kXNba4MSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTlXq3dp3z6K9G2;
	Sat,  5 Apr 2025 01:12:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 94BD5140625;
	Sat,  5 Apr 2025 01:16:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 19:16:23 +0200
Date: Fri, 4 Apr 2025 18:16:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Message-ID: <20250404181622.00006d29@huawei.com>
In-Reply-To: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-1-72ed5100da14@tdk.com>
References: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
	<20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-1-72ed5100da14@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 04 Apr 2025 17:52:02 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add interrupt-names field for specifying interrupt used.
> Only INT1 is supported by the driver currently.
No SoB?

Also, these are tricky to retrofit.  Arguably this is a binding
fix because there was not documentation to see the interrupt was INT1,
so perhaps we don't need to care in the binding (beyond adding that
INT2 is valid as well).

However we don't want the driver to fail on DT out in the field so
we need to fallback to assuming that if the interrupt name is not supplied
we just grab the one interrupt there and assume it is INT1.

Jonathan

> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7e4492bbd0278a336587dc5ac04da7153453da29..f19cdfd7450e04e7c984dc987f3c23f5ad89a248 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -41,6 +41,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    enum:
> +      - INT1
> +    description: |
> +      set to "INT1" the only supported interrupts pin
> +
>    drive-open-drain:
>      type: boolean
>  
> @@ -76,6 +82,7 @@ examples:
>              reg = <0x68>;
>              interrupt-parent = <&gpio2>;
>              interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT1";
>              vdd-supply = <&vdd>;
>              vddio-supply = <&vddio>;
>          };
> @@ -95,6 +102,7 @@ examples:
>              spi-cpol;
>              interrupt-parent = <&gpio1>;
>              interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT1";
>              vdd-supply = <&vdd>;
>              vddio-supply = <&vddio>;
>          };
> 


