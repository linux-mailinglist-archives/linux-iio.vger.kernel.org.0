Return-Path: <linux-iio+bounces-16893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A2A6353D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFF91891171
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DB1A08A4;
	Sun, 16 Mar 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2qnjhAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD474BE1;
	Sun, 16 Mar 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123564; cv=none; b=OLU98OXtn3hzIxQPsKoOVsYLa3f57wL4WakzR8NvKJNiXgIe9GUwZfsmU7VXXrVtcHvyq3tl3o+M4ehoMuNXn4NZe0EhY0QoCi4caXKhfOUDzgfOpObW+AwgoNsJojLD7ncGeRtmzIW3mtlQJd9mRSQtRUvLADIxnFDaaieZo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123564; c=relaxed/simple;
	bh=8gk3tZfxCd6XuKhUUZVxxKu5Rsl1eLo0xiKdrd6kMvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQKqFjzwcdjyyjHI1wZ5f03SDFox93G8kUnqf7S4Kvnf1K81egHfRVsYq5pvRfllGaSITHC3xIOnYUBYPqSbKZvr99E7XCO9Gaq9k2baNt8KGlP7W7u6y4pEKE2mka/1Y9DNoC6v0xupwapFeyUkECwm/ud4DdKtBiEnPimPoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2qnjhAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E760C4CEDD;
	Sun, 16 Mar 2025 11:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123563;
	bh=8gk3tZfxCd6XuKhUUZVxxKu5Rsl1eLo0xiKdrd6kMvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2qnjhAjLJMJqp/+qyNxn7QGWFD2b5LQfPspWg5s7P2Irp00jn1Lwpw/q99gSTgte
	 z/OWRuJqdeGnPNSdZL6FVyYr96SiQ8i9Pyia1K1jps+diwAdXBfu11dnc21jio21S+
	 QkNgAoqsa2uYkPm9n8zONrC49lQjqgupcJuW0JGmutgiyQWkgO4HZCNZPFZvdMeF1I
	 rsYGTJTj0tz6MN7a6/57bjL45FLIQag/ZGXAR0dgohoVyrHCW+gONbZo2ibhs7meMq
	 qZkcolE2zivkLDhi3n5KwcPRfvMiqv/pulw1IREzqjRJNuy8+mLPHrVkOKNlzAWz71
	 V31h+kgYRpLrw==
Date: Sun, 16 Mar 2025 11:12:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 03/14] iio: accel: adxl345: cleanup regmap return
 values
Message-ID: <20250316111229.4863d0c6@jic23-huawei>
In-Reply-To: <20250313165049.48305-4-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Regmap return values sometimes are checked being less than zero
> to trigger error handling. Sometimes this is checked for being not
> zero. Unify the situation and check for not being zero.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.

