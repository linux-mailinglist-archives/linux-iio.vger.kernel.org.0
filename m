Return-Path: <linux-iio+bounces-24714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2728BB8E9B
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9A5189DA6B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD820F09C;
	Sat,  4 Oct 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6mhdYdE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A91624D5;
	Sat,  4 Oct 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587471; cv=none; b=YXpa65flL7h/bZ7t/UsCu9/57RYN0QHZ3X2+/9Lu/nZQKdh5u8WBypLLSFILzNmrmc2zMVEXWkeG7RfnWKcEJG6jIpKsSEaeNwBhwW+u32b9D5+GxGBPqcvwMv7d9+/XyRP5dSFIOro9FNYYvv8Tsf1t8kzwmmIkMyk+bZH9Mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587471; c=relaxed/simple;
	bh=XSuJmY7cKALHKYFhprMg07CpvRsQaB27YUDzpQM41Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPI6wvKrbeHAmSAuzCiaiOqXDHkAcy7rshgVxhWd8c8FOou/xy7k3v/CtgkBYEMa5VR5e/yzWxTv7PRr0AlW12p1zt/KwYSEfCvaPHEzal1KtKiSZAk3FZq20HOfXGeVZqo4eRAaOH6vB0QJoMbmwdtBvrMYjH20AqjbH37SwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6mhdYdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E44C4CEF1;
	Sat,  4 Oct 2025 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759587471;
	bh=XSuJmY7cKALHKYFhprMg07CpvRsQaB27YUDzpQM41Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a6mhdYdELvhfNdz3jQ+ldhH09HlCG2xJKt4SUvaevqgo4jKxOevbVXBqWzc6fIdEV
	 FBJAD5WYtRVDgrpG6vZwJigPBihwWNo/tHaLdIlxo0dZ0RUwhbSv+w2t6Ic5U+D1FB
	 Ch7lGOCwxKn81USOAPvI+DTK9tUTW2noW2iPrydFnfw8SAoDZrTSKH62PfE8uELxCF
	 5u2AQpRC9mF5VczB/J/AS2gmGNY8BIcVt9025zITm1J3yuacZSll3JQJ1ckU1j0WI7
	 SPd9w5ILzRq8iqd1yYmoIzACeXHSAdRI99AtDLczTAIHCBhB/fdOGmfbBD0E9+Y8pR
	 vLGxsfFAnHQ6g==
Date: Sat, 4 Oct 2025 15:17:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: temperature: add support for MCP998X
Message-ID: <20251004151741.3147e3e9@jic23-huawei>
In-Reply-To: <20250930133131.13797-3-victor.duicu@microchip.com>
References: <20250930133131.13797-1-victor.duicu@microchip.com>
	<20250930133131.13797-3-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 16:31:31 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D Multichannel
> Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>

Other than the request for a stronger set of reasoning for IIO rather than
hwmon this looks good to me.

We have plenty of time given where we are in the cycle to resolve that
question.

Thanks,

Jonathan

