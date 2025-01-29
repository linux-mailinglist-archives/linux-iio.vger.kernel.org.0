Return-Path: <linux-iio+bounces-14720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C9A221F4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D51188727B
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800D1DF279;
	Wed, 29 Jan 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYpdHIaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6B143722;
	Wed, 29 Jan 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169013; cv=none; b=FR/lz21tNuuCg79Tr6dGiqR4bI+vU3axRODa+zK2FqaWwIFNy4ZSkGKeHzsFhG6j9aSubrK/gV4ehU0gGe+aCLo1i4MMjENCAi5tSoRc+RfRCM7P/L2/RMt/qOVXSByzn5kMWTEmFLQztdLV2Ugwfxpn+sVlkbKv0LUpKyy9J4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169013; c=relaxed/simple;
	bh=Iuc+Aon1048pqiFLDx9EqcJtdwLzmXImv2kT3TPIUUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFH+We06m+957C3vnbZPrSteyP9nDFdILtW2gJsfrwGSuADQr3ImtDdUmCw5fCV4jaQLp2ZGTgEfQDGNzXMQcBUkvgict8fSqkH7uFvJoWLaJE78c1dUdHbvu73MNHZ6x/wr0dIzQ3rgS00wzd6lK0FE5qWP17Y6Tx1LiAQRnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYpdHIaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29DCC4CED1;
	Wed, 29 Jan 2025 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169013;
	bh=Iuc+Aon1048pqiFLDx9EqcJtdwLzmXImv2kT3TPIUUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYpdHIaq6i93mda7V5QjfqvkAjvEbU68mQt9hgAME0qh+F5hevlQIbIwdVTtXg+H9
	 guqEwvnLZFl/0SHaPMtCVdUVETit0uqfotwsQ1jHngA9Q3lizQNhuPMZITdzSGHkxJ
	 5v4R3mrm41cgsipJlaXGhKg0vPSx3uNOYW8mjg4VjHWlJ5PcvLQ+UevHIbT7wroo5c
	 Ku4iAPcpzS5Sg559o8ZkqRQ2NDUYaA5D5o0axfzYPMa7yr9CjOX4hifczEidP2Y+gM
	 I/TrDzwtVMfPz0W4hNQbj5Bo4XX0kdGaLQRHoCAko21P0Qcy3GVsW/iDjj+vkEh87Z
	 m51xDDEonzqzQ==
Date: Wed, 29 Jan 2025 10:43:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-fbdev@vger.kernel.org,
	linux-iio@vger.kernel.org, Guillaume Stols <gstols@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: dac: adi-axi-adc: fix ad7606
 pwm-names
Message-ID: <173816901148.2210648.7229249527612652632.robh@kernel.org>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
 <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-1-c3aec77c0ab7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-1-c3aec77c0ab7@baylibre.com>


On Wed, 29 Jan 2025 12:03:02 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix make dt_binding_check warning:
> 
> DTC [C] Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb
> .../adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
>     from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> 
> Add "minItems" to pwm-names, it allows to use one single pwm when
> connected to both adc conversion inputs.
> 
> Fixes: 7c2357b10490 ("dt-bindings: iio: adc: ad7606: Add iio backend bindings")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


