Return-Path: <linux-iio+bounces-13112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE29E505F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61381882163
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092A1D45FE;
	Thu,  5 Dec 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxgv+uSp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73D41C69;
	Thu,  5 Dec 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388944; cv=none; b=ejhBZI5oUYgtSUutCZtgudsjTUF0+OMdD+MmDDW4Yqop941qzJP12JJOuDxHSIMjfYXoRqbxiFlDFSjD+iprR4R/lYnU570rNtaJYzt4yTlnt7YktX1euxm0AA9nyVoj/D8SKa6k6o6cpgTQO6nrPFNIHzJMd7liye1r+DGUdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388944; c=relaxed/simple;
	bh=fTIKkkwYVjilLYvRGXSnMs4omBzU25Ovg8SOWw6OiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwMNF3OG78O5cr3cTOlw9pT8nw14RpQ+QP65EDaYISZUl94jyvX9ZWTgUGLwEsFqyDd1iejwAB3kwrPTfi64NxzozlMVhxWMvrRQEtvtVOVrCCzJM6Rw2ylIYSFAnSnFvTS2L42EEEcJ/Uk3OY/ocUd1RPdoLWmdXeJxhuP7K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxgv+uSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE40DC4CED1;
	Thu,  5 Dec 2024 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733388943;
	bh=fTIKkkwYVjilLYvRGXSnMs4omBzU25Ovg8SOWw6OiPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxgv+uSpzDZefsoA62AoXgIgKinrGVn5+vhhHgfHF4Ibq3o0h0/8dO12B/ccLU/Ck
	 1cUHGTKVMKL9Rm3h5JZ0D9JaK4fmTC0CQGHHsxLsGKu+Q1IYMIehySWs/Xf+WWMfGH
	 e0e5XaOhg+NwS639wJu+ZP6qE/ObkdRcJs3l5u71gi55jBdZAGZqTdU067PXosxf1E
	 hUooJeTNv6XfsUHhZ026Xbrd0Iz3gFLHCUOasMJ/P8V0yJN4+E5urVPoJ+TBFvyAZx
	 RS2FaFF0LmUKA/VjWjihwPNKYg2mK4u2dmFRtFdRBxdR+5UniCLPYegqdoBlOfZHtG
	 SUtFI0g05Pm0Q==
Date: Thu, 5 Dec 2024 09:55:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v4 06/10] dt-bindings: iio: accel: add interrupt-names
Message-ID: <r23e4axzdjn423yl44lv2sjprywtjymvgramrrfoc2lv6ebeui@hzbm4ilbyvhw>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
 <20241204182451.144381-7-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204182451.144381-7-l.rubusch@gmail.com>

On Wed, Dec 04, 2024 at 06:24:47PM +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor. Only one line will be connected for incoming events. The driver
> needs to be configured accordingly. If no interrupt line is set up, the
> sensor will still measure, but no events are possible.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 280ed479ef5..a4c2cefe1a4 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -37,6 +37,15 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    description: Use either INT1 or INT2 for events, or ignore events.
> +    minItems: 1
> +    maxItems: 2

No improvements, no responses and according to commit msg you have only
one item, so instead above and below just:

description: .........
items:
 - enum: [ int1, int2]


Best regards,
Krzysztof


