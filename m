Return-Path: <linux-iio+bounces-4964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE78C325D
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DB9281B8E
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740556B65;
	Sat, 11 May 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXWCeRCx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69638DD3;
	Sat, 11 May 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443455; cv=none; b=s7UPJvrGcKNZLv0sAHahhHs8LlTG+IbSZuDpauo7dGTSGoZ2Z5g2o/LfQKErzzbpxrVRAJaSBBB0W3Asv1WVStklDqsr36S751Sx0xU337H/iVJqWLeOf1VzruJXbWlpyYG0KWsz61kGjstHGA6tqGQXoG2F+MdHgd0DAnAcUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443455; c=relaxed/simple;
	bh=JQRE0XHFO9GOKibnqirneeKjUdSE9KSkg1Ih2ug6M40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UB6dg+O2I4g0P0zDGPYb63r7Y8Xw1dDhqmzX2p0DfcMO5W4z15I2NkJVW5Nb2aypiSQzc30NZ21vAn152ERlI7gb86sOErrN6VL6hO13R67L83+8nWzxDuk9lQCZExv4Gb6eAR+9wzS6TvCG0aGrZrzHOeAUywHwB1rCRBOQZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXWCeRCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49CFC2BBFC;
	Sat, 11 May 2024 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715443454;
	bh=JQRE0XHFO9GOKibnqirneeKjUdSE9KSkg1Ih2ug6M40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NXWCeRCxyWIn5lw0x2auuwwkaEMuiV2KmekZYv2TpkTyzF70Y9b+Xdl+efgn0jeMO
	 xttPofnDX7t2qxCqvibqZ3AWbNKn7ZqdTXXpojYPtoXSZ1hStYG31pBNDPOqcpirI1
	 lm2+zwJNZUMYWQBGbMuKefOx4GcsKwuzKVVkR4zbEFD7S8iIlg8DuvqmoreonXGpny
	 kmXo4N2VbCkqCkP95MIjpeBferik2irCU6536SsTHrkngR20fCiDwA+qLSQ1/2OPVV
	 Dg06I2eIF61T/SXFwwdvpvgUdGZGVwbJkC9ZyHBU0l0GoxDPirFS0wPtYNjigDE8gr
	 jGEajj6Pyn9YA==
Date: Sat, 11 May 2024 17:04:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: add ad35xxr single output
 variants
Message-ID: <20240511170402.324d8e1f@jic23-huawei>
In-Reply-To: <20240510141836.1624009-1-adureghello@baylibre.org>
References: <20240510141836.1624009-1-adureghello@baylibre.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 16:18:34 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for ad3541r and ad3551r single output variants.

I'd expect to see constraints on reg for the channel nodes.
Am I missing some reason those don't make sense?

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml       | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index 8265d709094d..17442cdfbe27 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -19,7 +19,9 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad3541r
>        - adi,ad3542r
> +      - adi,ad3551r
>        - adi,ad3552r
>  
>    reg:
> @@ -128,7 +130,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: adi,ad3542r
> +            enum:
> +              - adi,ad3541r
> +              - adi,ad3542r
>      then:
>        patternProperties:
>          "^channel@([0-1])$":
> @@ -158,7 +162,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: adi,ad3552r
> +            enum:
> +              - adi,ad3551r
> +              - adi,ad3552r
>      then:
>        patternProperties:
>          "^channel@([0-1])$":


