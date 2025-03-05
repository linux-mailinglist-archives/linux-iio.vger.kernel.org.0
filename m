Return-Path: <linux-iio+bounces-16422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B57A50168
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9379188ACAF
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E624A06B;
	Wed,  5 Mar 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhF66fw0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB624BC02
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183573; cv=none; b=AodxdcDeUJhRL3PiNxS/tUO9JuMoXcL65Jv+PdslKuLWwiz9nttUXyFmMr+wR8bfKdlN1mC7lVuqPBNswNtOWRisIWSAmCZfm6/MRfgtJ97HXujMM11+5cR3GsAEcbAIPMV1EY/e3GkxZlmYzW/QPuBneHLwcmffX+2FUP+4LD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183573; c=relaxed/simple;
	bh=3B187AbCZpBAElmSCz+oOqGjk+8uepotddDRYnfwDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxxcKFEENH52P9G6H+84dWHiZ+cezbkhCIZtp/eE17csR/OqI2/5RTnEHcVTMawXJEio+R6l2k6xsFl+KT5crv82CktvWgpYgXxFvH2q1WpdEkPFO7vFMWus/q0vi/R4P5Jq6yWoE40euBcjJU0j0kWc1kKQBAnSmNjZMpaEZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhF66fw0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349dc31bcso121232085ad.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Mar 2025 06:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741183570; x=1741788370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dC2GKzR2/isixhMd9NfLBitKH7jsbibnC8DZUXmQq7c=;
        b=HhF66fw0mtp54RsV0dbsLra19CyxyxzHhM7MD1nOWv4n0NooMSLQphxFyjVHMbgokK
         akdYYp2Be1saaewopJMxSHElCz19w9DLR59rW3Pb+Gt8y8RVBjWKj+QPzJalpbekn0z/
         RTeyNV6kqWtX6eI6NgJPOulK1k/akmwR0OXul97jkSLpqqfSizaKdgZW/wm9jMOVRHdu
         PAsXQnZ3092c11ZZRjKt2hpRsxl12fOd98iJjLdVI0RX2kdXY76O7Ha76qK96ccGUIVM
         cJpon+4UkpuQ7iqO7ChCaWKKI7+pKjCAUFv4L2qRfiiVodvv03DohHWVJuYetCUA8dsA
         5i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741183570; x=1741788370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC2GKzR2/isixhMd9NfLBitKH7jsbibnC8DZUXmQq7c=;
        b=YsBcgL4/oTn7v2VH+g6fB3MUB9EcCmLRiwU8mfP4NLAVKavhFDI+0yYDythxj7v0E8
         U7wsfFoxu6QTx3TMkdVj1YbhgKkGq3ColbKL6kGqw6QhjQZCP3pU7UkAFyPKV3FoSdA0
         P2pcqzs5OCGSZ5LFRjZUEpFSv5bshfH2sPgYhW9/oWffAuS3P7e58aqwH/qbswqjShuA
         oVqqwT7348Vp8MuHKKLaUQv29y9nDHyvElY/xg88+C27ENkc/NQ1RNZIpmetYlNQ3Qi/
         Ff2W5i+mGnfupRD7E8TwkydVvNM2EeEWTZ/vFHLPtdHAVFNY0Hqn4xX5WYW7xExWAXQN
         AluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhw1/3XtUWlZOFQ8dJt1kwjVau8ROgCiXd8KaropRzZBbh6UoMVV8VyEJuJmYmg/1e2PMI3Y5EpuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycfRvr4gP2PxOcX2LL70VkIs0XYXxhywQcatXFHyzbSiNFgI1r
	qV44LYJDCJX8mxRhzeiwWhQjamEb7lvjA6OtUhs+G4lTPbHlnPyE
X-Gm-Gg: ASbGncv6RTE8o/n76eZ+ZxILZheZ6uhrV5+HjZuQY/XJNw70dM7cPEUXoD6tZxUzBA1
	6Isf80Dl/2/vdBe0gn0xXami+9Mc3ETbAuKQ5wuHpNVnq6XZKut6JR5kyC5JxSwtAA3fJRE8lBn
	N8gRhR0+2tnBEJrSNLUpQ3zxMASsHv5pH/3ugdBC8wThAn5DwMfmshUvVHWm9wxhlFvmtSYa04C
	/dM5A3QPIRplVeAzuSRCnMt/07to/0N8TQ4YbAPYYn9375LsUeG+8Z5A1ccKWL/IQgJlyzP+Atv
	7ydKvDW5+rKhfyQPlBRNFCFkV0iN0GEtk87mKa2pS5j8sZmz5vgrMD0=
X-Google-Smtp-Source: AGHT+IE/W8XYHcUI3214+qmhpBYrkZW3Oo183YE2O8fP+hLsToP3rqzvgDg4gSF/9+DiKhiA2/LXtQ==
X-Received: by 2002:a17:902:e842:b0:223:49cb:5eaa with SMTP id d9443c01a7336-223f1cf4211mr53302895ad.35.1741183570050;
        Wed, 05 Mar 2025 06:06:10 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5c20sm113637505ad.146.2025.03.05.06.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:06:09 -0800 (PST)
Date: Wed, 5 Mar 2025 11:07:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: Siddharth Menon
Message-ID: <Z8hahI_AKTyisMEk@debian-BULLSEYE-live-builder-AMD64>
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei>
 <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
 <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
 <CAGd6pzN-4a2cs82ABHU5-pr32hg9DtvhpD8kM1skdbGq7_rvQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGd6pzN-4a2cs82ABHU5-pr32hg9DtvhpD8kM1skdbGq7_rvQw@mail.gmail.com>

On 03/05, Siddharth Menon wrote:
> On Mon, 3 Mar 2025 at 10:17, Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >
> > I did a quick look at the IIO staging drivers and here are some comments and
> > improvement suggestions for those.
> 
> Thank you for taking the time to provide pointers to potential patches.
> I'll begin with the adis16203, as it appears to be the simplest.
> I'll also see if I can get access to any of the boards for testing.
> If that's not possible, I'll focus on submitting patches with minimal risk
> of breaking anything.
> 
Sounds great.

Thanks,
Marcelo

