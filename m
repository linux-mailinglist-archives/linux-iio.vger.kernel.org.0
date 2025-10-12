Return-Path: <linux-iio+bounces-24969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B615BD0587
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBC13B415F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756B2E92C0;
	Sun, 12 Oct 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIqSGBpB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3F2E7F25;
	Sun, 12 Oct 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282512; cv=none; b=Uz+RXP0EijjXu8m05VYiN3eOPvKfnbpyFhTdGVVQ1suV48smrP1daWCMEPQRC51v7HVj7nn8JCPh/rmbHE1cBimg1nwim7J1Ag0loaRtAFG4zbYprbZNV7jlGxfoktMzBjt3QpWpq7sYGHln04zj2lCHvfj1IK6X6sAJYijVRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282512; c=relaxed/simple;
	bh=SWrzKb4wJYoPcIbHv/lsotFeJkau3gPD6PD+PGbyMog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=na35Eo2fq94gPolhsZdpfVn02qjUybcAMqwPi0MXehyaQkaV/pJAZzaqZEBFtLydbOG+bXFEtQYSh8/sT8NAQhWTwdzBQjSIfHtbl96jPzsR9fVI+pHVGveB1IsGESFbncpM11JfiXfBmuDUgZPULemA52bjNq5Qqj11+MRBFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIqSGBpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C4DC4CEE7;
	Sun, 12 Oct 2025 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282510;
	bh=SWrzKb4wJYoPcIbHv/lsotFeJkau3gPD6PD+PGbyMog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIqSGBpBNlsNXkPjBcCjTX+yCWDfqAm000ls9S9AQyZ1KIfNxWVRBLGXv5mO5kKoO
	 TtAetGJ5xQTy9yanfO/a/7XI86MoiWrHSP6ZdHJHqD+H40j5YF55yQKBES6NiyDv/D
	 IzjMhS7iEQePTA7xDf2ZRSjVeObhZFwnAcGkCyGm9iE2ERPC6CObpj567jasL8JDGm
	 0D1nxO9DvI58mwoonJZ/5y7AYpPsmAUL6iPY0FgwJ4EfPmQiHmDmKKbCi2wl4PX+KN
	 Wb8HjBGqaHxI/3FETFDvl705DWyTbDNehjj7pXuRcOk/VxGDM9lbLCDXaarOsPvmUq
	 anqnGslN8xLNA==
Date: Sun, 12 Oct 2025 16:21:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/19] iio: accel: bma220: add interrupt trigger
Message-ID: <20251012162141.2a36f10a@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-16-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-16-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:25 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add interrupt trigger.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

Thanks,

Jonathan

