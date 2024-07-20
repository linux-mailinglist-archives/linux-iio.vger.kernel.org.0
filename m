Return-Path: <linux-iio+bounces-7753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F9938202
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8066281B5E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CA1487D4;
	Sat, 20 Jul 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIOSdjK1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227E12C48A
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491486; cv=none; b=rCnarZusc4dRahfr3RKF24Bh1hR/lBukIQGl5uSx8BDd2Vsd/NNmk/oYhlVlXGbG71gu9zZ9VPfXujJcyLhY26urh8VVjod8oeRiOppdPqLbV/vEhfsUnbbOwxQhViCNC/YD4YLa7Eq0voKKpOtfBzNLV2E6c716VuSXOBee+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491486; c=relaxed/simple;
	bh=im78+U55FBlyA62lj300z/cVxTMceSRNP+aaxWY8zhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVJERoguAoib66NrSZ8/aiWMgBKTC3L2VkMi9CmL32X0PB8eB59FKtiKZXOntGm68M7JHAuIuZ+UmIK4CPLPbXZrh+W/mXajzf6SD1Az9oVm7lgz4/QtnZhYzLMtMNPn6Mg8Q+ECoUVVsbnu2II0V517IWB3h4iGFR2cqLJJiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIOSdjK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AE2C2BD10;
	Sat, 20 Jul 2024 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491486;
	bh=im78+U55FBlyA62lj300z/cVxTMceSRNP+aaxWY8zhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZIOSdjK1OBPqIbwKEnFou6Bl7sKqXpMGN/HCvl3/o7oecLl3u++RvXM9dG7w+ofim
	 zFmWGZcy+u1AlKiYDTMuKwkGOl3vuxR5cmabc0BrEh+dHsz8EuOdqwcSxt7Z1j6G67
	 6Bp3DkpkOH4ciMUyLDryW8y495woUWx7bChDKbl/apBKeB82FAiBosqPSKcQi/VPU9
	 yzOQvkkyg5HFfrHLFXfZVmnpFVwbJU5CIpUKeirN/MUa9OVnWFqhO7U/7tklpb5dNI
	 h+QOqwcPAAymtHG/zZJ0bsCZzvjo0B3LxoWoi4hRgB6C7kdeSFKDLQhBPtuoukanro
	 tPmegGVBCymVg==
Date: Sat, 20 Jul 2024 17:04:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 06/22] iio: health: max30102: make use of
 iio_get_masklength()
Message-ID: <20240720170439.419e3053@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-6-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-6-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:52 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied

