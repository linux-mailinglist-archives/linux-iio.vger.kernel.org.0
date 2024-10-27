Return-Path: <linux-iio+bounces-11373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A549B1C92
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB531F2187C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E95464B;
	Sun, 27 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2muxlKT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2374059;
	Sun, 27 Oct 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730019815; cv=none; b=n65UzSAlwAgAgWyG6PaRAHTVmyf8JcZjE+QPVfX04UhjuduyVDJ0C/qGfY9qHDF3PPzPxFzBl+hM4OfH2tUF1qbwU5YM+AaCwjK+P1eKf5ZwKlxo7RzvqLmDJgatCjkQvCkG1DDlUxvAN1J69kTPPYH7fdAz0NWLCPr+68cqZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730019815; c=relaxed/simple;
	bh=HT9IYKp2L+d60nXzV2h9ba+gQbM2kGfGioaZ0TsjdOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpZI6nB6JxvxVsWua6VQhpKgRJ7qQUVFhp5ev3sebR+Csb4APc0ay3/DFL2YbTVit5cyZeMFzz7WpDm6xDTFtWns2WeEg7QCs1JV6SuUSMLjUmpIGJJtnVXUJ/x6+EUGSrAJfIM10IIE2mIzMUkwh2iq9bE0/hPqINLfZRu1c6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2muxlKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44294C4CEC3;
	Sun, 27 Oct 2024 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730019814;
	bh=HT9IYKp2L+d60nXzV2h9ba+gQbM2kGfGioaZ0TsjdOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2muxlKTQhZLWLB9Wm+cFzQ5zZxTOadCb6ZUalsyIXgUQkwq937P+cC8kwPVUwjNP
	 LdVwYfDYY4L7FA2a+kgNmK0y7dXBlJYHmvl+TA/Ob60eGrn/M4F91A6wYAkpDmXhAe
	 EMJX2Tysp1IZLMXC0FcXKW1TVX1+yXk1ZW6O6K4VAojV39sFNAzl8UX8uiv47rsVxf
	 rgI88z8/W3ckddjQdfQUrJui22AMnypE0EDfLDjlhH0cNVs8EDO1xpUfL07Yl/m9fq
	 fGdegXF6M6d75FYZ4lLPIuWnEk0kHJvfe37LQztqntot4oJmdi4obKwPPyksr8a2fC
	 MrAjsBUaiUJmg==
Date: Sun, 27 Oct 2024 09:03:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: invensense: fix multiple odr switch when FIFO
 is off
Message-ID: <20241027090328.13a97bcc@jic23-huawei>
In-Reply-To: <20241021-invn-inv-sensors-timestamp-fix-switch-fifo-off-v2-1-39ffd43edcc4@tdk.com>
References: <20241021-invn-inv-sensors-timestamp-fix-switch-fifo-off-v2-1-39ffd43edcc4@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 10:38:42 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When multiple ODR switch happens during FIFO off, the change could
> not be taken into account if you get back to previous FIFO on value.
> For example, if you run sensor buffer at 50Hz, stop, change to
> 200Hz, then back to 50Hz and restart buffer, data will be timestamped
> at 200Hz. This due to testing against mult and not new_mult.
> 
> To prevent this, let's just run apply_odr automatically when FIFO is
> off. It will also simplify driver code.
> 
> Update inv_mpu6050 and inv_icm42600 to delete now useless apply_odr.
> 
> Fixes: 95444b9eeb8c ("iio: invensense: fix odr switching to same value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git

Depending on what else comes in and timing, I might move this over to the
queue for the next merge window.

Thanks,

Jonathan


