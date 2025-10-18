Return-Path: <linux-iio+bounces-25220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118DBED027
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0398A407411
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596F27EFE3;
	Sat, 18 Oct 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPNL8aM/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620CEEBB
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792911; cv=none; b=Novvz324P3gtP9fDtIAv5Ksj58pKpa/u5AgrBiGzLod0OjLHEloleI2uaZk7NmlkKByv4grXdfXjSdU1QIwWcgCMgc5gbwWo47fKHOrK8+dWiil42ZgMml7RuWSLry4ILTISHnItC1C0BuyOVtijq6kpCM2deEHiOOugRPTFUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792911; c=relaxed/simple;
	bh=RE3lDdw1cFUt8GxhwI1+2SHPCKJQlB4wv9YI+pgUXT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZAIBmGXhtjFgUp+8j0qONHh0FVRJsjLYnv7PaVEuLPX9m2X0c9Hd3O8oxp0hreE1U1E+yVGlKjW/Uy0QWdi46x/BHZG8fBJSsAuCJilN9h1T7lwmLiRf8b1wi1+j7mDd6c5k23ndYhnFoSkjwm0TRVFAsbRLtJ3vOx9CwU8oHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPNL8aM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A735C4CEF8;
	Sat, 18 Oct 2025 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760792911;
	bh=RE3lDdw1cFUt8GxhwI1+2SHPCKJQlB4wv9YI+pgUXT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UPNL8aM/h5mfuffpV0u1so6vL/K/NTimMp37AOolZtiZu76ZIFNK48oVgv/SZdnRU
	 0XRIXM0ncXtx26yYheFRPDfSFM8PO3k8kbGHP3oPvh/G5YvF7Pul/4dFraLFcKPp6Q
	 jNll5d02saescDxeGG6IzpD6gIkshD6tLteRq+Ghz65NibhjJFuE5QBpVReMJUht1y
	 SmfHDAB8gK0dg8XQfZSP49LbBJLMJKAfZViS0Fuuqm/0CzBxT9uDHgHVgZJ6LJ3dwM
	 eEEXO4yMx9HWpV1+nvm129t4eeLmuf02RlK+RgBXStTcnxwczdCyk3/IAL/cXEa41h
	 Fl0/jJfL3194A==
Date: Sat, 18 Oct 2025 14:08:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>, Kessler Markus
 <markus.kessler@hilti.com>
Subject: Re: [PATCH v4] iio: accel: fix ADXL355 startup race condition
Message-ID: <20251018140825.006fcb7b@jic23-huawei>
In-Reply-To: <20251014071344.151914-1-andrej.v@skyrain.eu>
References: <20251006095812.102230-1-andrej.v@skyrain.eu>
	<20251014071344.151914-1-andrej.v@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 09:13:44 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> From: Valek Andrej <andrej.v@skyrain.eu>
> 
> There is an race-condition where device is not full working after SW reset.
> Therefore it's necessary to wait some time after reset and verify shadow
> registers values by reading and comparing the values before/after reset.
> This mechanism is described in datasheet at least from revision D.
> 
> Fixes: 12ed27863ea3 ("iio: accel: Add driver support for ADXL355")
> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
It doesn't hugely matter but I was only asking for a reply with the single
line David sent. Not a new posting of the driver.

Definitely don't ever send two v4 with any changes at all as that makes
it uncertain what automation will pick up.  Standard b4 string to grab this
patch grabs me two patches with two patches as it can't figure out they are
the same.

Anyhow, applied carefully by hand to get just this one and marked for
stable inclusion.

Thanks,

Jonathan

