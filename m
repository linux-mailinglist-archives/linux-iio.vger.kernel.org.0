Return-Path: <linux-iio+bounces-1978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B083F5A7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5E81F22089
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC923761;
	Sun, 28 Jan 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ7ONpWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD823757;
	Sun, 28 Jan 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706449563; cv=none; b=jcxIIMOU8Opx15FwzEOBtvFwIHREUMk9xQaS8DNO6OfUL5gTGl3ArgG3xy7rsZodeK+hKvGWlTePofXioCXi6kEqCwGjYUDIZCCUQ546wEeoXFuGdiPvyJjZ5adEqFer447fLxXddwfKeuA5wRdLoqM4SpvCcTuAn3AmPruaDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706449563; c=relaxed/simple;
	bh=Eif1EcPwIucAPMZzfTOF+bpnCervvybJ0jNtKXwpJeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYTPoUpzEG8loLEIDty3urRIBiwhED0j2EBLrCH9JA06x3HKZQ8pFQH0SkaOXzuElTBu1LJVjga9VQaqTFHXAbNv0SSkwDUuNAyGtQu92H17ivsyMgyMEY3wTT1Qs8lMFcTHTiC79v7PLQYO/EGzZPIztH9JjhghMksFX/doqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ7ONpWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD0C433F1;
	Sun, 28 Jan 2024 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706449563;
	bh=Eif1EcPwIucAPMZzfTOF+bpnCervvybJ0jNtKXwpJeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZ7ONpWbVvT+3qjtRSmehjWOEEx9Pa9NPBzzYQvh+YKkXa4ApeW6zpg1ZKsibVfdq
	 1Nqnwq7Z7e2wg6EuS5qbVtLdZhpkn64+wZYu5+tJoSDNeLorNPtsWCGIiLIYpgo7vW
	 p9eH65Wy4MZTp0r+Q7gJCU54+x6jnb2/c+STleFAnYymWSA5IAqyfN4zgUPZHg++3m
	 kvXXAvNIMeyjcZwRy2z8vjj/yTlWu++guBAuuosWaiIgwCU0Rbfl2IB9rVFhjL/yXv
	 kTPAemQZH0jzfH/TKyPWWA9J0CYgjZxuvdpAPGvrI72knRVadcplQ7pFj+6luHfAhc
	 NUZ3d0sd80W1w==
Date: Sun, 28 Jan 2024 13:45:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <20240128134542.56e5a08d@jic23-huawei>
In-Reply-To: <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
References: <cover.1706441008.git.lorenzo@kernel.org>
	<189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 12:25:45 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add device bindings for asm330lhhxg1 IMU sensor.
> Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> all the features currently supported by asm330lhhxg1.

If there are no other changes, I can amend this text whilst applying.
Something lie:

The asm330lhhx supports a subset of the features and functionality
provided by the asm330lhhxg1 via identical interfaces and so is a
suitable fallback compatible.

As normal for bindings we shouldn't talk about the driver though
what we really care about here is that the driver will never support
functionality for the fallback part that doesn't apply for the
more advanced part (because there isn't any!)

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 28b667a9cb76..7ba3de66a2e1 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -49,6 +49,9 @@ properties:
>        - items:
>            - const: st,asm330lhb
>            - const: st,asm330lhh
> +      - items:
> +          - const: st,asm330lhhxg1
> +          - const: st,asm330lhhx
>  
>    reg:
>      maxItems: 1


