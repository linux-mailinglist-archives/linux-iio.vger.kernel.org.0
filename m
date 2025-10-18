Return-Path: <linux-iio+bounces-25232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629EABED3E4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37853BFDAB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7F242D65;
	Sat, 18 Oct 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxv6t3Oo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D82206AC;
	Sat, 18 Oct 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760805033; cv=none; b=NMJhwYfPHYYcvOV2HMZTb4FBvOzitgkvGDVsA3UfZzPebwMDPAb5YN2eg5BNhSJ0uLCMKF6+xTVlF18TYtgY/inVmMc1OsJ1bSRJcRO/+295fSE3mkw1xlkhNjgMyhtzuZmtZsIJCdkGGFVn2NFqCfJjAI+eUvB2GRhet6IsuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760805033; c=relaxed/simple;
	bh=WEOnCKDlayM/o6YpFxM4CI5sf6SfmWxwfT4V8JMMsNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfzfGZZFK1MREZZ7RAt75Mz58TaZcL8RWX4KY98/7QV6KdMULJ76gDyTf2PyQx+cwG35ClRQU8c1/ZKdT63/62UFY26hZDv2VdFTTbFpPyxX77Pzm/h22nqvNR+x4CneIpS+NdQ5NuKAK5HYL+HkvM0pcqhXrZ3PEpIHOCxjsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxv6t3Oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15703C4CEF8;
	Sat, 18 Oct 2025 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760805032;
	bh=WEOnCKDlayM/o6YpFxM4CI5sf6SfmWxwfT4V8JMMsNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pxv6t3Ooc4i5aE6v0FWLyegukpXLhMfW2XpUK0RsNjnyO6AOzwGsvnLpBHk5gp/Mz
	 h6x7gOWhZe6NgMXQDoihg0KtHWDk8sNw6lxued/NirbV2E23XTIertEMXGDbBzASB6
	 J1cCVWT3kPmMFFFkASXLwldvQTvTtm1OQ03DQ2OLTuRK7sgOHQ794jahwgiUG/YvlM
	 9L3vHqmJOlQbc6zArWm0HZp/j4oq2OcfpqOvQg18v/tHG7+vv4Y7ftg1hkuUB0s1Ll
	 fOsnRrJMIpxARPn4wH737lDF9j10pSyo79xqfK6a0DdE/Ib6G7u+HIQeabhHuB+ZdB
	 3JDutRWLOM9LQ==
Date: Sat, 18 Oct 2025 17:30:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: test: fixed-point: new kunit test
Message-ID: <20251018173026.43d790b9@jic23-huawei>
In-Reply-To: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>
References: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 16:33:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a kunit test for iio_str_to_fixpoint(). This function has an
> unintuitive API so this is helpful to see how to use it and shows the
> various edge cases.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Thanks for doing this. Looks good to me other than the
missing const the bots shouted about and whatever you and Matti conclude
on the test conditions.

