Return-Path: <linux-iio+bounces-2357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ED68504FB
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F7B1F23062
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA245BAE8;
	Sat, 10 Feb 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riX6vxTh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82E53E2C
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579850; cv=none; b=hiDY1NJpRKaaBgXkG3/XIKpXuUULj+6fUa6mcH29moVoUqu1dX0hyP8T58Vxv9Y3SbTA7pf9WNtxUPFM0sZblb+kzPSuBNnkjeVJEPc5hSExsWW2Cl9fiBErWB90Dhbt9v/N5xxdGZHg1U1n3mlxxTxl/MDrbdmz1gTJq0i3C8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579850; c=relaxed/simple;
	bh=lDO2gNY+/jBavtfJuPho5vv2mhmQOU6ZtlY0pWTHT/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTyaiwMgz4SnF/KsLPJnnAjsVll8y1AL/r341wqeBKiSzIH/uhrIYhKIwa9bIUujkBiRNeqbXQ16zUsJRCOXdVrteRbDZIZRemMwmgeiDQbBofUQUWX2Eg9FN8f93HL+Z3iRcDxVomeojKntyngiDTE65hcWh2ZXdU1LoubNWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riX6vxTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50429C433C7;
	Sat, 10 Feb 2024 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707579850;
	bh=lDO2gNY+/jBavtfJuPho5vv2mhmQOU6ZtlY0pWTHT/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riX6vxThvdxgDyNPEJXj0q5UAqkZuo+X6OL88Qa1TPQs9xYZz7IOTGcFLk7CNhQtP
	 TVbn+gdwKzCFM2Z6I9CpZ4FwUMpOX5ryEuMZLLMOkjcFMjpffmoyp1cn6qH01xpjGp
	 utjygSarcSLNTCWTMUbd0xCb8yP0yOt9DQPWIA6+n/e/gYDIHakTUwmorLL6NTmVa6
	 FbB0o/GuUPaZVnWKyd/WzpOriugGpPoqWeObrb/4MUKeY/VjDSGES8hYx5fcgC7gRS
	 nY004IiYo9Nvi5HrhlQTQZE++/AXHMbqD2TacVn0krsHF49nuLqZB3W8zWzgM/oBQV
	 q/H6WRjRwfGmA==
Date: Sat, 10 Feb 2024 15:43:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] drivers/iio/accel/kxcjk-1013: Retrieve mount-matrix
 from ACPI Implement kxj_acpi_orientation to retrieve mount matrix from ACPI
 ROTM method
Message-ID: <20240210154359.4956d233@jic23-huawei>
In-Reply-To: <560489c23cb702e60d4f32c5b6c9f758d39841d2.1707426098.git.sean@starlabs.systems>
References: <560489c23cb702e60d4f32c5b6c9f758d39841d2.1707426098.git.sean@starlabs.systems>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Feb 2024 21:03:26 +0000
Sean Rhodes <sean@starlabs.systems> wrote:

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
I forgot to say - version number your patches...


