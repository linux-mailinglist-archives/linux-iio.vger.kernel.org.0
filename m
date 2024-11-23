Return-Path: <linux-iio+bounces-12540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E99D69C3
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27312161799
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11402E64A;
	Sat, 23 Nov 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5r81xRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AC18C0C;
	Sat, 23 Nov 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377124; cv=none; b=OTGfZiARKJhmtKmm1uxJDy4iixwTkSy2222pkuzrwHBSKPMqQEXko7UujyzvACd/35RMqCKeVFoo1yCqeAW12mMWmJ8qE6LGmH3r5TGLl8RLtkvKDd1IBli+dRHkpQ8/nd75jZMQqLVE/a+JgYmrekvXhlmy8QpHOuH4T7h0VoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377124; c=relaxed/simple;
	bh=3CGHvicSCiE0jpJg8cBsmpus5uCwiy6JNh4VAB2847Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITy9wTIHgJB7VM4zsWurwoCkyJTcfozxAhgrPBVlS2odPdj8s1smDpz0t0FMtKCGFMMpWpykJfiWAVp4amAcWU7nsa4QUIa2RXOwRXcO5viimQICMXHpvtGqDKd0RmzS/HlhUOymQYNVbu46O/rJp+FILskKFRzbuz9AEfwaIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5r81xRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049FC4CECD;
	Sat, 23 Nov 2024 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377124;
	bh=3CGHvicSCiE0jpJg8cBsmpus5uCwiy6JNh4VAB2847Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q5r81xRLiX4QRKVR6k1mLaXIr6rVaHTtM65yXGyFgztCFFWk8hKXRRl5A3WUZqHdY
	 QOAZp69zS3ais1bskvLTqUtsFW2sXAOd/B25I6CeOfNitTQnGmMpxmUzLzEj6SKwEy
	 ZGNFJ8h32A+rqiOTZez4azmkdDS5foKKd1TGkPk7kG7/wKXV3ay0l7l6Arxim9kid+
	 v7/Kief7XGVv0mEYGmc7m01GcHY+2mTD+SGv3A7bZQc0lSLxlhdHiZ7eVRLZcum8yG
	 +qi0f6cOuqmKvlay3cwaO4OwTMwbMkNiFZ107Eh2G0nxJHysfAgCReKrWkR6Ry8+b2
	 RdR+ECGuAkugQ==
Date: Sat, 23 Nov 2024 15:51:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] iio: dac: ad8801: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20241123155157.64b9d40e@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-6-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-6-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:29 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Simplify the code by using devm_regulator_get_enable_read_voltage().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Particularly nice saving in this one ;)

Applied.

