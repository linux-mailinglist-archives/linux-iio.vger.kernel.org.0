Return-Path: <linux-iio+bounces-22812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2FB28DF5
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3895C0152
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A5F2E36F6;
	Sat, 16 Aug 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX5mNu72"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27D1E0E1F;
	Sat, 16 Aug 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349053; cv=none; b=r0c1RqE1w7KYcT5WWd9PygbFWY7UDfSEhVlsN5tShfaZJPAKefWlGF0JG6w3q7OMKhy1KNSnjMLm9URevYttaKwmeQ1ghYwNz/PbG2AbM28JZlHrQ4+AYnIj1upgXAOKcnVmsKuebNvVM5142DCVKzAIhT2bO4QknhgNhTDohVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349053; c=relaxed/simple;
	bh=IHOT59Weeub264TkQZetcMqUCa5S/NmdbN0rLQ4XC1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toj5Bh4kCyurKTuv+pcM2+aqC7BZePRDzgo2Du1WFGV4ngdS4o/ex/vjt4BusYmlZVj3haLUApEy80FRIPWLNwlyIN0tWvtVuYgAqJeUfDbZ+ZlqE9xwSblvOqRMh3ulEf0sivYu25L96br0I90caCohpbQ3h1iBBFtf2YndNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX5mNu72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B70FC4CEEF;
	Sat, 16 Aug 2025 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755349052;
	bh=IHOT59Weeub264TkQZetcMqUCa5S/NmdbN0rLQ4XC1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EX5mNu72Vuudk6uil2fu7PcoOwAFIxkIKrc3NtdMo4XU9L4ulTEFdog/CM5yikuD4
	 tP5anYqq1eBz8Z2Pw7ZC+8QovToD8/P+oGU6FZ/rmp4S5Td3H+tF/j/WQ1W11wIQaV
	 DEvqp/KnKvurcoMCmnyuGcBNUwdHJNG6QeH2xS6/uKBqvHVqXBY5jRyWI/sScdhqFn
	 0H0XGPEZMO8za+keNSArZdYMubow7td9pUIz4McGYZEpc7DhjeMkPyyEhP0lbrLWZA
	 l1LV1YPhItouBH1tV/49sawKfM2FOQ5ml2Wz8TE+CARTRB8EWSgtMqcNASO0EFTJQd
	 iWCkuK45p+S4A==
Date: Sat, 16 Aug 2025 13:57:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: ltr390: Add device powerdown
 functionality via devm api
Message-ID: <20250816135723.11026da0@jic23-huawei>
In-Reply-To: <20250814034544.93331-1-akshayaj.lkd@gmail.com>
References: <20250814034544.93331-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 09:15:43 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Use devm_add_action_or_reset() to do cleanup when the device is removed.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
LGTM and I think you've addressed Andy's remaining feedback.

Applied to the togreg branch of iio.git and pushed out for testing.

Thanks,

Jonathan

