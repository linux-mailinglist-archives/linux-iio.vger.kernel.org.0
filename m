Return-Path: <linux-iio+bounces-24958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB852BD03A0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D111895CA5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18425285C9A;
	Sun, 12 Oct 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcENMItr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7F285069;
	Sun, 12 Oct 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279137; cv=none; b=M/31mYTAmYzjCGoX1zjm2SYafqwFQNxcwToSmxUBVvib51sZeTs2gHiVim8zzSPEvTTNPadV4Ji9tfnX+hzTQSXJQWeQYfeSQA+axm75d2UQpp2NFcTF2zdSmmi9fyEEbMgjC1Kq70qvzZBvJuQ14utsSAKFjJdabzKmXLck5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279137; c=relaxed/simple;
	bh=rqAxVsZLB9ynYo2yzKCzUCaJyf/+t5Cyvb0v4RfTRUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQlUGDnW8X02VN+pgM+wSa4OBRQaJqV4jylfaIdiWLAbLskUEjnuQHfvIhOUaBUrl+c7E6aZkV+KGu9aC+cgVBIzW7+G1XK5BYElunnpF9KAGl8KJGBmzrJUTiWRrntrsmWZVsEPdgXHHadrMNFM9kHwUbE0jxR9r5+GoKNt24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcENMItr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F70C4CEE7;
	Sun, 12 Oct 2025 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760279137;
	bh=rqAxVsZLB9ynYo2yzKCzUCaJyf/+t5Cyvb0v4RfTRUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcENMItreWcdoi5KEMPlC4yQ7xPSueWmILUVCwpVZTujMZIyB6TWu0rhTVxEaa+O9
	 KJ85sk+OzoEEjTf0LERlwbTP8JIkv+ft+YzkfCiTMGUCYbqmEFv3UvrEdf6H5Z/Jek
	 VVuW7uyoYdp3oIBPazd7Co3/SP6wAOaUlFTNa1J5FTL1qaaF5/Dgu76ZBC/rCQ8DOu
	 DcFIBAfOZAYNAJbesuMU095Bj/jPm9KHDvHJmfBfvexdkXqBCZs5xDbtxNOELZUA0Z
	 Pf1Ks4YL0my+hMWBphB9ore+h1SaPqSMN9vgwld3HurV87IHRVjq0Vr1Aicic9V6lm
	 ysccHvvwicziA==
Date: Sun, 12 Oct 2025 15:25:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/19] iio: accel: bma220: cleanup includes
Message-ID: <20251012152528.2cf6bd95@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-6-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-6-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:15 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Tweak includes based on requirements.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

