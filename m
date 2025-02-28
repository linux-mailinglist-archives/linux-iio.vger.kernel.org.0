Return-Path: <linux-iio+bounces-16163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0EA49104
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 06:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBD1894131
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 05:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC931C175A;
	Fri, 28 Feb 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i07Ws1TD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE861C07EC
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721110; cv=none; b=EqA8117tZhQv9tIgCQY7CLhA214TI5WN64IASKkwFtycl2r39z+NTEcUPihU4PTVlEdH4yv7a7/g4bPFGNqsgTLlpnqDZqr0msCMVeiyu+xm4k8Pr/hadFnBOjr7WMNcErBseKeCPTiRafR01dxdgUx6oPBQYqeD5sp91SFLDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721110; c=relaxed/simple;
	bh=EMEFQfYL85FdqL7yUZ7W2PrbLVXuINqAyxuWJnoHjUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEFCuwbOWSKJ3P2CHIUf8vCnhC7HVY3dfijZ9XPCnZINiqaz5rfIxBEeadj/pst7IF1If6R70lOvy9+EwQTxdSLz++N4QwLAQN10bupsLzNZQ/kC5u8nOOi5KYixDpLogMu7MzQVjjpAC/yOMekLs0LoajpvVy2NNwqlLGZXFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i07Ws1TD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e589c258663so2043034276.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 21:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740721108; x=1741325908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMEFQfYL85FdqL7yUZ7W2PrbLVXuINqAyxuWJnoHjUo=;
        b=i07Ws1TDAsJDCtlqtlEiUsOe3y3amlPdkytKK7LXHeWm8xCrxu/HN1wEcYNY7ybkKp
         VidirpGAEcVHD4XOp8fwNFyzfw4F7WFs8ohNMMlBXbGI0iS12bSTeCPInZpEVcj7MXi8
         X1tHBwK0uiZ+5tHww03AOv8yfkhah09cbfBLfrPhBWSyxk7LhIUE5fYQTrRRSeFrg45I
         8psAdOUGDndosAsdF6AixoxnUUCDGfUxzR2pZI6G62L6w4ZHZg4LGt87Y//tXrNLZvqN
         fU4U2wL/qEAK3ysze6mBwVTFxOEbTEGBk0JEMJvTcXSsxhnAvtuB0WVjAHHHWx+xPXY7
         lfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740721108; x=1741325908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMEFQfYL85FdqL7yUZ7W2PrbLVXuINqAyxuWJnoHjUo=;
        b=ZFgAf3olX3lgPXk4i63CUKpOwFmeJjVPfkg+M1I7THDPwESDFcjVUOFCgGH1xNje8e
         ZH64YVu4u2BJRS5I3TiCnR8jJEcvv/yAqVjEdMsxUSl2Nb4ybZUIXkQbCKGqGHAQ1WNW
         St1+5RPpiPbs2teSH59jTebyE/VvE51+o3eRpujEePXWuPR25oqx0yycMCyjoxy+/qYa
         mINNXbYYH9DyYIvK4Y5Q+hqnWYebCXWGIucHISNJUjXTXnEdrpqaeyWinlK8jCq/D0AV
         DpjlIBfGdC9F/XBSlN3ret9kZbMhAdIxGOyzv3sJ+Ja1lthzq2UbQPdzgkpHEeF2yZU8
         poPQ==
X-Gm-Message-State: AOJu0YyaqAa08TGlYXJotaATVbnlF4ANn5MtiwA+rBmATWclzh29Tof/
	YWcF9aSzD9rsrdwthpkRElKHx8rx+NJN1ln7gYSgxUSKJzL/IvaSPzie52Q1YKY0Y4geit0yjW3
	vad2HAjbmFGBgKipN/TpnL8qeggFmJZ2IvkI=
X-Gm-Gg: ASbGnct3zjszXj+mqasQG2Z1XBY0SRk2odpe7+9uxrf1SsX+uTk1CYtm8I5SE2jEwmt
	BgcxqP3DxWh3wYhDvLSPKE9ND4neQHvQIdy+y/J6RR/GqOLDPysYEV1X7x2HRRdD3ZMiWtxxPd4
	XC3jg=
X-Google-Smtp-Source: AGHT+IEOwZv1hyiJSaIOnHCFT0HQYufXw/qONXn0bB2u2sDBDPnkrQXwN8Uaw6wdt2bie7tBooizIw+OK7kEKiHqq0s=
X-Received: by 2002:a05:6902:26ca:b0:e57:38e8:e484 with SMTP id
 3f1490d57ef6-e60b2ec15aamr2196086276.25.1740721107986; Thu, 27 Feb 2025
 21:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei>
In-Reply-To: <20250222151143.7ca7f718@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Fri, 28 Feb 2025 11:07:52 +0530
X-Gm-Features: AQ5f1Jo4P1EX5Bb6Td0ny23BnrrL_NkpNsAAkZxJAyvlfQ96Cysvf7J35KtQfSo
Message-ID: <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
Subject: Re: GSoC IIO project: Siddharth Menon
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subject: Criteria for cleanup patch

Hello again,
I was going through some of the staging drivers. There are quite a few
checkpatch warnings under rtl8723bs, but they are mostly styling changes.
Would sending in patches for these be appropriate?

I had considered dt bindings earlier as they seemed like a more relevant
contribution.

Regards,
Siddharth Menon

