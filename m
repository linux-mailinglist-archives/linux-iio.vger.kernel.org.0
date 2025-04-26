Return-Path: <linux-iio+bounces-18698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5273A9DB9F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F277B1B63D93
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415361F873B;
	Sat, 26 Apr 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxW25hUd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39567081F
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679618; cv=none; b=ntJqsKv8j6bTOQSmBfczu1nd1hUtN5hEt6d9hjrJ/QanbvC0dCeciv6EqAd85uhNOQXKSidt8yN79shVx5tkaKi52Co+/0vrONxg7usqR+qJ2oX0+D6363g4UbD7C+yaOV5xcX+ITBs19HxUAfw1DhFhRWgLf8eic5MrZWHe+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679618; c=relaxed/simple;
	bh=LmIK+tlUCUSa6LTTOEI56QQEmLKcabIAywnKE+/B/ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNtV9uWQgwK74up8qbRu9o3ZDisjBAjcfWaVy4sriztIMfJquXz2nKYIcPuuAN9yNOx4KD+yYiRnhuXZTe1LttFVuc4Kisb8by0V9RJ0FTpQ5QyWKy2bxOq11VE9yL16m5RpStsWx//F3a59NlTlYAn1VKZZWiA1d9OEJ2m8FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxW25hUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A795CC4CEE2;
	Sat, 26 Apr 2025 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745679615;
	bh=LmIK+tlUCUSa6LTTOEI56QQEmLKcabIAywnKE+/B/ZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QxW25hUdVG5ucpeBIv8O5Hx5cHSKFYsv39f+Tj2wXNi079p0Ba2A7sqI78qmW9MxS
	 IWs4j2vYN1ALJCGCbd6s3QQdciwObusaFhrsnT4itm3ts++D8YBl92Is0LKkh1Fc52
	 93tkRthWIHUqxo1ncF72kmjLVxuLRaAqeqND7fmSwDWpvr24vSZREwGDLNeFYc2FOf
	 iQR3a5TttT6qp72H2lSMdLD5YPG5oHuLai4mdxXaNFvskTWlWK4TktBY+qMbFOutr6
	 HrqcPvS89fXRg3EOVNgH2tDa6z+lMZMR1BjPEt226UssRLRl4iFTdABQ+ib3um83n6
	 K0E37xGLN53Pw==
Date: Sat, 26 Apr 2025 16:00:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
Message-ID: <20250426160009.161b9f08@jic23-huawei>
In-Reply-To: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:23:28 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi,
> 
> After upgrading the kernel from 6.1 to 6.12 (also tested with
> linux-next), I started seeing the following warnings on a board
> populated with a Maxim MAX11601 ADC:
> 
> [    1.554029] max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> [    1.563627] max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> [    1.570439] max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> [    1.577328] max1363 1-0064: available_scan_mask 11 subset of 0. Never used
> [    1.584226] max1363 1-0064: available_scan_mask 12 subset of 0. Never used
> [    1.591119] max1363 1-0064: available_scan_mask 13 subset of 0. Never used
> [    1.598013] max1363 1-0064: available_scan_mask 8 subset of 1. Never used
> [    1.604817] max1363 1-0064: available_scan_mask 9 subset of 1. Never used
> [    1.611623] max1363 1-0064: available_scan_mask 10 subset of 1. Never used
> [    1.618516] max1363 1-0064: available_scan_mask 11 subset of 1. Never used
> [    1.625403] max1363 1-0064: available_scan_mask 12 subset of 1. Never used
> [    1.632293] max1363 1-0064: available_scan_mask 13 subset of 1. Never used
> [    1.639201] max1363 1-0064: available_scan_mask 8 subset of 2. Never used
> [    1.646002] max1363 1-0064: available_scan_mask 9 subset of 2. Never used
> [    1.652802] max1363 1-0064: available_scan_mask 10 subset of 2. Never used
> [    1.659691] max1363 1-0064: available_scan_mask 11 subset of 2. Never used
> [    1.666582] max1363 1-0064: available_scan_mask 12 subset of 2. Never used
> [    1.673478] max1363 1-0064: available_scan_mask 13 subset of 2. Never used
> [    1.680382] max1363 1-0064: available_scan_mask 8 subset of 3. Never used
> [    1.687183] max1363 1-0064: available_scan_mask 9 subset of 3. Never used
> [    1.693984] max1363 1-0064: available_scan_mask 10 subset of 3. Never used
> [    1.700871] max1363 1-0064: available_scan_mask 11 subset of 3. Never used
> [    1.707758] max1363 1-0064: available_scan_mask 12 subset of 3. Never used
> [    1.714645] max1363 1-0064: available_scan_mask 13 subset of 3. Never used
> [    1.721532] max1363 1-0064: available_scan_mask 8 subset of 4. Never used
> [    1.728332] max1363 1-0064: available_scan_mask 9 subset of 4. Never used
> [    1.735134] max1363 1-0064: available_scan_mask 10 subset of 4. Never used
> [    1.742022] max1363 1-0064: available_scan_mask 11 subset of 4. Never used
> [    1.748908] max1363 1-0064: available_scan_mask 12 subset of 4. Never used
> [    1.755796] max1363 1-0064: available_scan_mask 13 subset of 4. Never used
> [    1.762683] max1363 1-0064: available_scan_mask 8 subset of 5. Never used
> [    1.769484] max1363 1-0064: available_scan_mask 9 subset of 5. Never used
> [    1.776283] max1363 1-0064: available_scan_mask 10 subset of 5. Never used
> [    1.783171] max1363 1-0064: available_scan_mask 11 subset of 5. Never used
> [    1.790065] max1363 1-0064: available_scan_mask 12 subset of 5. Never used
> [    1.796955] max1363 1-0064: available_scan_mask 13 subset of 5. Never used
> [    1.803846] max1363 1-0064: available_scan_mask 7 subset of 6. Never used
> [    1.810646] max1363 1-0064: available_scan_mask 8 subset of 6. Never used
> [    1.817446] max1363 1-0064: available_scan_mask 9 subset of 6. Never used
> [    1.824246] max1363 1-0064: available_scan_mask 10 subset of 6. Never used
> [    1.831164] max1363 1-0064: available_scan_mask 11 subset of 6. Never used
> [    1.838053] max1363 1-0064: available_scan_mask 12 subset of 6. Never used
> [    1.844941] max1363 1-0064: available_scan_mask 13 subset of 6. Never used
> [    1.851828] max1363 1-0064: available_scan_mask 8 subset of 7. Never used
> [    1.858627] max1363 1-0064: available_scan_mask 9 subset of 7. Never used
> [    1.865424] max1363 1-0064: available_scan_mask 10 subset of 7. Never used
> [    1.872311] max1363 1-0064: available_scan_mask 11 subset of 7. Never used
> [    1.879197] max1363 1-0064: available_scan_mask 12 subset of 7. Never used
> [    1.886084] max1363 1-0064: available_scan_mask 13 subset of 7. Never used
> [    1.892971] max1363 1-0064: available_scan_mask 9 subset of 8. Never used
> [    1.899771] max1363 1-0064: available_scan_mask 10 subset of 8. Never used
> [    1.906657] max1363 1-0064: available_scan_mask 11 subset of 8. Never used
> [    1.913544] max1363 1-0064: available_scan_mask 12 subset of 8. Never used
> [    1.920430] max1363 1-0064: available_scan_mask 13 subset of 8. Never used
> [    1.927322] max1363 1-0064: available_scan_mask 10 subset of 9. Never used
> [    1.934210] max1363 1-0064: available_scan_mask 11 subset of 9. Never used
> [    1.941096] max1363 1-0064: available_scan_mask 12 subset of 9. Never used
> [    1.947980] max1363 1-0064: available_scan_mask 13 subset of 9. Never used
> [    1.954867] max1363 1-0064: available_scan_mask 11 subset of 10. Never used
> [    1.961841] max1363 1-0064: available_scan_mask 12 subset of 10. Never used
> [    1.968815] max1363 1-0064: available_scan_mask 13 subset of 10. Never used
> [    1.975789] max1363 1-0064: available_scan_mask 12 subset of 11. Never used
> [    1.982762] max1363 1-0064: available_scan_mask 13 subset of 11. Never used
> [    1.989735] max1363 1-0064: available_scan_mask 13 subset of 12. Never used
> 
> What is the correct way to fix these warnings?

Ah.  I think we have an order of modes bug.. Later entries should never be a subset
of earlier ones and we only recently added a sanity check on that.

static const enum max1363_modes max11607_mode_list[] = {
	_s0, _s1, _s2, _s3,
	s0to1, s0to2, s0to3,
	s2to3,
	d0m1, d2m3, d1m0, d3m2,
	d0m1to2m3, d1m0to3m2,
};

Is used to build available_scan_masks for this device.
I'm failing to correlate with the warnings but clearly s2to3 is a subset of s0to3
channels 2,3 vs 0,1,2,3

In general we should do a few things in here.

Reorder the enum max1363 to reflect the subset rule correctly (may be
fine from a quick look).
Use that to set the entries in the max1363_mode_table.
(I think it's fine today but we can enforce that).

Finally ensure we obey the rules for the individual mode_list tables.

With that stuff fixed we should remove possibility of enabling more
channels than strictly necessary (which is what that print is moaning about.)

As a trivial test, just reorder max11607_mode_list[] it might fix your warning.
I'm a bit unconvinced that this is the only issue though as we should have
only seen 7 is a subset of 6.

If you can dump the available_modes table that is generated that might let
us see what is causing there to be so many warnings.

Jonathan





  
> 
> Thanks,
> 
> Fabio Estevam


