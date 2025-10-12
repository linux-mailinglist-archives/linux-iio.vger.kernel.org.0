Return-Path: <linux-iio+bounces-24957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCEABD0397
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D1A1895368
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB72857C2;
	Sun, 12 Oct 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxMFyKaJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD428505C;
	Sun, 12 Oct 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279068; cv=none; b=lKh1COph9H1XJSnLxh/xWkG/T7moGJdy2SBRoQAo8MsohrorlJwP9bCopKardofexul4Ry9XGQOF+7RDgYaDj//B77XMqCANEf4dEsR2byAlvDFLHKJCOs0mR3DoThd+6+5tp1kdCYTG5WAi1Gx1tsHZt7DQYpPvX+sompW4qGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279068; c=relaxed/simple;
	bh=i5A5FC56+P1LHwoBpxOugENfxM4lW68hFZjPPPCAdgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoBvQZw+90hXMPt12r/IkxRpMsposT6MMdsITxWte3m2s00rLOCkvzB8uXdbUV6/Hl1GEoaTHHpYWXd6JOSJSsEyisYhYQgxEZyXN7gdWwtkCUM4/N8hCelIN/Z1F9/Ldg4Z7w4f+vczcjHaUWgyGnEaH7kLhQbeP/HTWAuj3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxMFyKaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF47C4CEE7;
	Sun, 12 Oct 2025 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760279068;
	bh=i5A5FC56+P1LHwoBpxOugENfxM4lW68hFZjPPPCAdgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxMFyKaJ+ij+Sg7Sql/fzLz53HVgPUXj2erh+3kC5bzdVGyASswdD2bKWbHPc7x8u
	 rjcVDsV7j0XChsrXA+2I6jplZ1Z/WZWE6oF2atKzesaRO0dWxYeHquXw7Z0iquOFlN
	 JMO5p9vjVbKzHkwrgVGPB432tMwxQCePCKkyWcqOYt1lgMDayfwyfEFQiygWrQyYzo
	 bar+0+c/gpYl7/SW4xNHvPYbTwqHKiv8r0qalL0dfofDByBUewdMrybrPwjoW/JVUb
	 b9QjkdLfXlbXJH2ktz9pAL9lfI0pM14z6Nh9uEacYIL1uy7eNQUBnKENel/b9KACO4
	 rOEZg1UtiHt3A==
Date: Sun, 12 Oct 2025 15:24:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] iio: accel: bma220: move bma220_power function
Message-ID: <20251012152418.758cf265@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-5-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-5-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:14 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Move bma220_power() before bma220_init() as a precursor to a
> patch that removes code duplication.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

