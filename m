Return-Path: <linux-iio+bounces-4790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B138BBAC4
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A80628239F
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E41C6B9;
	Sat,  4 May 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJfTJY5D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169010A16;
	Sat,  4 May 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822259; cv=none; b=EQkVLcf0UFmbm0KVc7KSmylf9Z44+u+FtFAVcoO8tnEbdLtuF/GnhkdUMJf+kueisjEJ6NkffbS/gDRFLtLX4EGnNRKI4fKxOhFxyzLa1TB1ykHzRKYHVOJonok6VbMLRiJx9YsQWtRSe1RhStZyTLbn6X2tBX7kkxFEDN3b/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822259; c=relaxed/simple;
	bh=7kGgyEpJQqnlCF0c6QEZp/weZu+M1IT6KMDBzJNA4x0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOhLCQlvmFEALFAtsWFV7SgKFjKpnGDEYv7C50xGQKa+8IR3aDZZcCDvdfX+r4lVrapPtlHhRTnccLOhY9m6EBoiMYqmVVwTorig2ewSYGh9BVm/NlD7Kxek1rdW34o/RAXGkC4Otl4KLmI9MHFLsuPhchjUlogycCBvVg2fPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJfTJY5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27396C072AA;
	Sat,  4 May 2024 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714822258;
	bh=7kGgyEpJQqnlCF0c6QEZp/weZu+M1IT6KMDBzJNA4x0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJfTJY5DdpsJ3GwdM5x1robyywKgIgOQZkq7va9i8+7gXcsskCjSw0HBfQeQYGyyu
	 OaRZjw23/lLsce5j7rSMq8gJOKjhrJA6qXvqJau1E5yFoGw57qLzoZyAxcV1B2oiBl
	 U6DItxYzGwSPD4bdLOyVlWWVerZd8VRPiGIVGqln4DS2PQgtS0NFyxlR/PfsH0tdvY
	 0Kl35EYjv9CArQub5m3LJoRuyuDKhUfIBNAxZm4PAE+Q9uLCeMhIONaEtd6/Mjv4fY
	 8AAdP+2Et1l7rotwJYWWfzoLQH4GClpDJsSyMJMwm9oM0W7Ftlt3ll63HsBoRNDvt2
	 +D0DrcaK9Vtgg==
Date: Sat, 4 May 2024 12:30:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: fix ad354xr output range
Message-ID: <20240504123047.0b4299c5@jic23-huawei>
In-Reply-To: <20240503185528.2043127-1-adureghello@baylibre.org>
References: <20240503185528.2043127-1-adureghello@baylibre.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 May 2024 20:55:28 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix output range, as per datasheet must be -2.5 to 7.5.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
When resending to add people and lists to CC, say that somewhere, or just
mark it as a v2 with the change being to increase the cc list.

Otherwise tooling and maintainers can both get confused!

Patch looks fine to me.

Jonathan

>  Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index 96340a05754c..8265d709094d 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -139,7 +139,7 @@ allOf:
>                  Voltage output range of the channel as <minimum, maximum>
>                  Required connections:
>                    Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
> -                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
> +                  Rfb2x for: 0 to 10 V; -2.5 to 7.5V; -5 to 5 V;
>                oneOf:
>                  - items:
>                      - const: 0


