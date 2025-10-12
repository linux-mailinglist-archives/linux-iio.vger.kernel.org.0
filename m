Return-Path: <linux-iio+bounces-24956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E4BD038E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 334674E8438
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689D190664;
	Sun, 12 Oct 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQoUkHJH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4F285053;
	Sun, 12 Oct 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279016; cv=none; b=DLUyooUurKH5giZo6QhfN9dIOryu8MosgSSQnT7/zWbMNEz5mOltJMTsO68K5rK0ec+2swdCo0dT7bz89SuClVQEKkN/UENMft788tPqqQxm8PxlKa4Wr67w9McCtWTGDIrDMOjXtCP9A/HjTFTN0LLE6NCrD47Jf2il7X+yGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279016; c=relaxed/simple;
	bh=LyBDNc5VI8NuhLRMfMr1lC5kpHYdDF+yvdrqL5yjqVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWRKrge+FnnhEqGLJEYDxf05s5zoQ2ILIAXKA1QeddkzmDMV8e+2ES3p9HnkbWx7HWHM0fBQ1WM26tuO8Q+b7zDzRg5Rq5CsvXLT7j8Jt6lQ/ywvmGTPDgBm5NCkfL8qnJIM+swsb9QHOQfTCV3uVka+VEsmR9OM1EkBBUP8+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQoUkHJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C7FC116C6;
	Sun, 12 Oct 2025 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760279016;
	bh=LyBDNc5VI8NuhLRMfMr1lC5kpHYdDF+yvdrqL5yjqVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qQoUkHJH3YAJZMKjv2d53f9kR7jQc6kPVYhs30bp6mahLpmTlWvJ4BdVey/0yBroK
	 sbaQnQQ4Z+rFWyNNE2LFFXQ4KDPd0jKTd+fvWUbB4dRXfaPLE0ZUEIlJTx4RvTJviq
	 L7FlGnim2a3IpzLOF0r0R4/aQc7YfFBrSKDFkQPf+7R2krobwSRIhDAlOZyRXN3ic6
	 +fm0yCEf8Hvt1PIABuMUp7b0dPfgLXpnePjGv0R3n0C1PVsMiTIONIuJrbxj9X00Lh
	 GHa7Lmx2VDQoW7rgH9T4YYgfEG1FLcwHPd0A4ADS9JDf2GollL9HcTcqshyvjUXMUz
	 uFENw9uMclRvQ==
Date: Sun, 12 Oct 2025 15:23:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] iio: accel: bma220: shorten spi->dev calls
Message-ID: <20251012152326.3f3526dc@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-4-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-4-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:13 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Provide functions easier access to device struct.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

