Return-Path: <linux-iio+bounces-15952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D3A40947
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD88189E5F4
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F280199934;
	Sat, 22 Feb 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0XooV8p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619E3224;
	Sat, 22 Feb 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236418; cv=none; b=mWXf/Wi2XxNVakAn2cDCB65hgc4F3SKGLrwS3yB+cs/AJW2ZhLtsRES68VWyqRRjpVESQKjxpA5vrcgG88N8VuZpC/BF1DmsTf4yWUc9zQjAoK9gq8HCiv0KMV831S4Ao0CGutawHYfRrcVL6JpeWhjkd3OZgrDPnxDc81nGksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236418; c=relaxed/simple;
	bh=UmbgguS77NIyFRa0QXCsvyE+xFrzLJ/SfUFhJjrNdK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahZ7M8FIvwbh1V9NApggUUtiUfRfHIFTDQngdIaRNGQ08DQxv+pKLWYACqAoq0hPtmJQz1ruk58US4C3cVDKLiubi47eZKtFpYs7u+QGnja7JgtGsiyx94309M5PvNTPkgFq2ZjjHMm+VHmI8gpWLrMmywm0V8QKiwteV8BPXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0XooV8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60419C4CED1;
	Sat, 22 Feb 2025 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740236417;
	bh=UmbgguS77NIyFRa0QXCsvyE+xFrzLJ/SfUFhJjrNdK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0XooV8pCAmkAK6/vYg/AufMSRWlWJ9mGMJaUpML9p+rbWf1iV9QezOV4cuEv8o2w
	 G4Ax3g/CfeT6v4aVVuWTl9UBoxvBIGAhYg3KLacABY7m+bj1lvFFe4zi7KiryX9ttA
	 tn5Wjo7+DyxsF2SbokMEk7oYcP2RWXRDIjHQuVEQAjbgz8Fu9VJyf91Yi1wZCdqmR9
	 n900kkjj9QCHqu1izDqpBj78HuLETx4AmrL72rRV6B2jmENbMYKAgMi8v/nfMX0uU0
	 7y+4VryUNM0IVNNIpxf99rIq5KvZpkDTnrT+Tg1zI8t6WtBCYK8vkn3YUCR8nkjfRU
	 xe8P19PDno/8Q==
Date: Sat, 22 Feb 2025 15:00:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] docs: iio: fix wrong driver name in
 documentation
Message-ID: <20250222150010.215cc1dc@jic23-huawei>
In-Reply-To: <20250221194658.41358-1-l.rubusch@gmail.com>
References: <20250221194658.41358-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 19:46:58 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The ADXL380/382 documentation uses in one place a wrong driver name.
> Adds no functional change.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.  Thanks!

