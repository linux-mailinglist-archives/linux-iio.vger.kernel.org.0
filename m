Return-Path: <linux-iio+bounces-22810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CFB28DF1
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E38AE2E7A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862F2DC34B;
	Sat, 16 Aug 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3fwggFD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3623504B;
	Sat, 16 Aug 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348836; cv=none; b=ZQA6i15sAK38/Y47wZwpRX9+a53niaUTvETZyAMqxEjxxdmS5UQ/T2zgAStRmCJdGpjCZbxtKIQULl3GRAnhjV4zTAwwCNfcjpYifMC22/S3sKxN1Dfpk3ZZSLv6lkXuQnfx39RJvazu+HOlWeVDomU0BYdi65sHUikcg9eYBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348836; c=relaxed/simple;
	bh=DXRkJYOupyO45vIGX4X0ydo+QBUCLJc/Y9OSIiLJPFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg7DKAnw1kCJQxWZt1lxKalCkfaGdRLVgQLf9GN38vMR5BKvbJz1sb8tRHL2yRDyRauHour3pVbUd054xTLO7+kMTEkmUFa0YF5brFC4HNzZZH2hSut+FbcTK0FtpFlCneDFv6YW3jFhVLQ1kjNyeP5ZNtIE033Ykwab8l60Pe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3fwggFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EEC4CEEF;
	Sat, 16 Aug 2025 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755348835;
	bh=DXRkJYOupyO45vIGX4X0ydo+QBUCLJc/Y9OSIiLJPFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3fwggFDOV0j/mcJ7UXEMeNrW3s2Gp3DkkI690tjVraUtj/P6uhUyexeB+NRw1mEd
	 r6q5pKVBDztbgJONSVdXFIuzBv/ViB+Q52QKfwWAvtpbpoXsDJNyOSaCoNyg57yNPm
	 cgG71e+2TJPo7LHKWFqY6OPYNgjoMm92Wjwsqm3F5fNmbo1vd6TXawy4EjRSIXqU8X
	 0g4PAUKL1dFVoM9xTQXf2AUvwvkxhF9qcC8zD8yn5a/8iE+dWIQM9BTtobVhDxKOgJ
	 QLQ2yfHhxaQYbmmptkWvfCFuxFirjZAMih74iF2GeaVeDV0wAyuqWWbLF8HhPCXpSr
	 zr/XB7fd+3CLA==
Date: Sat, 16 Aug 2025 13:53:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] iio: health: afe4403: Do not store dev pointer in
 device struct
Message-ID: <20250816135348.1f4372b1@jic23-huawei>
In-Reply-To: <20250813225840.576305-1-afd@ti.com>
References: <20250813225840.576305-1-afd@ti.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 17:58:35 -0500
Andrew Davis <afd@ti.com> wrote:

> The device *dev is only used in probe(), so no need to store it
> in the device local data struct. In all the places in probe()
> we did use that, just use a new local variable for the same.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
Applied

