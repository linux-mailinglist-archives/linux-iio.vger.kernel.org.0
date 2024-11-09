Return-Path: <linux-iio+bounces-12080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5D9C2DCD
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE6D282793
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2C195962;
	Sat,  9 Nov 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk8lNYys"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AC19415E;
	Sat,  9 Nov 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163195; cv=none; b=VRxWGU3QnlOU+oX+B/T0cgXOlzIvisn0+fNT79fSeM6iOETz9RC0Mwbw4fAW2yhhrLNGl7m6FxoeIHkgeSXrRG8cYvJzYZdaBPEd/5PMjXp2OhLiC4ArTs5BuL7n6cpg0gz/3M/xxVegsGgykUydArCABaS9fgin0GFnC8xaK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163195; c=relaxed/simple;
	bh=T510t+l0xB/kz/9PFkuaSPd/d4vzbmijLpOLZUZl87o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5Vs9492FgsLhBQBCZKbzYSgeWjsnfrTcHeQtpA0dOCJI3Cf3Yd9Y6n+Mrx+5JbYMkxMk4TLyAfbD8i+62m9rAC0cAzyjUCJS/qpq23Od3cvpOeTyfiIDrANCNoEIEhviOM/SRyPQz9I5/o3yllBnmUlUnznLOYZoTB1Kgkv+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk8lNYys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9C2C4CECE;
	Sat,  9 Nov 2024 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731163194;
	bh=T510t+l0xB/kz/9PFkuaSPd/d4vzbmijLpOLZUZl87o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mk8lNYysok1s5E1nICm/PNW3pliB63UBH2mjf3k0g1bCAVwA0pYi6zstHO2/5i6QA
	 kEA5dNkmxcMB2h72ApXVuhTnFE8ZG416VzxLnOp0NxeIkfwLJfvxVq2tBQ9vUHxxU4
	 vRmZWy9hUn7otj7j2QUO4/C/4Fgs71BZNG6dsftesXuv4Kl+gbJAKXQ/tuv8sPTWYz
	 W+wxVnqwMitwRT+hzrvj4Nmn+gv0uFS9a3BENZrd5ESvNGRKINV54eQPKZoRM/ATEq
	 X6PpbrGvNKwJzy2AVG0rLOcElVhJlcjws/TBv6yKFToqDOkd5TasVCSnhCCJMxR6Ur
	 wxfKiMBVy2aAg==
Date: Sat, 9 Nov 2024 14:39:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <gregkh@linuxfoundation.org>, <daniel.baluta@intel.com>,
 <shubhrajyoti@ti.com>, <linux-iio@vger.kernel.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <tanghui20@huawei.com>, <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
Subject: Re: [PATCH v2 0/2] Fix phase range check in AD9832 and AD9834
 drivers
Message-ID: <20241109143945.2616c5d5@jic23-huawei>
In-Reply-To: <20241107011015.2472600-1-quzicheng@huawei.com>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
	<20241107011015.2472600-1-quzicheng@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 01:10:13 +0000
Zicheng Qu <quzicheng@huawei.com> wrote:

> Hi,
> 
> The previous link is: https://lore.kernel.org/linux-iio/20241105140359.2465656-1-quzicheng@huawei.com/T/#u
> 
> This patch (v2) addresses an issue in both the AD9832 and AD9834 drivers
> where the phase range check allows an invalid value of 4096. The
> condition has been corrected to ensure only valid 12-bit values (0-4095)
> are accepted.
> 
> These changes ensure compliance with datasheet specifications and
> prevent potential issues with incorrect phase settings.
> 
> Zicheng Qu (2):
>   staging: iio: ad9834: Correct phase range check
>   staging: iio: ad9832: Correct phase range check
> 
>  drivers/staging/iio/frequency/ad9832.c | 2 +-
>  drivers/staging/iio/frequency/ad9834.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Thank you for reviewing this patch.
> 
For future reference, for IIO at least (and most of the kernel) don't
reply to previous version when posting a new version.  That tends to
make it likely your patch set will be lost way up the pile of email
in a maintainers in box.

Many maintainers start at latest and work backwards until they run out
of time :)

Jonathan

> Best regards,
> 
> Zicheng


