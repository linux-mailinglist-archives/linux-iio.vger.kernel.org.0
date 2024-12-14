Return-Path: <linux-iio+bounces-13449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD39F1E70
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B835E1888AD9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8B18FC72;
	Sat, 14 Dec 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9WoYnQe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C8155A2F;
	Sat, 14 Dec 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177853; cv=none; b=Ye/VdRj33eKyooMWZHKEV/FubEh2a7geBnI9i89RWZFyOOf+9r2CGHwoJ4ipWhBOfiw41CQ0uFbVOfYu3HZLgDnt9qV1xD8l2zFp15TXJXSfoX5Swt3iHd0HI8CSEK6cXTwGm5hvxpCTt3RtcfW5MRdyZBoxqlfiCcX5f3Y5YZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177853; c=relaxed/simple;
	bh=GUnmfEhzSaFNdPvyit8Xaoh9J5dT73WtvMAGv2lYc0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scP9X1txyPKbpkevoKZg3zl5qu1XERJBulY2AH5sP4qERmtOsx9rH29gnNkgjUE71ms2FWXvOjqGM+H2aLMUd/LFSGxvpq6bF5lX+DxesQ4Bkb5iOFCNWjUO9HZKeQrEAof2zr8T+m9SrbKjPtp3h+wjn+tuIKtrVqNbpia2vD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9WoYnQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3ABC4CED1;
	Sat, 14 Dec 2024 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734177853;
	bh=GUnmfEhzSaFNdPvyit8Xaoh9J5dT73WtvMAGv2lYc0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P9WoYnQeVB1NRXEJzOopadi3CCCRkkaDjtdnVdQVJoewgyNob1WkPYoG+9uqxgGXL
	 G3f4pkHtT6TtBlLaAopcV0DAMIqJiOTqHo1HoUVS2Y8psaorg6OuLmcS0XUwgw9V6O
	 mOEDZH1CfwiXVhjLGNdNGNxUhnQHU9hhMn5uYM+qB6sCrDPEYJ4IuI0dXNPOlFD/AQ
	 F3im5MV70PttmDiSLwEzlMvPEIr4BDBMB/lAE64FGVMdGNv0m/F8cSaRp/pGGNQv74
	 mRAXAnwu9UsEpvAkRPiTLVJfIYYFsoVZBbRm8pgN4FH6pirftauRHzz5ZkaRZzqtOe
	 Z+vehInVmTijQ==
Date: Sat, 14 Dec 2024 12:04:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: accel: adxl345: make
 interrupts not a required property
Message-ID: <20241214120404.325121bd@jic23-huawei>
In-Reply-To: <20241213211909.40896-3-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 21:19:04 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Remove interrupts from the list of required properties. The ADXL345
> does not need interrupts for basic accelerometer functionality. The
> sensor offers optional events which can be indicated on one of two
> interrupt lines.
It is harmless but if you are spinning again, remove the last sentence.
It isn't really anything to do with the reasoning behind this patch
(well covered by the first sentence).  If everyone is fine with this
version I might just drop it whilst applying.

Jonathan

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 280ed479e..bc46ed00f 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -40,7 +40,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>  
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#


