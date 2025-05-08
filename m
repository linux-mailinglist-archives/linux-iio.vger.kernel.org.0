Return-Path: <linux-iio+bounces-19343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71118AB0370
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BF87A578A
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5628935D;
	Thu,  8 May 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZoIiOHA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E1221731;
	Thu,  8 May 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731698; cv=none; b=k2KyM41X/ajsqrKrQyq9ugjZyfRiYP+bOcu3OUvU/xgpN726MafV1uKcJIPws4JA0hEoGbKLtpoDsTt+R9zDBpHBhy8kCRsZca4mess+6sRwA1ikGwhlBagZbYpncNtmJqwjn6s1Qye+nj+t6D51uK/ZDRNzpXnjgEiZ+3d+mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731698; c=relaxed/simple;
	bh=yxvPHV91Cpn4gps6nfSbv9hq41K67es1sWS8vQvF5uA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3LAdj8ExBCbrQ+LpOTHJbYEUPqYxk2kMbmJ9zhP+TfONw0DZjlaPe67DhWkxEiygPQKQczuOOGnOcPQ0d3V7W5bGRtZJG2MDy7oIdVhRNdjmwM+q8KFNzs7heGUdpGzwmrjDsXX6fEsXDOb0VrVOcAKo5xxmrNy6zOIW32Rp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZoIiOHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7651CC4CEE7;
	Thu,  8 May 2025 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746731697;
	bh=yxvPHV91Cpn4gps6nfSbv9hq41K67es1sWS8vQvF5uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZoIiOHAoqHPZScP30YgYaaU7zPlHCyWh/8hSKiPKFfn70hCncpK00PbRsjcTitck
	 +gc5Rudp/vacMVKUahQ/T9K5fDcgMMyDEC11Q7rDohJpp39A0xhkBZJeJq6ufLQ/kp
	 zUNokIzMEdppeOF0VeHBI2ORH7r/RfhEwP0qXVIvmN3gk9tK0E2vJV+zgwq0ydMYyK
	 U5n8np+n2GLb/rf45+l3z3tnol+7u5IKIIj7an8VceE8yBQb+OAw1+75/ToJdpvgYN
	 gnv6Qo0tCtwSkafmq4Q97eiUtp2IQmQFBR6cFUa5wCFwZ6EjI8lipRo7B0W2cjComK
	 620UMzIvkr7Qw==
Date: Thu, 8 May 2025 20:14:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, jikos@kernel.org,
 bentiss@kernel.org, srinivas.pandruvada@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation
Message-ID: <20250508201449.7fecd58e@jic23-huawei>
In-Reply-To: <9457b419-6aca-412a-b0f7-4b3c7274789a@baylibre.com>
References: <20250507055745.4069933-1-chelsyratnawat2001@gmail.com>
	<9457b419-6aca-412a-b0f7-4b3c7274789a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 08:24:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/7/25 12:57 AM, Chelsy Ratnawat wrote:
> > Includes the following corrections -
> >  - Changed Measurment -> Measurement
> >  - Changed clode -> close
> >  - Gyro -> gyro
> > 
> > Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied

