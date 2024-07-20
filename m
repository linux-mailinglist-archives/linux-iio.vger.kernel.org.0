Return-Path: <linux-iio+bounces-7734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C590C93816E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D31B21475
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5200E12D1F1;
	Sat, 20 Jul 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqgmnTZy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3328EB;
	Sat, 20 Jul 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721481178; cv=none; b=UK6w5WcHCOdiq/kaj6oLnzSC3cY5xHYMmaRbJ1KGf3dFVdh05X9WFkY+QHfNQt2aUnoscthZxeT5Zj+WLl6s7WXKFwcQ+9nJIYK4qTQT+Mip3P6Hw9VpETEEldWUcn/gbWGRwUwWTXZIBhrTzpfv57VgB5Y0SMVUYdPIpWmJWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721481178; c=relaxed/simple;
	bh=sNZYCj3islBACf17PqxU30DmV3RadDslk8NBxrpdoGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZrX0FXj/uqo9oL78Q5Wao+0Yf2azNhlg0LYNoaLMsGn41BmUYQQFVxe+AjWPwtpYwVK6oE/G9FOFLqFpMsNVjFXXb3jtrP6TC8l8pHMWQW1coSnx3OA+7Ywv7FSEqOafoOQHn6ZbndjaupEBohOK7fpn9zNhTsaYNHJKqgw0BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqgmnTZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A1C2BD10;
	Sat, 20 Jul 2024 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721481177;
	bh=sNZYCj3islBACf17PqxU30DmV3RadDslk8NBxrpdoGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqgmnTZypSAyJBUKKVqerUTAhfR4KIAitFzNsthdvrHqiSRPCJIYQRq23sH9S6J1Y
	 KS8i46ZyoyIX7sEl5VH+XFbsYVrj3fzzMOLQfK4q3mwldtEPO46Cs3KHG80clKnZjI
	 SyvC/fLQ8oTwAVqktrdH3VbXNY5ntlKL5N5sKt5siuCaQsYrGqKVCaOb3o+SVErpie
	 fkEb9Ao21N6khxgGcj0TvPiozRhu1i6CcwP/rsmwTJUVWuZ3eRBdYI9SHC7ENzX3hE
	 tetgcDxrsWyxr5Pihm9nziJfR/fM/hDNIIrZGy05jCa/tYLmIqG0W9oPiUXt4DhryD
	 PAQMiJthdm6Tg==
Date: Sat, 20 Jul 2024 14:12:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rayyan Ansari <rayyan@ansari.sh>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Robert
 Yang <decatf@gmail.com>, Rob Herring <robh@kernel.org>, Sean Rhodes
 <sean@starlabs.systems>
Subject: Re: [PATCH 0/3] KX022-1020 accel support + inertial sensors on
 msm8226-microsoft
Message-ID: <20240720141247.3b8c1364@jic23-huawei>
In-Reply-To: <20240714173431.54332-1-rayyan@ansari.sh>
References: <20240714173431.54332-1-rayyan@ansari.sh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jul 2024 18:33:02 +0100
Rayyan Ansari <rayyan@ansari.sh> wrote:

> Hi,
> The following patches:
> - Add support for the Kionix KX022-1020 accelerometer
> - Add the KX022-1020 accelerometer and AK09911 magnetometer to msm8x26
>   Lumia devices
Applied patches 1 and 2 to the iio.git tree testing branch.
That will be rebased on rc1, once available, and then be pushed out as
togreg which is the branch that linux-next etc pick up.

Thanks,

Jonathan

> 
> Thanks,
> Rayyan
> 
> Rayyan Ansari (3):
>   dt-bindings: iio: kionix,kxcjk1013: Document KX022-1020
>   iio: accel: kxcjk-1013: Add support for KX022-1020
>   ARM: dts: qcom: msm8226-microsoft-common: Add inertial sensors
> 
>  .../bindings/iio/accel/kionix,kxcjk1013.yaml  |  1 +
>  .../qcom/qcom-msm8226-microsoft-common.dtsi   | 26 +++++++++++++++++++
>  .../qcom-msm8226-microsoft-moneypenny.dts     |  3 +++
>  .../dts/qcom/qcom-msm8926-microsoft-tesla.dts |  3 +++
>  drivers/iio/accel/kxcjk-1013.c                |  8 ++++--
>  5 files changed, 39 insertions(+), 2 deletions(-)
> 


