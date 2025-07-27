Return-Path: <linux-iio+bounces-22057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FAB13067
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656193B39B4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F521C9E4;
	Sun, 27 Jul 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooizW+zc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA133EEC3;
	Sun, 27 Jul 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633494; cv=none; b=Mj6YDJxda7nrixBReK79LVwe9b/LKutWm6Kc6JMWAkKXHb/Yp74CppLKBCWGskUK5LTBFKSOgBoDYxaoCo8roXDfy4F0OSKQGM/4MQMQe/FT7Rq7Hrdn111owV++JC8vyC39zr/s/aFnioVZ3kMGlXVs66dGS7RIvlkewaGX3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633494; c=relaxed/simple;
	bh=uNgQDLt2+zV1bI+Fj2vOjS7Mbh8fQCqDg72+fS9+Vr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XokTaaFbEGvbD5FAUdhs0JzWO+3yfumia10tcuzrEmLDQOq2Zn46Jw3Kks/azPpaLDSGOgOgfjY/MQ1NoVDCD4tTQmagz99UivRrd2Ir7CMpjhn3RD3j6VJGY86/xKM4yCPTRsdcskVqxOuBReHDDuKqUZ4UmUaHW0jvKUXDhs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooizW+zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92F0C4CEEB;
	Sun, 27 Jul 2025 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753633493;
	bh=uNgQDLt2+zV1bI+Fj2vOjS7Mbh8fQCqDg72+fS9+Vr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooizW+zc+sNNVPIbeEILg+0HrcJwJ3xzHAQtHdAMoAJvqJ+UuQhKGXm2mTRTa00n0
	 ozv0+tiwJ5YF8PiopW4SOp3bdfWcQc/Xiri1wtz9IWsZt3/PriNyXWXHPkS55YfHr/
	 GKn0u4KyX6DGc4kk5PkobOa1vK+8tefeG5YKA9nMu6Mr2gajJoSjKLA7BHIFs6km2r
	 YhdSuN46g3U/im/dm5xwh+pffKkZTFo2WcXUsXkBLEMc7GClSp2hFukncHv3Hnn110
	 Hnixn4FuXuKsS/Rk8ESyrr5txYVFD6pKabHA12dVYAXpUwDCrUTGElyVgjSVHknVIS
	 kWcyimBTUuoUA==
Date: Sun, 27 Jul 2025 17:24:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
Message-ID: <20250727172445.1b19d0c3@jic23-huawei>
In-Reply-To: <20250715012023.2050178-4-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-4-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 21:20:19 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> Add an API to notify consumers about events. Events still need to be
> enabled using the iio_read_event/iio_write_event functions. Of course,
> userspace can also manipulate the enabled events. I don't think this is
> too much of an issue, since userspace can also manipulate the event
> thresholds. But enabling events may cause existing programs to be
> surprised when they get something unexpected. Maybe we should set the
> interface as busy when there are any in-kernel listeners?
I think we definitely want that to be an option.  

> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>


