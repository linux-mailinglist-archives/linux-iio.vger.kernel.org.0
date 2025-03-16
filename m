Return-Path: <linux-iio+bounces-16891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F18A63531
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B416C4E3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E019994F;
	Sun, 16 Mar 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHCa4ZWi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D08635E;
	Sun, 16 Mar 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123190; cv=none; b=KGFCfdj2JyIuOxOHLAuLD5KQ287nARVbBJPJISTaLPGNZmTehW+CdTKu6E/C2nKuGswp7VEUHd8bFrEWf4nbcozN1SdMNjicn7E2/kBwbr/UPLUAur+M9CQ0Bdr8dj7iTyruw462187dIDbXTLeGjrMHRmRU+krHf2UCrv76dAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123190; c=relaxed/simple;
	bh=wFzHR+uMoYZCqv2gAyzbwsm6Cu1G4Yyt3atEXZxmMwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYOksSamBzr4go6N+tYeaCgtFLSvKqreW/RI3wHd/Jb4J3ep7eIXYirsCFSI2v1utz8xsd0aov0n7q9Z6+mzwJSyBAsvSzfsRQ8nsC6VQpXkY16Bad89eE6lhdt+LYcSG63Las1tUx/FiO4qhqE8M2JRd8A1q+HURhv1dT/E+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHCa4ZWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C231C4CEDD;
	Sun, 16 Mar 2025 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123189;
	bh=wFzHR+uMoYZCqv2gAyzbwsm6Cu1G4Yyt3atEXZxmMwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHCa4ZWiEWE02tRjaEaLLJfFmYxEAVW9eR3/b3dUvBBD2edNMq9HHAOBXJK1WUuwt
	 ExOSZiwho3QOg4QJuOuQFraHAm7yChQa2oWWUFxU1B/DC/qF0fHy0T+a6gDA91kxuO
	 +jtDbJ3Y/C9GaAkpmOAHIzdtGj2s1WCueCtqrM1KdcppW13BsbObGrhdwUQExIyZ+7
	 Z6fCteEoC+i6faIOvFP8HgvCGaCcUn2fD3bPnIrbAIAo+8rsfxb+J2MsJ5KlfPAYxe
	 5E4u6GbigWtFyQiypXtip1tzRCHxpfPkwM/GxHtjzmIsJ5d2dvEnmcCC9ZayALEtCs
	 T3DRj9NfraO9g==
Date: Sun, 16 Mar 2025 11:06:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 01/14] iio: accel: adxl345: use regmap cache for INT
 mapping
Message-ID: <20250316110616.58193a25@jic23-huawei>
In-Reply-To: <20250313165049.48305-2-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:36 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Use regmap cache to replace the maintenance of the interrupt mapping
> state by a member variable intio. The interrupt mapping is initialized
> when the driver is probed, and it is perfectly cacheable.
> 
> The patch will still leave the function set_interrupts(). A follow up
> patch takes care of it, when cleaning up the INT enable register
> variable.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
I'm going to nibble away at this series applying what seems ready to me.

Applied this one.

Jonathan

