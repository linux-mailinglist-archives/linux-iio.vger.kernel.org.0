Return-Path: <linux-iio+bounces-21121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDFAECEE7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EF07A6576
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2623717C;
	Sun, 29 Jun 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvRJHZNs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC532367D1;
	Sun, 29 Jun 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216959; cv=none; b=XW5+v2E+RBfZXb5y7Ff6MrA5lfmgf7ubzs3KApA0F1wL7mDIdPR9PBE2uxUfCufziDMwyXnnOYLOCaBdg8DcSG+JUw45vKPHilWCTV8dqikldDhTQg+AOPKEY7Klzw7ts5wLhBv9wVOvZM1BDOc/cZY19iUhurC1bkqvDZ9gtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216959; c=relaxed/simple;
	bh=v3RusmOnBk/EUrMVD08r+c6xKeaRxw0SBUyRTiy+g9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=of3enLBb7oEAXogpgYwO8wjS7gfc/3UcY8RYo3join3mg/gSsVtTGVWLxZBPAEAcDTq3WocesFcMNBhzpY/tW/kkAcnQwZUHo1mJLSNf3G7eeFFv8stKk65cCU97kOVR9As299zYfOqxFOvpOzjtR4yWxBtzcLsGiHXLxLIdU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvRJHZNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7250C4CEEB;
	Sun, 29 Jun 2025 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216958;
	bh=v3RusmOnBk/EUrMVD08r+c6xKeaRxw0SBUyRTiy+g9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvRJHZNsB+RFYX/P4W107ChzDsc32+9vtBCs/d5vSJcKm7TF5KgVMmCQsTCuPI6rE
	 nfA7jQWyB/9O8MgmSj9Tuc3ohkNE+zNGGkVXDh1WQRb4MLGl1Me9RSV/6g5jzxxxgR
	 Ae8YqQ55P9/yB6gBQRgp0k1yHO1422uu6dacRNeuR4ZCzduy9r4Z8LmiWuldK1S61Y
	 mBAzTC8/6GoYH01kfxyA7or/FhC8pjCmRQaqZih3VLDMi4YcD/z/QelMBSIePY0A0e
	 IN9EUGRXNx5NvqvmXy52rT8jEvkenzblwuJDqr/PHlJJ7EZVeVqomUxN9Ybj1FvOfU
	 2PXsCQhWuhRgw==
Date: Sun, 29 Jun 2025 18:09:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5770r: make ad5770r_rng_tbl const
Message-ID: <20250629180910.4e7d2327@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-15-v1-1-b86ae055004c@baylibre.com>
References: <20250628-iio-const-data-15-v1-1-b86ae055004c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:11:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct ad5770r_output_modes ad5770r_rng_tbl[].
> This is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git.  Thanks,

Jonathan

