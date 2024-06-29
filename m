Return-Path: <linux-iio+bounces-7036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8091CDCD
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DEB282F7A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18D83CDE;
	Sat, 29 Jun 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9Cb+wFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FB1D52D;
	Sat, 29 Jun 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674299; cv=none; b=jUQmcvK8DqCeUn36NSFhOrhkgUHIoSBttytuXJstWflrvHz1OQIMKaknfv02shkBHkyt2Bo6zk2z4SXFaDd97LI6Zu9Ucg9yTsBAIdSKFROXZyWYR9fHPbHo+MetC8maZdUDUnbeAIDpljxtH5qIzffXKoiGrLdWIUoCP6MZRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674299; c=relaxed/simple;
	bh=2VZg0DiVwXfQn0oTJcUgu6YPNRakn5BvaJs4gnYzPDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSxl0DHwipfMPzJiLte0qx4hf8vKRxh0i/VRtFJH14UWPDjof46u8MekwlJ1EhtFxdkpmEEQzswqF+v8JEhcZfTt63fne4XNXC3H+cpuMgT+zJMJp7fkSiAo5XYsVQhZV+6ylJXXJmnYtO+0dzYph0Z1DKxp6BHwfVtGeHRrGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9Cb+wFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C6CC2BBFC;
	Sat, 29 Jun 2024 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719674298;
	bh=2VZg0DiVwXfQn0oTJcUgu6YPNRakn5BvaJs4gnYzPDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9Cb+wFxdaIFJtaZ2z8K4/HWNmPWIkh9gboO83Zlkt7d9d2RqT8Jz1kN0FoyCaFbJ
	 6pKiiVhzMW5vw1tw5UZTdCxGjagEqSPXCFncq1u9QUWZA/jAWzKn78jEU+j1ZrbhFo
	 fuUILwmwR0N4XWF1zmWdGQtROk8rCNzZKpYHFAOuhzMKu1N8eOJEWQAvH9/IblkDKY
	 xGhUwxuiTZGpAMMaILflvbjmjU5GXy4SC73zo5EK38puD/oHPVZZkHzIU0Y5NLyRzA
	 mytSSKiZXygJKp6R6ksWC3CDK11sM7a9tnZGdn/kOOWYsDuBurmp26vjgsQ4pVWorj
	 VJQIlUNTsomOg==
Date: Sat, 29 Jun 2024 16:18:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: adc: adi,ad7606: add missing
 datasheet link
Message-ID: <20240629161808.6c15bcb9@jic23-huawei>
In-Reply-To: <20240628-cleanup-ad7606-v2-1-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
	<20240628-cleanup-ad7606-v2-1-96e02f90256d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 14:48:19 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Add AD7606-5 datasheet link.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
You need to pick up all the tags given on earlier versions.
Rob acked this one for example on Thursday and you sent this update
on Friday so should have seen that to pick it up.

If there are substantial changes and it is appropriate to drop a tag,
say so below the ---
 
Applied with tag from Rob put in place.

Thanks,

Jonathan


> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 7fa46df1f4fb..d55c58400df5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -11,6 +11,7 @@ maintainers:
>  
>  description: |
>    Analog Devices AD7606 Simultaneous Sampling ADC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7605-4.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
> 


