Return-Path: <linux-iio+bounces-6749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C1913AA5
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6031F2166B
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AE181313;
	Sun, 23 Jun 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9o5jtT4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37F12C559;
	Sun, 23 Jun 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719146613; cv=none; b=bji1Nd92AIYV/yN0nRqg7Pk1V+mQUZki6ApEJicccUmhf86ovdRRX0gxdRHZp0QPsVLzM3sr+Rs59BydPkj6oC0yOc2zvCvlp9vkIY7+YQh3AsKp+8Dd9maEBJC50gQHbxoREVan9jrG14zTLrKKy5HxnCaslT4llPkBgWNNwv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719146613; c=relaxed/simple;
	bh=EetKD4SirjtMXGtpxQ3Z+7BWekwCyJri87L/QieyJH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lzqb7pG8+bxbOeGxwDjHVGbazFtcwt3DTOVYSwCQoALVdIhv3l4CMKzYGsLsqu8DPKHpRL+hbKsX+oxU61aJxXxPR7ciaT5/tTtQARJXfVQf6zej9/k3f3JgULcmwJF1dByPG/Zid1mrjUV2O4gq1sFoRrw1FZ07+lophDdCxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9o5jtT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8661FC2BD10;
	Sun, 23 Jun 2024 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719146613;
	bh=EetKD4SirjtMXGtpxQ3Z+7BWekwCyJri87L/QieyJH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9o5jtT4vJpgtVO/sxD+ozAL6Xb83kTaqLfbSgLNv5FmIpKtZfx0362gVs+SQmxcW
	 jZnQLuB4bHRnP/kZ7DEJDZyGTPiLpd0iOn72EDboBVQicQUQHzzeBPIAVkmUSn2YHp
	 xRaZSvt82PwX6rLQot5tVwh62qR+dGJpr4cELtHLUJ+fJshAQNpNCQPyM/bnbFJpYr
	 RnrFFhc0tpVPTmCB+OwTAEdQBhoDj5Ky1PHH4FQG4bfEiMuKjY6qLXLQh8Oj5RcLvb
	 ikqDyhmJ7et3c+AudOscJk670xk7MwFolq8ta92CkgunUUklhRpME1prhKZKS79Gqg
	 wrUGOtKc9Geew==
Date: Sun, 23 Jun 2024 13:43:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Marius Cristea <marius.cristea@microchip.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Liam Beguin <liambeguin@gmail.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, Lee
 Jones <lee@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Okan
 Sahin <okan.sahin@analog.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] ad777x driver addressing patch comments
Message-ID: <20240623134321.6c8ad61f@jic23-huawei>
In-Reply-To: <20240619122105.22642-1-ramona.nechita@analog.com>
References: <20240619122105.22642-1-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Don't change the patch title of a series mid way through multiple revisions
without a very good reason. Some of the automation we use relies on those
matching to ensure the latest version is picked up.

J

