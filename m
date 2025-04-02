Return-Path: <linux-iio+bounces-17563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC01A7991A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 01:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4562A3B32F6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF31EA7FC;
	Wed,  2 Apr 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry/nxGqt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D526AFB
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637632; cv=none; b=VJQwU+PUS730HGRmyo294RHiSvMde6cqS4FMOpeg+0a+VCzUVcZm9pgAZwxS7sRpcee51yIXlsz61nJs4Ul5bmUmCWlFaodSRt+whORczy4KXMpNDVhrjw+J35xqsqHRDKDJNzru9hq27S2Zm1kurql/ReOcXoWp3+uE+HM/+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637632; c=relaxed/simple;
	bh=bOPQDDqLHspuoX9ycGlKzNCQJMyXrx2zUeTni++DKhA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rtv6jECEsFkHoS00hAPOhI8Uha4gr4qKYM3dc18i9RdIokw5KGoUldVkV+l71gW7ssgw+ShjtlwXSFnXVoAaObmjzsE+c83Y6kbc2nLBZoxi3xyKw4ASLxWqolkLSW17rq0/dfNQI4ynArl9sQcaVlzcO7kb+nEDzuy6+LIZuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry/nxGqt; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so193327241.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Apr 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743637628; x=1744242428; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOPQDDqLHspuoX9ycGlKzNCQJMyXrx2zUeTni++DKhA=;
        b=Ry/nxGqtnb5TWEKdMnESAz6E2D3ri1QjE5n1AqeNfCn2DASIw2v87DFRP0CUNS0yCS
         g0ovASmhwzoIdV/bGqexhCpVtwCTrgbfuz2eavA+8vNzP7GhtfatRZNlE2ODovpdZDhq
         XJdyABiIIByh1w8eaSoc41mstD3JDec8h2eEwyJxMo3mzSH1qTZyPNEn+kGd2/SDd9hT
         0dy2OsnlKjdT2iBQn0ebKGCrLyDb+nymCVBKVywhQ4L+kSrTDu3ypAZqU5tjsdLnYFy1
         I30JPM5oMkIE1vK9H+j9cIZYlakKu+WOcjrb9ZKY/6Hl0h0SfP+nWxI9SkuBd4FLfjew
         exdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743637628; x=1744242428;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOPQDDqLHspuoX9ycGlKzNCQJMyXrx2zUeTni++DKhA=;
        b=eufVVYIaCzym9zR5YxCz+Yvli2xqRtOzpSXwQRC+Egwd+luWc0oUpgRW/zpwqiSSYb
         u+uOfDdZYYbfPWg3aPP5s75hO/vRzzrNybxXLwKEKLFvy2dZc3Yq0qnXM3zfN9wMeBup
         hCA/pOCZKGZi2HfAS65iUlQOH7Hwai1Ry4kjlbl+eSqEuuWzuB7CuVDX3QSdeTG85gZi
         yGzpTATHK99UyyX7AtbiWF9zx5YWe2ZDk+KK/7Md6G4QNrEg9S85dYP7RLRAZsQ/j1X0
         ar+anx9X5gGBQuysEucZkKlFSwardxPJc4K78sUiBExx2tuJUu7oRb856uJuXxNbQvoe
         jL1g==
X-Gm-Message-State: AOJu0YzyszfGn6L5ahrNRJBYNIOesNaV0snB1BVaxvc6fenIEzVI+jZO
	hd6zxY7h18Fd8ocEKew/xk24nnCIyZskTl4VAD/CkFP3O0s/KhS+E5s0yTo+wT66zUhQWYwLWVM
	0dwHEC/SjtrZhMLZ75b8MJna2IkO/4ns7F8Q=
X-Gm-Gg: ASbGnctcjknhY0cTkjmtaIJmDS5WEU5K3hTAxmprkbDvEn7BsR9/XCGMhF08PcAFDeO
	r3oNJg/X6s/1/8biG9o3lqTvTT3HylyljnhUgvjmenDRnmncHcSe1Kr2l8tY3t2yMoA+HTVA+Ur
	98AdhXZlPTAzIUDBOF5vOCzye5
X-Google-Smtp-Source: AGHT+IGhrgGby20tJKPYR0yb4iCC7++OA1if7ZtGHqdxtvr9/k1tDtdwsuphllyPzXEydleGCB6pYRJSeLcvCkTcLoc=
X-Received: by 2002:a05:6102:2d0b:b0:4bb:eb4a:f9ef with SMTP id
 ada2fe7eead31-4c6d37ffa36mr15171995137.4.1743637628458; Wed, 02 Apr 2025
 16:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jenish Togadiya <jenishtogadiya549@gmail.com>
Date: Thu, 3 Apr 2025 05:16:56 +0530
X-Gm-Features: ATxdqUHZALBcHO2FS4t53EoUdNETfmxWnCm31Fdl8V0dmzu9UyKrYY4cHPgGTFg
Message-ID: <CANDLU1R+N__nhDGXk0f13nBDPDT-EB9Pujrp-UUsLZD=TXtPeg@mail.gmail.com>
Subject: Subject: Introduction: Jenish Togadiya - Interested in ADE9113 IIO
 Driver Development
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello IIO Developers,

My name is Jenish Togadiya, and I am an aspiring Linux kernel
developer with experience in C and Bash scripting. I am particularly
interested in contributing to the Industrial I/O (IIO) subsystem and
working on the ADE9113 ADC driver.

I have been learning about Linux device drivers and IIO architecture,
and I am currently setting up my development environment with a
Raspberry Pi 3 Model B. I would appreciate any guidance on getting
started, relevant documentation, and potential first contributions.

Looking forward to collaborating with the community.

Best regards,
Jenish Togadiya

