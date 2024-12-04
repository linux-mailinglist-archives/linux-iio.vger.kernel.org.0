Return-Path: <linux-iio+bounces-13075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E449D9E3424
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 08:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72418B29321
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 07:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8356318C004;
	Wed,  4 Dec 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPkT2WGJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9918452C;
	Wed,  4 Dec 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297346; cv=none; b=gkn7ZkbcENG1gNwsXB7Qa0RR9sA94ZBCHaXMxQYqO7TGSRaEAxwF7BCFqi9In0MOMfXHhUoLTGGLd4vSflIw3MVON6FO53RlysABv2W3l7EByzNi2UHjG7slsdh2A7etPfY5gZnDbEyTegq5A9hVI0TMXTTkDxCHCNM8S0Ewv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297346; c=relaxed/simple;
	bh=Kq/8X7ldezvT0VU9r/8MRBUHGkHk2CETWn0T8Td25jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Y2+EuEJ70ubaGzrNSpuEXDGhNEPmH3wUDoHyJKNL/0ZlWo2KXaRML8g/uYRLQ9EEyaGBhvvefm0eU61dmugHi68GDwhyZMvWC8E1MdnDtAds0x4jEPcL2XF14P/zD1Ct9XL6JNAVbSuyDAWji+vhs7FJ++dotKp7CW0WR5BlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPkT2WGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D8CC4CED1;
	Wed,  4 Dec 2024 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733297345;
	bh=Kq/8X7ldezvT0VU9r/8MRBUHGkHk2CETWn0T8Td25jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPkT2WGJ+BMqaP0zOZj8mA03donab+XWO67Dvt3J7R+3+AnkJiWgrxVF5/omSy+WE
	 cqGmPtDkN94vP/aMFV9rKU8GvusggnuJRChPduMUGUAtuTcfpdvBKidDT6Gu7NCWsG
	 B4R3zZhHyV29jy9RymsXSZdUlVeUz2zqD0Wors6IKV3Vmy2tEApMVN1JmqV9zEkKlu
	 sbnYgXViqie44qAKxkBD1abN6/pCtaC2COmjji5N+DXgZgN5HFV/YFyZ/7bYU8al24
	 Rbl2rX3KQGoEZ4h/3TuHjAGosZOo1MTxZvhmnSQCQmYKN5UX6f01cJFn37Pk3UYZ1F
	 LJZFIQNKdSpAA==
Date: Wed, 4 Dec 2024 08:29:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v3 06/10] dt-bindings: iio: accel: add interrupt-names
Message-ID: <7tj5n3hsthhlpo4quj5anazotvte2f74jvpev362e6ivbtza67@pj6n3r4ooees>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
 <20241203205241.48077-7-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203205241.48077-7-l.rubusch@gmail.com>

On Tue, Dec 03, 2024 at 08:52:37PM +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor. Only one line will be connected for incoming events. The driver
> needs to be configured accordingly. If no interrupt line is set up, the
> sensor will still measure, but no events are possible.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 280ed479ef5..c3483a4b652 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -37,6 +37,17 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    Data ready is only available on INT1, but events can use either or
> +    both pins.  If not specified, first element assumed to correspond
> +    to INT1 and second (where present) to INT2.
> +  minItems: 1
> +  maxItems: 2

This does not match your interrupts property.


> +  items:
> +    enum:
> +      - INT1
> +      - INT2

Best regards,
Krzysztof


