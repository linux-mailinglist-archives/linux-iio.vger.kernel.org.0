Return-Path: <linux-iio+bounces-21119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975F2AECEDC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC213AF72A
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA92253AE;
	Sun, 29 Jun 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3cDJ/pV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643661EFF92;
	Sun, 29 Jun 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216711; cv=none; b=D6gOZASJhUNLdokdY186BiRsNDrZhkzJNb8B7822t6eHn1t0Yof0HAleQv29R21k37wh0hh2zmUJDNXk1VfMZzurwmvuU6avHwkrEw3Fmq7anWkxV0O+ueVBW/ePKuwZcuQWqYDvhmaoXacR7ULsnsbGbD4nxcpPhz9XgjvamaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216711; c=relaxed/simple;
	bh=hrDcifA5goRGo/uoBjsq/GF2DXr2z0mAFrft4lsImGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aezlhXdvzQKsLC9IUBWNhcbBf1V+tV4TqijaCvPJ6Xh61OrjzXnkpPT0ZfC8W+FWsWPj3ndVErlGUtDPyFKf71Oj+uvc4qrV+e89V7lMKMsoyeggkNGvlW7qIBCBUcJhDitq8CVvmiiMFsLemFFjoqnG31nBNKgh1TV9EHZkkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3cDJ/pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEE7C4CEEB;
	Sun, 29 Jun 2025 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216711;
	bh=hrDcifA5goRGo/uoBjsq/GF2DXr2z0mAFrft4lsImGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3cDJ/pVhT3MzphtVB4zffKi8+mDC4DAn9S4Z0KTBTjxaPyi9234Y6ysbjGTyPaJJ
	 Tg8A3OyZNDp9hzi+QslD3d251KE0t19WEwAAay9GRZFKvMJDQ6cpaWPfBZFgfM0Hkd
	 m9m06ufYoaIgEipOwKy5AhOzL/DunJwiWGkQ7tqsfsoorFzWlx0mNSU9lwOEFG/+he
	 yHqKTErVS6rQHle/g4PuHWZajmqpftOANIrapYwlma6lOVCmOEV2cbsFt6f4OYU+ZS
	 1SOG/QCATn4++gMADilW4aaBxwDIIOblJC73KR8PognTgGVL7Rq6pVFHermTt/7E+m
	 jJrAw47+L8XvQ==
Date: Sun, 29 Jun 2025 18:05:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-ezo-sensor: make atlas_ezo_devices
 const
Message-ID: <20250629180504.0b57eecc@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-13-v1-1-2a7fd592a07c@baylibre.com>
References: <20250628-iio-const-data-13-v1-1-2a7fd592a07c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:06:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct atlas_ezo_device atlas_ezo_devices[]. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

