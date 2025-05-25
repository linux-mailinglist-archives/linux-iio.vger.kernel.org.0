Return-Path: <linux-iio+bounces-19907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F1AC35C2
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF51894510
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B81F791C;
	Sun, 25 May 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYz5nqsS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8D13A265;
	Sun, 25 May 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748192250; cv=none; b=VtaTdCxR74QpN7nJK6GhzP3FCeTMbU1y6pScTqRJRMXtjyuyvhEN40nzFpG8oOT/I5XD7CEj+1mFXg5v4HsfQgk8RVf4UarLV1Ftr7MRNqzgZBACy94qAs98K85X7NvoVTzhR8mEzFaX5VjvMtZPbgt+9yTLVlQEnqnlscQJsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748192250; c=relaxed/simple;
	bh=LvpXPK8omddopnkD/kBk2LAvftNHGFIktAVaV+ecyIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Diq2oJ71AvOPPUap3Xf5Jov2H03vngVJod3AxbqIEEDql/SAyl0kNN0B2++NzrqS4h/GEnzR++ZYT0lv96sNJoenSBodecPJ7E/i5BfazyPW51rfVNJvduNP81QNuAW9ucjg88SgKSlEWOJ7rMt5ITkHVEI3BSTrqoj2mQK3vX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYz5nqsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4426EC4CEEA;
	Sun, 25 May 2025 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748192250;
	bh=LvpXPK8omddopnkD/kBk2LAvftNHGFIktAVaV+ecyIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYz5nqsSotVEa9uCVOC35JPW6rNeBFZ++2gJVnuZG0A85wDQbBjVvye44uHGDu4B8
	 Krir70K6XzAOceJhZzvkQfABpINCJMtO6SzmFKRliGG6ZtT5uJxAbws5mYzLy82X8S
	 mmGC7nbNhqwDkZOdhogiB96L957OcAkvaLmjxCGbR2e4j5KPh++Xe7JLvICcd8hazN
	 zt/oSicufAxy4F7YMvsOidICquabh31nmVf9F8GgyQmkeiVV+yvCyRez4+2s0pKmjf
	 DImTJeciN16Ep5rTQrETuOywMLLGhSuRH2f2c6ZUEIlCXI9JeZ4/6yhvbPjTbyIrMg
	 U5lRBxckpSjIA==
Date: Sun, 25 May 2025 17:57:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 1/7] iio: accel: adxl345: extend sample frequency
 adjustments
Message-ID: <20250525175724.680908b7@jic23-huawei>
In-Reply-To: <20250510224405.17910-2-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
	<20250510224405.17910-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 22:43:59 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce enums and functions to work with the sample frequency
> adjustments. Let the sample frequency adjust via IIO and configure
> a reasonable default.
> 
> Replace the old static sample frequency handling. During adjustment of
> bw registers, measuring is disabled and afterwards enabled again.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied to the testing branch of iio.git.
Note I'll rebase that on rc1 once it is available.

Thanks,

Jonathan

