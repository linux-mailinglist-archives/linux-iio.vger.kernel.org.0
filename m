Return-Path: <linux-iio+bounces-18413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C06A95017
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF8516F6F7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C12627E3;
	Mon, 21 Apr 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPyYU9TS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6B1E51E3;
	Mon, 21 Apr 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234404; cv=none; b=EBX26taShmNWJdiMoqk7tsokz9USzAErY4IlPcTrFsqCKxT242QkZL9qTmbz/x9gvN5Z6L2+muUlYLIUkqU6qxsfunjJSS/lm2fZT0AqTJ6QQv3nRHWa/oOopQ/fbs8r6Ds4SbIGLSxk21aBRbNiz57ob0oLEvZoTYAbUfnQAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234404; c=relaxed/simple;
	bh=1/Vt+zHQK1P+ptzrOwqPzYhvDovRK7kF4kbV9IIzcSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6FOM94TnzU1AKv1vrpaV5f1nTk9hEE6/bks/0PPc00yiYaM44tpvAeg8iR2bSogLFJqzj2Ph2abd9Q2vLgcZxsBsmtWqc93Swh56acoYpdo8amqtDyHGQMS+Q612DTQMtsaIAakT7CQFMDpwWMw15eKxU6/80BypJzcB1qtf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPyYU9TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B556C4CEE4;
	Mon, 21 Apr 2025 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745234404;
	bh=1/Vt+zHQK1P+ptzrOwqPzYhvDovRK7kF4kbV9IIzcSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPyYU9TSv9uKB724RISR3F9Azb4iFOl8JUbkG0yXWdmnzXGqS0p1GQkXKkx/uIFzD
	 5dVm1t0CUVx20hi53CyPa8Z3h/WisWLhfwdFODEcLFEOou7YyUGY/fiRDXMUNvNINW
	 Yp2ggz9if50TlhOVIwmmpM1G2jH/hmXzyyn3YzZ0QqYtltVF7H+Dv1XZ4sfDeVPVWN
	 R9jiExjzMM9e/+dTTudJ1ddhc4RjVoYILZ19CVb03Pd7lZDIgAXAZyeKh9RVJoV4kf
	 YtXQuxXQEbRh5J0xHqNOVWWfQemsqtyDYx17WWhbuYeOap0xyqoLgHzvhNecBVHuRL
	 3o1puRwU2V/Lw==
Date: Mon, 21 Apr 2025 12:19:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: orientation: hid-sensor-rotation: remove
 unnecessary alignment
Message-ID: <20250421121958.690ed909@jic23-huawei>
In-Reply-To: <aAPM3yhLn_aEkrlH@smile.fi.intel.com>
References: <20250418-iio-orientation-hid-sensor-rotation-remove-alignment-v1-1-6da68eae7ecf@baylibre.com>
	<aAPM3yhLn_aEkrlH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 19:18:39 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Fri, Apr 18, 2025 at 03:08:53PM -0500, David Lechner wrote:
> > Remove __aligned(16) in the scan data struct in the hid-sensor-rotation
> > driver. There is nothing in the code that requires this alignment.  
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 

Odd case. I wonder what motivated that...  Anyhow, I've applied
this to the togreg branch of iio.git and pushed that out as testing.
If there is something odd going on that the 3 of us have missed
hopefully someone will point it out!

Jonathan


