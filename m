Return-Path: <linux-iio+bounces-16596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF33A585E3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4D7A3798
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD21DEFCC;
	Sun,  9 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Rfs872"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407C748F;
	Sun,  9 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741538880; cv=none; b=bINQ75427Lwo73f5oyT3mfI2kt3osniCChA5HqtFx+Lr0q2Cz1mAeEVt9Od1ZcfY5hphnu1fl9Xvk8pJa8K/yfm3a6DipjkyCUeyEW5K2rBGjAo6Wh+W70k9/hG6iTOweIfDjSO0KqZBAN3at7Pkhsb+H55HYGAue+vnS3SOpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741538880; c=relaxed/simple;
	bh=t0LG7nxxi8upEAP4BGyoMxD7g1ZnHNHQBmMCKI/s/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKiViLWLXwHN6Ezz+gEqtckA8gtlpwU1/nLOj/QMb8UATBA5mfC1hmU3EWuuaKyhQ0FpN0u0juhzW4yM3dD5yn46QaN6cRIEIdmmhg75n/16hqCpsyPwoiohHoycgSG0wMjSEvxDpxlE+mEgCBcDTjWbAHMdjl59+ZuVoJnZGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Rfs872; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B734C4CEE3;
	Sun,  9 Mar 2025 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741538880;
	bh=t0LG7nxxi8upEAP4BGyoMxD7g1ZnHNHQBmMCKI/s/Wg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1Rfs87265JsquT59c2BS1TgdON9f5O+vkaWVdtpTTB2HVfyROKwsOwCY39KmDuFd
	 qWrAVZ7YACXP7hrUdDUaWpnHy86qy5tlqU//ltCvL63V44Av+kaB1h3ulHeXTs70DA
	 389LAxE1OPzK0jO1TWDwdxGXZkDXfNY9Ij+zOB9OWo+uOBYWgJn/wkrgE60P/eIHbe
	 pwCliKbEv8Y7mhWtHltOgYNVqN/zyZuIhuZU+t9D6KDo8eO3S7+p1SJbqg/RdhaBFG
	 3/Rlg1z6EnirVMuftVDa7hM+uDTDxLMXSgWgRUXpOIfmiMzBCGpO9wZxpX80oYEMYX
	 L7uUlfuH9OMKA==
Date: Sun, 9 Mar 2025 16:47:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: light: al3320a: Implement regmap support
Message-ID: <20250309164753.2a14ceeb@jic23-huawei>
In-Reply-To: <20250308-al3010-iio-regmap-v1-4-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
	<20250308-al3010-iio-regmap-v1-4-b672535e8213@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Mar 2025 21:01:01 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Modernize and make driver a bit cleaner.
> 
> Incorporate most of the feedback given on new AL3000A.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
This one is more less just the regmap change, so main question is why does that
bring benefits?  Code looks fine to me though one or two comments from review
of previous patch may apply here as well,

Thanks,

Jonathan

