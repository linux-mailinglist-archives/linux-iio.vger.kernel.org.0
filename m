Return-Path: <linux-iio+bounces-13792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551149FC5BB
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C75162F85
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938E196D8F;
	Wed, 25 Dec 2024 14:04:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98861E502
	for <linux-iio@vger.kernel.org>; Wed, 25 Dec 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735135487; cv=none; b=gZw9iP4EKg1JIq2xQOB3+N6wXjnr3EeFZMJIqlHdoPa5IsFV+5aX9ksKFOpx6HmptTxHm1txLMcd7UncjijwTPx5jq2lr7MNci5onhY+/dPGNmXSgpzSKHuOQDEwpzvS19XuHuY7DROu/IM7SNZGD8uV2rC/ZJFjU29iyWtwjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735135487; c=relaxed/simple;
	bh=Z2tIeU3kQJ/RJGs6liyehfsNep/4Om+iV80+pbHOG+s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=q9UXUA1b/AWyOl48RPVdAusLiNzWINJNtAEmWZYsw8sV2GyxfPE1zaY0cwXs/wCcU8rkplW15PgW+SFjWe+1VngRXH/bcQ8hmQB/aMZAt0ot1O1K7TgK8NQdXoUH17J8lmNaWAets3AxqIeZGy8j9h/Hm8tMfPov729f1H/8obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1tQRYp-00AqVg-DQ; Wed, 25 Dec 2024 13:36:27 +0000
Date: Wed, 25 Dec 2024 13:36:10 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Merge of fixes-togreg inside testing?
User-Agent: K-9 Mail for Android
In-Reply-To: <FR3P281MB1757F070DE7F29786C13412ECE032@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FR3P281MB1757F070DE7F29786C13412ECE032@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <E9B8591C-37ED-42F1-B41F-BD51BE20024C@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 9



On 24 December 2024 16:57:33 GMT, Jean-Baptiste Maneyrol <Jean-Baptiste=2E=
Maneyrol@tdk=2Ecom> wrote:
>Hello Jonathan,
>
>I currently have 2 patches inside fixes-togreg branch for driver inv_icm4=
2600 that have not been merged inside testing branch (c0f866de4ce4 and 65a6=
0a590142)=2E I've been waiting for them to be merged to send a new feature =
patch that is based on them=2E
>
>Can you tell me when you plan to merge these fixes inside testing branch?

I normally only do the merge once Greg has them via upstream in char-misc-=
next=2E=20
That keeps history slightly less messy=2E  Sometimes I even wait until aft=
er Greg
 takes a pull request for my togreg branch to simplify things further as t=
hen it's a fast
Forward merge only=2E

Anyhow this should sort itself out before the end of the cycle=2E  Feel fr=
ee to send
 changes that mention the dependencies=2E =20

Jonathan=20
>
>Thanks a lot,
>JB

