Return-Path: <linux-iio+bounces-9072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E16969CAC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD411F24418
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8921A42C2;
	Tue,  3 Sep 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV6aPb6H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433621B12C9;
	Tue,  3 Sep 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364839; cv=none; b=F9oCdplzZGKAklU7Ivuae9NEmc5dk1sFrxCAERVgJ9/vnRFlfDTgWaF9fkAR8zStwgMzeXUJyA2ExDLrGXxX3O0sUhxXpGgiamaWv3q86DmOCgRGe9XMae4meAmBlchXJW9anMXjXqrvFTXC3rkXXBLG+qAObyISAtnCfFmUr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364839; c=relaxed/simple;
	bh=g2ZKAzl4TOr6g6D8RpdLS2IQ1wzoftOGfyWpkv+/mgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=adnnqw5/uICVHNcBJefMBh1Z/9qCcyuPBXbmDaaOsBo7uNhK6za7l57ANiW9YDeo0/LHNbjInAG7hpnXzJ3rDnsK1zfChknqenLCq7l08eMgnMfIACilmWxf3cJrk9Nbvd1yJPmGdZTul7pFkELB7EkULj2ulWLaligkUOfHZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV6aPb6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D06EC4CEC4;
	Tue,  3 Sep 2024 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725364838;
	bh=g2ZKAzl4TOr6g6D8RpdLS2IQ1wzoftOGfyWpkv+/mgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uV6aPb6HKWWyPuMEeFUV6udCZxdPeQpFWbojR0DAcR1HMlDPFL6kEXaTHQ5o/0z2a
	 l1pimPTeWLNmEJEYwzMh3sQGvBPqM2F67T9psoDXPIh1z8Af0JyzLNamB8ebV5eHdQ
	 6eI8cOdTACjz/y2llRTS7RfTrwRxlLLwUdF59naai1z0HnWPcwNXTUr1+daQPz+PER
	 uXOxrjHtC8aMkpxHegYUb/rTNmqtRnRKdoYeXUAd/UOoAEw/vdn814LsEn4x1T+3ka
	 by39wg70MvdmZl9kZCJkbUS4p5c17qU3yd6x/VvZk8ox5WiEE/VbFC9blGvzi5cnoB
	 ykbywHmc/wbFQ==
Date: Tue, 3 Sep 2024 14:00:36 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
cc: jic23@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org, 
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-custom: Convert comma to semicolon
In-Reply-To: <20240903025010.493843-1-nichen@iscas.ac.cn>
Message-ID: <nycvar.YFH.7.76.2409031400280.31206@cbobk.fhfr.pm>
References: <20240903025010.493843-1-nichen@iscas.ac.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Sep 2024, Chen Ni wrote:

> Replace a comma between expression statements by a semicolon.

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs


