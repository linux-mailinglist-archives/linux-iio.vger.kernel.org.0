Return-Path: <linux-iio+bounces-20320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD31AD1346
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC923AAB19
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87B194137;
	Sun,  8 Jun 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfzkxT2t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8E2110;
	Sun,  8 Jun 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399803; cv=none; b=EIf6kirfR5ZZLf/P79FQ1D7CZ/7yB1S9THNjpcc/uDrwGy8Aymz12fQML37FlELPzXyuwVm7eePnTsYPAyaiJBn66YnUWsbLg7/l8LxuVSbphpOEBf7tN46DFbBqEyhmxAAo/bo8b0wlXJwWva1VQn7f4xZHSdq/kLuhtFNkWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399803; c=relaxed/simple;
	bh=C2+YF0UfT2EvcfpzmIRdivWGcxOEWCI411dt/lrF0qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C517pLqtGEjV8S/7xoa2yJ0ll6RUpE6/SIzXDTo18kik4YPQT5lBwVUSN0PQbD8OLefrJF5pX5Kv7llz/piCbb6ZuFYJAxgZNy5ngwFVvPU+pDXWNpP9982cIoIi0lyTBPpycZoXh7SxZd/NGjwB80ai1FWcWVXnZMi7dYtmH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfzkxT2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC2BC4CEEE;
	Sun,  8 Jun 2025 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749399803;
	bh=C2+YF0UfT2EvcfpzmIRdivWGcxOEWCI411dt/lrF0qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OfzkxT2tBsCbeYrOdeBd0p3paFnNtjFwdHP5SqHZgiFOdyq8rdVqCioDGspQL5JK6
	 u5I7XesUsNoVvfdWpwGQtOx33QLFkfltKHkBMwurXSF4zKgZXKxoLjvLgj3J/XqG5O
	 J2QWBf9layTEUjxSrm7Q6L79/qr2pCaVafdDPL8N3pKX50osWqBuKtbQ+JTOFbOIdH
	 cpQzRjEDNHajf+bbTTuzzuMWSuFj7rZ8UMt6iP9dJrWrwDjSieVgrUE/aFndu6hbWr
	 LQZoy3kdsBe8gr1GlEvCRmOOUT1UwFSo5DWxmENRoV9Bn/x/ERR8tokzrPcQKiddhw
	 2PjVQYkfUDPKw==
Date: Sun, 8 Jun 2025 17:23:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] iio: accel: adxl313: add AC coupled
 activity/inactivity events
Message-ID: <20250608172317.63473b9b@jic23-huawei>
In-Reply-To: <20250601172139.59156-11-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add AC coupling activity and inactivity as MAG_ADAPTIVE events. This adds
> up an additional set of threshold and period handles, verifies matching
> disabling functionality and extends setting the link bit to complementary
> event configurations.
> 
> This means, e.g. either ACTIVITY or ACTIVITY_AC can be enabled. The most
> recent set will remain configured. Disabling ACTIVITY where ACTIVITY_AC was
> enabled is ignored, since it does not match (should be disabling
> ACTIVITY_AC). When INACTIVITY or INACTIVITY_AC is also enabled, the link
> bit will be set. Note, having the link bit and auto-sleep in place activity
> and inactivity indicate the power save state change and thus will only be
> triggered once a state transition occurs. Since there is a separate AC bit
> for ACTIVITY and for INACTIVITY, events can be linked independently from
> each other i.e. ACTIVITY can be linked to INACTIVITY_AC for instance.
> 
> When one of both is disabled, the link bit will be removed. Hence, the
> remaining event will not indicate a plain state change anymore, but occur
> as a periodically triggered inactivity event or for each activity event
> above the threshold.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Minor thought on rereading this.  If we don't have the link bit set
(and the paired event) the AC events are more accurately described as
MAG_REFERENCED as they are referenced simply to whatever acceleration
was going on when they were first enabled.   Only with the link bit
set (and the other event type enabled) are they actually adapting 
(so MAG_ADAPTIVE).


Maybe there is room to use that to ultimately control whether the
link bit is set or not (putting aside the power aspect of that).
 

