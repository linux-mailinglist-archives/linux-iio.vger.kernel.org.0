Return-Path: <linux-iio+bounces-16429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890FA50313
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 16:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CCD188B6BB
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A633221F29;
	Wed,  5 Mar 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia/nhP6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DD24BC1A
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186680; cv=none; b=lGqiks+IEXAczUw44KTlDcdRg76irJpRqfEbWAMxiOroXkjfKcui0PVx/+zMJaozZB67A2HCZ2EVcESHN9IwWpMp+OoWL8xWmWX+4wU6+28DYakYuS4edAbzaX9EGMD1BgB/huyvqXeSAh4x2r08WP1NCAV/RRADNKo0fuzANoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186680; c=relaxed/simple;
	bh=bw4JDrruB07mBEjsvyL/FMwfNU8Uyd78yfHj0PwStJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt1zfhpt5oMYXhSAWfr6BUIqvjSs7K3AFlqo5GPichlamkE5/TP47WP/pNZw6OZyl7EJc27JOL1v/7mo9JK/S73WRa2V4cpwVidTOlJaQ6gEpfj3MTinwAinfuVXSrV8v+b+DsvHCfqknR11rQsfRym8PsIW3dfWsMhfJfEj2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia/nhP6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15835C4CED1;
	Wed,  5 Mar 2025 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186679;
	bh=bw4JDrruB07mBEjsvyL/FMwfNU8Uyd78yfHj0PwStJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ia/nhP6n0uvmS6WfGpEv45uv+K+5VOzdqSGjipsKrR8v/vjk0mZ6na4TlmNvvEqA6
	 NGG19Ibv/LBKPv+7laaVuMiXKxwBka9COuBJvCpJj7U46EV/AZ1lr3DVa+UrPtKIWw
	 Tm9fVzTNtFsNmFWldMs9hLjieAKLYrbUnqBY08Dtbnmb7vMkg78dqbS9u+w3Kc73+2
	 EC+5qZjLgGtvYtf04J9jTb0HovUIDFNJN0tFObdB1CHHYf/8ImtbdRBmQwnBP6Q7qP
	 yz6gcnbxRunXxR60mfEVXBFeWG32Avd2PqLJxGaf9+NZuhdB7XQYcJVsQey4Gwsonb
	 oYOS6Teb9APhw==
Date: Wed, 5 Mar 2025 14:57:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Siddharth Menon <simeddon@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: Siddharth Menon
Message-ID: <20250305145749.413fe30b@jic23-huawei>
In-Reply-To: <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
	<20250222151143.7ca7f718@jic23-huawei>
	<CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
	<Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> drivers/staging/iio/addac/adt7316*
> The device can communicate through I2C or SPI so could use regmap API to
> standardize data transfers in the driver.
> There was an old patch updating to regmap
> https://marc.info/?l=linux-iio&m=154853847705361&w=2.
> Aside from I2C related changes by and minor clean up changes, this driver hasn't
> got updates in a while.
> Suggested improvements:
> - Use regmap to standardize data transfers.
> - Add devicetree documentation.
> - Check/change if attributes can use standard ABI and document those that are specific.

This one is an interesting part - I have one somewhere from trying to help
on the previous go at cleaning it up.  One issue is that I couldn't manage
to get a stable SPI connection patched onto the dev board.  It kind of
worked if I used a long cable and did a rain dance, but not enough to really
test it.

Jonathan

