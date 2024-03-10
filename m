Return-Path: <linux-iio+bounces-3443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B35E877767
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 16:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF45282174
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D93374D1;
	Sun, 10 Mar 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flH4xZUV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D12D792
	for <linux-iio@vger.kernel.org>; Sun, 10 Mar 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082922; cv=none; b=d6Yxa8DPJQucycJ5824YoFsYoIgPx0wG0SDpurNbXOyDYqpIiT1JUzXRcGB+Mv9VBelHkOVqUZFu4GtSMxcVffeHzXOhnQ87cncu37UwBtgvFLzz6aGZ9+yIvC3qBEb0gtHHHfej50keiFHWOpYyGyLRP6skuXhBi/cGhmYKVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082922; c=relaxed/simple;
	bh=VrS12fx9AUTpDkHUCLxVEKv1LXXabi0S0WZhPs5hkdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZGNnRhd+VgcIPEMr1NFPPRum7YMt0jrfdRTaRrW8JdeIvH17oDrs2aBeFVFBQYCFuaeGXCxqcR98pGVlZ5my8O8WCF50MKEHKqP5JDzbUbJyr0zjKMz33HAWRjWDKdpJ02KfDZ4DiuzgglXQIEFnqDJnMm5/I+eVSNLUiQYneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flH4xZUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64A1C433F1;
	Sun, 10 Mar 2024 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710082921;
	bh=VrS12fx9AUTpDkHUCLxVEKv1LXXabi0S0WZhPs5hkdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flH4xZUVppZupWI2eBSC9xTz/cBl9NORUC13gvp7tOuLJOGjL2ALr9rWIrWFNd+jI
	 QYkADIJfaGXyQnfeHGKkZoj9szeVm2Tqd8U8o0YBgtNbaKuhRIWJynuKs4qFt4mfwz
	 Q+muFhuG2QxCD1Dj2pks99sGIa4Kgr5uZ6o4LYUkiESL1cvTq6xPZZVhgE78X9HHub
	 IF6g1KEF462AXpe1nOgPxoUb4LbaVf1e8+pqmux2+rQ1j+PJ4+HLDltLmaQQxa61yT
	 /wKP2Jw1TwdkcTIHAVQwKRc6sBP0/tLNGXcaavok06PASMEOa23LyNy4OhrMyRaPBj
	 qkrcoj6GE1ChA==
Date: Sun, 10 Mar 2024 15:01:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2 2/4] iio: imu: inv_mpu6050: add WoM event as accel
 event
Message-ID: <20240310150148.4cf40aa6@jic23-huawei>
In-Reply-To: <20240308151023.379705-3-inv.git-commit@tdk.com>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
	<20240308151023.379705-3-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 15:10:21 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM (roc rising) event as accel x_or_y_or_z event for all
> chips >= MPU-6500. This requires to create new MPU-6500 channels
> as default and MPU-6050 channels for older chips.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
LGTM

