Return-Path: <linux-iio+bounces-7752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53169381FA
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85900281B4F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE5A13AD22;
	Sat, 20 Jul 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USnhWA3r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0311DDF6
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491437; cv=none; b=DxJM1UwtGLvq6f4CFmwb9w77l+gaSK/uc6icEekCDxOzwRu8t0L0KAfsZVNRx43V8WVBOAtx6F3BcAuYeHVRuWuGQ1CMs83E7YVD+wXKbWrK70IUbs2HomrkHopsflzLUPbLoWDGyhDcrVbXWKIK9umi9RS/zZtz2S7rwajEgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491437; c=relaxed/simple;
	bh=7Ga8XSH5la/4jgfLmAhlFibGGE4fKrHRerxumBZWh2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJ0XWbbi0dQKpSxub7EhKQZrGKetltx24IE6L2Q1Ie0GYXokdwwFbh6zK7g/GE0LO0QwynVP9hGI6Axefb/mSu1q9C7yP3+okkKE7bzo4g0XrcLJDcIST96oHQZij/Xj/tYJ/ZU3eMQdaj4/HBDfVXa7q/WjZHsw2EIfABJZeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USnhWA3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED9AC2BD10;
	Sat, 20 Jul 2024 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491436;
	bh=7Ga8XSH5la/4jgfLmAhlFibGGE4fKrHRerxumBZWh2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USnhWA3rZBjYT1zduUPN9oVHS6wDocxdKsQqmGIZL/iLqi4lhxb/9LuIVNvAdXUEx
	 38bH4U1NXvGnyDRIen6MMZqKNKYPVXAEGKbU3Q6THWCrxj1FASINGFP/fgXm496krJ
	 ZpNeQyjQG3RrGOKieaA+GXU3qp4ELqF9cPgBOX28xnxjvbVepY0RTn2CXnLZ//FdDp
	 CAF3n0TBNfdULqaWkviRYekJRGX3teAgA5aLiWAQej447Qc+WRBOFiRmjiC7DdP2CL
	 gso8d+EfFwHGpQIf30q8s7IZiDnR1WUh+M4zl4eg2QOPIngyy5gz/M9L2kLaEDFxpu
	 DoDlh4UaEs/XA==
Date: Sat, 20 Jul 2024 17:03:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 05/22] iio: health: afe4403: make use of
 iio_for_each_active_channel()
Message-ID: <20240720170349.3a6d2dac@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-5-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-5-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:51 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Applied

