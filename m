Return-Path: <linux-iio+bounces-21124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A369AECEF2
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398003A5651
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E561235355;
	Sun, 29 Jun 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbIsvVYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C023185E;
	Sun, 29 Jun 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217288; cv=none; b=JwklaxhPqz8HVeppHpnILhOcILxLDaTNHRYXk7Xrk3BOjwc2DMyQzPgwuEjSNTrxzTZ1Zs7R5fN57JJH2LdBSBj7vosI7Uea/7lN6o2md0OYe+kIllssxzHy6G2dJ+8dCNtBJg0SA9kIQNtLQWFAqV57dPXBQidpaRhLdllXWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217288; c=relaxed/simple;
	bh=CKlkurbQlAizwg8ITxjTw4DO4P9AuUPmnwtoOvj0A28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMiEQrNvmCBgkZLy4IsN+UXHKKSKvmORT2Uikn4HXBgEEVcXNa25fXFVM0/DK37VgLHA6M9HqPiJMJFY2QBM2cZ6vFH7YuQE1EwfLtGCcnmJ07pfxnxPHMUJ+8TapSt4AAl0KuTZk4ZRkatrppEY+ZgXXr+RdstnPU2PE1dpD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbIsvVYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA6CC4CEEB;
	Sun, 29 Jun 2025 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217287;
	bh=CKlkurbQlAizwg8ITxjTw4DO4P9AuUPmnwtoOvj0A28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZbIsvVYfnC66SmfFcsmbNdbKQ65URKNh0BhVns2z2A+sXFE/XUQV4oOT8SIIGr2KW
	 TUc5feyzsYFNksartkG/epY2ajx9bkBxUFCXQuyzGKIz9KxVVATDB4grzCEh9q5A2Z
	 zcZ9KOAHBYFrt2ti5ZGNHjAbBSZ9dUpg9AZuPimLpWgAbegqR4qL3sew3zYBHE8ssM
	 cQ5WnDqH1ERAZ+2VyYCTJNMTogCrz9yYWl6hmwTuTsn28RMAEbv5YxqlL7hPuB+z3f
	 eh4U0pNBet+y7KqDZLXhi4hmfVwWgF01FCM+wlwvJiylVaWFt5Vo8nnonDdMhS25zs
	 A9715CLURweqA==
Date: Sun, 29 Jun 2025 18:14:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: make bno055_sysfs_attr const
Message-ID: <20250629181441.3173ee5d@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-19-v1-1-a17e7c16b122@baylibre.com>
References: <20250628-iio-const-data-19-v1-1-a17e7c16b122@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:35:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct bno055_sysfs_attr and its array fields.
> All of this is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I was a little more dubious about this one and whether the scope of the changes
made it not worthwhile.  Still const when possible is always good so
applied to the testing branch.

Thanks,

Jonathan

