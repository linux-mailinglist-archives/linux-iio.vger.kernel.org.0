Return-Path: <linux-iio+bounces-16361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442FA4E2D1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7C017C5EA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705F281346;
	Tue,  4 Mar 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIf/B5bq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810527C14D;
	Tue,  4 Mar 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100778; cv=none; b=oaEPq3V4WiS9mS2Yf6r6x9LbnDHQwfaZY0jrZIzoliWItXtB82fzIpCNaFwOwWBz80PC9TCOZAeVkYkENdf8ShVXzyBxlPwRPfu5/0ThHyI2+zMECQumTROgADDR6G0DbFT1jlo8LEt80x3pRfPI8J7IpPcucoPPqjvDxGdhpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100778; c=relaxed/simple;
	bh=YWffusgVy4JqzxHkhg7lyaWZ2TNntH893fnALgxGyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KodUbKoPU9unfiaWiWbJ/wbsIY0W0qEOR6DulDVtr5kv31fYIJlF1wgcaOBE934vwxOMG9uxIgN5tvukxlD8L+GiAU7luqDGkCvceMDT8qFQNTZGDd/Rx9UFCyPqJQ4JPGSMK9C6F4WCeOstvtpi/iTaf/bguS18/AXXweqhnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIf/B5bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD1C4CEE5;
	Tue,  4 Mar 2025 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100777;
	bh=YWffusgVy4JqzxHkhg7lyaWZ2TNntH893fnALgxGyJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KIf/B5bqXGbEHqQolNccXFTt6pJjSB/gwtS5LxrvptvqG6pmtjXol5/MPW77gC9b/
	 E3n1Cerw6RfVugcoEk8VzAeZGG6uyxRiW7BnGJ+JYmFF9z6VQ7ACllOAO9sIZNclcv
	 piZW4txwZ5vSk0hRFszQ0Hl8WrcVDC94gmQ2AoEF3s/N43LsN8P+A8lbR792R7SM4n
	 /BdgBhCVchwZHgGX9yWmxXO15mnUW/3zKgDwYKw/6NJpBjhqRrWpSqQ8WVTc77KF3d
	 MnCzWWR6gPLG2rMKE7oj4rv1xMe4KePHK5gRZ5hXWmCM8URI2jQTCd70cfxLgtl/p1
	 NWapbl3Ad5qrw==
Date: Tue, 4 Mar 2025 15:06:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] ad7380: add adaq4381-4 support
Message-ID: <20250304150606.5125bbea@jic23-huawei>
In-Reply-To: <5ad1f95b-ef0b-4e65-9e31-a8166a8e90cd@baylibre.com>
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
	<5ad1f95b-ef0b-4e65-9e31-a8166a8e90cd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 10:14:40 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/26/25 8:50 AM, Julien Stephan wrote:
> > ADAQ4381-4 is the 14 bits version of the ADAQ4380-4. It is compatible
> > with the ad7380 driver, so add its support and documentation, in driver,
> > doc, and bindings.
> > 
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 

Applied,

Thanks,

Jonathan

