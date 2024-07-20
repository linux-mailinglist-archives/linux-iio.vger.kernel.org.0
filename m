Return-Path: <linux-iio+bounces-7749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF79381F3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4FB214B2
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390B13C689;
	Sat, 20 Jul 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUlY6Vzw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440438F83
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491207; cv=none; b=Bdt0+VOY2Z1vSMkkNqgHbXHTrhG2yupk246ncaKAp01o1csKOxz7/QZl/jGmc9Bxv1rfEaGEhTGeqMeV9kpU4z78iMS0xdVWeJdSTXx6shxXMH5XrKHc+66rYt05HMKqCEyncWs1t5hitBenrvo+/BCLMtpVKiJxDQ3N+GYNZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491207; c=relaxed/simple;
	bh=hExF01a8SY09Nu5NOo6IYSm3CMrTMXBk+rADYsFF824=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az/YEXPzzDGwbB3DTnfAUfaEM0UhirQ8tA0MhZryy7MNc+N/B5JR4+BWB59/kxtxrXn8DAN5C6FQ2f+Wz4zwkJZ4QjVmBpvnnp7RiipzrbJMtisYM67l8VpA7DkVQ0rBkf2AlVoVMnhmdzoYF4BXHQUdqEqCGar0j7PBuB7P6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUlY6Vzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE37C2BD10;
	Sat, 20 Jul 2024 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491206;
	bh=hExF01a8SY09Nu5NOo6IYSm3CMrTMXBk+rADYsFF824=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUlY6VzwCiK8t0imin4NKGOhB+1kaaYfsI1jXBMdow8I7Os4WZy7BdRLMpv7JMzOw
	 v78xI1ea6igj3oMOTWBYAELcl/qWNeILoneb6hLD0N0GmsL+aAD5/u6cXzsWZDYCDI
	 iFc295L9CxA78VxlS5aFmG6VqRmWmrqCW3jJLKGOCLHDk37OxWgoLpoAqycoB+fLHW
	 s0ZaHVzKSBgP8/1zvbydoTSW20H0wJ8DYgYw/SshlVcDVgOEny763GyiG8UlVcVDzo
	 q9RHJDemX7ZaqNnItx4nVrBVB1wSxt/uLFJRfR7UwZ63i19ppS0uicptIdEN7nD5bd
	 rNOOfx3nWojvw==
Date: Sat, 20 Jul 2024 17:00:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 02/22] iio: adc: dln2-adc: use new '.masklength'
 accessors
Message-ID: <20240720170000.201b9640@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-2-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-2-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:48 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Make use of iio_get_masklength) and iio_for_each_active_channel() to
> access '.masklength' so it can be annotated as __private when there
> are no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied

