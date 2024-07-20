Return-Path: <linux-iio+bounces-7748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A49381F1
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE11281FAA
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722913DDA8;
	Sat, 20 Jul 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO/+dBGO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D41946C
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491149; cv=none; b=gdWMowwF4T45BsLz7vA5rqQI04Z8gcpxy1BtPR5NWVD2g7zg9pC6kiX1wEnhp4lNJnhiW/WJ9a4gVL1u6GIundnxe40Et9NwPAwDIrI/wTk2wFrYCTZ0M9Vlwh7B+inChO4zBCQYa/L5cl6w6d08cl6L0I1gdCXwEa5S0FYLfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491149; c=relaxed/simple;
	bh=fpVGrFmuhJ8G0iUy3M+kU+RMf4p2D5QlVMDT5y+iVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH8TOcZ9E6bflRgXHkMaOjCKEQ8CBz4jZTRtQJW9qdtPZJBnacX/VI2hg4AnibR7fAse+ppEo2OjjSmFRxwjMTfOlK7aUWvyjBAZ+nkV4sly6PaxZwrTayjUW4QUCMmVoVN3rPnfg9EQBuUuzBacb/ss7kXY2itXp70yhZ2AGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO/+dBGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F2CC2BD10;
	Sat, 20 Jul 2024 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491149;
	bh=fpVGrFmuhJ8G0iUy3M+kU+RMf4p2D5QlVMDT5y+iVxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NO/+dBGO9+EPUJ5Bj3CXWYwHaxqjtFTWo3b6wANWwNpdk9Qs7/5J7P2whPJ9yrjpO
	 oS/h+yC32+ItGYwgBLK7Htmsa0+aIxofE1ljym2UDksW+pxyBvqkvKIN6msVmhwCDJ
	 cUi0trH9Hx6cMde7IkuvE6KjLvsE4mHL3IXpzU7hBDehddGt4A2Ib2JcmcUEsSYxQs
	 EMb5mHjOR4oIgRgU43dTenzdYzAKikcK5kA4HyAAIudq2H4M92iIuRCaxW6Nolk/n6
	 ur9mvfjtaKmJtXLj34zok93zMRNajOV8AfykmbfvIqsLYCJUMFBPVoePxvVh1GkycX
	 FCG9L+kyrwgLw==
Date: Sat, 20 Jul 2024 16:59:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 01/22] iio: adc: cc10001_adc: make use of
 iio_for_each_active_channel()
Message-ID: <20240720165902.6e0adcbe@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-1-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-1-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:47 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied

