Return-Path: <linux-iio+bounces-7754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4393820B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE701F21E81
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4D1459E8;
	Sat, 20 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGmmnOBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B912C48A
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491550; cv=none; b=Ri4sfmROYiUmx8rxpv6b+9PBeTkW8VlmBivZgCChosGVPvPI8zCEuAnNv/oIDaX2/ZROTdypG9VCqd+Nsfx6T3/fy2yVfnYHh4EtuLpH6SjferdM5U+Q/4htvaibvLkjebK22gj8pOfww0Br/Okj2S/tz9yoWJQP/bs1jiHDsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491550; c=relaxed/simple;
	bh=KFW2tYLFM3s3ndkfDRYSOhurQXeCzPYhr77THsh35JI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoUIE9272HOg7WhyHJydABjR3umrFSarabZPwgVW0d8DooOunTeewi+frrKGdBWacQjSD9Jzguj3UZly1MuS+WUX8ut7qR6EBrTVaFjZo9/HXWI+PIdwlecbnp4jyAlhzth7rajOQxkal3+Z65D50sr7jEN3iESbG8SJZBziicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGmmnOBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA40C2BD10;
	Sat, 20 Jul 2024 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491549;
	bh=KFW2tYLFM3s3ndkfDRYSOhurQXeCzPYhr77THsh35JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGmmnOBW0nJNXYfUP7yx/gJkU/AWkHY21I8iKPDTdmg55FWFIuyodnU/ALyjqLvZP
	 tz/7ET/dqVIXb7jW7yjBeF2wfOtEBPGCsR4Z2naOl6qAU1xNPecDmvDIuqOIFuu6C1
	 eGasIoYXy8sgEN2DGBSq2ClE8jMxKpRIQ1jk1ITzSTROJlFV0azq7s4nrCBj9gb6RB
	 nSVXYW8tW9bzmZKPCnR/QwS8ewgBEbFP2yaWcZgvEpTpzlaD9Q4iLk63vl0qtu0rKB
	 dJaGpelptXQtdSeAo/xytTl+xZQ7S71hRlx8TcrpYMKb96M8RIyMB58fWe6BKBDSm9
	 z4smgeOcXnmLg==
Date: Sat, 20 Jul 2024 17:05:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 07/22] iio: health: afe4404: make use of
 iio_for_each_active_channel()
Message-ID: <20240720170544.37306653@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-7-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-7-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:53 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied.
Hmm. Maybe I should have been optimistic an looked through whole lot
first so as to save on emails ;)


