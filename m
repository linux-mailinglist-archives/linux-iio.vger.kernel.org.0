Return-Path: <linux-iio+bounces-23177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBCB32E18
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E79486383
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0E244673;
	Sun, 24 Aug 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyfkA1IK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E1393DF4;
	Sun, 24 Aug 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756022791; cv=none; b=C7uUn8bRUk1qrkdlF3re6numJAj6ZkR/EHEMMirLMxPeuQVHa+EiY/ccBQYLunrkGzoOIevJnhDtWsk9UtPtAE6ThmblehagVrzv/TyuzgobWJx9Br1BQSn8TYLCf0KKZNQJT3TOMKJZRskNM5SMsthseUYS7PicsNJ/11Sd4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756022791; c=relaxed/simple;
	bh=w4ru9Ckeny+k2OjrihK96QUfV39aJCsiSbwXD6qXk2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reVVe281bdpCDOmMc1TjT+2AY9Zy5kjYniGCl1owiB8RfCxA8ytS26ZwY7XcMlopc3BlLj7BbmLx/pIPG3tQQT7vg9aLE7J2nG6uFW9Jzl4/V/+kN0i3nNUVWLbqJYl0WPWCBIW+7YsamJt4jy1lof5LIikjwhekkbyk0yMI318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyfkA1IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA5EC4CEEB;
	Sun, 24 Aug 2025 08:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756022790;
	bh=w4ru9Ckeny+k2OjrihK96QUfV39aJCsiSbwXD6qXk2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyfkA1IKeCe9nFAgJASvzDeTSQFFLMdxvtPdE8lQ1fz3KMF+esfxzvs8S3EwwpZxb
	 WvjPWhOqVKeIqHIQg5zQOH14aZEtGuPir9JdDmcroHYz0p+/2/1EubhwTxXI0eG/vC
	 3H8oY5C8XRqM6EXic9ENiY8jRJOjU97vKNGuS/mtBfwZieFQURoxnU/pds5S5bDmtx
	 6Hwq72VKOy/JuQjWA4mXoAiXGVK71DMYFkXziIfrgyZJzreuo0WO6pLrZeN+TCP9XO
	 06WSlnAswM2HRZdGVJxuzUJvbj7X2tckTZVomTGKMTdJJBFPGliuEbgEbByEeOqQqx
	 hfTnaEfuTNfPQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	Andrew Davis <afd@ti.com>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	kernel@axis.com,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: ti-ecap-capture: Use devm_pm_runtime_enable()
Date: Sun, 24 Aug 2025 17:06:24 +0900
Message-ID: <175602272525.419332.11059830322724662200.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <pnda54bjmij.a.out@axis.com>
References: <pnda54bjmij.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=wbg@kernel.org; h=from:subject:message-id; bh=Oqx4fBtYiwXvpqHbSIke+fECeLWTZ3+Nr3xoytI/CSE=; b=kA0DAAoWtUhWyr4SIysByyZiAGiqx9mhyE/1dwH1I9QweXj8488yUDTwsGBGpFOJaECpOkrLZ Yh1BAAWCgAdFiEEjTfN3eDSJSj46J+2tUhWyr4SIysFAmiqx9kACgkQtUhWyr4SIyvPBQEA9CzZ o0AVGOpr+VaN7a9hvQ4A1cv8H6OIidC4hho9lJwA/iBy4A7sW/siQEDyGMQ5q/OTo03I9DQ+hUG zkxseHSAO
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Thu, 07 Aug 2025 15:21:08 +0200, Waqar Hameed wrote:
> There is no need to register a manual `devm` action for
> `pm_runtime_disable()` when `devm_pm_runtime_enable()` exists. It does
> the same thing (but also calls `pm_runtime_dont_use_autosuspend()`,
> which should be fine here).
> 
> Moreover, when `devm_add_action_or_reset()` fails, it is due to a failed
> memory allocation and will thus return `-ENOMEM`. `dev_err_probe()`
> doesn't do anything when error is `-ENOMEM`. Therefore, the call to
> `dev_err_probe()` is useless. Note that `devm_pm_runtime_enable()` has a
> tail call to `devm_add_action_or_reset()` and thus returns that value.
> Therefore, replace `dev_err_probe()` with the returning value.
> 
> [...]

Applied, thanks!

[1/1] counter: ti-ecap-capture: Use devm_pm_runtime_enable()
      commit: 51548c36b37d0e84bd43a5f20bcbc36f70e61c5a

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

