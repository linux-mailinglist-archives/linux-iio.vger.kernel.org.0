Return-Path: <linux-iio+bounces-10814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9219A53E4
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C707E1F21EEA
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39D1917E7;
	Sun, 20 Oct 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGyPfDVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694ECEEC5;
	Sun, 20 Oct 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425192; cv=none; b=czdgef7IMC2LS9I+OzHDaKzvAe9O0hZ8JdkNaipl5eomffljvU61S+sBtaOs2fYyhobFlBSiuZtmdpTf8StM/RptZUxhzABuAoR4e2TWoJaRk9e7mzaqzAZJSLKiSAlkvyGGVP0mpBQclzPXvP5b/yxOqRJ43Aik4+8dpDMIlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425192; c=relaxed/simple;
	bh=04OPnXZgmY4xOt8YiZE2+SzjZlfkD/ELh6KNpmyBJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw7klVOjHUdNfFMSU5PV2eaEMkH2Kc5OBrm+lcNChPMNzoavyt0LoXs8Ht067A2Z97Kub7PNb7mabOOtolf0bkqIZ01pScq9TX/9kyS1XAkr7kdpXgDELBoIO4F0eAvfpU3pdbHwh5OOdY/CIf0o83YsWY6od/vshvbhaTY9Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGyPfDVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833DAC4CEC6;
	Sun, 20 Oct 2024 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729425192;
	bh=04OPnXZgmY4xOt8YiZE2+SzjZlfkD/ELh6KNpmyBJKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGyPfDVJDotA9OVEl8OpQePFT9aVcsMwmMNB6jMSjgCD9iHjhTdhwsEnrdJ7u17Am
	 Hrb3HFnTLufCZasJVNBfRCzgZPUxZ8ifORIRB/HjvhXkiuxR3A/X6a0ZLBUG0eoO6I
	 9ekimgzRhbKplEJegUFP4SB+mMCwjCCcDvivQTxtDDj387aLjFto/11i0wZLrPYQJQ
	 Mf1Csyg9DX0MCMHbzsgHXeKaMaNjlSIlbTCqvy+WO82LuZGb+iIS8EkT0fsm+xrOqj
	 QYoeOTkH3a39BtNiKVVWzT2CaKHhduTFBxrQ1/FtqUdDI0pRmgMKajhD6Kh4jK46fb
	 XRake2SlNEGqQ==
Date: Sun, 20 Oct 2024 12:53:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, George Mois
 <george.mois@analog.com>, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20241020125303.027939ea@jic23-huawei>
In-Reply-To: <20241014143204.30195-3-ramona.nechita@analog.com>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
	<20241014143204.30195-3-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 17:31:59 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> The filter mode / filter type property is used for ad4130
> and ad7779 drivers, therefore the ABI doc file for ad4130
> was removed, merging both of them in the sysfs-bus-iio.
> Since one of the drivers is available from 6.1, the version
> has been set to 6.1 for these attributes.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
You didn't pick up Andy's Reviewed-by on an earlier version.

Please be more careful with those in future!

