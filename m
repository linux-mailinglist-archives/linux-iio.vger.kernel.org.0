Return-Path: <linux-iio+bounces-24239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D8B829DE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 04:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB161C807B4
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E1235050;
	Thu, 18 Sep 2025 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiEd8KC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89B2629D;
	Thu, 18 Sep 2025 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161341; cv=none; b=u8hv3p6MQQwxzmm7pzmVoekXnC7uN6t13omOWMIBAWrriNwERu0F/FumbAUyH4EM3zhmb1qwzyhTYhLY4sON3WckTcwIXUIlpLcQdprktXwv3la0zxPBZbes3eQbE5hiSfppOuUAA/zQizanXMXIUWZ7ZY/otOG0gyvj0r5vJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161341; c=relaxed/simple;
	bh=uFCVuLS9FONMgDNghTO7S8MUxH9RID83Er5IyfEHK/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AauM7Fy2/clKk1WX2jLMJBefwqyzpWTGtdMI1N8089xegbScse/S56HUSVHevbE5S5UsEFaXdenhjYkViHV3tceMROVtkLiwzoi89BnhKrEzFc62m1SJ2i6s2/umV/ixmSeaIISAgFnIfhIuwB6dJU/69i4NjsJZ6zpSHdYQ5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiEd8KC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05E6C4CEE7;
	Thu, 18 Sep 2025 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758161341;
	bh=uFCVuLS9FONMgDNghTO7S8MUxH9RID83Er5IyfEHK/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiEd8KC6ND1FemX4BP6D9dxiom7gzcIX3j1FUvLN6Nh3Pw9vK6dcTr4qsVrz3IJsX
	 4bizlYedi9y7rlebJFE+JQiwVLVsg0mFRjXExUh27Q+3glGaOxxIrSd1So07PZWkKW
	 gMNdpDnViVOrM+UAizgC6vWXvHjxd04IhdAlS7p7MrvsqZVt+h+DDtd+Ns26BQsyvv
	 F88wBOez9cHIfhrfEzdFYtZaE+VfUw0iyIXS6G7ekFvXa944fNFT2INbI87mgXnKqI
	 +UeLItjln38SkOcmiKFmrKDpvCkOw5D1jxxXanXkV/1ol0lhIr6AffaBErRexCiOMn
	 l7504rcG3BhTA==
Date: Thu, 18 Sep 2025 11:08:59 +0900
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/18] dt-bindings: iio: accel: bosch,bma220 set irq
 type in example block
Message-ID: <20250918-brave-khaki-sloth-b0b7dd@kuoka>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-3-0b97279b4e45@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913-b4-bma220_improvements-v3-3-0b97279b4e45@subdimension.ro>

On Sat, Sep 13, 2025 at 06:39:24PM +0300, Petre Rodan wrote:
> Set the interrupt type to rising edge within the example block in order
> to match the new driver.
> 
> The entry that got replaced was not in use by the original driver.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


