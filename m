Return-Path: <linux-iio+bounces-6187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFAA904E24
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18352881BC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F516C852;
	Wed, 12 Jun 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GBuFBZew"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBA16C6AF
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180913; cv=none; b=pRWyj1L3b2yZ2bbKAdUOjwXpsKtKioAC83LjZM4LtzICdSACvLOmNkQl6KYUMBvjKb1XyCcQdrdx9s5kPNQbHJ9sWWg3FGAeCtDh7BUE9eAXknz4hxVeEXqbP/DIq0k7w3Xejkj63Uh/CYUsvWyzSP5Z7K0+Mh5pf4jfWVuykzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180913; c=relaxed/simple;
	bh=wqGfPq096rEmemBBkOminRw+GODXRpj40ayCnZziQOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tDzDcx/UIBrxQdHdZm0EbG7DFGzWEnJ85JUvfft4EM571j/2C/LveKcTm+RZwYUYto6T5EJWP2LjVTStHrEihhdp2PUNfjkjXET7Afmx4xvf6UL5lRIhoduWet52Osg3CXwvG3ckqTNqQXwP5W879J1frYzLYXZailFxEEMd0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=GBuFBZew; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date
	:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=wqGfPq096rEmemBBkOminRw+GODXRpj40ayCnZziQOU=; b=GB
	uFBZewE4QI6OYoN/D/HSywt50ybo76+ZWPB98mDqY2By2CQuW8zi7FWYj47jCSklIoWBmaYv++Qhf
	nNa8Nu8kAWFAYru6k+1HfK5QjLi+VNfCaaWljO1tDaJOsut7msyFqFNToKyssQDYhX2t/dOfApNVL
	q6XN5pG8008Ft/z1SUc2wzwyCwBH6KD54kitDr8ajTCjDU3IMvSKZJdTHL1XAvTmOA4XRJ9DK3DKv
	1Af31mrzCJvhCDf2wjUe/VWhaqVBmDEBFpbdI/EWSy31UAafpjSvI/vGstNItTts7W1TUY8QNJqGZ
	wLo9lBTDKzfjifQG+g4oj7qO3HzqhwEA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sHJLE-0004Ii-JM; Wed, 12 Jun 2024 10:28:21 +0200
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sHJLA-000D9Q-1h;
	Wed, 12 Jun 2024 10:28:20 +0200
Date: Wed, 12 Jun 2024 10:28:20 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
	inv.git-commit@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: inv_icm42600: icm42670
Message-ID: <7s6uxp3luxdenurhh5kcgsrokiawtrlzn2krqphotoeuir5xol@yqhbztxiv6by>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27303/Tue Jun 11 10:26:09 2024)

Hi all,

I got a custom board with the TDK icm42670 fitted. We thought is was a
simple ID add, but I was somewhat wrong.
Many registers are on different addresses and so on.

I have done some work in the st_lsm6dsx, that includes many different
imu devices from the same family.
But the driver is kinda hard to read because of that.

So is it better to do a new driver called icm42670 or should we do the
same style as the st_lsm6dsx?

@TDK
Do you have done some work for the icm42670?

/Sean

