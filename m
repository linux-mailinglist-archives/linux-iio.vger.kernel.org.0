Return-Path: <linux-iio+bounces-24059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C0B56187
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E113BB5DC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869E2ECD05;
	Sat, 13 Sep 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEg/kbub"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4527442;
	Sat, 13 Sep 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773260; cv=none; b=ZTJl8ejkiA/rXRFKRUstodTEqAUBlOO1/7rj4BPr2PAaHv64Xp4PyEiS3UTyjA5TPvAyhPDRHEkLeBM4n/yw4r0IK8mcfZsNzluHT5XyXtLwZeBlobpnu+J9ZIpZ/7+ABcXigVEmH2CQTWfEy9185B5DgIURdS/YnJbOt5LDfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773260; c=relaxed/simple;
	bh=ydFsivNafldVowd7pihJmysBCa5WYsiDarIOK8yr6gA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWGiisKimkE9LftJ/6lz/hFfCgqF258wTr7RFMYncLev7fbdtB0SbdTWOcWfAK9gUW66RpLD1m9tfOsXtVvrPDn/I/rPchv9BodvAXv3wxGqulXi1bKxIWMFexVpjx1I+9Dd7yTDr60kUXMMpsHbTd2gBepYw82mTLyhTHnEy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEg/kbub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6CCC4CEEB;
	Sat, 13 Sep 2025 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757773259;
	bh=ydFsivNafldVowd7pihJmysBCa5WYsiDarIOK8yr6gA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEg/kbubYU5D/rDjohOlzxBs/75LXbtmoVoZkyLPpFVpgUMyF0Bv3wRUBZfrI+NB6
	 XUN2CfIdQpc4yy71raxvesgoy+0ZWJcRtqkEkZH8O2TKBks0BvadoAK5XGXsbYceLq
	 PheDPqt2fRdT+vuZq58eN8EQ/ckDf68viszo+PKFQwUy2uO4ey2hvq1OuuzGo+rn2v
	 u6QeQrqLUYY5D9gCW09YXu+7voLJpw4Use5g0b01Upq0esAKbGdy1zETmhhAy+xAhq
	 9LomIQOmGWJbflf8lQh01pxsbWJ13xdwF9I4uynslo06kUNs2RjY4KSLrDTglEuwMH
	 wC/Xcpp4LszZw==
Date: Sat, 13 Sep 2025 15:20:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andrew Davis <afd@ti.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: health: afe4403: Use
 devm_regulator_get_enable() helper
Message-ID: <20250913152052.134a4059@jic23-huawei>
In-Reply-To: <4e109905-347d-4830-aea6-a93d88252481@baylibre.com>
References: <20250813225840.576305-1-afd@ti.com>
	<20250813225840.576305-2-afd@ti.com>
	<4e109905-347d-4830-aea6-a93d88252481@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 18:12:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/13/25 5:58 PM, Andrew Davis wrote:
> > This takes care of both getting and enabling the regulator in one
> > function, it also handles the devm action, so remove that. Also
> > do not disable the regulator on suspend, this will be handled for  
> 
> I didn't know that this worked automatically. What is the mechanism
> that makes it work? I've seen lots of drivers doing the disable/
> enable in suspend/resume, so I just always assumed that was how one
> is supposed to do it.
> 
Hi Andrew

This question is still open, so I'll not pick the reset of the series
up until it's resolved.  I'm going to mark these in patchwork as
changes requested so will need a v2 now.


Jonathan

> > us. We now do not need to track the regulator at all, so drop it
> > from the device struct.
> > 
> > Signed-off-by: Andrew Davis <afd@ti.com>  


