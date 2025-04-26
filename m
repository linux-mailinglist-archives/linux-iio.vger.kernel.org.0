Return-Path: <linux-iio+bounces-18696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C360A9DB77
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C21BA5365
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64B725C6E3;
	Sat, 26 Apr 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL4W5DTt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F82AD0F;
	Sat, 26 Apr 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677729; cv=none; b=RK9rGS9TzCkJ25IuIvaO8c6i1h6K5yXFeQtQvlDPHLRHgJrQaCwUzKigemOhWNEXTzxemUbUfhd/VXNCmjbCYLxWhZebDhNz4qz68MlIy7RPyq55jBqPdS8BzDN7BJi5FkeSukFoiHrD/t8313B6HitiKrAHchxFmQ6wvoe4m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677729; c=relaxed/simple;
	bh=UoQOZFMYyvSlSxpL/oqMDkYMGe0Otfbzicnh0yYcnKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/+4wHkMVQy0WFzEyimkGHE3ZbQws9UHrhdRdPko7OlCDHoFRJHaTLPotMecv7a5YWH8b4HYFh4o8CvcWjeVAG3snJ6OrT2KUla/+wx9kDLGIXS7hfQ28OW83v/9llBTDxyJ2d/a+26AF5KdeekEKqM7Y3JuKqtUGS/JrU79yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL4W5DTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E14C4CEE2;
	Sat, 26 Apr 2025 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677728;
	bh=UoQOZFMYyvSlSxpL/oqMDkYMGe0Otfbzicnh0yYcnKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oL4W5DTtgN1ZVOwm5+DQ4iO5SgamULGDCpt9vHxKgZMmsfdCd9jkMkgcBp01DWYnI
	 BTdWd/Hcj5l2AXK5PrRkTJPA4ZMQWEryve67zpPhwspL9N9TxCXh/xmlEoD8siBOUQ
	 76cWN2VmgqxqYytYHogs+HlQ+Fg/FQi2EG5cEe1h8CJ1NvxwarGFMPq/CnyJ3n3/b1
	 b5y/sY8zRV1SE0bBsUh90lYMbXZm4RXAn2TWKiB7KnYDdOaiIaLC7Y6sJNCKcciXDp
	 RF/ZifRL76RmwT3CeRImytWXAorjY+z4bT+uOk9C2G0nprZdbhZJJwQXXCVrcfZa1G
	 gbUOi+UFLWNHQ==
Date: Sat, 26 Apr 2025 15:28:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: cros_ec_sensors: Flush when changing the FIFO
 timeout
Message-ID: <20250426152843.3c79473b@jic23-huawei>
In-Reply-To: <20250423220506.2061021-1-gwendal@chromium.org>
References: <20250423220506.2061021-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 15:05:06 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> |hwfifo_timeout| is used by the EC firmware only when new samples are
> available.
> When the timeout changes, espcially when the new timeout is shorter than
> the current one, send the samples waiting in the FIFO to the host.
> Inline the call to transmit |hwfifo_timeout| value to the firmware.
> 
> Now flush when a sensor is suspended (ODR set to 0) as well.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
LGTM
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a first swing at it.

Thanks,

Jonathan

