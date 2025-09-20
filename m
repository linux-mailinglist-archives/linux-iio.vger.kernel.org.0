Return-Path: <linux-iio+bounces-24317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB8B8C694
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273A87B879D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB82F8BEE;
	Sat, 20 Sep 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt7Xtfqt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576AC2192EE;
	Sat, 20 Sep 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366500; cv=none; b=U7eudOQ5YSJcSwugXaomhojRVB1DmXNIcT/cRHDBoBZxIVu97MOkHU3p+7xPr9jOdCmCE5og/iHyq9M41IAIOb/ssfC+ph+9Ew8eCcTa0kwS5rt+H/s0dfLKDa5gJ5SINGrIXrp7KgNEs+QVNjXnQEIGfWZ+HOd+Q5lLchPNoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366500; c=relaxed/simple;
	bh=i3xP8oero5Zp4wMgbI+vU+tBFQEgFJH6yGJ7DhP5gHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2htWMzXyXJAyb5mlzKZkXu8EXVWp+mpqnrfZZG9KEv/k+Q5B2ibdhrBfWvn7JgyULMOsAT70eBTrGfNi3N3HXnwEzGhX1/3q7yy039Wt0Yu4wb+5xZ0OEFEQuV0WpP1x5kdQcYZrAzFwhHg3307d6u/IxoluqNdgzveebN4dDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt7Xtfqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF3C4CEEB;
	Sat, 20 Sep 2025 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366497;
	bh=i3xP8oero5Zp4wMgbI+vU+tBFQEgFJH6yGJ7DhP5gHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yt7XtfqtzkvR6ke7jTkpZOWhg2Rw6iC0fQclnmtPG5wBE06OI9wgriYM/T4uLrbRF
	 lFH62n8Z02BzHWAGwfkIWJX9mmsrAuPONxnDaSvPgrR1O1+QiNKCt7sEkOL6fPkpZt
	 BdRNSa8BKhDbOJROXUQk3lB3O6QbxaF88IlVruSXEEHtUywU6P0N8C/3C1XJOkf5Ox
	 KOkFWWEk4zHHa5rWSj9x2BLr5x5Yxej0zq9ezalVm0Ev4mor6846Yi2eUaYxv3kH/1
	 GwePZwfeY37yC1dQjW4mdY6nyQCDhPk+0zoKy1DMidTx029jKf+hf0HIc72aK4pdJv
	 NiVGKY8fO+tbQ==
Date: Sat, 20 Sep 2025 12:08:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: adc: ad7124: remove
 __ad7124_set_channel()
Message-ID: <20250920120809.0d62a503@jic23-huawei>
In-Reply-To: <1f8bace0-081d-4197-89f5-cb5aeee04752@baylibre.com>
References: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
	<1f8bace0-081d-4197-89f5-cb5aeee04752@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 16:52:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> For some reason I put drivers: in the subject, which should not be there.
> 

Tweaked that and applied to iio.git/testing

thanks,

Jonathan

