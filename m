Return-Path: <linux-iio+bounces-20845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69080AE2FA2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1E16BC60
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F371DE8AE;
	Sun, 22 Jun 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMBWWPjS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295D1DAC92;
	Sun, 22 Jun 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750592799; cv=none; b=U7MVdMW+R9lD5ioIz2Th1BAALra3pFAqFLaJvbUh4c5WJqovH3+CY4uU0H+zE+RnBHrK94IJYKJmS1Pg1s5XMfyRim6Dqq6hJydtQEVOXdRa7KFtDXjXeuNepcR3tnmGXdHzCFG2PCe5AuQ0tUrxXY9oAZ/vGMKd7i2YLCHDOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750592799; c=relaxed/simple;
	bh=+07UWUF6RiQR/h2fs2FgH8dAa/6207v6+e/KEDKdLm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RP3sPPh97+KMTGFjw5L0eqPYHWngcJiof/1pRonLyXs/neXH0vu2q/GsOUwERitt1jNdSgdEjjhEIjgb/dKHvVtkGqX5DCkNVi7AZ2TJSnAh3AQNWVsBVW1xNGZee0QZxZ36UoS89j931cjcEMlx7wkNnhLA+jYEgLU78zBp6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMBWWPjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED19C4CEE3;
	Sun, 22 Jun 2025 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750592797;
	bh=+07UWUF6RiQR/h2fs2FgH8dAa/6207v6+e/KEDKdLm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rMBWWPjSxiVonHn+JtFv9Z/sfI0xD9Ms1TcJHVxJtAJ08gD4jsOyr6kVPUoJ0UlB7
	 4Bhg/GD9lf1NsQwjEAyd/gPLZUz2gUn/U+FfOcMQ/m9vNG9T0ybY9ef26vWfr/u+Ns
	 FFZIRiUkFjr3fFybRSeMhvnCrXFVjXAmsDEg6py1DNBSohksOsNrUsSnHVOX/w2T5+
	 w+oE76Hsj2zVRbIpco+O7iVZBhNRQ5j8cFPLfs6EFzZ82raU38eLZEhkCynArQXInN
	 zsdFE+Qz4zY20Qb2KZR4TrVWTiCRSP04xGOWAuHxOx/RHk+7hdf3AeRnrksrTkZldV
	 lANzbsKWc/Lvg==
Date: Sun, 22 Jun 2025 12:46:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: imu: bmi270: add step counter watermark
 event
Message-ID: <20250622124630.052fd593@jic23-huawei>
In-Reply-To: <20250616-bmi270-events-v3-2-16e37588604f@gmail.com>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
	<20250616-bmi270-events-v3-2-16e37588604f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 20:53:10 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add support for generating events when the step counter reaches the
> configurable watermark.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see what we missed.

Thanks,

Jonathan

