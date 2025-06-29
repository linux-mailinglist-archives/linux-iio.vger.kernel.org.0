Return-Path: <linux-iio+bounces-21112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F9AECEC3
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E641894EB3
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16737231A24;
	Sun, 29 Jun 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUyqLS+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A676FB9;
	Sun, 29 Jun 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215851; cv=none; b=rqF+b7GTKU426Alt7VVEd00ODjbx5A76XdJsjL35T68H73vEyLF0BRIZbRyxOVNDtFcJaSpjz9uPHy/d4aP8Mjmwxvu/069fl5KJx8zYHzWKYgD9dXS2OfbdyAKeYRQQy/3v92k0kCVebjXm24h00CS11qelE6/o3mxQjRXPDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215851; c=relaxed/simple;
	bh=f5tbvhdooVYNNpT1GzoijVeGwOFw0ltQrq50Jlmo3II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyp7vVJGdU3RmcpBdfQ/rpaQ7a1weHvxgn80QicwGcsX0XbWDupjsMTykuRcrdn+RN4ISExN79rJ7Yz6mNc6LUzPqj0X5OBmqYvQkZhOMsqfi4KpWlYmUR1j6h2mhwvRwg/7n9q2luZv/8DGdESmJ52B4pDEMe66nbec9bMBG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUyqLS+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6A6C4CEEB;
	Sun, 29 Jun 2025 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751215851;
	bh=f5tbvhdooVYNNpT1GzoijVeGwOFw0ltQrq50Jlmo3II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUyqLS+VZh/8cccNV2R0b4ZEW1K5w2xYiUA1LeA7luW8WW6Al5SNlEhlWrDx0jboU
	 qLCGyDWDINUuEKQ4OEDrGpp5dZJuWRDj16nkPASWOpfTSzuN/WSG1XE4kEtPOj2/VU
	 x57B7WXGBM4ihrOkm6X1rhNsbfJzU4PnDL9DKYqUo369rjV3Oph4Uox7yVmhZWSNCM
	 GjTaJ8ApM6oUtunqDJqsolpw3gG2H5rwQRu9sILd71pmBxbk0oA1BMlWKZgROPVC8E
	 u7Zas0j0I4Cl6w8sGtSXMBCgdwdgvdlHbUhzO7EEMvarFQQjBS8CvYZ25VAbL8E1Zq
	 +wJzBy24gsDeA==
Date: Sun, 29 Jun 2025 17:50:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r8: make ad7091r_init_info const
Message-ID: <20250629175043.737b5fc9@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-4-v1-1-4e0f93c9cf83@baylibre.com>
References: <20250628-iio-const-data-4-v1-1-4e0f93c9cf83@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:09:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct ad7091r_init_info ad7091r*_init_info. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git. Time available for feedback
but it seem simple enough and the compiler should scream if wrong!

Thanks,

J

