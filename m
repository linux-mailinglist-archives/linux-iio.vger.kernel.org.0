Return-Path: <linux-iio+bounces-12544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B39D69CB
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A6161736
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0136AF5;
	Sat, 23 Nov 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3PfvCFm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D32943F;
	Sat, 23 Nov 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377342; cv=none; b=NDcxgCrXWmi7jbx6fXAjkVYOXmyOWrmzmux2l87cZ0gDOD6oPgb1kxvisw1b4Aat73KJn0LYHooLZZ0Dq4Ibd5Pf7hvPGi8lpztaj0PvyPQ+y4KcjWXfo9q6rQbhMf9hZZbedZa5s6x+K225kS8JaYQ40ZcYdVkIsk5zWhXMJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377342; c=relaxed/simple;
	bh=UrZuEOQCxY11R79LlaiwgT6UhJd61HWvfGh38DuH1tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzB1/YZVipXxjKZX0OkDRUaQX2CELkjf5ecg9rfpl3vy71SGmn+8hJ5t3MAYJZYzCuEW/mwD0/e4XG/mPQtHL7F8gFY/zGodNx8Fa7421RwdQXEmMrLBMt4NpYni+rzEN2Zo0aTNcI5TebGdj0bATtIgL09uKqxejpvr9E+ZEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3PfvCFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF9DC4CECD;
	Sat, 23 Nov 2024 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377340;
	bh=UrZuEOQCxY11R79LlaiwgT6UhJd61HWvfGh38DuH1tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u3PfvCFma1p7Z2538nnn0VjQU6xXsXXtxEKPseooy65lPiWpYw3dibs1yWyPY+0tx
	 Ghb8coGnQZggEqZnzch+xKoLxS6Qn6i7if3PV9E3XN0B6XVvj2kf0ZxCC0JHp2p14+
	 AXpoV4i9BlUlbGkp0vTTHoRND9Xq3wIbTQAwRNGnm/ZxjTmOiD+z3T3CfTcx08WYI9
	 PKJb7mEenIXiEwHFf1MsZet8ODNFH0YKKMIyRDKiYXHR86vDIGCdDQe/ljMyWby3a0
	 kVJF2LXhV7PuCE3r5agQtp2aTHypXLxYrknbYXYcS/PcxlXLw15f36bhQg7W8UWZ5a
	 8LA277eZkCrTA==
Date: Sat, 23 Nov 2024 15:55:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] iio: dac: ltc2688: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20241123155532.597beb71@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-10-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-10-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:33 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Simplify the code by using devm_regulator_get_enable_read_voltage().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied

