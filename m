Return-Path: <linux-iio+bounces-24967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABECBBD0575
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D721883AB5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E02DCF6B;
	Sun, 12 Oct 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfqMpXro"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9472DF146;
	Sun, 12 Oct 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282422; cv=none; b=Duh9xq1KeCK+EdavIJWDKkPuU0iMIDdBONBTVYFwGbvsUYv94dZ3zB4yaIEip6FVL/ZfvwVX89zgo6wfFVFr9DObzAjoAkNUyMro8qx1RwKLqQ5N/ricaE0d3sYTQ2FTdxpazovxpC/QIOVYb+vu7s9a0D86d32CYkPyxP5fV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282422; c=relaxed/simple;
	bh=6MEEoi+Qo6A99+kAKvJx5dfVG4ArwUca2cn7HdLeKxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0ORCg59MU+zfpRY5cMWyhLO7djVfCX8XVkkzsR3u41qLC5eMZ5qcPzCJ8asWx0AEqVU/OmozM0FfBBWcXLpoedFTW7kMyZL7sTIgpUnAnmtLuS51PSbyXUK7WMuvJcLc9xQtd0dE96fVOeQ0f2RuP/MBLm9VRonJ+TqZFSChuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfqMpXro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F3C4CEE7;
	Sun, 12 Oct 2025 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282421;
	bh=6MEEoi+Qo6A99+kAKvJx5dfVG4ArwUca2cn7HdLeKxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NfqMpXro/qyXM5Bg9MD/LluBrt6dyRFo9UjBGJLDzA4rQmzQd+UcQ9Mgn7BKBmZEW
	 Vfd6CQju7V62A8RF4gbCO8FZY6/CGIw2RyDmeB5Ns9bUihukKfUIS6AgdeL9Sezdci
	 IpeIXeA98mm1N733aIUCZLNgz9lwMR4Tm3fKYGWcbs8VABbwbyamcTDmKI70DKY3Dr
	 1BGvKfsU84fYaHkKgbKXzbc63+C5hR8z4CoeD/NbuHBFF9tTbh1X1WJI3ImaRqGsQJ
	 R49O4Lpwfb64gELKyBlPkGJFm80ZKy5YNl1/VBMCFt4LfGT5QTLseRO77q8UBYoMj0
	 2MScrUUl6fTTg==
Date: Sun, 12 Oct 2025 16:20:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/19] iio: accel: bma220: use find_match_table fct
Message-ID: <20251012162012.5a659ff1@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-13-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-13-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:22 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Clean up the code a bit by using a find_match_table function.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied. Thanks!

